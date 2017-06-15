package com.eshop.controllers;


import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eservice.core.beans.NestedCategory;
import com.eservice.core.services.SystemSetUpService;
import com.eshop.services.CartService;

@Controller
public class CartController {

	private CartService cartService;
	
	public void setCartService(CartService cartService) {
		this.cartService = cartService;
	}
	
	
	List<String> startupCriteriaList;
	
	public void setStartupCriteriaList(List<String> startupCriteriaList) {
		this.startupCriteriaList = startupCriteriaList;
	}
	@ModelAttribute("startupCriteriaList")
	public List<String> getStartupCriteriaList() {
		return startupCriteriaList;
	}
	
	@Autowired
	Long startupHierarchyInitId;
	
	@ModelAttribute("startupHierarchyInitId")
	public Long getStartupHierarchyInitId()
	{
		return startupHierarchyInitId;
	}
	public void setStartupHierarchyInitId(Long startupHierarchyInitId)
	{
		this.startupHierarchyInitId = startupHierarchyInitId;
	}
	
	@ModelAttribute("systemHierarchySetupList")
	public Map<Long, String> getSystemHierarchySetupList() {
		return cartService.getSystemHierarchySetupList();
	}

	@Autowired
	String startupHierarchyHome;
	
	@ModelAttribute("startupHierarchyHome")
	public String getStartupHierarchyHome() {
		return startupHierarchyHome;
	}
	public void setStartupHierarchyHome(String startupHierarchyHome) {
		this.startupHierarchyHome = startupHierarchyHome;
	}
	
	@RequestMapping(value="/getStartingSetup")
	@ResponseBody
    public String getStartingSetup(ModelMap model,@RequestParam("type") String type,@RequestParam("id") long id){
		System.out.println("getStartingSetup---->Id="+id+"--type="+type);
		boolean start=getStartByType(type);
		JSONObject object=new JSONObject();
		Map<String, List<NestedCategory>> startList=new LinkedHashMap<String,List<NestedCategory>>();
		try{
		for(String value: getCriteriaListByType(type)){
			if(start){
				List<NestedCategory> nestedCategories=cartService.getSpringSystemSetUpService().getImediateCaregoryList(id);
				
				if(nestedCategories!=null && nestedCategories.size()>0){
					object.put(value, getJSONArray(nestedCategories));
					id = nestedCategories.get(0).getId();
				}else{
					object.put(value, getJSONArray(nestedCategories));
				}
			}
			if(type.equalsIgnoreCase(value)) start= true;
			
			
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("getStartingSetup---->jason string="+object.toString());
		return object.toString();
		
	}
	private boolean getStartByType(String type) {
		if(type != null && type.equalsIgnoreCase(getStartupHierarchyHome()))
			return true;
		if(type != null && type.equalsIgnoreCase(cartService.getStartupHierarchySchedule()))
			return true;
		if(type != null && type.equalsIgnoreCase(cartService.getStartupHierarchyShippingMethod()))
			return true;
		return false;
	}
	private List<String> getCriteriaListByType(String type) {
		if(type != null && type.equalsIgnoreCase(getStartupHierarchyHome()))
			return getStartupCriteriaList();
		if(type != null && type.equalsIgnoreCase(cartService.getStartupHierarchySchedule()))
			return cartService.getShippingScheduleCriteriaList();
		if(type != null && type.equalsIgnoreCase(cartService.getStartupHierarchyShippingMethod()))
			return cartService.getShippingMethodCriteriaList();
		for(String criteria : getStartupCriteriaList()){
			if(criteria.equalsIgnoreCase(type))
				return getStartupCriteriaList();
		}
		for(String criteria : cartService.getShippingScheduleCriteriaList()){
			if(criteria.equalsIgnoreCase(type))
				return cartService.getShippingScheduleCriteriaList();
		}
		for(String criteria : cartService.getShippingMethodCriteriaList()){
			if(criteria.equalsIgnoreCase(type))
				return cartService.getShippingMethodCriteriaList();
		}
		return new ArrayList<String>();
	}
	@RequestMapping(value="/setStartingSetup", method=RequestMethod.POST)
	public void setStartingSetup(ModelMap model,HttpServletRequest request,HttpServletResponse response){
		System.out.println("setStartingSetup:");
		String key;
		int maxIndex=0,index=0;
		long id=0;
		try {
			for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
				key = (String)e.nextElement();
				index = getStartupCriteriaList().indexOf(key);
				if(index>0 && index>maxIndex){
					maxIndex=index;
					id = Long.valueOf(request.getParameter(key));
				}
		     }
			List<NestedCategory> bredcrumbList = cartService.getSpringSystemSetUpService().getSinglePathCaregoryList(id);
			cartService.getShoppingCart().setStartupHierarchyList(bredcrumbList);
			
			
			response.sendRedirect(request.getContextPath()+"/shop?id=0");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/initStartingSetup", method=RequestMethod.GET)
	public void setStartingSetupInit(ModelMap model,HttpServletRequest request,HttpServletResponse response){
		System.out.println("setStartingSetupInit: id="+getStartupHierarchyInitId());
		try {
			if(getStartupHierarchyInitId()!=null && getStartupHierarchyInitId()>0)
			{
			List<NestedCategory> bredcrumbList = cartService.getSpringSystemSetUpService().getSinglePathCaregoryList(getStartupHierarchyInitId());
			cartService.getShoppingCart().setStartupHierarchyList(bredcrumbList);
			response.sendRedirect(request.getContextPath()+"/shop?id=0");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/home");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private JSONArray getJSONArray(List<NestedCategory> nestedCategoryList) {
		JSONArray jsArr=new JSONArray();
		JSONObject obj = new JSONObject();

		for(NestedCategory nestedCategory:nestedCategoryList){
			obj = new JSONObject();
			obj.put(nestedCategory.getId(), nestedCategory.getCategory().getName());
			jsArr.add(obj);
		}
		
		return jsArr;
	}
	@RequestMapping("/home")
	public ModelMap goHome(HttpServletRequest request,HttpServletResponse response) {
		ModelMap model = new ModelMap();
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		try {
			if(cartService.getShoppingCart().getItemCount()>0)
			
				response.sendRedirect(request.getContextPath()+"/shop?id=0");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return model;
	}
	
	@RequestMapping("/shop")
	public ModelMap goShop(@RequestParam("id") long categotyId,HttpServletRequest request,HttpServletResponse response){
		System.out.println("goShop-->categotyId="+categotyId);
		System.out.println("goShop-->StartupHierarchyList="+cartService.getShoppingCart().getStartupHierarchyList().size());
		ModelMap model = new ModelMap();
		try {
			if(cartService.getShoppingCart().getStartupHierarchyList().size()==0){
			
				response.sendRedirect(request.getContextPath()+"/initStartingSetup");
				return model;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(categotyId<=0){
			categotyId = cartService.getHierarchyIdFromSystemHierarchySetupList(cartService.getStartupHierarchyShop());
			cartService.getShoppingCart().getSaleItemCategoryHierarchyList().clear();
		}
		
		
		
		List<NestedCategory> nestedCategories = new ArrayList<NestedCategory>();
		List<NestedCategory> bredcrumbList = new ArrayList<NestedCategory>();
		try {
			nestedCategories = cartService.getSpringSystemSetUpService().getImediateCaregoryList(categotyId);
			bredcrumbList = cartService.getSpringSystemSetUpService().getSinglePathCaregoryList(categotyId);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//set SaleItemCategoryHierarchyList
		setSaleItemCategoryHierarchyList(cartService.getShoppingCart().getSaleItemCategoryHierarchyList(),categotyId);
		
		
		cartService.clearSaleItems();
		//get all sale items if categoryid is leaf
		if(nestedCategories.size()==0){
			NestedCategory nestedCategory = cartService.getShoppingCart().getStartupHierarchyList().get(cartService.getShoppingCart().getStartupHierarchyList().size()-1);
			System.out.println("/shop--->Hierarchy Id-"+nestedCategory.getId()+"="+nestedCategory.getCategory().getName());
			cartService.setSaleItems(nestedCategory.getId(),categotyId);
		}else{
			cartService.getShoppingCart().getSaleItemCategoryHierarchyList().add(nestedCategories);
		}
			model.addAttribute("saleItems", cartService.getSaleItems());
	
		model.addAttribute("categotyId", categotyId);
		model.addAttribute("saleItemCategories", nestedCategories);
		model.addAttribute("bredcrumbList", bredcrumbList);
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		return model;
	}
	private void setSaleItemCategoryHierarchyList(List<List<NestedCategory>> saleItemCategoryHierarchyList,long categotyId) {
		boolean isFound=false;
		List<List<NestedCategory>> removeList=new ArrayList<List<NestedCategory>>();
		for(List<NestedCategory> saleItemCategoryList:saleItemCategoryHierarchyList){
			if(isFound){
				removeList.add(saleItemCategoryList);
			}else if(isCategoryIdExist(saleItemCategoryList,categotyId)){
				for(NestedCategory nestedCategory:saleItemCategoryList){
					nestedCategory.setSelected(false);
					if(nestedCategory.getId()==categotyId){ 
						nestedCategory.setSelected(true);
						isFound = true;
					}
				}
			}
		}
		saleItemCategoryHierarchyList.removeAll(removeList);
		
	}
	private boolean isCategoryIdExist(List<NestedCategory> saleItemCategoryList, long categotyId) {
		for(NestedCategory nestedCategory:saleItemCategoryList){
			if(nestedCategory.getId()==categotyId){ 
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping("/shoppingCartUpdated")
	@ResponseBody
	public String shoppingCartUpdated(@RequestParam("qty") int qty){
		System.out.println("goShop-->shoppingCartUpdated="+cartService.getShoppingCart().getItemCount());
		JSONObject object=new JSONObject();
		if(qty>0)
			object.put("message", "Successfuly add to the shoping cart");
		else
			object.put("message", "Successfuly remove from the shoping cart");
		
		object.put("item_count", cartService.getShoppingCart().getItemCount());
		object.put("total_price", cartService.getShoppingCart().getTotalCurrencyPrice());
		return object.toString();
	}
	
}

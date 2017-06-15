package com.eshop.controllers;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eservice.core.beans.User;
import com.eservice.core.services.AccountService;
import com.eshop.services.CartService;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	AccountService accountService;
	
	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}
	
	private CartService cartService;
	
	public void setCartService(CartService cartService) {
		this.cartService = cartService;
	}
	
	Map<String,String> titleList;

	@ModelAttribute("titleList")
	public Map<String, String> getTitleList() {
		return titleList;
	}

	public void setTitleList(Map<String, String> titleList) {
		this.titleList = titleList;
	}

	
	@RequestMapping("/addCustomer")
	public ModelMap addCustomer() {
		System.out.println("register");
		ModelMap model = new ModelMap();
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		model.addAttribute("user", cartService.getShoppingCart().getCustomer());
		if(cartService.getShoppingCart().getCustomer()!=null && cartService.getShoppingCart().getCustomer().getId()>0){
			model.addAttribute("heading", "Update Customer");
			model.addAttribute("buttonLabel", "Update");
			model.addAttribute("action", "updateCustomer");
			
		}else{
			model.addAttribute("heading", "Add New Customer");
			model.addAttribute("buttonLabel", "Save");
			model.addAttribute("action", "saveCustomer");
		
		}
		
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		model.addAttribute("startupHierarchyList", cartService.getShoppingCart().getStartupHierarchyList());
		model.addAttribute("customer",cartService.getShoppingCart().getCustomer());
		return model;
	}
	
	@RequestMapping(value = "/saveCustomer", method = RequestMethod.POST)
	public String saveCustomer(User user,ModelMap model) {
		System.out.println("saveCustomer");
		System.out.println(user);
		Map resultMap =accountService.addCustomer(user);
		
		model.addAttribute("message",resultMap.get("message"));
		model.addAttribute("success",resultMap.get("success"));
		if(resultMap!=null && resultMap.containsKey("user"))
			model.addAttribute("user", (User)resultMap.get("user"));
		if(!(Boolean)resultMap.get("success")){
			model.addAttribute("heading", "New Customer");
			model.addAttribute("buttonLabel", "Save");
			model.addAttribute("action", "saveCustomer");
		}else{
			model.addAttribute("heading", "Update Customer");
			model.addAttribute("buttonLabel", "Update");
			model.addAttribute("action", "updateCustomer");
			
		}
		
		cartService.getShoppingCart().setCustomer(user);
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		model.addAttribute("startupHierarchyList", cartService.getShoppingCart().getStartupHierarchyList());
		model.addAttribute("customer",cartService.getShoppingCart().getCustomer());
		return "account/addCustomer";
	}
	
	@RequestMapping(value = "/updateCustomer", method = RequestMethod.POST)
	public String updateCustomer(User user,ModelMap model) {
		System.out.println("updateCustomer");
		Map resultMap =accountService.updateCustomer(user);
		model.addAttribute("message",resultMap.get("message"));
		model.addAttribute("success",resultMap.get("success"));
		model.addAttribute("heading", "Update Customer");
		model.addAttribute("buttonLabel", "Update");
		model.addAttribute("action", "updateCustomer");
		
		cartService.getShoppingCart().setCustomer(user);
		model.addAttribute("shoppingCart", cartService.getShoppingCart());
		model.addAttribute("startupHierarchyList", cartService.getShoppingCart().getStartupHierarchyList());
		model.addAttribute("customer",cartService.getShoppingCart().getCustomer());
		
		return "account/addCustomer";
	}
	
	
	
}

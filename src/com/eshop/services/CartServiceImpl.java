package com.eshop.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.eservice.core.beans.NestedCategory;
import com.eservice.core.beans.NestedCategorySaleItem;
import com.eservice.core.beans.User;
import com.eservice.core.services.SystemSetUpService;
import com.eservice.utils.PayPalPayment;
import com.eshop.core.beans.ShoppingCart;

// Commented this out since I want to specify the shippingOptions property in
// the config file.
@Repository("cartService")
public class CartServiceImpl implements CartService {

	private ShoppingCart shoppingCart;

	private Map<Long, NestedCategorySaleItem> saleItems = new HashMap<Long, NestedCategorySaleItem>();
	private List<NestedCategorySaleItem> recommendations = new ArrayList<NestedCategorySaleItem>();

	private List<String> shippingOptions;

	private List<NestedCategory> shippingSchedule;

	@Autowired
	SystemSetUpService hibernateSystemSetUpService;

	public SystemSetUpService getHibernateSystemSetUpService() {
		return hibernateSystemSetUpService;
	}

	public void setHibernateSystemSetUpService(
			SystemSetUpService hibernateSystemSetUpService) {
		this.hibernateSystemSetUpService = hibernateSystemSetUpService;
	}

	@Autowired
	SystemSetUpService springSystemSetUpService;

	public SystemSetUpService getSpringSystemSetUpService() {
		return springSystemSetUpService;
	}

	public void setSpringSystemSetUpService(
			SystemSetUpService springSystemSetUpService) {
		this.springSystemSetUpService = springSystemSetUpService;
	}

	Map<Long, String> systemHierarchySetupList;

	public Map<Long, String> getSystemHierarchySetupList() {
		return systemHierarchySetupList;
	}

	public void setSystemHierarchySetupList(
			Map<Long, String> systemHierarchySetupList) {
		this.systemHierarchySetupList = systemHierarchySetupList;
	}

	@Autowired
	String startupHierarchyShop;

	public String getStartupHierarchyShop() {
		return startupHierarchyShop;
	}

	public void setStartupHierarchyShop(String startupHierarchyShop) {
		this.startupHierarchyShop = startupHierarchyShop;
	}

	@Autowired
	String startupHierarchySchedule;

	public String getStartupHierarchySchedule() {
		return startupHierarchySchedule;
	}

	public void setStartupHierarchySchedule(String startupHierarchySchedule) {
		this.startupHierarchySchedule = startupHierarchySchedule;
	}

	List<String> shippingScheduleCriteriaList;

	@ModelAttribute("shippingScheduleCriteriaList")
	public List<String> getShippingScheduleCriteriaList() {
		return shippingScheduleCriteriaList;
	}

	public void setShippingScheduleCriteriaList(
			List<String> shippingScheduleCriteriaList) {
		this.shippingScheduleCriteriaList = shippingScheduleCriteriaList;
	}
	
	@Autowired
	String startupHierarchyShippingMethod;
	
	public String getStartupHierarchyShippingMethod()
	{
		return startupHierarchyShippingMethod;
	}

	public void setStartupHierarchyShippingMethod(String startupHierarchyShippingMethod)
	{
		this.startupHierarchyShippingMethod = startupHierarchyShippingMethod;
	}

	List<String> shippingMethodCriteriaList;
	
	@ModelAttribute("shippingMethodCriteriaList")
	public List<String> getShippingMethodCriteriaList()
	{
		return shippingMethodCriteriaList;
	}

	public void setShippingMethodCriteriaList(List<String> shippingMethodCriteriaList)
	{
		this.shippingMethodCriteriaList = shippingMethodCriteriaList;
	}

	private void addSaleItem(NestedCategorySaleItem saleItem) {
		saleItems.put(saleItem.getSaleItem().getId(), saleItem);

	}

	@Override
	public ShoppingCart getShoppingCart() {
		return shoppingCart;
	}

	public void setShoppingCart(ShoppingCart cart) {
		this.shoppingCart = cart;
	}

	@Override
	public void setSaleItems(long hierarchyId) {
		// get assigned sale items
		String criteria = "from NestedCategorySaleItem n where n.compoundKey.nestedCategory.id=? and n.assigned=? and n.compoundKey.saleItem.enabled=? order by n.assigned DESC";
		Object[] criteriaValues = { hierarchyId, true, true };
		try {
			List<NestedCategorySaleItem> nestedCategorySaleItems = getHibernateSystemSetUpService()
					.getNestedCategorySaleItems(criteria, criteriaValues);
			for (NestedCategorySaleItem nestedCategorySaleItem : nestedCategorySaleItems) {
				addSaleItem(nestedCategorySaleItem);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void setSaleItems(long hierarchyId, long categoryId) {
		// get assigned sale items
		// select p.* from nested_category_sale_item AS p join
		// nested_category_sale_item AS c on p.sale_item_id=c.sale_item_id and
		// c.nested_category_id in(41,43,44,45,46) and c.active='t' where
		// p.nested_category_id=35 and p.active='t'
		String criteria = "select node from NestedCategorySaleItem node, NestedCategorySaleItem item "
				+ "where item.compoundKey.saleItem.id=node.compoundKey.saleItem.id "
				+ "and item.compoundKey.nestedCategory.id in "
				+ "(select child.id from NestedCategory child,"
				+ "NestedCategory parent "
				+ "where child.type = parent.type "
				+ "and child.left between parent.left and parent.right "
				+ "and parent.id = ?) "
				+ "and item.assigned=? "
				+ "and node.compoundKey.nestedCategory.id=? "
				+ "and node.assigned=? "
				+ "and node.compoundKey.saleItem.enabled=?";
		Object[] criteriaValues = { categoryId, true, hierarchyId, true, true };
		try {
			List<NestedCategorySaleItem> nestedCategorySaleItems = getHibernateSystemSetUpService()
					.getNestedCategorySaleItems(criteria, criteriaValues);
			for (NestedCategorySaleItem nestedCategorySaleItem : nestedCategorySaleItems) {
				addSaleItem(nestedCategorySaleItem);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public List<NestedCategorySaleItem> getSaleItems() {
		List<NestedCategorySaleItem> list = new ArrayList<NestedCategorySaleItem>(
				saleItems.values());
		return list;
	}

	@Override
	public NestedCategorySaleItem getSaleItem(long saleItemId) {
		return saleItems.get(saleItemId);
	}

	@Override
	public List<NestedCategorySaleItem> getRecommendations() {
		return recommendations;
	}

	@Override
	public List<String> getShippingOptions() {
		return shippingOptions;
	}

	public void setShippingOptions(List<String> options) {
		this.shippingOptions = options;
	}

	@Override
	public void submitOrderForPayment() {
		System.out.println("calling...submitOrderForPayment");
		System.out.printf("%s = %s \n", "TotalCurrencyPrice", shoppingCart
				.getTotalCurrencyPrice());
		System.out.printf("%s = %s \n", "AddressLine1", shoppingCart
				.getCustomer().getLocationContactDetailList().get(0)
				.getAddressLine1());
		Map<String, String> codeMap = PayPalPayment
				.ECSetExpressCheckoutCodeMap(
						"http://localhost:8080/eShop/initStartingSetup",
						"http://localhost:8080/eShop/initStartingSetup", shoppingCart
								.getTotalCurrencyPrice().replace("$", ""),
						"Sale", "AUD");
		System.out.printf("%s = %s \n", "ACK", codeMap.get("ACK"));
		System.out.printf("%s = %s \n", "TOKEN", codeMap.get("TOKEN"));
		// shoppingCart.clear();
	}

	@Override
	public void clearSaleItems() {
		saleItems.clear();
	}

	public List<NestedCategory> getShippingSchedule() {
		long hierarchyId = getHierarchyIdFromSystemHierarchySetupList(getStartupHierarchySchedule());
		try {
			return getSpringSystemSetUpService().getImediateCaregoryList(
					hierarchyId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ArrayList<NestedCategory>();
	}

	public long getHierarchyIdFromSystemHierarchySetupList(String hierarchyName) {
		for (Entry<Long, String> entry : getSystemHierarchySetupList()
				.entrySet()) {
			if (entry.getValue().equalsIgnoreCase(hierarchyName)) {
				return entry.getKey();
			}
		}
		return 1;
	}

	@Override
	public void clearShoppingCart()
	{
		System.out.println("calling...clearShoppingCart");
		
		getShoppingCart().setCustomer(new User());
		getShoppingCart().clear();
	}

}

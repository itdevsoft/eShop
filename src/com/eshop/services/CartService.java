package com.eshop.services;

import java.util.List;
import java.util.Map;

import com.eservice.core.beans.NestedCategory;
import com.eservice.core.beans.NestedCategorySaleItem;
import com.eservice.core.services.SystemSetUpService;
import com.eshop.core.beans.ShoppingCart;

public interface CartService {
	Map<Long, String> getSystemHierarchySetupList();
	
	String getStartupHierarchyShop();
	
	String getStartupHierarchySchedule();
	
	String getStartupHierarchyShippingMethod();
	
	ShoppingCart getShoppingCart();
	
	void setSaleItems(long hierarchyId);
	
	void setSaleItems(long hierarchyId,long categoryId);
	
	void clearSaleItems();
	
	List<NestedCategorySaleItem> getSaleItems();
	
	List<NestedCategorySaleItem> getRecommendations();
	
	NestedCategorySaleItem getSaleItem(long saleItemId);
	
	List<String> getShippingOptions();
	
	void submitOrderForPayment();
	
	List<NestedCategory> getShippingSchedule();
	
	SystemSetUpService getSpringSystemSetUpService();
	
	long getHierarchyIdFromSystemHierarchySetupList(String hierarchyName);
	
	List<String> getShippingScheduleCriteriaList();
	
	List<String> getShippingMethodCriteriaList();
	
	void clearShoppingCart();

}

package com.eshop.core.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eservice.core.beans.NestedCategory;
import com.eservice.core.beans.NestedCategorySaleItem;
import com.eservice.core.beans.User;
import com.eshop.utils.Util;


public class ShoppingCart implements Serializable {
	private static final long serialVersionUID = -4461143736086272397L;
	
	private List<NestedCategory> startupHierarchyList=new ArrayList<NestedCategory>();
	
	public void setStartupHierarchyList(List<NestedCategory> startupHierarchyList) {
		this.startupHierarchyList = startupHierarchyList;
	}
	public List<NestedCategory> getStartupHierarchyList() {
		return startupHierarchyList;
	}
	
	private List<List<NestedCategory>> saleItemCategoryHierarchyList=new ArrayList<List<NestedCategory>>();
	
	public void setSaleItemCategoryHierarchyList(
			List<List<NestedCategory>> saleItemCategoryHierarchyList) {
		this.saleItemCategoryHierarchyList = saleItemCategoryHierarchyList;
	}
	public List<List<NestedCategory>> getSaleItemCategoryHierarchyList() {
		return saleItemCategoryHierarchyList;
	}
	

	private Map<Long, ShoppingCartItem> items = new HashMap<Long, ShoppingCartItem>();
	
	
	public List<ShoppingCartItem> getItems() {
		List<ShoppingCartItem> list = new ArrayList<ShoppingCartItem>(items.values());
		return list;
	}
	
	User customer;
	
	public User getCustomer() {
		return customer;
	}

	public void setCustomer(User customer) {
		this.customer = customer;
	}

	
	public ShoppingCart() {
	}
	
	public void addItem(NestedCategorySaleItem saleItem,int quantity) {
		long saleItemId = saleItem.getSaleItem().getId();
		ShoppingCartItem item = items.get(saleItemId);
		if (item != null) {
			if(quantity>0){
			item.setQuantity(quantity);
			items.put(saleItemId,item);
			}else{
				items.remove(saleItemId);
			}
		} else if(quantity>0){
			items.put(saleItemId, new ShoppingCartItem(saleItem, quantity));
		}
	}
	
	public int getItemCount() {
		return items!=null?items.size():0;
	}
	
	public String getTotalCurrencyPrice() {
		float total = 0;
		for (ShoppingCartItem item : items.values()) {
			total += item.getTotalPrice();
		}
		return Util.getCurrencyPrice(total);
	}
	
	public void clear() {
		items.clear();
	}
}

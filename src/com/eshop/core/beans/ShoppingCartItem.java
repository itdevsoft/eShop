package com.eshop.core.beans;

import java.io.Serializable;

import com.eservice.core.beans.NestedCategorySaleItem;
import com.eshop.utils.Util;


public class ShoppingCartItem implements Serializable {
	private static final long serialVersionUID = 4134652647253355430L;
	
	private NestedCategorySaleItem saleItem;
	private int quantity;
	
	public ShoppingCartItem(NestedCategorySaleItem saleItem, int quantity) {
		this.saleItem = saleItem;
		this.quantity = quantity;
	}

	public NestedCategorySaleItem getSaleItem() {
		return saleItem;
	}

	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity=quantity;
	}

	public float getBasePrice() {
		return saleItem.getPrice();
	}
	
	public String getUnitCurrencyPrice() {
		return Util.getCurrencyPrice(saleItem.getPrice());
	}
	
	public float getTotalPrice() {
		return (quantity * getBasePrice());
	}
	
	public String getTotalCurrencyPrice() {
		return Util.getCurrencyPrice(getTotalPrice());
	}
	
	@Override
	public boolean equals(Object o) {
		return o instanceof ShoppingCartItem &&
			saleItem.equals(((ShoppingCartItem) o).saleItem);
	}
	
	@Override
	public int hashCode() {
		return saleItem.hashCode();
	}
	
}

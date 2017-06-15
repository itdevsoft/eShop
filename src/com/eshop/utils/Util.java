package com.eshop.utils;

import java.text.NumberFormat;

public class Util {
	
	public static String getCurrencyPrice(float price) {
		NumberFormat nf=NumberFormat.getCurrencyInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		return nf.format(price);
		
	}
}

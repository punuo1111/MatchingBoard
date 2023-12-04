package com.multi.model;

import lombok.Data;

@Data
public class ShopVO {

	private String shopid;
	private String sname;
	private String saddr;
	private String smenu_img;
	private String price_img;
	private int hour_price;
	private int unlim_price;
	private double stars;
	private double mapx;
	private double mapy;
	//private int reviews;
	
}

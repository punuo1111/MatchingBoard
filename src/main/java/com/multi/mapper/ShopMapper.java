package com.multi.mapper;

import java.util.List;

import com.multi.model.ShopVO;

public interface ShopMapper {

	List<ShopVO> getAllShop();
	
	List<ShopVO> getFindShopTitleAddr(String keyword);
	
}

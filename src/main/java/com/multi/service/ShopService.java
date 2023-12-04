package com.multi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.multi.model.ShopVO;

@Service
public interface ShopService {

	List<ShopVO> getAllShop();
	
	List<ShopVO> getFindShopTitleAddr(String keyword);
	
}

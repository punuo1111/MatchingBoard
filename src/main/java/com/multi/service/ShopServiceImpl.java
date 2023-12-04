package com.multi.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.mapper.ShopMapper;
import com.multi.model.ShopVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Inject private ShopMapper sMapper;
	
	@Override
	public List<ShopVO> getAllShop() {
		
		return sMapper.getAllShop();
	}

	@Override
	public List<ShopVO> getFindShopTitleAddr(String keyword) {
		
		return sMapper.getFindShopTitleAddr(keyword);
	}

}

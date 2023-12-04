package com.multi.matchingBoard;

import java.util.List;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.multi.model.GameVO;
import com.multi.model.ShopVO;
import com.multi.service.ShopService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class ShopController {
	
	@Inject
	private ShopService shService;
	
	@GetMapping(value="/shops", produces="application/json")
	public List<ShopVO> gameAll(@RequestParam(defaultValue="") String keyword){
		
		
		List<ShopVO> arr=null;
		if(keyword.isEmpty()) {
			arr=shService.getAllShop();
		}else {
			//검색한 도서정보 가져오기
			arr=shService.getFindShopTitleAddr(keyword);
		}
		
		return arr;
	}
	
}

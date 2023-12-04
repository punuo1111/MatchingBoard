package com.multi.service;

import java.util.List;

import com.multi.model.PagingVO;
import com.multi.model.RoomVO;
import com.multi.model.WishListVO;

public interface BoardSearchService {

	//모임방 목록
	public List<RoomVO> getList();
	
	//모임방 목록 (페이징)
	public List<RoomVO> getListPaging(PagingVO pagingvo);
	
	//모임방 총 갯수
	public int getTotal(PagingVO pagingvo);
	
	//좋아요
	public int updateLike(String uuid, String roomid);
	
	
	public List<String> getUserWishList(String userid);
	
	

}

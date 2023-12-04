package com.multi.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.mapper.BoardSearchMapper;
import com.multi.model.PagingVO;
import com.multi.model.RoomVO;
import com.multi.model.WishListVO;

@Service
public class BoardSearchServiceImpl implements BoardSearchService{

	@Inject 
	private BoardSearchMapper mapper;
	
	//모임방 리스트
	@Override
	public List<RoomVO> getList() {
		return mapper.getList();
	}

	//모임방 리스트 (페이징)
	@Override
	public List<RoomVO> getListPaging(PagingVO pagingvo) {
		
		return mapper.getListPaging(pagingvo);
	}

	//모임방 총 갯수
	@Override
	public int getTotal(PagingVO pagingvo) {
		
		return mapper.getTotal(pagingvo);
	}

	
	//좋아요
	@Override
	public int updateLike(String userid, String roomid) {
		WishListVO vo = new WishListVO(userid, roomid);
		System.out.println("WishListVO = " + vo);
		
		int count = mapper.likecount(vo);
		System.out.println("likeCount = " + count);
		
		if(count <= 0) {
			return mapper.likeinsert(vo);
		} else {
			return mapper.likedelete(vo);
		}
	}

	@Override
	public List<String> getUserWishList(String userid) {

		return mapper.getUserWishList(userid);
	}
	
	
}

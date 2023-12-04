package com.multi.service;

import java.util.List;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.mapper.ClickRoomMapper;
import com.multi.model.RoomVO;

@Service
public class ClickRoomServiceImpl implements ClickRoomService{

	@Inject 
	private ClickRoomMapper mapper;
	
	@Override
	public List<RoomVO> clickList() {
		return mapper.clickList();
	}

	//모임방 목록 - 상세페이지
	@Override
	public RoomVO clickRoom(String roomid) {

		return mapper.clickRoom(roomid);
	}
}

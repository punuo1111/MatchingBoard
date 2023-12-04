package com.multi.service;

import java.util.List;

import com.multi.model.RoomVO;

public interface ClickRoomService {
	//모임방 조회
	public RoomVO clickRoom(String roomid);
	
	public List<RoomVO> clickList();
}

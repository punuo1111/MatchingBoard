package com.multi.mapper;

import java.util.List;


import com.multi.model.RoomVO;

public interface ClickRoomMapper {

	public List<RoomVO> clickList();

	public RoomVO clickRoom(String roomid);
	
	
}

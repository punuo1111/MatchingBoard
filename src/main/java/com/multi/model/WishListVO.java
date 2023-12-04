package com.multi.model;

import lombok.Data;

@Data
public class WishListVO {
	private String userid; //social
	private String roomid; //room

	public WishListVO() {
		super();
	}
	
	public WishListVO(String userid, String roomid) {
		this.userid = userid;
		this.roomid = roomid;
	}

	public WishListVO(String userid, String roomid, int likecount) {
		this.userid = userid;
		this.roomid = roomid;
	}
}

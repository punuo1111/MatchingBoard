package com.multi.model;

import lombok.Data;

@Data
public class RoomVO {

	private String cheif; //방장. 스키마 바꿀것.
	private String roomid;
	private String shopid;
	private String rname;
	private String rplace;
	private int rmaxpeople;
	private String rgenre;
	private String rgame;
	private String rstr;
	
//	private Date rdate;
//	private Time rtime;
	private String rdatetime;
	
	public RoomVO(String roomid, String rname, String rplace, int rmaxpeople, String rgenre, String rgame, String rstr,
			String rdatetime) {
		super();
		this.roomid = roomid;
		this.rname = rname;
		this.rplace = rplace;
		this.rmaxpeople = rmaxpeople;
		this.rgenre = rgenre;
		this.rgame = rgame;
		this.rstr = rstr;
		this.rdatetime= rdatetime;
	}



	public RoomVO() {
		this(null, null, null, 0, null, null, null, null);
	}
	
}

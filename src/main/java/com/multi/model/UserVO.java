package com.multi.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class UserVO {

	//private int idx;
	//private String name;
	private String userid;
	private String profile_img;
	private String nickname;
	private String area_text;
	private int area_code;
	
	private int grade;
	private int exp;
	private float manner;
	
	//favorite genres
	private String fgenre1; 
	private String fgenre2; 
	private String fgenre3; 
	
	//favorite games
	private String fgame1;
	private String fgame2;
	private String fgame3;
	
	private int attend;
	private int late;
	private int absent;
	
}

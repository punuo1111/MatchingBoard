package com.multi.model;

import lombok.Data;

@Data
public class SnsLoginVO {
	private String userid;
	private String type;
	private String identifier;
	private String refreshtoken;
}

package com.multi.snslogin;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class KaKaoLoginApi extends DefaultApi20 {
	protected KaKaoLoginApi(){
		
	}
	private static class InstanceHolder{
		private static final KaKaoLoginApi INSTANCE = new KaKaoLoginApi();
	}
	public static KaKaoLoginApi instance(){
		return InstanceHolder.INSTANCE;
	}
	@Override
	public String getAccessTokenEndpoint() {
		return "https://kauth.kakao.com/oauth/token";
	}
	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://kauth.kakao.com/oauth/authorize";
	}
}

package com.multi.snslogin;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class NaverLoginBO {
	
	
	private static String CLIENT_ID = "GdBCfTeIsbnGTcF_zw_U" ;
	private static String CLIENT_SECRET = "far_EeuhHE";
	private final static String REDIRECT_URI = "http://localhost:9090/matchingBoard/user/callbackNaver";
	private final static String SESSION_STATE = "oauth_state";

	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}


	public String getAuthorizationUrl(HttpSession session) {
		
	
		String state = generateRandomString();
		
		setSession(session,state);
 
	
	OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state) 
				.build(NaverLoginApi.instance());
				return oauthService.getAuthorizationUrl();
	}
 
	
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException{
		
		String sessionState = getSession(session);
		if (sessionState == null) {
	        System.out.println("sessionState is null");
	        return null;
	    }
	    if (state == null) {
	        System.out.println("state is null");
	        return null;
	    }
		if(StringUtils.pathEquals(sessionState, state)){
				OAuth20Service oauthService = new ServiceBuilder()
						.apiKey(CLIENT_ID)
						.apiSecret(CLIENT_SECRET)
						.callback(REDIRECT_URI)
						.state(state)
						.build(NaverLoginApi.instance());
				
				OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
				return accessToken;
		}
		System.out.println("sessionState: " + sessionState);
		System.out.println("state: " + state);
		return null;
	}

 
	private void setSession(HttpSession session,String state){
		session.setAttribute(SESSION_STATE, state);     
	}
 

	private String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
	}
	
	public String getUserProfile(OAuth2AccessToken oauthToken) throws Exception{
 
		OAuth20Service oauthService =new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(NaverLoginApi.instance());

		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}


}

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
public class KaKaoLoginBO {

	private static String KAKAO_CLIENT_ID = "610c34069cfc956fd14eace0ab056630";
	private static String KAKAO_CLIENT_SECRET= "hrxqz5LmvJiHEFjA8qnoXfLDdV7DDifH";
	private final static String KAKAO_REDIRECT_URI = "http://localhost:9090/matchingBoard/user/callbackKakao";
	private final static String SESSION_STATE = "kakao_oauth_state";
	/* ������ ��ȸ API URL */
	private final static String PROFILE_API_URL = "https://kapi.kakao.com/v2/user/me";
	
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	private void setSession(HttpSession session,String state){
		session.setAttribute(SESSION_STATE, state);     
	}
 
	/* http session���� ������ �������� */ 
	private String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
	} 

	public String getAuthorizationUrl(HttpSession session) {

		/* ���� ��ȿ�� ������ ���Ͽ� ������ ���� */
		String state = generateRandomString();
		/* ������ ���� ���� session�� ���� */
		setSession(session, state);

		/* Scribe���� �����ϴ� ���� URL ���� ����� �̿��Ͽ� �׾Ʒ� ���� URL ���� */
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(KAKAO_CLIENT_ID)
				.apiSecret(KAKAO_CLIENT_SECRET)
				.callback(KAKAO_REDIRECT_URI)
				.state(state) // �ռ� ������ �������� ���� URL������ �����
				.build(KaKaoLoginApi.instance());
		return oauthService.getAuthorizationUrl();
	}
	
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException{
		/* Callback���� ���޹��� ���������� �������� ���ǿ� ����Ǿ��ִ� ���� ��ġ�ϴ��� Ȯ�� */
		String sessionState = getSession(session);
		if(StringUtils.pathEquals(sessionState, state)){
				OAuth20Service oauthService = new ServiceBuilder()
						.apiKey(KAKAO_CLIENT_ID)
						.apiSecret(KAKAO_CLIENT_SECRET)
						.callback(KAKAO_REDIRECT_URI)
						.state(state)
						.build(KaKaoLoginApi.instance());
				/* Scribe���� �����ϴ� AccessToken ȹ�� ������� �׾Ʒ� Access Token�� ȹ�� */
				OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
				return accessToken;
		}
		return null;
	}

	
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
		 
		OAuth20Service oauthService =new ServiceBuilder()
				.apiKey(KAKAO_CLIENT_ID)
				.apiSecret(KAKAO_CLIENT_SECRET)
				.callback(KAKAO_REDIRECT_URI)
				.build(NaverLoginApi.instance());

		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}

}

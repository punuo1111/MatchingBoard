package com.multi.matchingBoard;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.multi.model.RoomVO;
import com.multi.model.SnsLoginVO;
import com.multi.model.UserVO;
import com.multi.service.RoomService;
import com.multi.service.SocialService;
import com.multi.service.UserService;
import com.multi.snslogin.KaKaoLoginBO;
import com.multi.snslogin.NaverLoginBO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user")
@Log4j
public class LoginController {
	
	@Autowired
	private SocialService socialservice;
	@Autowired
	private UserService userservice;
	@Autowired
	private RoomService rService;
	
	private NaverLoginBO naverLoginBO;
	private String NaverapiResult =null;
	
	private KaKaoLoginBO kakaoLoginBO;
	private String KakaoapiResult= null;
	
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Autowired
	private void setKakaoLoginBO(KaKaoLoginBO kakaoLoginBO) {
		this.kakaoLoginBO = kakaoLoginBO;
	}
	
	@RequestMapping(value = "login")
    public String login(Model model,HttpSession session) {
		
		String naverAuthUrl= naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("urlNaver", naverAuthUrl);
		
		String kakaoAuthUrl= kakaoLoginBO.getAuthorizationUrl(session);
		model.addAttribute("urlKakao", kakaoAuthUrl);
		
		googleOAuth2Parameters.set("access_type", "offline");
        googleOAuth2Parameters.set("approval_prompt", "force");
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String googleAuthUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("urlGoogle",googleAuthUrl);
		
        return "user/login";
    }
	
	@RequestMapping(value="/callbackNaver", method= {RequestMethod.GET , RequestMethod.POST})
	public String callBackNaver(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception{
		OAuth2AccessToken oauthToken;
	    oauthToken = naverLoginBO.getAccessToken(session, code, state);
	    String NaverapiResult = naverLoginBO.getUserProfile(oauthToken);
	    System.out.println(NaverapiResult);
	    
	    // Naver API JSON 정보 파싱
	    JsonElement jsonElement = JsonParser.parseString(NaverapiResult);
	    JsonObject jsonObject = jsonElement.getAsJsonObject();
	    JsonObject response = jsonObject.getAsJsonObject("response");
	    
	    String identifier = response.get("id").getAsString();
	    String accessToken = oauthToken.getAccessToken();
	    String refreshToken = oauthToken.getRefreshToken();
	    
	    String type = "Naver";
	    
	    SnsLoginVO snsLogin = socialservice.findSnsLoginByidentifier(identifier);
	    System.out.println("snsLogin: " + snsLogin);
	    UserVO user=(UserVO) session.getAttribute("loginUser");
	    System.out.println("user : "+user);
	   
	    if(snsLogin == null){
	    	if(user != null && user.getUserid() !=null) {
	    		String userid=user.getUserid();
	    		socialservice.saveSnsLogin(userid, type, identifier, refreshToken);
	    		UserVO loginUser = userservice.getUserById(userid);
	    		session.setAttribute("loginUser", loginUser);
	    		System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
	    		session.setAttribute("loginSnsType", type);
	    		System.out.println("현재 연결된 SNS타입 : "+type);
	    		System.out.println("네이버 연동에 성공하였습니다.");
	    		
	    		return "user/mypage";
	    	}else{
	    		String userid = UUID.randomUUID().toString(); 
		        userservice.insertUser(userid);
		        socialservice.saveSnsLogin(userid, type, identifier, refreshToken);
		        UserVO loginUser = userservice.getUserById(userid);
		        System.out.println("New user created with userid: " + userid);
		        session.setAttribute("loginUser", loginUser);
	    		System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
	    		session.setAttribute("loginSnsType", type);
	    		System.out.println("현재 연결된 SNS타입 : "+type);
		        
		        return "user/callbackNaver";
	    	}
	    } else {
	        String userid = snsLogin.getUserid();
	        UserVO loginUser = userservice.getUserById(userid);
	        session.setAttribute("loginUser", loginUser);
	        session.setAttribute("loginSnsType", snsLogin.getType());
	        System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
	        session.setAttribute("loginSnsType", type);
    		System.out.println("현재 연결된 SNS타입 : "+type);
	        return "redirect:/";
	    }
		
	}
	
	@RequestMapping(value="/callbackKakao", method= {RequestMethod.GET, RequestMethod.POST})
	public String callBackKakao(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
		OAuth2AccessToken oauthToken;
		oauthToken=kakaoLoginBO.getAccessToken(session, code, state);
		KakaoapiResult=kakaoLoginBO.getUserProfile(oauthToken);
		System.out.println(KakaoapiResult);
		System.out.println(oauthToken);
		
		JsonElement jsonElement = JsonParser.parseString(KakaoapiResult);
	    JsonObject jsonObject = jsonElement.getAsJsonObject();

	   
	    String identifier = jsonObject.get("id").getAsString();
	    String accessToken = oauthToken.getAccessToken();
	    String refreshToken = oauthToken.getRefreshToken();
	    
	    String type = "Kakao";
	    SnsLoginVO snsLogin = socialservice.findSnsLoginByidentifier(identifier);
	    UserVO user=(UserVO) session.getAttribute("loginUser");
	    if(snsLogin == null){
	    	if(user != null && user.getUserid() !=null) {
	    		String userid=user.getUserid();
	    		socialservice.saveSnsLogin(userid, type, identifier, refreshToken);
	    		UserVO loginUser = userservice.getUserById(userid);
	    		session.setAttribute("loginUser", loginUser);
	    		System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
	    		session.setAttribute("loginSnsType", type);
	    		System.out.println("현재 연결된 SNS타입 : "+type);
	    		System.out.println("카카오 연동에 성공하였습니다.");
	    		return "user/mypage";
	    	}else{
	    		String userid = UUID.randomUUID().toString(); 
		        userservice.insertUser(userid);
		        socialservice.saveSnsLogin(userid, type, identifier, refreshToken);
		        UserVO loginUser = userservice.getUserById(userid);
		        System.out.println("New user created with userid: " + userid);
		        session.setAttribute("loginUser", loginUser);
		        System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
		        session.setAttribute("loginSnsType", type);
	    		System.out.println("현재 연결된 SNS타입 : "+type);
		        return "user/callbackKakao";
	    	}
	    } else {
	        String userid = snsLogin.getUserid();
	        UserVO loginUser = userservice.getUserById(userid);
	        session.setAttribute("loginUser", loginUser);
	        System.out.println("현재 세션에 로그인되어있는 아이디: "+loginUser);
	        session.setAttribute("loginSnsType", type);
    		System.out.println("현재 연결된 SNS타입 : "+type);
	        return "redirect:/";
	    }
	}
	
	@RequestMapping(value = "/callbackGoogle", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code) throws Exception {
		AccessGrant accessGrant = googleConnectionFactory.getOAuthOperations().exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
		
		String accessToken = accessGrant.getAccessToken();
		System.out.println("액세스 토큰" + accessToken);
		String refreshToken = accessGrant.getRefreshToken();
		System.out.println("리프레시 토큰" + refreshToken);
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
	    String oogleAuthUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
	    System.out.println("Google Authorization URL: " + oogleAuthUrl);

		try {
	        // Google OAuth2 API
	        URL url = new URL("https://www.googleapis.com/oauth2/v3/userinfo");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        
	        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        
	        // JSON 파싱
	        JsonElement jsonElement = JsonParser.parseString(response.toString());
	        JsonObject jsonObject = jsonElement.getAsJsonObject();
	        
	        //UUID 생성
		    String userid= UUID.randomUUID().toString();
		  
		    String id = jsonObject.get("email").getAsString();
		    String type="Google";
	        
	        // DB연동
		    userservice.insertUser(userid);
		    socialservice.saveSnsLogin(userid, type, id, refreshToken);
	        
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return "user/callbackGoogle";
	}
	
	@RequestMapping(value = "/mypage")
	public String connectSns(Model model, HttpSession session) throws Exception {
		System.out.println("mypage 로딩 성공");
		Object userObj = session.getAttribute("loginUser");
	    if (userObj == null) {
	        // 사용자가 로그인하지 않은 경우 로그인 페이지로 리다이렉션
	        return "redirect:/user/login";
	    }
	    System.out.println("userObj :"+userObj);
	    
	    String naverAuthUrl= naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("connecturlNaver", naverAuthUrl);
		
		
		String kakaoAuthUrl= kakaoLoginBO.getAuthorizationUrl(session);
		model.addAttribute("connecturlKakao", kakaoAuthUrl);
		
		
		googleOAuth2Parameters.set("access_type", "offline");
        googleOAuth2Parameters.set("approval_prompt", "force");
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String googleAuthUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("connecturlGoogle",googleAuthUrl);
		
		String userid = ((UserVO) userObj).getUserid();
		System.out.println("userid 잘 들어 왔는지? :"+userid);
	    List<String> userConnections = userservice.getUserSocialConnections(userid);
	    System.out.println("잘 연결 되었는지?: "+userConnections);
	    
	    model.addAttribute("connectedNaver", userConnections.contains("Naver"));
	    model.addAttribute("connectedKakao", userConnections.contains("Kakao"));
		
	    List<String> usersRoomIds = userservice.getUsersRoomIds(userid);
	    List<String> scheduleArr = new ArrayList<>();
	    for(String uRoomId : usersRoomIds) {
	    	RoomVO room=rService.selectRoomByIdx(uRoomId);
	    	scheduleArr.add(room.getRname()+" - "+room.getRplace());
	    	scheduleArr.add(room.getRdatetime());
	    }
	    
	    model.addAttribute("scheduleArr", scheduleArr);
	    
		return "user/mypage";
	    
	    
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();        
	    return "redirect:/";
	}
}

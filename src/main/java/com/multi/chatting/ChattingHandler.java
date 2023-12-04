package com.multi.chatting;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.log4j.Log4j;

@RequestMapping("/echo")
@Component
@Log4j
public class ChattingHandler extends TextWebSocketHandler{
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionEstablished");
		sessionList.add(session);
		
//		log.info(session.getPrincipal().getName() + "님이 입장하였습니다.");
//		log.info(session.getId() + "님이 입장하였습니다.(Handler)");
		log.info(session + " 클라이언트 접속");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		log.info("#ChattingHandler, handleMessage");
		log.info(session.getId() + ": " + message);
		String payload = message.getPayload();
        log.info("payload : " + payload);
		
		for(WebSocketSession s: sessionList) {
			s.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionClosed");
		
		log.info(session + " 클라이언트 접속 해제");
		sessionList.remove(session);
		
//		log.info(session.getPrincipal().getName() + "님이 퇴장하셨습니다.");
//		log.info(session.getId() + "님이 퇴장하셨습니다.(Handler)");
	}
	
}

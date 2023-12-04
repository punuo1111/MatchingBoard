package com.multi.matchingBoard;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.messaging.MessagingException;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
//https://recordsoflife.tistory.com/672
//https://dev-gorany.tistory.com/212
@Controller
public class ChatController {
	
	private final SimpMessagingTemplate template;
  
    public ChatController(SimpMessagingTemplate template) {
        this.template = template;
    }
    
//	@MessageMapping("/chat")
//	@SendTo("/subscribe/messages")
	public OutputMessage send(Message message) throws Exception {
		String time = new SimpleDateFormat("HH:mm").format(new Date());
		return new OutputMessage(message.getRoomId(), message.getFrom(), message.getFromId(), message.getText(), time);
	}
	
	@MessageMapping("/chat/join")
    public void join(Message message) {
        message.setText("[" + message.getFrom() + "]님이 입장하셨습니다.");
        message.setFrom("server");
        message.setFromId("server");
        template.convertAndSend("/subscribe/chatroom/" + message.getRoomId(), message);
    }

	@MessageMapping("/chat/quit")
    public void quit(Message message) {
        message.setText("[" + message.getFrom() + "]님이 퇴장하셨습니다.");
        message.setFrom("server");
        message.setFromId("server");
        template.convertAndSend("/subscribe/chatroom/" + message.getRoomId(), message);
    }
	
    @MessageMapping("/chat/message")
    public void message(Message message) throws Exception {
        template.convertAndSend("/subscribe/chatroom/" + message.getRoomId(), send(message));
    }
}

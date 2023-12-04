package com.multi.matchingBoard;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//https://dev-gorany.tistory.com/235
@Configuration
@EnableWebSocketMessageBroker //WebSocket
public class WebSocketConfig  implements WebSocketMessageBrokerConfigurer{ //extends AbstractWebSocketMessageBrokerConfigurer {

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		config.enableSimpleBroker("/subscribe");
		config.setApplicationDestinationPrefixes("/publish");
		//prefix를 /app으로 지정함
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/ws-connection").setAllowedOrigins("*");
		registry.addEndpoint("/ws-connection").withSockJS();
	}
}
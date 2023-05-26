package com.kh.ws.websocket;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

/*
 * 접속한 사용자를 기억해두고 모두에 대한 처리를 하는 서버
 * 
 * 
 */

@Slf4j
public class WebSocketGroupServer extends TextWebSocketHandler {
	
	/*
	 * 사용자를 기억하기 위한 저장소
	 * - 중복 불가
	 * - 동기화처리(동시접근하면 안되기 때문에) ->동기화된 set을 사용하겟다 CopyOnWriteArraySet
	 */
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		users.add(session); //저장소에 세션(사용자)정보를 담겠다.
		
		log.info("현재 접속자 수 : {}", users.size()); //저장소에 담긴 개수로 사용자수 확인하기
	}
	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		users.remove(session);
		
		log.info("접속 종료! 현재 접속자 수 : {}", users.size());
	}
	
	
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//메세지를 모든 사용자에게 전송(사용자 수만큼 반복하여 전송)
		TextMessage newMessage = new TextMessage(message.getPayload());
		
		for(WebSocketSession ws : users) {
			ws.sendMessage(newMessage);	
		}
		

		
		
	}
	
}

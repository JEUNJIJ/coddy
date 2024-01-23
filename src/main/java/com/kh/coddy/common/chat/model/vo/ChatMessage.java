package com.kh.coddy.common.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class ChatMessage {

	private String messageId; // 메세지 번호
	private String roomId;    // 프로젝트 번호
	private int memberNo; 	  // 보낸사람 회원번호
	private String memberName; 	  // 보낸사람 이름
	private String role;
	private String message;   // 메세지 내용	
	private int unReadCount;  // 안읽은 메세지 수
	private int sessionCount; // 현재 세션 수
	private String messageType; // 메세지 타입(1: 채팅참여자, 2: 공지)
}

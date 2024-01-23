package com.kh.coddy.common.chat.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class ChatRoom {
	
	private Integer roomId;  // 방번호
	private int userNo;
	private Date chatInsert;
	
	public ChatRoom(Integer roomId, int userNo) {
		this.roomId = roomId;
		this.userNo = userNo;
	}
}
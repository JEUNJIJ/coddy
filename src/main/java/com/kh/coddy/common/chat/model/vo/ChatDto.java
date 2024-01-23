package com.kh.coddy.common.chat.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class ChatDto {
	private ArrayList<ChatMessage> mList;
	private ArrayList<ChatMember> cList;
}

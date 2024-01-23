package com.kh.coddy.common.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class ChatMember {
	private int projectNo;
	private int memberNo;
	private String role;
	private String memberName;
	private String memberPhotoExtend;
}

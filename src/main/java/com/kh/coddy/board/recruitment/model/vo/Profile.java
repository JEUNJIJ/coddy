package com.kh.coddy.board.recruitment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Profile {
	private int memberNo;
	private String memberName;
	private String role;
	private int projectNo;
	private String profileImg;
	
}

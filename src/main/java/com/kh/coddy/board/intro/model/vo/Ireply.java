package com.kh.coddy.board.intro.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class Ireply {

	private int ireplyNo;		//	IREPLY_NO	NUMBER
	private String memberNo;		//	MEMBER_NO	NUMBER
	private int iboardNo;		//	IBOARD_NO	NUMBER
	private int ireplyParent;		//	IREPLY_PARENT	NUMBER
	private String ireplyContent;		//	IREPLY_CONTENT	VARCHAR2(2000 BYTE)
	private String ireplyInsert;		//	IREPLY_INSERT	DATE
	private String ireplyUpdate;		//	IREPLY_UPDATE	DATE
	private String ireplyDelete;		//	IREPLY_DELETE	DATE
	
}
package com.kh.coddy.board.code.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class CreplyImage {
	private int creplyNo;			//	IREPLY_NO	NUMBER
	private String memberNo;		//	MEMBER_NO	NUMBER
	private String memberName;
	private int cboardNo;			//	IBOARD_NO	NUMBER
	private int creplyParent;		//	IREPLY_PARENT	NUMBER
	private String creplyContent;	//	IREPLY_CONTENT	VARCHAR2(2000 BYTE)
	private String creplyInsert;	//	IREPLY_INSERT	DATE
	private String creplyUpdate;	//	IREPLY_UPDATE	DATE
	private String creplyDelete;	//	IREPLY_DELETE	DATE
}
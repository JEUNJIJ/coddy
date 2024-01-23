package com.kh.coddy.board.code.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Creply {

	private int creplyNo; 		 	//	REPLY_NO	NUMBER
	private int memberNo;			//	MEMBER_NO  NUMBER
	private int cboardNo;			//	CBOARD_NO  NUMBER
	private int creplyParent;		//	REPLY_PARENT  NUMBER
	private String creplyContent;	//	REPLY_CONTENT  VARCHAR2(2000)
	private String creplyInsert;	//	REPLY_INSERT  DATE
	private String creplyUpdate;	//	REPLY_UPDATE  DATE
	private String creplyDelete;	//	REPLY_DELETE  DATE

}

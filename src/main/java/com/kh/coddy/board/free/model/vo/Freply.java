package com.kh.coddy.board.free.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Freply {

	private int freplyNo; 		 	//	REPLY_NO	NUMBER
	private String memberNo;			//	MEMBER_NO  NUMBER
	private int fboardNo;			//	FBOARD_NO  NUMBER
	private int freplyParent;		//	FREPLY_PARENT  NUMBER
	private String freplyContent;	//	FREPLY_CONTENT  VARCHAR2(2000)
	private String freplyInsert;	//	FREPLY_INSERT  DATE
	private String freplyUpdate;	//	FREPLY_UPDATE  DATE
	private String freplyDelete;	//	FREPLY_DELETE  DATE

}

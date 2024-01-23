package com.kh.coddy.board.intro.model.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class IBoard {

	
	private int iboardNo;		//	IBOARD_NO	NUMBER
	private String iboardTitle;		//	IBOARD_TITLE	VARCHAR2(400 BYTE)
	private String iboardContent;		//	IBOARD_CONTENT	VARCHAR2(4000 BYTE)
	private String iboardWriter;		//	IBOARD_WRITER	NUMBER
	private String iboardInsert;		//	IBOARD_INSERT	DATE
	private String iboardUpade;		//	IBOARD_UPDATE	DATE
	private String iboardDelete;		//	IBOARD_DELETE	DATE
	private int projectNo;		//	PROJECT_NO	NUMBER
	private int iboardViews;		//	IBOARD_VIEWS	NUMBER
	
}

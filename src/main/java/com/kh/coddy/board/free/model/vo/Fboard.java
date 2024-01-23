package com.kh.coddy.board.free.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Fboard {
			
	private int fboardNo;			//	FBOARD_NO  NUMBER
	private String fboardTitle;		//	FBOARD_TITLE    VARCHAR2(400)
	private String fboardContent;	//	FBOARD_CONTENT  VARCHAR2(4000)
	private String fboardWriter;		//	FBOARD_WRITER   NUMBER
	private String fboardInsert;	//	FBOARD_INSERT   DATE
	private String fboardUpdate;	//	FBOARD_UPDATE   DATE
	private String fboardDelete;		//	FBOARD_DELETE   DATE
	private int fboardViews;		//	FBOARD_VIEWS    NUMBER
	private String fboardOrigin;		//	FBOARD_ORIGIN	VARCHAR2(100)
	private String fboardChange;		//	FBOARD_CHANGE	VARCHAR2(100)
	
}

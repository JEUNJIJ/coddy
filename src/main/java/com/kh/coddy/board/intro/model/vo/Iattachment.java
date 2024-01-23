package com.kh.coddy.board.intro.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class Iattachment {
	
	
	private int iAttachmentNo;			//	IATTACHMENT_NO	NUMBER
	private int iboardNo;			//	IBOARD_NO	NUMBER
	private String iAttachmentOrigin;			//	IATTACHMENT_ORIGIN	VARCHAR2(200 BYTE)
	private String iAttachmentChange;			//	IATTACHMENT_CHANGE	VARCHAR2(200 BYTE)
	private String iAttachmentPath;			//	IATTACHMENT_PATH	VARCHAR2(200 BYTE)
	private Date iAttachmentInsert;			//	IATTACHMENT_INSERT	DATE
	private int iAttachmentLevel;			//	IATTACHMENT_LEVEL	NUMBER
	
}

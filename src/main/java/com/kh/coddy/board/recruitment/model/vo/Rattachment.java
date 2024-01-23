package com.kh.coddy.board.recruitment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Rattachment {
	private int rAttachmentNo; 			//  RECRUITMENT_ATTACHMENT_NO	NUMBER
	private int recruitmentNo; 			//	RECRUITMENT_NO	NUMBER
	private String rAttachmentOrigin;	//	RECRUITMENT_ATTACHMENT_ORIGIN	VARCHAR2(200 BYTE)
	private String rAttachmentChange; 	//	RECRUITMENT_ATTACHMENT_CHANGE	VARCHAR2(200 BYTE)
	private String rAttachmentPath;		//	RECRUITMENT_ATTACHMENT_PATH	VARCHAR2(200 BYTE)
	private String rAttachmentInsert;	//	RECRUITMENT_ATTACHMENT_INSERT	DATE
	private int rAttachmentLevel; 		//	RECRUITMENT_ATTACHMENT_LEVEL	NUMBER
}

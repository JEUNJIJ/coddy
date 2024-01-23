package com.kh.coddy.board.job.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Hattachment {
	private int hattachmentNo;
	private int hboardNo;
	private String hattachmentOrigin;
	private String hattachmentChange;
	private String hattachmentPath;
	private String hattachmentInsert;
	private int hattachmentLevel;
}
package com.kh.coddy.board.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Nattachment {
	private int nattachmentNo;
	private int nboardNo;
	private String nattachmentOrigin;
	private String nattachmentChange;
	private String nattachmentPath;
	private String nattachmentInsert;
	private int nattachmentLevel;
}
package com.kh.coddy.board.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor @NoArgsConstructor @Setter @Getter @ToString
public class Nboard {
	private int nboardNo;
	private String nboardTitle;
	private String nboardContent;
	private String nboardInsert;
	private String nboardUpdate;
	private String nboardDelete;
	private int nboardViews;
	private String nboardOrigin;		
	private String nboardChange;
}

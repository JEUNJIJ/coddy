package com.kh.coddy.board.job.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class HSearch {
	private String keyword;
	private String[] education;
	private String[] career;
	private String sort;
	private String[] tags;
	private int active;
	private String where_start;
	private String where_end;
}
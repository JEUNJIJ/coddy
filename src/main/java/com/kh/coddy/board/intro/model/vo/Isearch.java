package com.kh.coddy.board.intro.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Isearch {

	private String keyword;
	private String sort;
	private String[] tags;
	
}

package com.kh.coddy.board.recruitment.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class RecruitSearch {
	
	private String keyword;
	private String[] techs;
	private String[] careers;
	private boolean recruit;
	

}

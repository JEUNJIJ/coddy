package com.kh.coddy.board.recruitment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class RecruitmentState {
	private int recruitmentNo;
	private String position;
	private int maxPersonnel;
}

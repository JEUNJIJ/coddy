package com.kh.coddy.board.recruitment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Project {
	private int projectNo;
	private String projectOwner;
	private int recruitmentNo;
	private String projectName;
	private String projectInfo;
	private String projectInsert;
	private String projectStart;
	private String projectEnd;
	private String projectLocation;
	private int projectReady;
}

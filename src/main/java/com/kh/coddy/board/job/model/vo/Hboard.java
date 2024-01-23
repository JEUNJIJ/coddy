package com.kh.coddy.board.job.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor @NoArgsConstructor @Setter @Getter @ToString
public class Hboard {
	private int hboardNo;
	private String hboardTitle;
	private String hboardContent;
	private String hboardInsert;
	private String hboardUpdate;
	private String hboardDelete;
	private int hboardViews;
	private String companyNo;
	private String hboardStart;
	private String hboardEnd;
	private int hboardSalary;
	private String hboardEducation;
	private String hboardCareer;
	private String hboardLocation;
}
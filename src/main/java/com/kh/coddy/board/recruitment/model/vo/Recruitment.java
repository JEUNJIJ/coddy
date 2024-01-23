package com.kh.coddy.board.recruitment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor @NoArgsConstructor @Setter @Getter @ToString
public class Recruitment {
	private int recruitmentNo;			
	private String recruitmentTitle;	
	private String recruitmentContent;
	private String recruitmentWriter;	
	private String recruitmentInsert;	
	private String recruitmentUpdate;	
	private String recruitmentDelete;	
	private int recruitmentView;		
	private String recruitmentStart;	
	private String recruitmentEnd;		
	private String recruitmentLocation;	
	private String recruitmentIntro;	
}
 
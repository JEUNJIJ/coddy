package com.kh.coddy.board.recruitment.model.vo;

import java.util.ArrayList;

import com.kh.coddy.common.vo.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor @NoArgsConstructor @Setter @Getter @ToString
public class RecruitmentSearchDto {
	
	private PageInfo pi;
	private ArrayList<Recruitment> list;
	private ArrayList<Rattachment>at_list;
	private ArrayList<ArrayList<Prelation>>tg_list;
	private ArrayList<ArrayList<RecruitmentState>>pos_list;
	private ArrayList<Boolean>ws_list;
}

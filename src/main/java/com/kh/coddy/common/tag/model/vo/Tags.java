package com.kh.coddy.common.tag.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Tags {
	private int tagsNo;
	private String tagsName;
	private int tagsType;
	private int tagsActive;
}
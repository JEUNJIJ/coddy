package com.kh.coddy.member.model.vo;

import javax.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class Member {
	private int memberNo;
	private String memberId;
	private String memberPwd;
	@Pattern(regexp="^[a-zA-Z0-9_+&*-]+(?:\\." + "[a-zA-Z0-9_+&*-]+)*@" + "(?:[a-zA-Z0-9-]+\\.)+[a-z" + "A-Z]{2,7}$", message="이메일 형태가 아닙니다.") private String memberEmail;
	private String memberName;
	@Pattern(regexp="^\\\\S+.(?i)(jpg|jpeg|png)$", message="지원하는 파일이 아닙니다.") private String memberPhotoExtend;
	private String memberInfo;
	private String memberInsert;
	private String memberDelete;
}
package com.kh.coddy.member.model.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Setter @Getter @ToString
public class Company {
	private int companyNo;
	private String companyName;
	private String companyOwner;
	private String companyId;
	private String companyPwd;
	@Pattern(regexp="^[a-zA-Z0-9_+&*-]+(?:\\." + "[a-zA-Z0-9_+&*-]+)*@" + "(?:[a-zA-Z0-9-]+\\.)+[a-z" + "A-Z]{2,7}$", message="이메일 형태가 아닙니다.") private String companyEmail;
	@Pattern(regexp="^\\\\S+.(?i)(jpg|jpeg|png)$", message="지원하는 파일이 아닙니다.") private String companyPhotoExtend;
	private String companyBno;
	private String companyInfo;
	private String companyInsert;
	private String companyDelete;
	@Min(value=0, message="직원수는 음수가 될 수 없습니다.") private int companyWorker;
	@Min(value=0, message="연봉은 음수가 될 수 없습니다.") private int companySalary;
}
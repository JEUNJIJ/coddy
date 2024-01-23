package com.kh.coddy.member.model.service;

import com.kh.coddy.member.model.vo.Company;

public interface CompanyService {
	int companyCheck(String id);
	int insertCompany(Company c);
	Company login(Company c);
	String findIdAccess(Company c);
	int setNewPassword(Company c);
	int uploadFile(int companyNo);
	int countWritten(int companyNo);
	String getPassword(String companyId);
	int updateCompany(Company c);
	int deleteCompany(int companyNo);
	Company getCompanyByNo(int companyNo);
}
package com.kh.coddy.admin.member.model.service;

import java.util.ArrayList;

import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Company;

public interface CompanyAdminService {
	int selectListCount();
	ArrayList<Company> selectList(PageInfo pi);
	int forceDelete(int companyNo);
	int forceRestore(int companyNo);
}
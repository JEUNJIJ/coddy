package com.kh.coddy.admin.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.admin.member.model.dao.CompanyAdminDao;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Company;

@Service
public class CompanyAdminServiceImpl implements CompanyAdminService {
	@Autowired SqlSessionTemplate sqlSession;
	@Autowired CompanyAdminDao companyDao;
	
	@Override public int selectListCount() { return companyDao.selectListCount(sqlSession); }
	@Override public ArrayList<Company> selectList(PageInfo pi) { return companyDao.selectList(sqlSession, pi); }
	@Override public int forceDelete(int companyNo) { return companyDao.forceDelete(sqlSession, companyNo); }
	@Override public int forceRestore(int companyNo) { return companyDao.forceRestore(sqlSession, companyNo); }
}
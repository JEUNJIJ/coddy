package com.kh.coddy.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.member.model.dao.CompanyDao;
import com.kh.coddy.member.model.vo.Company;

@Service
public class CompanyServiceImpl implements CompanyService {
	@Autowired private CompanyDao companyDao;
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override public int companyCheck(String id) { return companyDao.companyCheck(sqlSession, id); }
	@Override public int insertCompany(Company c) { return companyDao.insertCompany(sqlSession, c); }
	@Override public Company login(Company c) { return companyDao.login(sqlSession, c); }
	@Override public String findIdAccess(Company c) { return companyDao.findIdAccess(sqlSession, c); }
	@Override public int setNewPassword(Company c) { return companyDao.setNewPassword(sqlSession, c); }
	@Override public int uploadFile(int companyNo) { return companyDao.uploadFile(sqlSession, companyNo); }
	@Override public int countWritten(int companyNo) { return companyDao.countWritten(sqlSession, companyNo); }
	@Override public String getPassword(String companyId) { return companyDao.getPassword(sqlSession, companyId); }
	@Override public int updateCompany(Company c) { return companyDao.updateCompany(sqlSession, c); }
	@Override public int deleteCompany(int companyNo) { return companyDao.deleteCompany(sqlSession, companyNo); }
	@Override public Company getCompanyByNo(int companyNo) { return companyDao.getCompanyByNo(sqlSession, companyNo); }
}
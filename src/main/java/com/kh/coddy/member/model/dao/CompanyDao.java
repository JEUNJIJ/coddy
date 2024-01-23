package com.kh.coddy.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.member.model.vo.Company;

@Repository
public class CompanyDao {
	public int companyCheck(SqlSessionTemplate sqlSession, String id) { return sqlSession.selectOne("companyMapper.companyCheck", id); }
	public int insertCompany(SqlSessionTemplate sqlSession, Company c) { return sqlSession.insert("companyMapper.insertCompany", c); }
	public Company login(SqlSessionTemplate sqlSession, Company c) { return sqlSession.selectOne("companyMapper.loginCompany", c); }
	public String findIdAccess(SqlSessionTemplate sqlSession, Company c) { return sqlSession.selectOne("companyMapper.findIdAccess", c); }
	public int setNewPassword(SqlSessionTemplate sqlSession, Company c) { return sqlSession.update("companyMapper.setNewPassword", c); }
	public int uploadFile(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.update("companyMapper.uploadFile", companyNo); }
	public int countWritten(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.selectOne("companyMapper.countWritten", companyNo); }
	public String getPassword(SqlSessionTemplate sqlSession, String companyId) { return sqlSession.selectOne("companyMapper.getPassword", companyId); }
	public int updateCompany(SqlSessionTemplate sqlSession, Company c) { return sqlSession.update("companyMapper.updateCompany", c); }
	public int deleteCompany(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.update("companyMapper.deleteCompany", companyNo); }
	public Company getCompanyByNo(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.selectOne("companyMapper.getCompanyByNo", companyNo); }
}
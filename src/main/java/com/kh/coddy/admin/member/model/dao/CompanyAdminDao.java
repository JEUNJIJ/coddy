package com.kh.coddy.admin.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Company;

@Repository
public class CompanyAdminDao {
	public int selectListCount(SqlSessionTemplate sqlSession) { return sqlSession.selectOne("companyMapper.selectListCount"); }
	public ArrayList<Company> selectList(SqlSessionTemplate sqlSession, PageInfo pi) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("companyMapper.selectList", null, new RowBounds(offset, limit)); }
	public int forceDelete(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.update("companyMapper.deleteCompany", companyNo); }
	public int forceRestore(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.update("companyMapper.restoreCompany", companyNo); }
}
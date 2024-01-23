package com.kh.coddy.admin.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Repository
public class MemberAdminDao {
	public int selectListCount(SqlSessionTemplate sqlSession) { return sqlSession.selectOne("memberMapper.selectListCountAdmin"); }
	public ArrayList<Member> selectList(SqlSessionTemplate sqlSession, PageInfo pi) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("memberMapper.selectListAdmin", null, new RowBounds(offset, limit)); }
	public int forceDelete(SqlSessionTemplate sqlSession, int memberNo) { return sqlSession.update("memberMapper.deleteMemberAdmin", memberNo); }
	public int forceRestore(SqlSessionTemplate sqlSession, int memberNo) { return sqlSession.update("memberMapper.restoreMemberAdmin", memberNo); }
}
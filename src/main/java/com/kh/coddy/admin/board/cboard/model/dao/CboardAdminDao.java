package com.kh.coddy.admin.board.cboard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.code.model.vo.Crelation;
import com.kh.coddy.common.vo.PageInfo;

@Repository
public class CboardAdminDao {
	public int selectListCount(SqlSessionTemplate sqlSession) { return sqlSession.selectOne("cboardMapper.selectListCountAdmin"); }
	public ArrayList<Cboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("cboardMapper.selectListAdmin", null, new RowBounds(offset, limit)); }
	public int forceDelete(SqlSessionTemplate sqlSession, int cboardNo) { return sqlSession.update("cboardMapper.forceDelete", cboardNo); }
	public int forceRestore(SqlSessionTemplate sqlSession, int cboardNo) { return sqlSession.update("cboardMapper.forceRestore", cboardNo); }
	public String getTag(SqlSessionTemplate sqlSession, int cboardNo) { ArrayList<Crelation> cr = (ArrayList)sqlSession.selectList("cboardMapper.getTag", cboardNo); String ret = ""; for(Crelation c: cr) ret+=c.getTagsNo()+","; return ret.substring(0, ret.length() - 1); }
}
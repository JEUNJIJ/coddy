package com.kh.coddy.admin.board.hboard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hrelation;
import com.kh.coddy.common.vo.PageInfo;

@Repository
public class HboardAdminDao {
	public int selectListCount(SqlSessionTemplate sqlSession) { return sqlSession.selectOne("hboardMapper.selectListCountAdmin"); }
	public ArrayList<Hboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("hboardMapper.selectListAdmin", null, new RowBounds(offset, limit)); }
	public int forceDelete(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.update("hboardMapper.forceDelete", hboardNo); }
	public int forceRestore(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.update("hboardMapper.forceRestore", hboardNo); }
	public String getTag(SqlSessionTemplate sqlSession, int hboardNo) { ArrayList<Hrelation> hr = (ArrayList)sqlSession.selectList("hboardMapper.getTag", hboardNo); String ret = ""; for(Hrelation h: hr) ret+=h.getTagsNo()+","; return ret.substring(0, ret.length() - 1); }
}
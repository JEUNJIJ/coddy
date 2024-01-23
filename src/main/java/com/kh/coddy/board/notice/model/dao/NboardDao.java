package com.kh.coddy.board.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.notice.model.vo.Nboard;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.board.notice.model.vo.Nattachment;

@Repository
public class NboardDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("nboardMapper.selectListCount");
	}
	
	public ArrayList<Nboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList)sqlSession.selectList("nboardMapper.selectList", null, rowBounds);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Nboard n) {

		return sqlSession.insert("nboardMapper.insertBoard", n);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int nboardNo) {
	
		return sqlSession.update("nboardMapper.increaseCount", nboardNo);
	}
	
	public Nboard selectBoard(SqlSessionTemplate sqlSession, int nboardNo) {

		return sqlSession.selectOne("nboardMapper.selectBoard", nboardNo);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, int nboardNo) {

		return sqlSession.update("nboardMapper.deleteBoard", nboardNo);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Nboard n) {
		
		return sqlSession.update("nboardMapper.updateBoard", n);
	}

	public ArrayList<Nattachment> selectAttachmentList(SqlSessionTemplate sqlSession, int nboardNo) {
		
	    return (ArrayList)sqlSession.selectList("nboardMapper.selectAttachmentList", nboardNo);
	}

	public Nattachment selectOneAttachment(SqlSessionTemplate sqlSession, int nattachmentNo) {
		
	    return sqlSession.selectOne("nboardMapper.selectOneAttachment", nattachmentNo);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, int nattachmentNo) {
		
	    return sqlSession.delete("nboardMapper.deleteAttachment", nattachmentNo);
	}
}

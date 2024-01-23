package com.kh.coddy.board.free.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.free.model.vo.Freply;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.free.model.vo.Fattachment;


@Repository
public class FboardDao {
    
	public int selectListCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("fboardMapper.selectListCount");
	}
	
	public ArrayList<Fboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList)sqlSession.selectList("fboardMapper.selectList", null, rowBounds);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Fboard f) {

		return sqlSession.insert("fboardMapper.insertBoard", f);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int fboardNo) {
	
		return sqlSession.update("fboardMapper.increaseCount", fboardNo);
	}
	
	public Fboard selectBoard(SqlSessionTemplate sqlSession, int fboardNo) {

		return sqlSession.selectOne("fboardMapper.selectBoard", fboardNo);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, int fboardNo) {

		return sqlSession.update("fboardMapper.deleteBoard", fboardNo);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Fboard f) {
		
		return sqlSession.update("fboardMapper.updateBoard", f);
	}
	
	public ArrayList<Freply> selectReplyList(SqlSessionTemplate sqlSession, int fboardNo) {

		return (ArrayList) sqlSession.selectList("fboardMapper.selectReplyList", fboardNo);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Freply fr) {

		return sqlSession.insert("fboardMapper.insertReply", fr);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int freplyNo) {

		return sqlSession.update("fboardMapper.deleteReply", freplyNo);
	}

	public int updateReply(SqlSessionTemplate sqlSession, Freply fr) {

		return sqlSession.update("fboardMapper.updateReply", fr);
	}
	
	public ArrayList<Fboard> selectTopBoardList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("fboardMapper.selectTopBoardList");
	}
	public ArrayList<Fattachment> selectAttachmentList(SqlSessionTemplate sqlSession, int fboardNo) {
		
	    return (ArrayList)sqlSession.selectList("fboardMapper.selectAttachmentList", fboardNo);
	}

	public Fattachment selectOneAttachment(SqlSessionTemplate sqlSession, int fattachmentNo) {
		
	    return sqlSession.selectOne("fboardMapper.selectOneAttachment", fattachmentNo);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, int fattachmentNo) {
		
	    return sqlSession.delete("fboardMapper.deleteAttachment", fattachmentNo);
	}

}

package com.kh.coddy.board.code.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.code.model.vo.Crelation;
import com.kh.coddy.board.code.model.vo.Creply;
import com.kh.coddy.board.code.model.vo.CreplyImage;
import com.kh.coddy.common.vo.PageInfo;

@Repository
public class CboardDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("cboardMapper.selectListCount");
	}

	
	public ArrayList<Cboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		// 1. 일단 전체 게시글 목록 조회 (최신순)
		ArrayList<Cboard> list = new ArrayList<>(sqlSession.selectList("cboardMapper.selectList", null, rowBounds));

		// 2. 조회된 게시글 목록으로부터 반복적으로 해당 게시글에 딸린 태그들만 또 조회
		for (int i = 0; i < list.size(); i++) {

			int cboardNo = list.get(i).getCboardNo();

			ArrayList<String> tags = (ArrayList) sqlSession.selectList("cboardMapper.selectTagList", cboardNo);

			// System.out.println(tags);

			list.get(i).setTags(tags); // 게시글별 태그 목록 매칭
		}

		return list; // 태그목록이 포함된 리스트 리턴 ^0^
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Cboard c) {

		return sqlSession.insert("cboardMapper.insertBoard", c);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int cboardNo) {

		return sqlSession.update("cboardMapper.increaseCount", cboardNo);
	}

	public Cboard selectBoard(SqlSessionTemplate sqlSession, int cboardNo) {

		return sqlSession.selectOne("cboardMapper.selectBoard", cboardNo);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int cboardNo) {

		return sqlSession.update("cboardMapper.deleteBoard", cboardNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Cboard c) {

		return sqlSession.update("cboardMapper.updateBoard", c);
	}

	public ArrayList<CreplyImage> selectReplyList(SqlSessionTemplate sqlSession, int cboardNo) {

		return (ArrayList) sqlSession.selectList("cboardMapper.selectReplyList", cboardNo);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Creply cr) {

		return sqlSession.insert("cboardMapper.insertReply", cr);
	}

	public int deletereply(SqlSessionTemplate sqlSession, int creplyNo) {

		return sqlSession.update("cboardMapper.deletereply", creplyNo);
	}

	public int updatereply(SqlSessionTemplate sqlSession, Creply cr) {

		return sqlSession.update("cboardMapper.updatereply", cr);
	}

	public ArrayList<Cboard> selectTopBoardList(SqlSessionTemplate sqlSession) {

		return (ArrayList) sqlSession.selectList("cboardMapper.selectTopBoardList");
	}

	public ArrayList<Crelation> getTagInfo(SqlSessionTemplate sqlSession, Cboard c) {

		return (ArrayList) sqlSession.selectList("cboardMapper.getTagInfo", c);
	}

	public int insertTag(SqlSessionTemplate sqlSession, String tag) {

		return sqlSession.insert("cboardMapper.insertTag", tag);
	}

	public int selectSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {

		return sqlSession.selectOne("cboardMapper.selectSearchCount", map);
	}

	public ArrayList<Cboard> selectSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("cboardMapper.selectSearchList", map, rowBounds);
	}

}

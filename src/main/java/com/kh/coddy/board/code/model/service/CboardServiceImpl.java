package com.kh.coddy.board.code.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.coddy.board.code.model.dao.CboardDao;
import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.code.model.vo.Crelation;
import com.kh.coddy.board.code.model.vo.Creply;
import com.kh.coddy.board.code.model.vo.CreplyImage;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class CboardServiceImpl implements CboardService {

	@Autowired
	private CboardDao boardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Cboard> selectList(PageInfo pi) {
		return boardDao.selectList(sqlSession, pi);
	}

	@Override
	@Transactional 
	public int insertBoard(Cboard c) {
		return boardDao.insertBoard(sqlSession, c);
	}

	@Override
	@Transactional
	public int increaseCount(int cboardNo) {
		return boardDao.increaseCount(sqlSession, cboardNo);
	}

	@Override
	public Cboard selectBoard(int cboardNo) {
		return boardDao.selectBoard(sqlSession, cboardNo);
	}

	@Override
	@Transactional
	public int deleteBoard(int cboardNo) {
		return boardDao.deleteBoard(sqlSession, cboardNo);
	}

	@Override
	@Transactional
	public int updateBoard(Cboard c) {
		return boardDao.updateBoard(sqlSession, c);
	}

	@Override
	public ArrayList<CreplyImage> selectReplyList(int cboardNo) {
		
		return boardDao.selectReplyList(sqlSession, cboardNo);
	}
	
	@Override
	public int insertReply(Creply cr) {

		return boardDao.insertReply(sqlSession, cr);
	}

	@Override
	public int deletereply(int creplyNo) {
		
		return boardDao.deletereply(sqlSession, creplyNo);
	}

	@Override
	public int updatereply(Creply cr) {
		
		return boardDao.updatereply(sqlSession, cr);
	}

	@Override
	public ArrayList<Cboard> selectTopBoardList() {
		return boardDao.selectTopBoardList(sqlSession);
	}
	
	@Override
	public ArrayList<Crelation> getTagInfo(Cboard c) {
		
		return boardDao.getTagInfo(sqlSession, c);
	}

	@Override
	public int insertTag(String tag) {
		
		return boardDao.insertTag(sqlSession, tag);
	}
	
	@Override
	public int selectSearchCount(HashMap<String, String> map) {
	     return boardDao.selectSearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Cboard> selectSearchList(HashMap<String, String> map, PageInfo pi) {
	     return boardDao.selectSearchList(sqlSession, map, pi);
	}
}

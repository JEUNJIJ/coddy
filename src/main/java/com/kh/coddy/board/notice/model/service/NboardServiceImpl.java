package com.kh.coddy.board.notice.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.coddy.board.notice.model.dao.NboardDao;
import com.kh.coddy.board.notice.model.vo.Nattachment;
import com.kh.coddy.board.notice.model.vo.Nboard;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class NboardServiceImpl implements NboardService{


	@Autowired
	private NboardDao nboardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return nboardDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Nboard> selectList(PageInfo pi) {
		return nboardDao.selectList(sqlSession, pi);
	}

	@Override
	@Transactional 
	public int insertBoard(Nboard n) {
		return nboardDao.insertBoard(sqlSession, n);
	}

	@Override
	@Transactional
	public int increaseCount(int nboardNo) {
		return nboardDao.increaseCount(sqlSession, nboardNo);
	}

	@Override
	public Nboard selectBoard(int nboardNo) {
		return nboardDao.selectBoard(sqlSession, nboardNo);
	}

	@Override
	@Transactional
	public int deleteBoard(int nboardNo) {
		return nboardDao.deleteBoard(sqlSession, nboardNo);
	}

	@Override
	@Transactional
	public int updateBoard(Nboard n) {
		return nboardDao.updateBoard(sqlSession, n);
	}

	@Override
	public int insertAttachment(Nattachment nattachment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Nattachment selectOneAttachment(int nattachmentNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteAttachment(int nattachmentNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Nattachment> selectAttachmentList(int nboardNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
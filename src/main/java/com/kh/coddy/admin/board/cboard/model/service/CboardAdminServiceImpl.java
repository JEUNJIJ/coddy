package com.kh.coddy.admin.board.cboard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.admin.board.cboard.model.dao.CboardAdminDao;
import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class CboardAdminServiceImpl implements CboardAdminService {
	@Autowired SqlSessionTemplate sqlSession;
	@Autowired CboardAdminDao cboardDao;
	
	@Override public int selectListCount() { return cboardDao.selectListCount(sqlSession); }
	@Override public ArrayList<Cboard> selectList(PageInfo pi) { return cboardDao.selectList(sqlSession, pi); }
	@Override public int forceDelete(int cboardNo) { return cboardDao.forceDelete(sqlSession, cboardNo); }
	@Override public int forceRestore(int cboardNo) { return cboardDao.forceRestore(sqlSession, cboardNo); }
	@Override public String getTag(int cboardNo) { return cboardDao.getTag(sqlSession, cboardNo); }
}
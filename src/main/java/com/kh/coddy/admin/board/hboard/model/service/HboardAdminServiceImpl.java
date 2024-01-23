package com.kh.coddy.admin.board.hboard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.admin.board.hboard.model.dao.HboardAdminDao;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class HboardAdminServiceImpl implements HboardAdminService {
	@Autowired SqlSessionTemplate sqlSession;
	@Autowired HboardAdminDao hboardDao;
	
	@Override public int selectListCount() { return hboardDao.selectListCount(sqlSession); }
	@Override public ArrayList<Hboard> selectList(PageInfo pi) { return hboardDao.selectList(sqlSession, pi); }
	@Override public int forceDelete(int hboardNo) { return hboardDao.forceDelete(sqlSession, hboardNo); }
	@Override public int forceRestore(int hboardNo) { return hboardDao.forceRestore(sqlSession, hboardNo); }
	@Override public String getTag(int hboardNo) { return hboardDao.getTag(sqlSession, hboardNo); }
}
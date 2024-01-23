package com.kh.coddy.board.job.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.board.job.model.dao.HboardDao;
import com.kh.coddy.board.job.model.vo.HSearch;
import com.kh.coddy.board.job.model.vo.Hattachment;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hrelation;
import com.kh.coddy.board.job.model.vo.Hwishlist;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class HboardServiceImpl implements HboardService {
	@Autowired private SqlSessionTemplate sqlSession;
	@Autowired private HboardDao hboardDao;
	
	@Override public int insertBoard(Hboard h) { return hboardDao.insertBoard(sqlSession, h); }
	@Override public int initTag(int hboardNo) { return hboardDao.initTag(sqlSession, hboardNo); }
	@Override public boolean insertTag(Hrelation hr) { return (hboardDao.insertTag(sqlSession, hr) > 0 ? true : false); }
	@Override public boolean insertTag2(Hrelation hr) { return (hboardDao.insertTag2(sqlSession, hr) > 0 ? true : false); }
	@Override public int insertThumb(Hattachment ha) { return hboardDao.insertThumb(sqlSession, ha); }
	@Override public int insertThumb2(Hattachment ha) { return hboardDao.insertThumb2(sqlSession, ha); }
	@Override public int selectListCount(HSearch hs) {  return hboardDao.selectListCount(sqlSession, hs); }
	@Override public ArrayList<Hboard> selectList(PageInfo pi, HSearch hs) { return hboardDao.selectList(sqlSession, pi, hs); }
	@Override public Hattachment getThumbOne(Hboard h) {
		Hattachment ha = hboardDao.getThumbOne(sqlSession, h);
		return ha != null ? ha : new Hattachment(-1, h.getHboardNo(), "white.jpg", "white.jpg", "resources\\image", null, 1);
	}
	@Override public ArrayList<Hrelation> getTagInfo(Hboard h) { return hboardDao.getTagInfo(sqlSession, h); }
	@Override public Boolean getWishList(Hboard h, int mno) { h.setHboardContent(String.valueOf(mno)); return hboardDao.getWishList(sqlSession, h) > 0 ? true : false; }
	@Override public int getWish(Hwishlist hw) { return hboardDao.getWish(sqlSession, hw); }
	@Override public String deleteWish(Hwishlist hw) { int result = hboardDao.deleteWish(sqlSession, hw); return (result > 0) ? "찜목록 제거에 성공함": "찜목록 제거에 실패함"; }
	@Override public String insertWish(Hwishlist hw) { int result = hboardDao.insertWish(sqlSession, hw); return (result > 0) ? "찜목록 추가에 성공함": "찜목록 추가에 실패함"; }
	@Override public int plusView(int hno) { return hboardDao.plusView(sqlSession, hno); }
	@Override public Hboard selectBoard(int hno) { return hboardDao.selectBoard(sqlSession, hno); }
	@Override public ArrayList<Hattachment> getAttachmentList(Hboard h) { return hboardDao.getAttachmentList(sqlSession, h); }
	@Override public int addFile(Hattachment ha) { return hboardDao.addFile(sqlSession, ha); }
	@Override public int minusFile(int ano) { return hboardDao.minusFile(sqlSession, ano); }
	@Override public int rejectThumb(int hboardNo) { return hboardDao.rejectThumb(sqlSession, hboardNo); }
	@Override public int updateBoard(Hboard h) { return hboardDao.updateBoard(sqlSession, h); }
	@Override public int deleteBoard(int hboardNo) { return hboardDao.deleteBoard(sqlSession, hboardNo); }
	@Override public int selectListCount(int companyNo) { return hboardDao.selectListCount(sqlSession, companyNo); }
	@Override public ArrayList<Hboard> selectList(PageInfo pi, int companyNo) { return hboardDao.selectList(sqlSession, pi, companyNo); }
	@Override public int getAllWish(int hboardNo) { return hboardDao.getAllWish(sqlSession, hboardNo); }
}
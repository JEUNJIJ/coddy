package com.kh.coddy.board.job.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.job.model.vo.HSearch;
import com.kh.coddy.board.job.model.vo.Hattachment;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hrelation;
import com.kh.coddy.board.job.model.vo.Hwishlist;
import com.kh.coddy.common.vo.PageInfo;

@Repository
public class HboardDao {
	public int insertBoard(SqlSessionTemplate sqlSession, Hboard h) { return sqlSession.insert("hboardMapper.insertBoard", h); }
	public int initTag(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.delete("hboardMapper.initTag", hboardNo); }
	public int insertTag(SqlSessionTemplate sqlSession, Hrelation hr) { return sqlSession.insert("hboardMapper.insertTag", hr); }
	public int insertTag2(SqlSessionTemplate sqlSession, Hrelation hr) { return sqlSession.insert("hboardMapper.insertTag2", hr); }
	public int insertThumb(SqlSessionTemplate sqlSession, Hattachment ha) { return sqlSession.insert("hboardMapper.insertThumb", ha); }
	public int insertThumb2(SqlSessionTemplate sqlSession, Hattachment ha) { return sqlSession.insert("hboardMapper.insertThumb2", ha); }
	public int selectListCount(SqlSessionTemplate sqlSession, HSearch hs) { return sqlSession.selectOne("hboardMapper.selectListCount", hs); }
	public ArrayList<Hboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi, HSearch hs) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("hboardMapper.selectList", hs, new RowBounds(offset, limit)); }
	public Hattachment getThumbOne(SqlSessionTemplate sqlSession, Hboard h) { return (Hattachment)sqlSession.selectOne("hboardMapper.getThumbOne", h); }
	public ArrayList<Hrelation> getTagInfo(SqlSessionTemplate sqlSession, Hboard h) { return (ArrayList)sqlSession.selectList("hboardMapper.getTagInfo", h); }
	public int getWishList(SqlSessionTemplate sqlSession, Hboard h) { return sqlSession.selectOne("hboardMapper.getWishList", h); }
	public int getWish(SqlSessionTemplate sqlSession, Hwishlist hw) { return sqlSession.selectOne("hboardMapper.getWish", hw); }
	public int deleteWish(SqlSessionTemplate sqlSession, Hwishlist hw) { return sqlSession.delete("hboardMapper.deleteWish", hw); }
	public int insertWish(SqlSessionTemplate sqlSession, Hwishlist hw) { return sqlSession.insert("hboardMapper.insertWish", hw); }
	public int plusView(SqlSessionTemplate sqlSession, int hno) { return sqlSession.update("hboardMapper.plusView", hno); }
	public Hboard selectBoard(SqlSessionTemplate sqlSession, int hno) { return sqlSession.selectOne("hboardMapper.selectBoard", hno); }
	public ArrayList<Hattachment> getAttachmentList(SqlSessionTemplate sqlSession, Hboard h) { return (ArrayList)sqlSession.selectList("hboardMapper.getAttachmentList", h); }
	public int addFile(SqlSessionTemplate sqlSession, Hattachment ha) { return sqlSession.insert("hboardMapper.addFile", ha); }
	public int minusFile(SqlSessionTemplate sqlSession, int ano) { return sqlSession.update("hboardMapper.minusFile", ano); }
	public int rejectThumb(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.update("hboardMapper.rejectThumb", hboardNo); }
	public int updateBoard(SqlSessionTemplate sqlSession, Hboard h) { return sqlSession.update("hboardMapper.updateBoard", h); }
	public int deleteBoard(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.update("hboardMapper.deleteBoard", hboardNo); }
	public int selectListCount(SqlSessionTemplate sqlSession, int companyNo) { return sqlSession.selectOne("hboardMapper.selectListCountForMyBoard", companyNo); }
	public ArrayList<Hboard> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int companyNo) { int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() - 1) * limit; return (ArrayList)sqlSession.selectList("hboardMapper.selectListForMyBoard", companyNo, new RowBounds(offset, limit)); }
	public int getAllWish(SqlSessionTemplate sqlSession, int hboardNo) { return sqlSession.selectOne("hboardMapper.getAllWish", hboardNo); }
}
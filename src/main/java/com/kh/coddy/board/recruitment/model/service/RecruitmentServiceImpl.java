package com.kh.coddy.board.recruitment.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.board.recruitment.model.dao.RecruitmentDao;
import com.kh.coddy.board.recruitment.model.vo.PlaceDto;
import com.kh.coddy.board.recruitment.model.vo.Prelation;
import com.kh.coddy.board.recruitment.model.vo.Profile;
import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.board.recruitment.model.vo.Rattachment;
import com.kh.coddy.board.recruitment.model.vo.RecruitSearch;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.board.recruitment.model.vo.RecruitmentState;
import com.kh.coddy.board.recruitment.model.vo.RecruitmentWishList;
import com.kh.coddy.common.chat.model.vo.ChatMember;
import com.kh.coddy.common.vo.PageInfo;

import lombok.extern.slf4j.Slf4j;

@Service @Slf4j
public class RecruitmentServiceImpl implements RecruitmentService{

	@Autowired
	private RecruitmentDao rDao;
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertRecruitment(Recruitment r) {
		return rDao.insertRecruitment(sqlSession, r);
	}
	@Override
	public int insertImg(Rattachment ra) {
		return rDao.insertImg(sqlSession,ra);
	}
	@Override
	public int insertTag(Prelation rel) {
		return rDao.insertTag(sqlSession,rel);
	}
	@Override
	public int insertState(RecruitmentState state) {
		return rDao.insertState(sqlSession,state);
	}
	@Override
	public int createProject(Project p) {
		return rDao.createProject(sqlSession,p);
	}

//	@Override 
//	public int selectListCount(RSearch rs){ 
//		return rDao.selectListCount(sqlSession, rs); 
//	}
	@Override 
	public int selectListCount(){ 
		return rDao.selectListCount(sqlSession); 
	}
//	@Override
//	public ArrayList<Recruitment> selectList(PageInfo pi, RSearch rs) {
//		return rDao.selectList(sqlSession,pi,rs);
//	}
	@Override
	public ArrayList<Recruitment> selectList(PageInfo pi) {
		return rDao.selectList(sqlSession,pi);
	}
	@Override 
	public Rattachment getThumbOne(Recruitment r) {
		Rattachment ra = rDao.getThumbOne(sqlSession, r);
		return ra != null ? ra : new Rattachment(-1, r.getRecruitmentNo(), "white.jpg", "white.jpg", "resources\\image", null, 1);
	}

	@Override
	public ArrayList<Prelation> getTagInfo(Recruitment r) {
		return rDao.getTagInfo(sqlSession,r);
	}
	
	@Override
	public ArrayList<RecruitmentState> getState(Recruitment r) {
		return rDao.getState(sqlSession, r);
	}
	
	@Override 
	public Boolean getWishList(Map<String,Integer> wishMap) { 
		return rDao.getWishList(sqlSession, wishMap) > 0 ? true : false; 
	}
	@Override
	public int getWish(RecruitmentWishList rw) {
		return rDao.getWish(sqlSession, rw);
	}
	@Override
	public String deleteWish(RecruitmentWishList rw) {
		int result = rDao.deleteWish(sqlSession, rw); return (result > 0) ? "찜목록 제거에 성공함": "찜목록 제거에 실패함";
	}
	@Override
	public String insertWish(RecruitmentWishList rw) {
		int result = rDao.insertWish(sqlSession, rw); return (result > 0) ? "찜목록 추가에 성공함": "찜목록 추가에 실패함"; 
	}
	@Override
	public ArrayList<Recruitment> selectPopular() {
		return rDao.selectPopular(sqlSession);
	}
	@Override
	public ArrayList<Rattachment> selectRecent() {
		return rDao.selectRecent(sqlSession);
	}
	@Override
	public Recruitment selectRecruitment(int rno) {
		return rDao.selectRecruitment(sqlSession, rno);
	}
	@Override
	public ArrayList<Rattachment> getAttachmentList(Recruitment r) {
		return rDao.getAttachmentList(sqlSession, r);
	}
	@Override
	public Project getProject(Recruitment r) {
		return rDao.getProject(sqlSession, r);
	}
	@Override
	public int updatePlace(PlaceDto pDto) {
		return rDao.updatePlace(sqlSession, pDto);
	}
	@Override
	public int projectStart(ArrayList<ChatMember> memberList) {
		int pno = memberList.get(0).getProjectNo();
		log.info("pno = {}",pno);
		int result = rDao.updateProjectState(sqlSession, pno);
		log.info("service result = {}",result);		
		int result2 = rDao.insertJoin(sqlSession, memberList);
		log.info("service result2 = {}",result2);
		return result * result2;
				
	}
	@Override
	public int memberExile(HashMap<String, Integer> map) {
		return rDao.memberExile(sqlSession, map);
	}
	@Override
	public ArrayList<Profile> getJoinMember(int pno) {
		return rDao.getJoinMember(sqlSession, pno);
	}
	@Override
	public int getLikeCount(int rno) {
		return rDao.getLikeCount(sqlSession,rno);
	}
	@Override
	public int getViewCount(int rno) {
		return rDao.getLikeCount(sqlSession,rno);
	}
	@Override
	public int insertViewCount(int rno) {
		return rDao.insertViewCount(sqlSession,rno);
	}
	@Override
	public int selectSearchCount(RecruitSearch rSearch) {
		return rDao.selectSearchCount(sqlSession,rSearch);
	}
	@Override
	public ArrayList<Recruitment> selectSearchList(PageInfo pi, RecruitSearch rs) {
		return rDao.selectSearchList(sqlSession, pi, rs);
	}
	
	
	
	
	
	
	
	


	
	
	

}

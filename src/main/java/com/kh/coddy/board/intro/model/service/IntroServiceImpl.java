package com.kh.coddy.board.intro.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.board.intro.model.dao.IntroDao;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.intro.model.vo.Iattachment;
import com.kh.coddy.board.intro.model.vo.Ireply;
import com.kh.coddy.board.intro.model.vo.IreplyImage;
import com.kh.coddy.board.intro.model.vo.Likes;
import com.kh.coddy.board.recruitment.model.vo.Joins;
import com.kh.coddy.board.recruitment.model.vo.Prelation;
import com.kh.coddy.board.recruitment.model.vo.Profile;
import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.board.recruitment.model.vo.Rattachment;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.vo.PageInfo;

@Service
public class IntroServiceImpl implements IntroService {

	@Autowired
	private IntroDao introDao;
	
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertBoard(IBoard i) {
		
		return introDao.insertBoard(sqlSession , i);
	}

	@Override
	public int insertBoardImg(Iattachment ia) {
		
		return introDao.insertBoardImg(sqlSession, ia);
	}

	@Override
	public ArrayList<IBoard> selectList(PageInfo pi) {


		return introDao.selectList(sqlSession, pi);
	}


	@Override
	public Boolean getWishList(IBoard ib, int mno) {
		
		ib.setIboardContent(String.valueOf(mno)); return introDao.getWishList(sqlSession, ib) > 0 ? true : false;
	}

	@Override
	public int selectListCount() {
		
		return introDao.selectListCount(sqlSession);
	}

	@Override
	public Iattachment selectattachment(IBoard ib) {

		Iattachment ia = introDao.selectattachment(sqlSession, ib);
		 
		return ia != null ? ia : new Iattachment(-1, ib.getIboardNo(), "white.jpg", "white.jpg", "resources\\image", null, 1);
	}

	@Override
	public int getWish(Likes iw) {

		return introDao.getWish(sqlSession, iw);
	}

	@Override
	public String deleteWish(Likes iw) {

		int result = introDao.deleteWish(sqlSession, iw); return (result > 0) ? "좋아요 제거에 성공함": "좋아요 제거에 실패함";
	}

	@Override
	public String insertWish(Likes iw) {

		int result = introDao.insertWish(sqlSession, iw); return (result > 0) ? "좋아요 추가에 성공함": "좋아요 추가에 실패함";
	}

	@Override
	public int plusView(int ino) {
	
		return introDao.plusView(sqlSession, ino);
	}

	@Override
	public IBoard selectBoard(int ino) {
		
		return introDao.selectBoard(sqlSession, ino);
	}

	@Override
	public int getAllWish(int iboardNo) {
		
		return introDao.getAllWish(sqlSession, iboardNo);
	}

	@Override
	public int deleteForm(int iboardNo) {
		
		return introDao.deleteForm(sqlSession, iboardNo);
	}

	@Override
	public ArrayList<IreplyImage> selectReplyList(int iboardNo) {
		
		return introDao.selectReplyList(sqlSession, iboardNo);
	}
	
	@Override public ArrayList<IreplyImage> selectReplyListChild(Ireply ir) { return introDao.selectReplyListChild(sqlSession, ir); }
	
	@Override
	public int insertReply(Ireply r) {

		return introDao.insertReply(sqlSession, r);
	}

	@Override
	public int deletereply(int ireplyNo) {
		
		return introDao.deletereply(sqlSession, ireplyNo);
	}

	@Override
	public int updatereply(Ireply r) {
		
		return introDao.updatereply(sqlSession, r);
	}

	@Override
	public ArrayList<IBoard> selectTopList() {
		
		return introDao.selectTopList(sqlSession);
	}

	@Override
	public ArrayList<Project> selectProject(int memberNo) {
		
		return introDao.selectProject(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Recruitment> selectRecruitment(ArrayList<Project> projectlist) {
		
		return introDao.selectRecruitment(sqlSession, projectlist);
	}

	@Override
	public Recruitment selectRecruitment2(int projectNo) {
		
		return introDao.selectRecruitment2(sqlSession, projectNo);
	}
	
	@Override
	public ArrayList<Joins> getState(ArrayList<Project> projectlist) {
		
		return introDao.getState(sqlSession, projectlist);
	}

	@Override
	public Rattachment getThumbOne(Recruitment r) {
		
		return introDao.getThumbOne(sqlSession, r);
	}

	@Override
	public ArrayList<Rattachment> getAttachmentList2(Recruitment r) {
		
		return introDao.getAttachmentList2(sqlSession, r);
	}

	@Override
	public Project getProject(Recruitment r) {
	
		return introDao.getProject(sqlSession, r);
	}

	@Override
	public int updateReady(IBoard i) {
		
		return introDao.updateReady(sqlSession, i);
	}

	@Override
	public ArrayList<Iattachment> selectRecent() {
		
		return introDao.selectRecent(sqlSession);
	}

	@Override
	public Iattachment getThumb2(IBoard ib) {
		
		return introDao.getThumb2(sqlSession, ib);
	}

	@Override
	public int insertImg(Iattachment ia2) {
		
		return introDao.insertImg(sqlSession, ia2);
	}

	@Override
	public Project selectPro(IBoard ib) {
		
		return introDao.selectPro(sqlSession, ib);
	}



	@Override
	public int countLike(IBoard ib) {
		
		return introDao.countLike(sqlSession, ib);
	}

	@Override
	public ArrayList<Prelation> getTagInfo2(Recruitment r) {
	
		return introDao.getTagInfo2(sqlSession, r);
	}

	@Override
	public ArrayList<Iattachment> getAttachmentList3(IBoard ib) {
		
		return introDao.getAttachmentList3(sqlSession, ib);
	}

	@Override
	public Recruitment selectRecruitment3(int iboardNo) {
	
		return introDao.selectRecruitment3(sqlSession, iboardNo);
	}

	@Override
	public int updateBoard(IBoard i) {
		
		return introDao.updateBoard(sqlSession , i);
	}

	@Override
	public IBoard iBoardUpdate(int projectNo) {
		
		return introDao.iBoardUpdate(sqlSession, projectNo);
	}

	@Override
	public ArrayList<Profile> getJoinMember(int projectNo) {
		
		return introDao.getJoinMember(sqlSession, projectNo);
	}

	@Override
	public ArrayList<Joins> getJoinInfo(int projectNo) {
		
		return introDao.getJoinInfo(sqlSession, projectNo);
	}

	@Override
	public ArrayList<Iattachment> iAttachmentUpdate(int iboardNo) {
		
		return introDao.iAttachmentUpdate(sqlSession, iboardNo);
	}
}
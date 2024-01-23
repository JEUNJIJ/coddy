package com.kh.coddy.board.intro.model.service;

import java.util.ArrayList;

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

public interface IntroService {

	// 글 인서트
	int insertBoard(IBoard i);
	
	// 이미지 인서트
	int insertBoardImg(Iattachment ia);

	// 게시글의 총 갯수 조회
	int selectListCount();

	// 전체조회
	ArrayList<IBoard> selectList(PageInfo pi);

	// 이미지 전체조회용
	Iattachment selectattachment(IBoard ib);

	// 좋아요리스트
	Boolean getWishList(IBoard ib,  int mno);

	// 좋아요 기능
	int getWish(Likes iw);

	// 좋아요 제거
	String deleteWish(Likes iw);

	// 좋아요 넣기
	String insertWish(Likes iw);

	// 상세조회 조회수 증가
	int plusView(int ino);

	// 상세조회용 select
	IBoard selectBoard(int ino);

	// 상세
	int getAllWish(int iboardNo);

	// 게시판 글 삭제
	int deleteForm(int iboardNo);

	// 댓글 조회용
	ArrayList<IreplyImage> selectReplyList(int iboardNo);
	
	// 대댓글 조회용
	ArrayList<IreplyImage> selectReplyListChild(Ireply ir);

	// 댓글 작성용
	int insertReply(Ireply r);

	// 댓글 삭제용
	int deletereply(int ireplyNo);
	
	// 댓글 수정용
	int updatereply(Ireply r);

	// 인기게시글
	ArrayList<IBoard> selectTopList();

	// 자기가 한 project list 조회
	ArrayList<Project> selectProject(int memberNo);

	// 자기가 참여한 recruit게시판 list 조회
	ArrayList<Recruitment> selectRecruitment(ArrayList<Project> projectlist);

	// 글작성 페이지에서 R 객체
	Recruitment selectRecruitment2(int projectNo);

	// 글작성 태그 가져오기
	ArrayList<Prelation> getTagInfo2(Recruitment r);

	// 글작성 상태 가져오기
	ArrayList<Joins> getState(ArrayList<Project> projectlist);

	// 글작성 썸네일 가져오기
	Rattachment getThumbOne(Recruitment r);

	ArrayList<Rattachment> getAttachmentList2(Recruitment r);

	Project getProject(Recruitment r);

	// 프로젝트 ready 번호 바꾸기
	int updateReady(IBoard i);

	// 최신글 블러오기
	ArrayList<Iattachment> selectRecent();

	// 상세조회용 썸네일 가져오기
	Iattachment getThumb2(IBoard ib);

	// 이미지 insert 용
	int insertImg(Iattachment ia2);

	// 전체조회 프로젝트
	Project selectPro(IBoard ib);

	// 좋아요 개수 측정
	int countLike(IBoard ib);

	// iboard 이미지 리스트 조회
	ArrayList<Iattachment> getAttachmentList3(IBoard ib);

	// 상세조회용 Recruitment
	Recruitment selectRecruitment3(int iboardNo);

	// iboard 불러올려고 쓰는거
	IBoard iBoardUpdate(int projectNo);

	// update 문
	int updateBoard(IBoard i);

	// 프로필 보여주기용
	ArrayList<Profile> getJoinMember(int projectNo);

	// joins 정보 가져오기
	ArrayList<Joins> getJoinInfo(int projectNo);

	// iAttachment update값 가져오기
	ArrayList<Iattachment> iAttachmentUpdate(int iboardNo);
}
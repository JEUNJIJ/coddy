package com.kh.coddy.board.free.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.free.model.vo.Freply;
import com.kh.coddy.board.free.model.vo.Fattachment;
import com.kh.coddy.common.vo.PageInfo;

public interface FboardService {
	
	// 게시글의 총 갯수 조회
	int selectListCount();
	
	// 게시글 리스트 조회
	ArrayList<Fboard> selectList(PageInfo pi);
	
	// 게시글 작성하기 서비스
	int insertBoard(Fboard f);
	
	// 게시글 상세조회 서비스
	// 게시글 조회수 증가
	int increaseCount(int fboardNo);
	
	// 게시글 상세조회
	Fboard selectBoard(int fboardNo);
	
	// 게시글 삭제 서비스
	int deleteBoard(int fboardNo);
	
	// 게시글 수정 서비스
	int updateBoard(Fboard f);
	
	// 댓글 조회용
	ArrayList<Freply> selectReplyList(int fboardNo);

	// 댓글 작성용
	int insertReply(Freply fr);

	// 댓글 삭제용
	int deleteReply(int freplyNo);
		
	// 댓글 수정용
	int updateReply(Freply fr);
	
	// 첨부파일 리스트 조회 서비스 (ajax)
	ArrayList<Fattachment> selectAttachmentList(int fboardNo);
	
	// 첨부파일 업로드 서비스 (ajax)
	int insertAttachment(Fattachment fattachment);
	
	// 첨부파일 다운로드 서비스
	Fattachment selectOneAttachment(int fattachmentNo);
	
	// 첨부파일 삭제 서비스 (ajax)
	int deleteAttachment(int fattachmentNo);



}
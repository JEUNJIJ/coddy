package com.kh.coddy.board.notice.model.service;

import java.util.ArrayList;

import com.kh.coddy.board.notice.model.vo.Nboard;
import com.kh.coddy.board.notice.model.vo.Nattachment;
import com.kh.coddy.common.vo.PageInfo;

public interface NboardService {
	
	// 게시글의 총 갯수 조회
	int selectListCount();
	
	// 게시글 리스트 조회
	ArrayList<Nboard> selectList(PageInfo pi);
	
	// 게시글 작성하기 서비스
	int insertBoard(Nboard n);
	
	// 게시글 상세조회 서비스
	// 게시글 조회수 증가
	int increaseCount(int nboardNo);
	
	// 게시글 상세조회
	Nboard selectBoard(int nboardNo);
	
	// 게시글 삭제 서비스
	int deleteBoard(int nboardNo);
	
	// 게시글 수정 서비스
	int updateBoard(Nboard n);
	
	// 첨부파일 리스트 조회 서비스 (ajax)
	ArrayList<Nattachment> selectAttachmentList(int nboardNo);
	
	// 첨부파일 업로드 서비스 (ajax)
	int insertAttachment(Nattachment nattachment);
	
	// 첨부파일 다운로드 서비스
	Nattachment selectOneAttachment(int nattachmentNo);
	
	// 첨부파일 삭제 서비스 (ajax)
	int deleteAttachment(int nattachmentNo);

}

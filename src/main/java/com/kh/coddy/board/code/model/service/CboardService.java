package com.kh.coddy.board.code.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.code.model.vo.Crelation;
import com.kh.coddy.board.code.model.vo.Creply;
import com.kh.coddy.board.code.model.vo.CreplyImage;
import com.kh.coddy.common.vo.PageInfo;


public interface CboardService {

	// 게시글의 총 갯수 조회
	int selectListCount();
	
	// 게시글 리스트 조회
	ArrayList<Cboard> selectList(PageInfo pi);
	
	// 게시글 작성하기 서비스
	int insertBoard(Cboard c);
	
	// 게시글 상세조회 서비스
	// 게시글 조회수 증가
	int increaseCount(int cboardNo);
	
	// 게시글 상세조회
	Cboard selectBoard(int cboardNo);
	
	// 게시글 삭제 서비스
	int deleteBoard(int cboardNo);
	
	// 게시글 수정 서비스
	int updateBoard(Cboard c);
	
	
	// 댓글 조회용
	ArrayList<CreplyImage> selectReplyList(int cboardNo);

	// 댓글 작성용
	int insertReply(Creply cr);

	// 댓글 삭제용
	int deletereply(int creplyNo);
		
	// 댓글 수정용
	int updatereply(Creply cr);
	
	
	// 조회수 top5 리스트 조회용 서비스 (ajax)
	ArrayList<Cboard> selectTopBoardList();
	
	// 태그 가져오기
	ArrayList<Crelation> getTagInfo(Cboard c);

	// 태그 추가하기
	int insertTag(String tag);

	int selectSearchCount(HashMap<String, String> map);

	ArrayList<Cboard> selectSearchList(HashMap<String, String> map, PageInfo pi);
}
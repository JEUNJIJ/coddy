package com.kh.coddy.member.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hwishlist;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.auth.model.vo.Auth;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

public interface MemberService {
	
	// 카카오 로그인
	
	// 로그인
	Member loginMember(Member m);
	
	// id 체크
	int memberCheck(String checkId);

	// 가입하는중
	int insertMember(Member m);

	// 가입간 인증번호 생성
	int authMake(Auth auth);

	// 이메일로 넘어간 애랑 비교하기위해 db에서 찾아옴
	int authCheck(Auth auth);

	// id 찾기
	String findId(Member findMember);


	int updateMember(Member m);


	int deleteMember(String memberId);

	int PwdChangeForm(Member m);

	// 실제 있는 계정정보인지 찾음
	int findPwd(Member findMember);

	// 새 비밀번호 설정해줌
	int setNewPassword(Member newMember);

	// 이제 db에 등록된 이메일로 보내주기 위해 가져옴
	String findEmail(Member findMember);

	int uploadFile(int memberNo);
	
	// iboard 카운트 조회
	int selectListCounti(int memberNo);

	// iboard 전체 조회
	ArrayList<IBoard> selectListi(PageInfo pi, int memberNo);

	// Recruitmet 카운트 조회
	int selectListCountr(int memberNo);

	// Recruitmet 전체 조회
	ArrayList<Recruitment> selectListr(PageInfo pi, int memberNo);

	// cboard 카운트 조회
	int selectListCountc(int memberNo);

	// cboard 전체 조회
	ArrayList<Recruitment> selectListc(PageInfo pi, int memberNo);

	// fboard 카운트 조회
	int selectListCountf(int memberNo);

	// fboard 전체 조회
	ArrayList<Fboard> selectListf(PageInfo pi, int memberNo);
	
	// Recruitment 게시글 숫자 구하기
		int count1(int memberNo);

		// cboard
		int count2(int memberNo);
		
		// fboard
		int count3(int memberNo);

		// iboard
		int count4(int memberNo);

		// projecting
		int projecting(int memberNo);

		// projecting 구하기
		ArrayList<Recruitment> selectListing(PageInfo pi, int memberNo);

		// your Page Member 정보들
		ArrayList<Member> selectMember(int memberNo);

		// your Page project count
		int selectListyourCount(int memberNo);

		ArrayList<Recruitment> selectListyour(PageInfo pi, int memberNo);

	int selectListCounth(int memberNo);

	
	ArrayList<Hboard> selectListh(PageInfo pi, int memberNo);
	
	
		
}

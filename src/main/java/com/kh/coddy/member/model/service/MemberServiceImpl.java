package com.kh.coddy.member.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.auth.model.vo.Auth;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.dao.MemberDao;
import com.kh.coddy.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override public Member loginMember(Member m) { return memberDao.loginMember(sqlSession, m); }
	@Override public int memberCheck(String checkId) { return memberDao.memberCheck(sqlSession, checkId); }
	@Override public int insertMember(Member m) { return memberDao.insertMember(sqlSession, m); }
	@Override public int authMake(Auth auth) { return memberDao.authMake(sqlSession, auth); }
	@Override public int authCheck(Auth auth) { return memberDao.authCheck(sqlSession, auth); }
	@Override public String findId(Member findMember) { return memberDao.findId(sqlSession, findMember); }



	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(String memberId) {
		
		return memberDao.deleteMember(sqlSession, memberId);
	}

	@Override
	public int PwdChangeForm(Member m) {
		return memberDao.PwdChangeForm(sqlSession, m);
	}
	
	@Override 
	public int uploadFile(int memberNo) { 
		return MemberDao.uploadFile(sqlSession, memberNo); 
	}

	@Override public int findPwd(Member findMember) { return memberDao.findPwd(sqlSession, findMember); }
	@Override public int setNewPassword(Member newMember) { return memberDao.setNewPassword(sqlSession, newMember); }
	@Override public String findEmail(Member findMember) { return memberDao.findEmail(sqlSession, findMember); }
	

	@Override
	public int selectListCounti(int memberNo) {
		
		return memberDao.selectListCounti(sqlSession, memberNo);
	}
	@Override
	public ArrayList<IBoard> selectListi(PageInfo pi, int memberNo) {
		
		return memberDao.selectListi(sqlSession, pi, memberNo);
	}
	
	@Override
	public int selectListCountr(int memberNo) {
		
		return memberDao.selectListCountr(sqlSession, memberNo);
	}
	@Override
	public ArrayList<Recruitment> selectListr(PageInfo pi, int memberNo) {
		
		return memberDao.selectListr(sqlSession, pi, memberNo);
	}
	@Override
	public int selectListCountc(int memberNo) {
		
		return memberDao.selectListCountc(sqlSession, memberNo);
	}
	@Override
	public ArrayList<Recruitment> selectListc(PageInfo pi, int memberNo) {
		
		return memberDao.selectListc(sqlSession, pi, memberNo);
	}
	@Override
	public int selectListCountf(int memberNo) {
		
		return memberDao.selectListCountf(sqlSession, memberNo);
	}
	@Override
	public ArrayList<Fboard> selectListf(PageInfo pi, int memberNo) {
		
		return memberDao.selectListf(sqlSession, pi, memberNo);
	}
	
	 @Override
	 public int selectListCounth(int memberNo) {
	        return memberDao.selectListCounth(sqlSession, memberNo);
	    }
	 @Override
	    public ArrayList<Hboard> selectListh(PageInfo pi, int memberNo) {
	        return memberDao.selectListh(sqlSession, pi, memberNo);
	    }
	
	 @Override
		public int count1(int memberNo) {
			
			return memberDao.count1(sqlSession, memberNo);
		}
		@Override
		public int count2(int memberNo) {
			
			return memberDao.count2(sqlSession, memberNo);
		}
		@Override
		public int count3(int memberNo) {
			
			return memberDao.count3(sqlSession, memberNo);
		}
		@Override
		public int count4(int memberNo) {
			
			return memberDao.count4(sqlSession, memberNo);
		}
		@Override
		public int projecting(int memberNo) {
			
			return memberDao.projecting(sqlSession, memberNo);
		}
		@Override
		public ArrayList<Recruitment> selectListing(PageInfo pi, int memberNo) {
			
			return memberDao.selectListing(sqlSession, pi, memberNo);
		}
		@Override
		public ArrayList<Member> selectMember(int memberNo) {
			
			return memberDao.selectMember(sqlSession, memberNo);
		}
		
		@Override
		public int selectListyourCount(int memberNo) {
			// TODO Auto-generated method stub
			return 0;
		}
		@Override
		public ArrayList<Recruitment> selectListyour(PageInfo pi, int memberNo) {
			
			return memberDao.selectListyourCount(sqlSession, pi ,memberNo);
		}
		
}


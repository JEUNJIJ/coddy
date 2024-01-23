package com.kh.coddy.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.auth.model.vo.Auth;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Repository
public class MemberDao {
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) { return sqlSession.selectOne("memberMapper.loginMember", m); }
	public int memberCheck(SqlSessionTemplate sqlSession, String checkId) { return sqlSession.selectOne("memberMapper.memberCheck", checkId); }
	public int insertMember(SqlSessionTemplate sqlSession, Member m) { return sqlSession.insert("memberMapper.insertMember", m); }
	public int authMake(SqlSessionTemplate sqlSession, Auth auth) { return sqlSession.insert("authMapper.authMake", auth); }
	public int authCheck(SqlSessionTemplate sqlSession, Auth auth) { return sqlSession.selectOne("authMapper.authCheck", auth); }
	public String findId(SqlSessionTemplate sqlSession, Member findMember) { return sqlSession.selectOne("memberMapper.findId", findMember); }

	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {	
		return sqlSession.update("memberMapper.updateMember", m);
	}
	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.update("memberMapper.deleteMember", memberId);
	}
	
	public int PwdChangeForm(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.PwdChangeForm", m);	
	}
	

	public int findPwd(SqlSessionTemplate sqlSession, Member findMember) { return sqlSession.selectOne("memberMapper.findPwd", findMember); }
	public int setNewPassword(SqlSessionTemplate sqlSession, Member newMember) { return sqlSession.update("memberMapper.setNewPassword", newMember); }
	public String findEmail(SqlSessionTemplate sqlSession, Member findMember) { return sqlSession.selectOne("memberMapper.findEmail", findMember); }
	public static int uploadFile(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.update("memberMapper.uploadFile", memberNo);
	}


	public int selectListCounti(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.selectOne("memberMapper.selectListCounti" ,memberNo);
	}
	
	public ArrayList<IBoard> selectListi(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectListi", memberNo, rowBounds);
	}
	
	public int selectListCountr(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.selectOne("memberMapper.selectListCountr" ,memberNo);
	}
	
	public ArrayList<Recruitment> selectListr(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
	
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectListr", memberNo, rowBounds);
	}
	
	
	public int selectListCountc(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.selectOne("memberMapper.selectListCountc" ,memberNo);
	}
	
	public ArrayList<Recruitment> selectListc(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectListc", memberNo, rowBounds);
	}
	
	public int selectListCountf(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("memberMapper.selectListCountf" ,memberNo);
	}
	
	public ArrayList<Fboard> selectListf(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectListf", memberNo, rowBounds);
		
	}

	 public int selectListCounth(SqlSessionTemplate sqlSession, int memberNo) {
	        return sqlSession.selectOne("memberMapper.selectListCounth", memberNo);
	    }
	
	 public ArrayList<Hboard> selectListh(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
	        int limit = pi.getBoardLimit();
	        int offset = (pi.getCurrentPage() - 1) * limit;

	        RowBounds rowBounds = new RowBounds(offset, limit);

	        return (ArrayList) sqlSession.selectList("memberMapper.selectListh", memberNo, rowBounds);
	    }
	
	 public int count1(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.count1", memberNo);
		}
		public int count2(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.count2", memberNo);
		}
		public int count3(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.count3", memberNo);
		}
		public int count4(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.count4", memberNo);
		}
		public int projecting(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.projecting", memberNo);
		}
		public ArrayList<Recruitment> selectListing(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
			
			System.out.println(memberNo);
			int limit = pi.getBoardLimit();
			int offset = (pi.getCurrentPage() - 1) * limit;
			
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("memberMapper.selectListing", memberNo, rowBounds);
		}
		public ArrayList<Member> selectMember(SqlSessionTemplate sqlSession, int memberNo) {
			
			return (ArrayList)sqlSession.selectList("memberMapper.selectMember", memberNo);
		}
		public int selectListyourCount(SqlSessionTemplate sqlSession, int memberNo) {
			
			return sqlSession.selectOne("memberMapper.selectListyourCount", memberNo);
		}
		public ArrayList<Recruitment> selectListyourCount(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
			
			int limit = pi.getBoardLimit();
			int offset = (pi.getCurrentPage() - 1) * limit;
			
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("memberMapper.selectListyour", memberNo, rowBounds);
		}
	
	
}




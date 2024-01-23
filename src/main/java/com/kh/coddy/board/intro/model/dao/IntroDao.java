package com.kh.coddy.board.intro.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository
public class IntroDao {

	public int insertBoard(SqlSessionTemplate sqlSession, IBoard i) {
		
		
		return sqlSession.insert("introMapper.insertBoard", i);
		
	}

	public int insertBoardImg(SqlSessionTemplate sqlSession, Iattachment ia) {
		
		return sqlSession.insert("introMapper.insertBoardImg", ia);
	}

	public ArrayList<Iattachment> selectattachment(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("introMapper.selectattachment");
	}

	public int getWishList(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return sqlSession.selectOne("introMapper.getWishList", ib);
	}

	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("introMapper.selectListCount");
	}

	public ArrayList<IBoard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("introMapper.selectList", null, new RowBounds(offset, limit));

	}

	public Iattachment selectattachment(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return (Iattachment)sqlSession.selectOne("introMapper.selectattachment", ib);
		
	}

	public int getWish(SqlSessionTemplate sqlSession, Likes iw) {
		
		return sqlSession.selectOne("introMapper.getWish", iw);
		
	}

	public int deleteWish(SqlSessionTemplate sqlSession, Likes iw) {
		
		return sqlSession.delete("introMapper.deleteWish", iw);
		
	}

	public int insertWish(SqlSessionTemplate sqlSession, Likes iw) {
		
		return sqlSession.insert("introMapper.insertWish", iw);
		
	}

	public int plusView(SqlSessionTemplate sqlSession, int ino) {
		
		return sqlSession.update("introMapper.plusView", ino);
		
	}

	public IBoard selectBoard(SqlSessionTemplate sqlSession, int ino) {

		return sqlSession.selectOne("introMapper.selectBoard", ino);
	}

	public int getAllWish(SqlSessionTemplate sqlSession, int iboardNo) {
		
		return sqlSession.selectOne("introMapper.getAllWish", iboardNo);
	}

	public int deleteForm(SqlSessionTemplate sqlSession, int iboardNo) {
		
		return sqlSession.update("introMapper.deleteForm", iboardNo);
	}

	public ArrayList<IreplyImage> selectReplyList(SqlSessionTemplate sqlSession, int iboardNo) {
		
		return (ArrayList)sqlSession.selectList("introMapper.selectReplyList", iboardNo);
	}
	
	public ArrayList<IreplyImage> selectReplyListChild(SqlSessionTemplate sqlSession, Ireply ir) { return (ArrayList)sqlSession.selectList("introMapper.selectReplyListChild", ir); }
	
	public int insertReply(SqlSessionTemplate sqlSession, Ireply r) {
		
		return sqlSession.insert("introMapper.insertReply", r);
	}

	public int deletereply(SqlSessionTemplate sqlSession, int ireplyNo) {
		
		return sqlSession.update("introMapper.deletereply", ireplyNo);
	}

	public int updatereply(SqlSessionTemplate sqlSession, Ireply r) {
		
		return sqlSession.update("introMapper.updatereply", r);
	}

	public ArrayList<IBoard> selectTopList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("introMapper.selectTopList");
	}

	public ArrayList<Project> selectProject(SqlSessionTemplate sqlSession, int memberNo) {
		
		return (ArrayList)sqlSession.selectList("introMapper.selectProject", memberNo);
	}

	public ArrayList<Recruitment> selectRecruitment(SqlSessionTemplate sqlSession, ArrayList<Project> projectlist) {
		
		return (ArrayList)sqlSession.selectList("introMapper.selectRecruitment", projectlist);
	}


	public Recruitment selectRecruitment2(SqlSessionTemplate sqlSession, int projectNo) {
		
		return sqlSession.selectOne("introMapper.selectRecruitment2", projectNo);
	}

	public ArrayList<Prelation> getTagInfo2(SqlSessionTemplate sqlSession, Recruitment r) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getTagInfo2", r); 
	}

	public ArrayList<Joins> getState(SqlSessionTemplate sqlSession, ArrayList<Project> projectlist) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getState", projectlist);
	}

	public Rattachment getThumbOne(SqlSessionTemplate sqlSession, Recruitment r) {
		
		return sqlSession.selectOne("introMapper.getThumbOne",r);
	}

	public ArrayList<Rattachment> getAttachmentList2(SqlSessionTemplate sqlSession, Recruitment r) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getAttachmentList2",r);
	}

	public Project getProject(SqlSessionTemplate sqlSession, Recruitment r) {
		
		return sqlSession.selectOne("introMapper.getProject", r);
	}

	public int updateReady(SqlSessionTemplate sqlSession, IBoard i) {
		
		return sqlSession.update("introMapper.updateReady", i);
	}

	public ArrayList<Iattachment> selectRecent(SqlSessionTemplate sqlSession) {
	
		return (ArrayList)sqlSession.selectList("introMapper.selectRecent");
	}

	public Iattachment getThumb2(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return sqlSession.selectOne("introMapper.getThumb2",ib);
	}

	public int insertImg(SqlSessionTemplate sqlSession, Iattachment ia2) {
		
		return sqlSession.insert("introMapper.insertImg",ia2);
	}

	public Project selectPro(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return sqlSession.selectOne("introMapper.selectPro", ib);
	}

	public int countLike(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return sqlSession.selectOne("introMapper.countLike", ib);
	}

	public ArrayList<Iattachment> getAttachmentList3(SqlSessionTemplate sqlSession, IBoard ib) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getAttachmentList3",ib);
	}

	public Recruitment selectRecruitment3(SqlSessionTemplate sqlSession, int iboardNo) {
		
		return sqlSession.selectOne("introMapper.selectRecruitment3", iboardNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, IBoard i) {
		
		return sqlSession.update("introMapper.updateBoard", i);
	}

	public IBoard iBoardUpdate(SqlSessionTemplate sqlSession, int projectNo) {
		
		return sqlSession.selectOne("introMapper.iBoardUpdate", projectNo);
	}

	public ArrayList<Profile> getJoinMember(SqlSessionTemplate sqlSession, int projectNo) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getJoinMember", projectNo);
	}

	public ArrayList<Joins> getJoinInfo(SqlSessionTemplate sqlSession, int projectNo) {
		
		return (ArrayList)sqlSession.selectList("introMapper.getJoinInfo", projectNo);
	}

	public ArrayList<Iattachment> iAttachmentUpdate(SqlSessionTemplate sqlSession, int iboardNo) {
		
		return (ArrayList)sqlSession.selectList("introMapper.iAttachmentUpdate", iboardNo);
	}
}
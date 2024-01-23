package com.kh.coddy.admin.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.admin.member.model.dao.MemberAdminDao;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Service
public class MemberAdminServiceImpl implements MemberAdminService {
	@Autowired SqlSessionTemplate sqlSession;
	@Autowired MemberAdminDao memberDao;
	
	@Override public int selectListCount() { return memberDao.selectListCount(sqlSession); }
	@Override public ArrayList<Member> selectList(PageInfo pi) { return memberDao.selectList(sqlSession, pi); }
	@Override public int forceDelete(int memberNo) { return memberDao.forceDelete(sqlSession, memberNo); }
	@Override public int forceRestore(int memberNo) { return memberDao.forceRestore(sqlSession, memberNo); }
}
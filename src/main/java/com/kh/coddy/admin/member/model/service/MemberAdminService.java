package com.kh.coddy.admin.member.model.service;

import java.util.ArrayList;

import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

public interface MemberAdminService {
	int selectListCount();
	ArrayList<Member> selectList(PageInfo pi);
	int forceDelete(int memberNo);
	int forceRestore(int memberNo);
}
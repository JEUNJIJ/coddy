package com.kh.coddy.admin.board.cboard.model.service;

import java.util.ArrayList;

import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.common.vo.PageInfo;

public interface CboardAdminService {
	int selectListCount();
	ArrayList<Cboard> selectList(PageInfo pi);
	int forceDelete(int cboardNo);
	int forceRestore(int cboardNo);
	String getTag(int cboardNo);
}
package com.kh.coddy.admin.board.hboard.model.service;

import java.util.ArrayList;

import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.common.vo.PageInfo;

public interface HboardAdminService {
	int selectListCount();
	ArrayList<Hboard> selectList(PageInfo pi);
	int forceDelete(int hboardNo);
	int forceRestore(int hboardNo);
	String getTag(int hboardNo);
}
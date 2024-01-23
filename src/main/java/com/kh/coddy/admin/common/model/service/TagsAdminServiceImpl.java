package com.kh.coddy.admin.common.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.admin.common.model.dao.TagsAdminDao;
import com.kh.coddy.common.tag.model.vo.Tags;

@Service
public class TagsAdminServiceImpl implements TagsAdminService {
	@Autowired TagsAdminDao tagsDao;
	@Autowired SqlSessionTemplate sqlSession;
	
	@Override public ArrayList<Tags> getTagsListAll() { return tagsDao.getTagsListAll(sqlSession); }
	@Override public int adminRemoveTags(int tagsNo) { return tagsDao.adminRemoveTags(sqlSession, tagsNo); }
	@Override public int adminRestoreTags(int tagsNo) { return tagsDao.adminRestoreTags(sqlSession, tagsNo); }
	@Override public int adminAddTags(Tags tg) { return tagsDao.adminAddTags(sqlSession, tg); }
}
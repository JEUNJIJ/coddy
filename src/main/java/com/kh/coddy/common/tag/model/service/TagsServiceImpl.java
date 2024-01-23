package com.kh.coddy.common.tag.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.common.tag.model.dao.TagsDao;
import com.kh.coddy.common.tag.model.vo.Tags;

@Service
public class TagsServiceImpl implements TagsService {
	@Autowired private SqlSessionTemplate sqlSession;
	@Autowired private TagsDao tagsDao;
	
	@Override public ArrayList<Tags> getTagsList() { return tagsDao.getTagsListAll(sqlSession); }
	@Override public ArrayList<Tags> getTagsList(String mode) {
		if((mode.equals("0")) || (mode.toLowerCase().equals("tag"))) { return tagsDao.getTagsTag(sqlSession); }
		if((mode.equals("1")) || (mode.toLowerCase().equals("career"))) { return tagsDao.getTagsCareer(sqlSession); }
		else { return this.getTagsList(); }
	}
}
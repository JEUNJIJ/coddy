package com.kh.coddy.common.tag.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.common.tag.model.vo.Tags;

@Repository
public class TagsDao {
	public ArrayList<Tags> getTagsListAll(SqlSessionTemplate sqlSession) { return (ArrayList)sqlSession.selectList("tagsMapper.selectTagsAll"); }
	public ArrayList<Tags> getTagsTag(SqlSessionTemplate sqlSession) { return (ArrayList)sqlSession.selectList("tagsMapper.selectTagsTag"); }
	public ArrayList<Tags> getTagsCareer(SqlSessionTemplate sqlSession) { return (ArrayList)sqlSession.selectList("tagsMapper.selectTagsCareer"); }
}
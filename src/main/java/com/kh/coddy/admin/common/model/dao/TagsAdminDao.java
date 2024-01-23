package com.kh.coddy.admin.common.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.common.tag.model.vo.Tags;

@Repository
public class TagsAdminDao {
	public ArrayList<Tags> getTagsListAll(SqlSessionTemplate sqlSession) { return (ArrayList)sqlSession.selectList("tagsMapper.getTagsListAll"); }
	public int adminRemoveTags(SqlSessionTemplate sqlSession, int tagsNo) { return sqlSession.update("tagsMapper.adminRemoveTags", tagsNo); }
	public int adminRestoreTags(SqlSessionTemplate sqlSession, int tagsNo) { return sqlSession.update("tagsMapper.adminRestoreTags", tagsNo); }
	public int adminAddTags(SqlSessionTemplate sqlSession, Tags tg) { return sqlSession.insert("tagsMapper.adminAddTags", tg); }
}
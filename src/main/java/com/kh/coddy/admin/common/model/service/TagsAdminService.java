package com.kh.coddy.admin.common.model.service;

import java.util.ArrayList;

import com.kh.coddy.common.tag.model.vo.Tags;

public interface TagsAdminService {
	ArrayList<Tags> getTagsListAll();
	int adminRemoveTags(int tagsNo);
	int adminRestoreTags(int tagsNo);
	int adminAddTags(Tags tg);
}
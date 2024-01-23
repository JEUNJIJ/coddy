package com.kh.coddy.common.tag.model.service;

import java.util.ArrayList;

import com.kh.coddy.common.tag.model.vo.Tags;

public interface TagsService {
	ArrayList<Tags> getTagsList();
	ArrayList<Tags> getTagsList(String mode);
}
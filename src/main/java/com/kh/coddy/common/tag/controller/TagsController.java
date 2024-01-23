package com.kh.coddy.common.tag.controller;

import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.coddy.common.tag.model.service.TagsService;
import com.kh.coddy.common.tag.model.vo.Tags;

@Controller
public class TagsController {
	@Autowired TagsService tagsService;
	/**
	 * @return
	 */
	public ArrayList<Tags> getTagsList() { return tagsService.getTagsList(); }
	
	/**
	 * @param mode
	 * @return
	 */
	public ArrayList<Tags> getTagsList(String mode) { return tagsService.getTagsList(mode); }
	
	/**
	 * 전부다 출력함
	 * @return "~,~,~"
	 */
	public String getTagsNameString() {
		String result = "";
		for(Tags t:this.getTagsList()) { result += t.getTagsName() + ","; }
		return result.substring(0, result.length() - 1);
	}
	
	/**
	 * @param mode 0:ex)C,C#, 1:ex)프론트엔드
	 * @return "~,~,~"
	 */
	public String getTagsNameString(int mode) {
		String result = "";
		if(mode==0) { for(Tags t:this.getTagsList("0")) { result += t.getTagsName() + ","; } }
		else if(mode==1) { for(Tags t:this.getTagsList("1")) { result += t.getTagsName() + ","; } }
		else { return this.getTagsNameString(); }
		return result.substring(0, result.length() - 1);
	}
	
	/**
	 * 전부다 출력하는데 이름만 ArrayList로
	 * @return
	 */
	public ArrayList<String> getTagsNameList() { 
		ArrayList<String> result = new ArrayList<String>(); 
		for(Tags t:this.getTagsList()) { result.add(t.getTagsName()); }
		return result;
	}
	
	public ArrayList<String> getTagsNameList(int mode) {
		ArrayList<String> result = new ArrayList<String>();
		if(mode==0) { for(Tags t:this.getTagsList("0")) { result.add(t.getTagsName()); } }
		else if(mode==1) { for(Tags t:this.getTagsList("1")) { result.add(t.getTagsName()); } }
		else { return this.getTagsNameList(); }
		return result;
	}

	public ArrayList<String> getTagsNameListOnFilter(int mode, String[] filter) {
		ArrayList<String> result = new ArrayList<>();
		if(mode==0) { result = getTagsNameList(0); }
		else if(mode==1) { result = getTagsNameList(1); }
		else { result = getTagsNameList(); }
		ArrayList<String> resultCopy = (ArrayList<String>)result.clone();
		for(String check: resultCopy) { if(Arrays.asList(filter).contains(check)) { result.remove(check); } }
		return result;
	}
}
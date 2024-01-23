package com.kh.coddy.common;

public class RemoveHTMLTag {
	public static String allowForArrow(String str, String allowTags){
		String pattern = "<(/?)(?!/####)([^<|>]+)?>";
		String substitute = "&lt;$1$2&gt;";
		String[] allowTag = allowTags.split(",");
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < allowTag.length; i++) {
			buffer.append("|" + allowTag[i].trim() + "(?!w)");
		}
		pattern = pattern.replaceAll("####", buffer.toString());
		String returnstr = str.replaceAll(pattern, substitute);
		return returnstr;
	}
	public static String allow(String str, String allowTags){
		String pattern = "<(/?)(?!/####)([^<|>]+)?>";
		String substitute = "$1$2";
		String[] allowTag = allowTags.split(",");
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < allowTag.length; i++) {
			buffer.append("|" + allowTag[i].trim() + "(?!w)");
		}
		pattern = pattern.replaceAll("####", buffer.toString());
		String returnstr = str.replaceAll(pattern, substitute);
		return returnstr;
	}
}
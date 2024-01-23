package com.kh.coddy.common.tag;

public class ReadTag {
	public static String[] read(String input) {
		input = input.replace("[", "").replace("]", "").replace("{", "").replace("}", "").replace("value", "").replace(":", "").replace("\"", "");
		return input.split(",");
	}
}
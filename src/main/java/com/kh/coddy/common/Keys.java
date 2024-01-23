package com.kh.coddy.common;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Keys {
	public static String read(String keyFile, String attr) throws IOException, ParseException {
		JSONParser parser = new JSONParser();
		
		Reader reader = new FileReader(keyFile);
		JSONObject jsonObject = (JSONObject)parser.parse(reader);
		
		return (String)jsonObject.get(attr);
	}
}
package com.kh.coddy.common.vo;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.core.io.ClassPathResource;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter @ToString
public class Geo {
    private String location;
    private String addr;
    private String lat;
    private String lng;
    
    public static Geo getGeo(String locationNum) {
        try { 
        	Reader reader = new FileReader(new ClassPathResource("location/locationMapping.json").getURL().getPath());
        	JSONParser parser = new JSONParser();
            JSONObject jo = (JSONObject)parser.parse(reader);
            String find = jo.get(locationNum).toString();
			return new Geo(locationNum, (String)((JSONObject)parser.parse(find)).get("addr"), (String)((JSONObject)parser.parse(find)).get("lat"), (String)((JSONObject)parser.parse(find)).get("lng"));
        }
        catch (IOException | ParseException e) { e.printStackTrace(); return null; }
    };
}

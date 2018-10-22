package kr.hanne.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.URIDereferencer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/news")
@Controller
public class NewsController {

	private static Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@RequestMapping("/")
	public String newsMain() throws Exception{
		return "news/newsMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/testA", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String test() throws Exception{
		return "안녕";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/getEuroNews", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> newsEuro() {
		
		ResponseEntity<Object> entity = null;
		
		String clientID = "C0tMtzIbzO4GsZlpeSG9";
		String clientSecret = "SjrCVtDqvv";
		
		int display = 10;
		try {
			String text = URLEncoder.encode("유럽축구", "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/news.json?query="
					+ text + "&display=" + display + "&";
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientID);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"utf-8"));
			}
			
			String inputLine;
			StringBuffer res = new StringBuffer();
			
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
				
			entity = new ResponseEntity<>(res, HttpStatus.OK);
			return entity;
						
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			return entity;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/getKorNews", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> newsKor() {
		
		ResponseEntity<Object> entity = null;
		
		String clientID = "C0tMtzIbzO4GsZlpeSG9";
		String clientSecret = "SjrCVtDqvv";
		
		int display = 10;
		try {
			String text = URLEncoder.encode("한국축구, 대표팀", "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/news.json?query="
					+ text + "&display=" + display + "&";
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientID);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"utf-8"));
			}
			
			String inputLine;
			StringBuffer res = new StringBuffer();
			
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
				
			entity = new ResponseEntity<>(res, HttpStatus.OK);
			return entity;
						
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			return entity;
		}
	}
}

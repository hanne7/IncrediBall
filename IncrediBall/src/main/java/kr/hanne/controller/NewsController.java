package kr.hanne.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/news")
@Controller
public class NewsController {

	private static final Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@RequestMapping("/")
	public String newsMain() throws Exception{
		logger.info("news page called................");
		return "news/newsMain";
	}
	
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
	
	@RequestMapping(value="/getKorNews", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> newsKor() {
		
		ResponseEntity<Object> entity = null;
		
		String clientID = "C0tMtzIbzO4GsZlpeSG9";
		String clientSecret = "SjrCVtDqvv";
		
		int display = 10;
		try {
			String text = URLEncoder.encode("한국축구  대표팀", "UTF-8");
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

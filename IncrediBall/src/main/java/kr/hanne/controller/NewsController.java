package kr.hanne.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/news")
@Controller
public class NewsController {

	@RequestMapping("/")
	public String newsMain() throws Exception{
		return "news/newsMain";
	}
	
	@RequestMapping(value="/getNews", method=RequestMethod.GET)
	public ResponseEntity<Object> newsAjax(){
		
		ResponseEntity<Object> entity = null;
		
		String clientID = "C0tMtzIbzO4GsZlpeSG9";
		String clientSecret = "SjrCVtDqvv";
		
		int display = 10;
		try {
			String text = URLEncoder.encode("유럽축구", "utf-8");
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
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
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

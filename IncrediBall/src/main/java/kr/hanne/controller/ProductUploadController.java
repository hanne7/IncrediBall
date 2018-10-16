package kr.hanne.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.hanne.util.MediaUtils;
import kr.hanne.util.UploadFileUtils;

@Controller
public class ProductUploadController {

	private static final Logger logger = LoggerFactory.getLogger(ProductUploadController.class);
	
	@Resource(name = "productPath")
	private String uploadPath;

	@ResponseBody
	@RequestMapping(value="/uploadProduct", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		logger.info("originalName: " + file.getOriginalFilename());
		
		return new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	/*
	 * displayFile()은 파라미터로 브라우저에서 전송받기를 원하는 파일이름을 받음.
	 * 파일의 이름은 '/년/월/일/파일명'의 형태로 받음.
	 * displayFile()은 반환형이 ResponseEntity<byte[]>이고, 결과는 실제로 파일의
	 * 데이터가 됨.
	 * @ResponseBody를 이용해서 byte[]데이터가 그대로 전송될 것을 명시함.
	 * ex) http://localhost:8080/displayFile?fileName=/2018/08/06/333a0e97-8f5d-429e-99cf-27de073e6552_%EC%88%98%EC%97%85%EC%B0%B8%EC%A1%B0.pptx
	 * ex) http://localhost:8080/displayFile?fileName=/2018/08/06/d995e94e-9605-4ade-a324-d5f786917d8e_%EB%B8%94%EB%A3%A8%ED%88%AC%EC%8A%A4_%EB%AF%B8%EB%8B%88%ED%82%A4%EB%B3%B4%EB%93%9C.jpg
	 */
	@ResponseBody
	@RequestMapping("/displayProduct")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		
		InputStream in = null;
		
		ResponseEntity<byte[]> entity = null;
		
		logger.info("FILE NAME: " + fileName);
		
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			// 파일이름에서 확장자를 추출하고, 이미지 타입의 파일인 경우
			// 적절한 MIME타입을 지정함.
			// 브라우저는 이 MIME타입을 보고 사용자에게 자동으로 다운로드 창을 열어줌.
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();
			
			in = new FileInputStream(uploadPath + fileName);
			
			if(mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				
				//이미지가 아닌 경우, MIME타입을 다운로드 용으로 사용되는
				//'application/octet-stream'으로 지정함.
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				
				//다운로드 할 때 사용자에게 보이는 파일의 이름이므로 한글처리를 해서 전송함.
				//한글 파일의 경우, 다운로드하면 파일의 이름이 깨져서 나오기 때문에 반드시
				//인코딩 처리를 할 필요가 있음.
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\""); 
			}
			
			//실제로 데이터를 읽는 부분은 commons라이브러리의 기능을 활용해서
			//대상 파일에서 데이터를 읽어내는 IOUtils.toByteArray()임.
			//결과는 'displayFile?fileName=년/월/일/파일명'을 호출해서 확인할 수 있음.
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		
		return entity;
	}
	
	
	
	/*
	 * 화면에서 'X'를 선택해서 첨부파일을 삭제하면, 실제 저장 경로에서도 파일이 삭제됨.
	 * 이미지파일은 원본파일을 먼저 삭제하고, 이후 썸네일 파일을 삭제함.
	 */
	@ResponseBody
	@RequestMapping(value="/deleteProduct", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		
		logger.info("delete file: " + fileName);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) {
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
		}
		
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}
	
	
	/*
	 * 	게시글 삭제와 첨부파일 삭제.
	 *  기존의 첨부파일을 함께 삭제함.
	 */
	@ResponseBody
	@RequestMapping(value="/deleteAllProducts", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files) {
		logger.info("delete all files: " + files);
		
		if(files==null || files.length==0) {
			return new ResponseEntity<>("deleted", HttpStatus.OK);
		}
		
		for(String fileName:files) {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			if(mType != null) {
				String front = fileName.substring(0, 12);
				String end = fileName.substring(14);
				new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
			}
			
			new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		}
		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}
}

package kr.hanne.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadProductUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadProductUtils.class);
	
	public static String uploadFile(String uploadPath, 
			String originalName, byte[] fileData) throws Exception{
		
		UUID uid = UUID.randomUUID();
		logger.info("uid: " + uid.toString());
		
		String savedName = uid.toString() + "_" + originalName;
		logger.info("savedName: " + savedName);
		
		String savedPath = calcPath(uploadPath);
		logger.info("savedPath: " + savedPath);
		
		File target = new File(uploadPath + savedPath, savedName);
		logger.info("target: " + target.toString());
		
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		
		String uploadedFileName = null;
		
		//...이미지 파일인 경우와 그렇지 않은 경우를 나눠서 처리.
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeImgName(uploadPath, savedPath, savedName);
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadedFileName;
	}

	
	private static String makeImgName(String uploadPath, 
			String path, String fileName) throws Exception {
				
		String uploadedFileName = uploadPath + path + File.separator + fileName;
		
		//	브라우저에서 윈도우의 경로로 사용하는 '\'문자가 정상적인 경로로 인식되지 않으므로
		//  '/'로 치환함.
		return uploadedFileName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	
	//...이미지 타입이 아닌 파일의 경우, 경로 처리를 하는 문자열의 치환용도.
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	

	/*
	 * calcPath()의 리턴 값은 최종 결과 폴더를 반환함.
	 * 내부적으로 폴더를 생성해주는 기능이 필요하므로 기본적인 경로(uploadPath)를 파라미터로 전달받음.
	 * 날짜정보와 기본경로를 makeDir()에 전달해서, 폴더가 생성됨.
	 */
	private static String calcPath(String uploadPath) {
	
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		logger.info(datePath);
		
		return datePath;
	}

	
	private static void makeDir(String uploadPath, String... paths) {
		if(new File(uploadPath + paths[paths.length-1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}

}

package musign.classes;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;

import musign.model.family.UserDAO;
import musign.model.family.SalesDAO;

public class Utils {
	public static HashMap<String, Object> reqToMap(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> enumer = request.getParameterNames();

		if (enumer.hasMoreElements()) {
			while (enumer.hasMoreElements()) {
				String key = enumer.nextElement().toString();
				String value = repWord(checkNullString(request.getParameter(key)));
				map.put(key, value);
			}
		} else {
			map = new HashMap<String, Object>();
		}

		return map;
	}
	private static String toHex(byte hash[]) {
		StringBuffer buf = new StringBuffer(hash.length * 2);
		for(int i = 0; i < hash.length; i++) {
			int intVal = hash[i] & 0xff;
			if(intVal < 0x10) {
				buf.append("0");
			}
			buf.append(Integer.toHexString(intVal));
		}
		return buf.toString();
	}
	public static String getHashString(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			return toHex(md.digest());
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			return str;
		}
	}
	
	public static synchronized String checkNullString(Object str) 
	{
		String strTmp;
		try 
		{
			if (str != null && str.toString().length() > 0 && !str.equals("") && !str.equals("null"))
			{
				strTmp = repWord(str.toString());
			}
			else
			{
				strTmp = "";
			}
		} 
		catch (Exception e) 
		{
			strTmp = "";
		}
		return strTmp;
	}
	
	public static synchronized int checkNullInt(Object num) 
	{
		int numTmp;
		try 
		{
			if (num != null && num.toString().length() > 0 && !num.equals(""))
			{
				numTmp = Integer.parseInt(num.toString().trim());
			}
			else
			{
				numTmp = 0;
			}
		} 
		catch (Exception e) 
		{
			numTmp = 0;
		}
		return numTmp;
	}
	
	public static String getDateNow(String type)
	{
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String year = (sdf.format(now)).substring(0,4);
		String month = (sdf.format(now)).substring(4,6);
		String day = (sdf.format(now)).substring(6,8);
		
		String ret = "";
		if("year".equals(type))
		{
			ret = year;
		}
		else if("month".equals(type))
		{
			ret = month;
		}
		else if("day".equals(type))
		{
			ret = day;
		}
		return ret;
	} 
	
	public static String getClientIP(HttpServletRequest request) {
		String ip = null;
		ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
			System.out.println("Proxy-Client-IP : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
			System.out.println("WL-Proxy-Client-IP : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
			System.out.println("HTTP_CLIENT_IP : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			System.out.println("HTTP_X_FORWARDED_FOR : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
			System.out.println("X-Real-IP : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
			System.out.println("X-RealIP : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
			System.out.println("REMOTE_ADDR : "+ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
			System.out.println("ip : "+ip);
		}
		return ip;
	}
	
	public static String excelDown(String sheetname, String filename, ArrayList<String> db_column, ArrayList<String> print_column, ArrayList<Integer> size_column, List<HashMap<String, Object>> list) throws IOException
	{
		if(db_column.size() != print_column.size())
		{
			return "FAIL : 컬럼 갯수 상이";
		}
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(sheetname);
		
		HSSFRow row = null;
		HSSFCell cell = null;
		
		//셀 스타일
		CellStyle headStyle = workbook.createCellStyle();
		headStyle.setFillForegroundColor(HSSFColorPredefined.AQUA.getIndex()); //배경색
		headStyle.setAlignment(HorizontalAlignment.CENTER); //가운데정렬
		headStyle.setVerticalAlignment(VerticalAlignment.CENTER); //세로정렬
		
		//사이즈지정
		for(int i = 0; i < size_column.size(); i++)
		{
			sheet.setColumnWidth(i+1, size_column.get(i)); 
		}
		//셀 스타일

		
		//제목 셋팅
		row = sheet.createRow(1); //한칸띄자 보기좋게
		for(int i = 0; i < print_column.size(); i++)
		{
			cell = row.createCell(i+1); //한칸띄자 보기좋게
			cell.setCellStyle(headStyle);
			cell.setCellValue(print_column.get(i));
		}
		//제목 셋팅
		
		for(int i = 0; i < list.size(); i++)
		{
			row = sheet.createRow(i+2);
			for(int z = 0; z < db_column.size(); z++)
			{
				cell = row.createCell(z+1);
				if(list.get(i).get(db_column.get(z)) != null)
				{
					cell.setCellValue(list.get(i).get(db_column.get(z)).toString());
				}
			}
		}
		
		
		FileOutputStream fos = new FileOutputStream("C:\\Users\\musign design lab\\Documents\\workspace-sts-3.9.6.RELEASE\\ak_culture\\WebContent\\excel\\"+filename);
		workbook.write(fos);
		fos.flush();
		fos.close();
		
		return "SUCCESS";
	}
	
	public static String excelDownforTable(String sheetname, String filename,int countMatches, ArrayList<String> print_column, ArrayList<Integer> size_column, ArrayList<Integer> list) throws IOException
	{
		if(countMatches != print_column.size())
		{
			return "FAIL : 컬럼 갯수 상이";
		}
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(sheetname);
		
		HSSFRow row = null;
		HSSFCell cell = null;
		
		ArrayList<String> get_cell = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			Integer a = list.get(i);
		}
		
		//셀 스타일
		CellStyle headStyle = workbook.createCellStyle();
		headStyle.setFillForegroundColor(HSSFColorPredefined.AQUA.getIndex()); //배경색
		headStyle.setAlignment(HorizontalAlignment.CENTER); //가운데정렬
		headStyle.setVerticalAlignment(VerticalAlignment.CENTER); //세로정렬
		
		//사이즈지정
		for(int i = 0; i < size_column.size(); i++)
		{
			sheet.setColumnWidth(i+1, size_column.get(i)); 
		}
		//셀 스타일

		
		//제목 셋팅
		row = sheet.createRow(1); //한칸띄자 보기좋게
		for(int i = 0; i < print_column.size(); i++)
		{
			cell = row.createCell(i+1); //한칸띄자 보기좋게
			cell.setCellStyle(headStyle);
			cell.setCellValue(print_column.get(i));
		}
		//제목 셋팅
		/*
		for(int i = 0; i < list.size(); i++)
		{
			row = sheet.createRow(i+2);
			
			for(int z = 0; z < db_column.size(); z++)
			{
				cell = row.createCell(z+1);
				if(list.get(i).get(db_column.get(z)) != null)
				{
					cell.setCellValue(list.get(i).get(db_column.get(z)).toString());
				}
			}
		}
		*/
		
		
		FileOutputStream fos = new FileOutputStream("C:\\Users\\MUSIGN-301\\Documents\\workspace\\ak_culture\\WebContent\\excel\\"+filename);
		workbook.write(fos);
		fos.flush();
		fos.close();
		
		return "SUCCESS";
	}
	
	public static String repWord(String buffer) {
		buffer = buffer.replaceAll("&", "&amt;");
		buffer = buffer.replaceAll("<", "&lt;");
		buffer = buffer.replaceAll(">", "&gt;");
		buffer = buffer.replaceAll("\"", "&quot;");
		buffer = buffer.replaceAll("\'", "&#039;");
		buffer = buffer.replaceAll("\r'", "");
		//buffer = buffer.replaceAll("\n", "<br>");
		//buffer = buffer.replaceAll(System.getProperty("line.separator"), "<br>");
		buffer = buffer.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		//replaceAll("(\r\n|\r|\n|\n\r)", "<br>")
		
		return buffer;
	}
	
	public static String getNowTime() {
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMddHHmmss");
		Date time = new Date();
		String now_time = format1.format(time);
		return now_time;
	}

	public static String f_setfill_zero(String temp_str, int str_length, String str_flag) {
		int temp_len = 0;
		temp_len = trim(temp_str).length();
		if (trim(temp_str) == null)
			return zero(str_length);
		if (temp_len >= str_length)
			return temp_str.substring(0, str_length);
		if (str_flag == "R")
			return trim(temp_str) + zero(str_length - temp_len);
		else if (str_flag == "L")
			return zero(str_length - temp_len) + trim(temp_str);
		else {
			return temp_str;
		}
	}

	public static String trim(String str) {
		return str.trim();
	}

	public String space(int len) {
		String spaceString = "";
		for (int i = 0; i < len; i++) {
			spaceString = spaceString + " ";
		}
		return spaceString;
	}

	public static String zero(int len) {
		String zeroString = "";
		for (int i = 0; i < len; i++) {
			zeroString = zeroString + "0";
		}
		return zeroString;
	}
	public static String convertFileName(String filename, String uploadPath, int seq) {
		if(!"".equals(filename))
		{
			String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
			int i = -1;
			i = filename.lastIndexOf("."); // 파일 확장자 위치
			String realFileName = now + seq + filename.substring(i, filename.length()); // 현재시간과 확장자 합치기
			
			File oldFile = new File(uploadPath + filename);
			File newFile = new File(uploadPath + realFileName);
			oldFile.renameTo(newFile); // 파일명 변경
			
			return realFileName.toString();
		}
		else
		{
			return "";
		}
	}

	public static long calDateBetweenAandB(String date1, String date2) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		// date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
		Date FirstDate = format.parse(date1);
		Date SecondDate = format.parse(date2);

		// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
		// 연산결과 -950400000. long type 으로 return 된다.
		long calDate = FirstDate.getTime() - SecondDate.getTime();
		// Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다.
		// 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
		long calDateDays = calDate / (24 * 60 * 60 * 1000);
		calDateDays = Math.abs(calDateDays);
		
		return calDateDays;
	}
	
	public static String addDate(String dd, int days) throws ParseException
	{
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date date = df.parse(dd);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, days);
		
		return df.format(cal.getTime());
	}
	
	public static String getMonFlag(String dateString) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		try{
		  date = sdf.parse(dateString);
		}catch(ParseException e){
		}

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.setTime(date);

		cal.add(Calendar.DATE, 2- cal.get(Calendar.DAY_OF_WEEK));
		
		return sdf.format(cal.getTime());
	}
	public static String getSunFlag(String dateString) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		try{
		  date = sdf.parse(dateString);
		}catch(ParseException e){
		}

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.setTime(date);

		cal.add(Calendar.DATE, 2- cal.get(Calendar.DAY_OF_WEEK));
		
		cal.setTime(date);

		cal.add(Calendar.DATE, 8 - cal.get(Calendar.DAY_OF_WEEK));

		return sdf.format(cal.getTime());
	}
	public static String getWeekDays(String inputStartDate, String inputEndDate) throws ParseException {
		final String DATE_PATTERN = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		Date startDate = sdf.parse(inputStartDate);
		Date endDate = sdf.parse(inputEndDate);
		ArrayList<String> dates = new ArrayList<String>();
		Date currentDate = startDate;
		while (currentDate.compareTo(endDate) <= 0) {
			dates.add(sdf.format(currentDate));
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		String ret = "";
		for (String date : dates) {
			ret += date+"|";
		}
		return ret;
	}
	
	
	public static String encrypt(String planText) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(planText.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}
			return hexString.toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
	
	public static String getChkline(String approval_line) throws ParseException {
		
		String[] approval_line_arr = approval_line.split("\\|");
		String temp="";
		for (int i = 0; i < approval_line_arr.length; i++) {
			temp +="X|";
		}
		return temp;
	}
	
	public static String getWaiter(String approval_line,String chk_line) throws ParseException {
		
		String[] approval_arr = approval_line.split("\\|");
		String[] chk_arr = chk_line.split("\\|");
		String temp="";
		for (int i = 0; i < approval_arr.length; i++) {
			if (chk_arr[i].equals("X")) {
				temp=approval_arr[i];
				break;		
			}
		}
		return temp;
	}
	
	public static String getStep(String chmod,UserDAO user_dao){
		System.out.println("session chmod : "+chmod);
		String getChmod = user_dao.getChmod_kor(chmod);
		
		return getChmod+"승인";
	}
	
	public static String send_Dosign_mail(String mail_type,String waiter_mail,String waiter_nm,String idx,String target_nm,String target_doc_type, String mail_msg){
		String from = "delivery@musign.net"; //보내는사람
		String to = waiter_mail;
		//String to = "mdh0088@musign.net";
		
		//String to = waiter_mail;
		//String subject = "프로젝트 배정["+target_project+"]";
		String subject = "";
		if (mail_type.equals("urgent")) 
		{
			subject = waiter_nm+"님 긴급 전자결재 알림입니다.";
		}
		else
		{
			subject = waiter_nm+"님 정기 전자결재 알림입니다.";			
		}
		String content="";
		content += mail_msg;
		content += "<br><br> 오늘도 즐거운 하루 보내세요~";
		
		Properties p = new Properties(); // 정보를 담을 객체
		p.put("mail.smtp.host","smtp.worksmobile.com"); // 네이버 SMTP
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try{
		    Authenticator auth = new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication("delivery@musign.net", "ehdehddlqkqh1");
	          }
		    };
		    
		    Session ses = Session.getInstance(p, auth);
		     
//		     ses.setDebug(true);
		     
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		    msg.setSubject(subject); // 제목
		    
		    /*
		    String[] TeamLeaderMail_arr = TeamLeaderMail.split("\\|");
		    InternetAddress[] ccAddr = new InternetAddress[TeamLeaderMail_arr.length];
		    for (int i = 0; i < TeamLeaderMail_arr.length; i++) 
		    {
		    	ccAddr[i] = new InternetAddress (TeamLeaderMail_arr[i]);
			}
			*/
		    //팀장 본부장 대표 남성우
		    //ccAddr[0] = new InternetAddress (TeamLeaderMail);
		    //ccAddr[1] = new InternetAddress ("nam1087@musign.net");
		    //ccAddr[2] = new InternetAddress ("angelo@musign.net");
		    //ccAddr[3] = new InternetAddress ("musign@musign.net");
		    //msg.setRecipients(Message.RecipientType.CC, ccAddr);

		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr); // 보내는 사람
		     
		    Address toAddr = new InternetAddress(to);
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
		    Transport.send(msg); // 전송
		} catch(Exception e){
		    e.printStackTrace();
		    return "fail";
		}
		return "success";
	}
	
	
	
	
	public static String send_mail(String manager_mail,String target_idx,String target_project,String manager_name,String TeamLeaderMail){
		String from = "delivery@musign.net"; //보내는사람
		String to = manager_mail;
		//String subject = "프로젝트 배정["+target_project+"]";
		String subject = "담당자 배정 안내";
		String content="";
		content += "담당자 이름 : "+manager_name+"<br>";
		content += "배정된 프로젝트 : "+target_project+"<br>";
		content += "URL : <a href=http://sale.musign.net/sales/write?idx="+target_idx+">프로젝트 이동</a> <br>";
		content += "오늘도 즐거운 하루 보내세요~";
		
		Properties p = new Properties(); // 정보를 담을 객체
		p.put("mail.smtp.host","smtp.worksmobile.com"); // 네이버 SMTP
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try{
		    Authenticator auth = new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication("delivery@musign.net", "ehdehddlqkqh1");
	          }
		    };
		    
		    Session ses = Session.getInstance(p, auth);
		     
//		     ses.setDebug(true);
		     
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		    msg.setSubject(subject); // 제목
		    
		    String[] TeamLeaderMail_arr = TeamLeaderMail.split("\\|");
		    InternetAddress[] ccAddr = new InternetAddress[TeamLeaderMail_arr.length];
		    for (int i = 0; i < TeamLeaderMail_arr.length; i++) 
		    {
		    	ccAddr[i] = new InternetAddress (TeamLeaderMail_arr[i]);
			}
		    //팀장 본부장 대표 남성우
		    //ccAddr[0] = new InternetAddress (TeamLeaderMail);
		    //ccAddr[1] = new InternetAddress ("nam1087@musign.net");
		    //ccAddr[2] = new InternetAddress ("angelo@musign.net");
		    //ccAddr[3] = new InternetAddress ("musign@musign.net");

		    msg.setRecipients(Message.RecipientType.CC, ccAddr);

		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr); // 보내는 사람
		     
		    Address toAddr = new InternetAddress(to);
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
		    Transport.send(msg); // 전송
		} catch(Exception e){
		    e.printStackTrace();
		    return "fail";
		}
		return "success";
	}
	
	
	
	public static String getUserNameByIdx(UserDAO user_dao, String idx)
	{
		HashMap<String, Object> userInfo = user_dao.userInfo(idx);
		return userInfo.get("name").toString();
	}
	
	public static String getUserChmodByIdx(UserDAO user_dao, String idx)
	{
		HashMap<String, Object> userInfo = user_dao.userInfo(idx);
		return userInfo.get("chmod_nm").toString();
	}
	
	public static String getUserTeamByIdx(UserDAO user_dao, String idx)
	{
		HashMap<String, Object> userInfo = user_dao.userInfo(idx);
		return userInfo.get("team_nm").toString();
	}

	
	public static void sendJandiAlarm_New(int sale_idx, HttpSession session, SalesDAO seles_dao) throws ParseException {
		JSONObject jo1 = new JSONObject();
		String jsonData = "";
		BufferedReader br = null;
		StringBuffer sb = null;
		String returnText = "";
		
		String myidx = session.getAttribute("login_idx").toString();
		String myName = session.getAttribute("login_name").toString();
		String myTeam = session.getAttribute("login_team_nm").toString();
		String myChmod = session.getAttribute("login_chmod_nm").toString();
		
		HashMap<String, Object> saleInfo = seles_dao.getTargetInfo(Integer.toString(sale_idx));
		
		
		jo1.put("body", "신규 프로젝트 작성 알림");
		jo1.put("connectColor", "#FAC11B");
		
		JSONArray ja = new JSONArray();
		JSONObject jo2 = new JSONObject(); JSONObject jo3 = new JSONObject(); JSONObject jo4 = new JSONObject();
		JSONObject jo5 = new JSONObject(); JSONObject jo6 = new JSONObject(); JSONObject jo7 = new JSONObject();
		JSONObject jo8 = new JSONObject(); JSONObject jo9 = new JSONObject(); JSONObject jo10 = new JSONObject();
		jo2.put("title", "신규 프로젝트가 작성 되었습니다.");
		jo2.put("description", myName+"("+myTeam+"_"+myChmod+")님이 신규 프로젝트를 작성 하였습니다.");
		
		jo3.put("title", "문의 회사");
		jo3.put("description", saleInfo.get("site_url"));
		
		jo4.put("title", "담당자");
		jo4.put("description", saleInfo.get("user_manager"));
		
		jo5.put("title", "연락처");
		jo5.put("description", saleInfo.get("user_phone"));
		
		jo6.put("title", "프로젝트 유형");
		jo6.put("description", saleInfo.get("project_type_nm"));
		
		jo7.put("title", "서비스 유형");
		jo7.put("description", saleInfo.get("service_type_nm"));
		
		jo8.put("title", "금액");
		jo8.put("description", saleInfo.get("price_nm"));
		
		jo9.put("title", "기한");
		jo9.put("description", saleInfo.get("start_ymd")+"~"+saleInfo.get("end_ymd"));
		
		jo10.put("title", "URL");
		jo10.put("description", "http://sale.musign.net/sales/write?idx="+sale_idx);
		
		ja.add(jo2); ja.add(jo3); ja.add(jo4); ja.add(jo5); ja.add(jo6); 
		ja.add(jo7); ja.add(jo8); ja.add(jo9); ja.add(jo10); 
		jo1.put("connectInfo", ja);

		
		System.out.println(jo1.toJSONString());
		
		try {
			URL url = new URL("https://wh.jandi.com/connect-api/webhook/21137853/38b64d677aed4d6e65665458bff03726"); // 호출할 url
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setDoOutput(true);
			conn.setRequestProperty("Accept", "application/vnd.tosslab.jandi-v2+json");
	        conn.setRequestProperty("content-type", "application/json");
	        conn.setRequestMethod("POST");
	        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
	        wr.write(Utils.checkNullString(jo1));
	        wr.flush();
	        conn.connect();
	        
	        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        sb = new StringBuffer();
	        System.out.println("br : "+br);
	        while ((jsonData = br.readLine()) != null) {
	            sb.append(jsonData);
	            System.out.println("jsonData :"+jsonData);
	        }
	        
		} catch (IOException e) {
			System.out.println("sendSms 전송에 실패했습니다.");
			e.printStackTrace();
		} 
		
	}
}

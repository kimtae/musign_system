package musign.controller.family;


import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.net.HttpURLConnection;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.LeaveDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/leave/*")
public class LeaveController {

	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	// 게시판 dao
	@Autowired
	private LeaveDAO leave_dao;
	
	// user dao
	@Autowired
	private UserDAO user_dao;

	// 게시물 목록 페이지
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/leave/list");
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		mav.addObject("year",year);
		return mav;
	}
	
	// 글 등록 페이지 맵핑
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/leave/write");
		
		return mav;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/leave/detail");
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		HttpSession session = request.getSession();    
		if (session.getAttribute("login_idx")==null) 
		{
			mav.addObject("msg", "로그인 세션이 만료되었습니다.");
			mav.addObject("isSuc", "fail");
			
			return mav;
		}
		String isManager = session.getAttribute("isManager").toString();

		String myidx = session.getAttribute("login_idx").toString();
		String teamidx = session.getAttribute("login_team").toString();
		String chmodidx = session.getAttribute("login_chmod").toString();
		String levelidx = session.getAttribute("login_level").toString();
		
		mav.addObject("idx",idx);
		mav.addObject("myidx",myidx);
		mav.addObject("teamidx",teamidx);
		mav.addObject("chmodidx",chmodidx);
		mav.addObject("levelidx",levelidx);
		
		return mav;
	}
	
	@RequestMapping("/user_detail")
	public ModelAndView user_detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/leave/user_detail");
		
		String leave_idx = Utils.checkNullString(request.getParameter("leave_idx"));
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		
		
		mav.addObject("user_idx",user_idx);
		return mav;
	}
	
	@RequestMapping("/holiday_list")
	public ModelAndView holiday_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/leave/holiday_list");
		
		String leave_idx = Utils.checkNullString(request.getParameter("leave_idx"));
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		
		
		mav.addObject("user_idx",user_idx);
		return mav;
	}
	
	
	@RequestMapping("/getLeaveList")
	@ResponseBody
	public HashMap<String, Object> getLeaveList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
	
		List<HashMap<String, Object>> list = leave_dao.getLeaveList(search_name); 
		map.put("list", list);
	
		return map;
	}
	
	@RequestMapping("/addLeave")
	@ResponseBody
	public HashMap<String, Object> addLeave(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String title = Utils.checkNullString(request.getParameter("title"));
		String target_year = Utils.checkNullString(request.getParameter("target_year"));
		
		
		//중보된 연도 체크
		HashMap<String, Object> data = leave_dao.chkLeave(target_year,"");
		String result = "";
		if(data != null)
		{
			map.put("isSuc", "fail");
	    	map.put("msg", "중복된 연도가 있습니다.");
	    } 
		else 
	    {
			//연차 마스터 테이블 insert
	    	int idx = leave_dao.addLeave(title,target_year);
	    	
	    	//insert한 연차 마스터 idx값에 따라 직원들 데이터 세팅
	    	leave_dao.addLeaveUser(idx);
	    	map.put("isSuc", "success");
	    	map.put("msg", "저장되었습니다.");
	    }
		return map;
	}

	@RequestMapping("/uptLeave")
	@ResponseBody
	public HashMap<String, Object> uptLeave(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String target_year = Utils.checkNullString(request.getParameter("target_year"));
		String title = Utils.checkNullString(request.getParameter("title"));
		
		HashMap<String, Object> data = leave_dao.chkLeave(target_year,idx);
		String result = "";
		if(data != null)
		{
			map.put("isSuc", "fail");
	    	map.put("msg", "중복된 연도가 있습니다.");
	    } 
		else 
	    {
	    	leave_dao.uptLeave(idx,title,target_year);
	    	map.put("isSuc", "success");
	    	map.put("msg", "저장되었습니다.");
	    }
		return map;
	}
	
	@RequestMapping("/delLeave")
	@ResponseBody
	public HashMap<String, Object> delLeave(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		int result = leave_dao.delLeave(idx);
		if(result > 0)
		{
			leave_dao.delLeaveUser(idx);
		}
		map.put("isSuc", "success");
    	map.put("msg", "삭제 되었습니다.");
		return map;
	}
	
	@RequestMapping("/getLeaveUserList")
	@ResponseBody
	public HashMap<String, Object> getLeaveUserList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_team = Utils.checkNullString(request.getParameter("search_team"));
		String search_chmod = Utils.checkNullString(request.getParameter("search_chmod"));
		String search_level = Utils.checkNullString(request.getParameter("search_level"));
		String search_use_yn = Utils.checkNullString(request.getParameter("search_use_yn"));
		String targetYear ="";
		
		if (!idx.equals("")) 
		{
			targetYear = leave_dao.getTargetYear(idx).get("target_year").toString();			
		}
		else
		{
			targetYear = Utils.checkNullString(request.getParameter("targetYear"));
		}
		List<HashMap<String, Object>> list = leave_dao.getLeaveUserList(targetYear,search_name,search_team,search_chmod,search_level,search_use_yn); 

		map.put("list", list);
	
		return map;
	}
	
	@RequestMapping("/getLeaveUserDetailList")
	@ResponseBody
	public HashMap<String, Object> getGuntaeList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		
		List<HashMap<String, Object>> listCnt = leave_dao.getLeaveUserDetailCount(user_idx,start_ymd,end_ymd);
		int listCount = Integer.parseInt(listCnt.get(0).get("CNT").toString());
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 10;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		int block=5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
		    s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
		    e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = leave_dao.getLeaveUserDetailList(s_point, listSize, order_by, sort_type,user_idx,start_ymd,end_ymd); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	@RequestMapping("/getHolidayList")
	@ResponseBody
	public HashMap<String, Object> getHolidayList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		
		List<HashMap<String, Object>> listCnt = leave_dao.getHolidayListCount(search_name,start_ymd,end_ymd);
		int listCount = Integer.parseInt(listCnt.get(0).get("CNT").toString());
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 10;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		int block=5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
		    s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
		    e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = leave_dao.getHolidayList(s_point, listSize, order_by, sort_type,search_name,start_ymd,end_ymd); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	@RequestMapping("/saveLeaveList")
	@ResponseBody
	public HashMap<String, Object> saveLeaveList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String[] user_arr = Utils.checkNullString(request.getParameter("user_arr")).split("\\|");
		String[] leave_arr = Utils.checkNullString(request.getParameter("leave_arr")).split("\\|");
		
	
		
		for (int i = 0; i < user_arr.length; i++) {
			leave_dao.saveUserLeave(idx,leave_arr[i],user_arr[i]); 
		}
		map.put("isSuc", "success");
    	map.put("msg", "저장 되었습니다.");
	
		return map;
	}
	
	
	@RequestMapping("/addHoliday")
	@ResponseBody
	public HashMap<String, Object> addHoliday(HttpServletRequest request) throws IOException {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String target_year = Utils.checkNullString(request.getParameter("target_year"));
		String key = "VpCFJ9NY4TWC3Xkr%2FZ5gf%2FhKJY1LGZuV9eRwWYf3JhmpE%2BQx2LO8DTNz3aSG9c27o4ErTvw%2Bc7mkDOHMDrIFYw%3D%3D";
		String mon = "";
		for (int n = 1; n < 13; n++) {
			
			if (n < 10) 
			{
				mon = "0"+Integer.toString(n);
			}
			else
			{
				mon = Integer.toString(n);
			}
			
	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*공공데이터포털에서 받은 인증키*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("365", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(target_year, "UTF-8")); /*연*/
	        urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode(mon, "UTF-8")); /*월*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	
	        String[] arr= sb.toString().split("<item>");
	        String dateName="";
	        String isHoliday="";
	        String locdate="";
	        int cnt=0;
	        for (int i = 1; i < arr.length; i++) {
	        	
	        	dateName=arr[i].split("<dateName>")[1].split("</dateName>")[0];
	        	isHoliday=arr[i].split("<isHoliday>")[1].split("</isHoliday>")[0];
	        	locdate=arr[i].split("<locdate>")[1].split("</locdate>")[0];
	        	locdate = locdate.substring(0,4)+"-"+locdate.substring(4,6)+"-"+locdate.substring(6,8);
	        	System.out.println("dateName : "+dateName);
	        	System.out.println("isHoliday : "+isHoliday);
	        	System.out.println("locdate : "+locdate);
	        	if (isHoliday.equals("Y")) 
	        	{
	        		HashMap<String, Object> data = leave_dao.chkHoliday(locdate);
	        		if (Integer.parseInt(data.get("cnt").toString()) == 0) 
	        		{
	        			int result = leave_dao.addHoliday(locdate,dateName);
	        			if (result > 0) 
	        			{
	        				cnt++;
						}
					}
				}
			}
	        if (cnt > 0) 
	        {
	        	map.put("isSuc", "success");
	        	map.put("msg", "저장 되었습니다.");
			}
	        else
	        {
	        	map.put("isSuc", "success");
	        	map.put("msg", "추가할 휴일이 없습니다.");
	        }
		}
        return map;
	}
	
	@RequestMapping("/addHoliday_one")
	@ResponseBody
	public HashMap<String, Object> addHoliday_one(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String holiday_info = Utils.checkNullString(request.getParameter("holiday_info"));
		String target_day = Utils.checkNullString(request.getParameter("target_day"));
		
		HashMap<String, Object> data = leave_dao.chkHoliday_one(holiday_info,target_day);
		if (Integer.parseInt(data.get("cnt").toString()) == 0) 
		{
			leave_dao.addHoliday_one(holiday_info,target_day);
			map.put("isSuc", "success");
			map.put("msg", "저장 되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "이미 등록된 휴일입니다.");
		}
		return map;
	}
}
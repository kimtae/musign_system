package musign.controller.family;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;
import musign.model.family.AllowDAO;
import musign.model.family.BoardDAO;
import musign.model.family.DosignDAO;
import musign.model.family.LeaveDAO;
import musign.model.family.MainDAO;
import musign.model.family.UserDAO;


import java.lang.String;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;



@Controller
@RequestMapping("/family/*")
public class MainController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private DosignDAO dosign_dao;
	
	@Autowired
	private MainDAO main_dao;
	
	@Autowired
	private LeaveDAO leave_dao;
	
	@Autowired
	private BoardDAO board_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private AllowDAO allow_dao;
	
		
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/main/main");
        
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx") == null) 
		{
			return mav;
		}
		
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String targetYmd="";
		int early_temp=0; //조퇴의 경우 사용할 임시 변수
		
		double leave_cnt =0.0;
		double sum_leave_cnt =0.0;
		double user_leave = 0;
		double over_leave = 0;
		double prize_leave = 0;
		double use_leave = 0;
		double use_cancel_leave = 0;
		/*
		double late_leave = 0;				double late_cnt = 0;
		*/
		double early_leave = 0;				double early_cnt = 0;
		double early_cancel_leave = 0;		double early_cancel_cnt = 0;
		double half_leave = 0.0;			double half_cnt = 0.0;
		double half_cancel_leave = 0.0;		double half_cancel_cnt= 0.0;
		
		double result =0.0;
		
		List<HashMap<String, Object>> getMyTeamList = user_dao.getMyTeam(myteam,myidx);
		mav.addObject("getMyTeamList", getMyTeamList);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy"); 
		Date now = new Date(); 
		targetYmd = format.format(now); 
		
		sum_leave_cnt += leave_cnt;
		
		HashMap<String, Object> myleave = allow_dao.getMyLeave(myidx,targetYmd,early_temp);
		 user_leave 		= Double.parseDouble(myleave.get("user_leave").toString());								//부여연차
		 over_leave 		= Double.parseDouble(myleave.get("over_leave").toString());								//야근연차
		 prize_leave 		= Double.parseDouble(myleave.get("prize_leave").toString());							//포상연차
		 use_leave 			= Double.parseDouble(myleave.get("use_leave").toString());								//사용연차
		 use_cancel_leave 	= Double.parseDouble(myleave.get("use_cancel_leave").toString());						//사용취소연차
		 
		 //late_cnt 		= Double.parseDouble(myleave.get("late_leave").toString());									//지각횟수
		 /*미개발  조퇴와 같이 쿼리에서 처리할 것*/
		 //late_leave = (late_cnt >= 0) ? late_cnt % 3 : 0;															//지각연차 
		 
		 early_cnt 		= Double.parseDouble(myleave.get("early_leave").toString());								//조퇴회수
		 early_cancel_cnt = Double.parseDouble(myleave.get("early_cancel_leave").toString());						//조퇴취소횟수
		 early_leave = ( (early_cnt + (early_cancel_cnt * -1)) >= 0 ) ? (early_cnt + (early_cancel_cnt * -1)) : 0;	//조퇴연차
		 
		 half_cnt 		= Double.parseDouble(myleave.get("half_leave").toString());									//반차횟수
		 half_cancel_cnt 	= Double.parseDouble(myleave.get("half_cancel_leave").toString());						//반차취소횟수
		 half_leave  = ( half_cnt + (half_cancel_cnt*-1) >= 0 ) ? half_cnt + (half_cancel_cnt*-1) : 0;				//반차사용연차
		
		 
		 //(부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차 + 지각연차 + 조퇴연차 + 반차사용연차)
		 //result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + late_leave + early_leave + half_leave);
		 result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave  + early_leave + half_leave);
		
		mav.addObject("left_guntae", result);
		
		
        String URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQzPt1cl0_0ho1aTfpgQFOWh2VxXSFUMegEtu_06JH4Kz11BoV2RoP88bTpiL5ZZmTyfWj961rMSmPl/pubhtml?gid=0&single=true";
        Document doc = Jsoup.connect(URL).get();
        	
        //Elements elem = doc.select("tr");
        String doc_text = doc.text().split("SHTSTART")[1].split(", Published by Google Sheets–악용사례 신고 –Updated automatically every 5 minutes")[0];
        System.out.println(doc_text);
        main_dao.delGoogleCal();
        main_dao.insGoogleCal(doc_text);
		
		return mav;
	}
	
	@RequestMapping("/main2")
	public ModelAndView main2(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/main/main2");
	
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx") == null) 
		{
			return mav;
		}
		
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		
		String targetYmd="";
		int early_temp=0; //조퇴의 경우 사용할 임시 변수
		
		double leave_cnt =0.0;
		double sum_leave_cnt =0.0;
		double user_leave = 0;
		double over_leave = 0;
		double prize_leave = 0;
		double use_leave = 0;
		double use_cancel_leave = 0;
		
		/*
		double late_leave = 0;				double late_cnt = 0;
		*/
		
		double early_leave = 0;				double early_cnt = 0;
		double early_cancel_leave = 0;		double early_cancel_cnt = 0;
		double half_leave = 0.0;			double half_cnt = 0.0;
		double half_cancel_leave = 0.0;		double half_cancel_cnt= 0.0;
		
		double result =0.0;
		
		List<HashMap<String, Object>> getMyTeamList = user_dao.getMyTeam(myteam,myidx);
		mav.addObject("getMyTeamList", getMyTeamList);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy"); 
		Date now = new Date(); 
		targetYmd = format.format(now); 
		
		sum_leave_cnt += leave_cnt;
		
		HashMap<String, Object> myleave = allow_dao.getMyLeave(myidx,targetYmd,early_temp);
		 user_leave 		= Double.parseDouble(myleave.get("user_leave").toString());								//부여연차
		 over_leave 		= Double.parseDouble(myleave.get("over_leave").toString());								//야근연차
		 prize_leave 		= Double.parseDouble(myleave.get("prize_leave").toString());							//포상연차
		 use_leave 			= Double.parseDouble(myleave.get("use_leave").toString());								//사용연차
		 use_cancel_leave 	= Double.parseDouble(myleave.get("use_cancel_leave").toString());						//사용취소연차
		 
		 //late_cnt 		= Double.parseDouble(myleave.get("late_leave").toString());									//지각횟수
		 /*미개발  조퇴와 같이 쿼리에서 처리할 것*/
		 //late_leave = (late_cnt >= 0) ? late_cnt % 3 : 0;															//지각연차 
		 
		 early_cnt 		= Double.parseDouble(myleave.get("early_leave").toString());								//조퇴회수
		 early_cancel_cnt = Double.parseDouble(myleave.get("early_cancel_leave").toString());						//조퇴취소횟수
		 early_leave = ( (early_cnt + (early_cancel_cnt * -1)) >= 0 ) ? (early_cnt + (early_cancel_cnt * -1)) : 0;	//조퇴연차
		 
		 half_cnt 		= Double.parseDouble(myleave.get("half_leave").toString());									//반차횟수
		 half_cancel_cnt 	= Double.parseDouble(myleave.get("half_cancel_leave").toString());						//반차취소횟수
		 half_leave  = ( half_cnt + (half_cancel_cnt*-1) >= 0 ) ? half_cnt + (half_cancel_cnt*-1) : 0;				//반차사용연차
		
		 
		 //(부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차 + 지각연차 + 조퇴연차 + 반차사용연차)
		 //result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + late_leave + early_leave + half_leave);
		 result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave  + early_leave + half_leave);
		
		mav.addObject("left_guntae", result);
		
		String URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQzPt1cl0_0ho1aTfpgQFOWh2VxXSFUMegEtu_06JH4Kz11BoV2RoP88bTpiL5ZZmTyfWj961rMSmPl/pubhtml?gid=0&single=true";
        Document doc = Jsoup.connect(URL).get();
        	
        //Elements elem = doc.select("tr");
        String doc_text = doc.text().split("SHTSTART")[1].split("SHTEND")[0];
        System.out.println(doc_text);
        main_dao.delGoogleCal();
        main_dao.insGoogleCal(doc_text);
		
		return mav;
	}

	
	// 게시판 목록 조회
	@RequestMapping("/main_getBoardList")
	@ResponseBody
	public HashMap<String, Object> main_getBoardList(HttpServletRequest request){

		//List<HashMap<String, Object>> list = board_dao.getBoardList("","");
		List<HashMap<String, Object>> list = main_dao.main_getBoardList();
			
		HashMap<String, Object> map = new HashMap<>();
			
		map.put("list", list); 
		
		// 게시물 수
		map.put("count", list.size());
			
		
		return map;
	}	
	
	// 게시판 목록 조회
	@RequestMapping("/getUserLeave")
	@ResponseBody
	public HashMap<String, Object> getUserLeave(HttpServletRequest request)throws IOException{
		HashMap<String, Object> map = new HashMap<>();
		
		String cal_year = Utils.checkNullString(request.getParameter("cal_year"));
		String cal_mon = Utils.checkNullString(request.getParameter("cal_mon"));
		String google_chk = Utils.checkNullString(request.getParameter("google_chk"));
		String leave_chk = Utils.checkNullString(request.getParameter("leave_chk"));
		String none_leave_chk = Utils.checkNullString(request.getParameter("none_leave_chk"));
		
		System.out.println("cal_year : "+cal_year);
		System.out.println("cal_mon : "+cal_mon);
		
		/*
		if (google_chk.equals("N") && leave_chk.equals("N") && none_leave_chk.equals("N")) 
		{
			return map;
		}
		*/
		
		List<HashMap<String, Object>> list = main_dao.getUserLeave(cal_year,cal_mon,google_chk,leave_chk,none_leave_chk);
		//List<HashMap<String, Object>> google_list = main_dao.getGoogleList(cal_year,cal_mon);
		//List<HashMap<String, Object>> list = main_dao.main_getBoardList();
         
		
		
		map.put("list", list); 
		//map.put("google_list", google_list); 
		
		return map;
	}
	/*
	@RequestMapping("/getGoogleSchedule")
	@ResponseBody
	public HashMap<String, Object> getGoogleSchedule(HttpServletRequest request) throws IOException{

		//List<HashMap<String, Object>> list = main_dao.main_getBoardList();
        String URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQzPt1cl0_0ho1aTfpgQFOWh2VxXSFUMegEtu_06JH4Kz11BoV2RoP88bTpiL5ZZmTyfWj961rMSmPl/pubhtml?gid=0&single=true";
       
        Document doc = Jsoup.connect(URL).get();
        Elements elem = doc.select("tr");
        //String doc_text = doc.text();
        //String doc_html = doc.html();
        
        //System.out.println(doc.text());  //text 출력
        //System.out.println(doc_html);  //html 출력
        List<HashMap<String, Object>> google_list = new ArrayList<HashMap<String, Object>>();;
        HashMap<String, Object> google_map = new HashMap<>();
		int flag = 1;
		int cnt = 0;
        for(Element e: elem.select("td")) {
        	if (flag == 1) 
        	{
        		google_map.put("target_year", e.text());
			} 
        	else if (flag == 2) 
        	{
        		google_map.put("start_ymd", e.text());
			}
        	else if (flag == 3) 
        	{
        		google_map.put("end_ymd", e.text());
			}
        	else if (flag == 4) 
        	{
        		google_map.put("cont", e.text());
			}
        	
        	google_list.add(cnt, google_map);
        	
        	flag++;
        	if (flag==5) 
        	{
        		flag=1;
			}

        	cnt++;
        	
        }
        
        HashMap<String, Object> map = new HashMap<>();
		map.put("list", google_list); 
		return map;
	}
	*/
	
	// 게시판 목록 조회
	@RequestMapping("/getMyYeonChaList")
	@ResponseBody
	public HashMap<String, Object> getMyYeonChaList(HttpServletRequest request){

		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		
		List<HashMap<String, Object>> list = leave_dao.getLeaveUserDetailList(0, 9999, "", "",myidx,"",""); 
		
		HashMap<String, Object> map = new HashMap<>();
		
			
		map.put("list", list); 
		return map;
	}
	
	@RequestMapping("/getSignCnt")
	@ResponseBody
	public HashMap<String, Object> getSignCnt(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx") == null) 
		{
			return map;
		}
		
		int login_chmod = Integer.parseInt(session.getAttribute("login_chmod").toString());
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		if (login_chmod > 3) 
		{
			return map;
		}
		
		HashMap<String, Object> getSignCnt = main_dao.getSignCnt(myidx,isManager);
		map.put("getSignCnt", getSignCnt.get("cnt")); 
		return map;
	}
		
	
	@RequestMapping("/getSignList")
	@ResponseBody
	public HashMap<String, Object> getSignList(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx") == null) 
		{
			return map;
		}
		
		int login_chmod = Integer.parseInt(session.getAttribute("login_chmod").toString());
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		List<HashMap<String, Object>> getSignList = main_dao.getSignList(myidx,isManager);
		map.put("getSignList", getSignList); 
		return map;
	}
	
	@RequestMapping("/getSaleList")
	@ResponseBody
	public HashMap<String, Object> getSaleList(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx") == null) 
		{
			return map;
		}
		
		List<HashMap<String, Object>> getSaleList = main_dao.getSaleList();
		map.put("getSaleList", getSaleList); 
		return map;
	}
	
	
	/**
	 * 1. 매월 1일 새벽 2시에 자동으로 결재완료하는 스케쥴러
	 */
	// * 을 입력할경우 모두(항상)으로 설정함.
	//                 초  분  시  일  월  요일
	//@Scheduled(cron = "* /60 * * * *")
	@Scheduled(cron = "0 30 16 * * 1-5" )
 	@RequestMapping("/schedule")
	public void autoSendMail(){
		
		String user_idx="";
		String user_name="";
		String user_mail="";
		
		String target_idx="";
		String target_name="";
		String target_doc_type="";
		String target_doc_name="";
		
		String isManager="";
		
		HashMap<String, Object> sign_cnt=null;
		List<HashMap<String, Object>> getSignList = null;
		String mail_msg="";

		HashMap<String, Object> managerInfo =null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());


		List<HashMap<String, Object>> getMyTeamList = main_dao.getLeaderListForMail(strToday);
		if (getMyTeamList.size() > 0) 
		{
			for (int i = 0; i < getMyTeamList.size(); i++) 
			{
				mail_msg="";
				user_idx = getMyTeamList.get(i).get("idx").toString();
				user_name = getMyTeamList.get(i).get("name").toString();
				user_mail = getMyTeamList.get(i).get("email").toString();
				
				managerInfo = dosign_dao.chkManager(getMyTeamList.get(i).get("idx").toString());
				if (managerInfo.get("team_kr").toString().equals("경영지원") &&
						managerInfo.get("chmod_nm").toString().equals("팀장")) 
				{
					isManager="Y";
				}else {
					isManager="";
				}
				
				sign_cnt = main_dao.getSignCnt(user_idx,isManager);
				getSignList = main_dao.getSignList(user_idx,isManager);
				
				if (Integer.parseInt(sign_cnt.get("cnt").toString()) > 0) 
				{
					mail_msg +="총 "+sign_cnt.get("cnt")+"개의 결재 서류가 있습니다.<br>";
					
					for (int j = 0; j < getSignList.size(); j++) {
						target_idx = getSignList.get(j).get("idx").toString();
						target_name = getSignList.get(j).get("kor_nm").toString();
						target_doc_type = getSignList.get(j).get("doc_type").toString();
						target_doc_name = getSignList.get(j).get("doc_name").toString();
		
						mail_msg += "<a href=http://sale.musign.net/family/dosign/detail?idx="+target_idx+"&doc_type="+target_doc_type+">"+(j+1)+"."+target_doc_name+"_"+target_name+"</a><br>";
						
					}
					if (!mail_msg.equals("")) 
					{
						Utils.send_Dosign_mail("auto",user_mail, user_name, target_idx, target_name, target_doc_type, mail_msg);
						main_dao.insMailLog(user_idx,"정기메일");
					}
				}
			}
		}
	}
	
	@RequestMapping("/getSaleCnt")
	@ResponseBody
	public HashMap<String, Object> getSaleCnt(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HashMap<String, Object> getSaleCnt = main_dao.getSaleCnt();
		
		map.put("getSaleCnt", getSaleCnt.get("sale_cnt")); 
		return map;
	}

}

package musign.controller.family;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.DosignDAO;
import musign.model.family.MainDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/dosign/*")
public class DosignController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private DosignDAO dosign_dao;
	
	@Autowired
	private BoardDAO board_dao;
	
	@Autowired
	private MainDAO main_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/dosign/list");	
		return mav;
	}
	
	@RequestMapping("/getDosignList")
	@ResponseBody
	public HashMap<String, Object> getDosignList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
	
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		String doc_type_search = Utils.checkNullString(request.getParameter("doc_type_search"));
		String content_search = Utils.checkNullString(request.getParameter("content_search"));
		String step_search = Utils.checkNullString(request.getParameter("step_search"));
		String imsi_yn = Utils.checkNullString(request.getParameter("imsi_yn"));
		String use_yn = Utils.checkNullString(request.getParameter("use_yn"));
		
		List<HashMap<String, Object>> listCnt = dosign_dao.getDosignListCount(myidx,isManager,search_name,start_ymd,end_ymd,doc_type_search,content_search,step_search,imsi_yn,use_yn);
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
		
		List<HashMap<String, Object>> list = dosign_dao.getDosignList(myidx,s_point, listSize, order_by, sort_type,isManager,search_name,start_ymd,end_ymd,doc_type_search,content_search,step_search,imsi_yn,use_yn); 
		
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
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			mav.setViewName("/WEB-INF/pages/family/main/main");	
			return mav;
		}
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		String login_name = session.getAttribute("login_name").toString();
		String login_team = session.getAttribute("login_team").toString();
		String login_chmod = session.getAttribute("login_chmod").toString();
		
		String isPop= Utils.checkNullString(request.getParameter("isPop"));
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="";
		
		if (doc_type.equals("100")) //근태 신청서
		{ 
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_guntae");	
			doc_nm = "doc_guntae";
		}
		else if(doc_type.equals("101"))
		{
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_jicul");	
			doc_nm = "doc_jicul";
		}
		else if(doc_type.equals("102"))
		{
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_jumal");	
			doc_nm = "doc_jumal";
		}
		else if(doc_type.equals("103"))
		{
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_yeonjang");	
			doc_nm = "doc_yeonjang";
		}
		else if(doc_type.equals("104"))
		{
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_roundrobin");		
			doc_nm = "doc_roundrobin";
		}
		else if(doc_type.equals("105"))
		{
			mav.setViewName("/WEB-INF/pages/family/dosign/dosign_prize");		
			doc_nm = "doc_prize";
		}
		
		//권한 체크용
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) 
		{
			System.out.println("권한 없음!");
			mav.addObject("authChk", "-1"); //권한이 없다면 ㅂㅂ
			return mav;
		}
		
		String[] ref_line;
		String ref_nm="";
		String ref_team_nm="";
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
			
			
			//참조라인 대상 이름,소속 부서 이름 값 세팅 --- start
			if (key.equals("ref_line") && !data.get(key).toString().equals("")) 
			{
				ref_line = data.get(key).toString().split("\\|");
				for (int i = 0; i < ref_line.length; i++) 
				{
					HashMap<String, Object> target_info = user_dao.getMyInfo(ref_line[i]);
					ref_nm += target_info.get("name")+"|";
					ref_team_nm += target_info.get("team_nm")+"|";
					
				}
				mav.addObject("ref_nm", ref_nm);
				mav.addObject("ref_team_nm", ref_team_nm);
			}
			//참조라인 대상 이름,소속 부서 이름 값 세팅 --- end
		}
		
		//각 서류 값 세팅
		String doc_idx = data.get("doc_idx").toString();
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) 
			{
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}
			
			//결제수단 한글 번역용
			if (key.equals("pay_method"))
			{
				mav.addObject(key, dosign_dao.getPayMethodNm(doc_info.get(key).toString()));
			}
			
			//대체 근무자 이름,직급,팀 세팅
			if (key.equals("shifter") || key.equals("target")) 
			{
				HashMap<String, Object> target_info = user_dao.getMyInfo(doc_info.get(key).toString());
				if (target_info!=null) 
				{					
					mav.addObject("target_nm", target_info.get("name"));
					mav.addObject("target_level_nm", target_info.get("level_nm"));
					mav.addObject("target_chmod_nm", target_info.get("chmod_nm"));
					mav.addObject("target_team_nm", target_info.get("team_nm"));
				}
			}	
			
			//대체 근무자 이름,직급,팀 세팅
			if (key.equals("user_idx")) 
			{
				HashMap<String, Object> writer_info = user_dao.getMyInfo(doc_info.get(key).toString());
				if (writer_info!=null) 
				{					
					mav.addObject("writer_nm", writer_info.get("name"));
					mav.addObject("writer_level_nm", writer_info.get("level_nm"));
					mav.addObject("writer_chmod_nm", writer_info.get("chmod_nm"));
					mav.addObject("writer_team_nm", writer_info.get("team_nm"));
				}
			}
			
			
		}
		
		HashMap<String, Object> PrevNextInfo = dosign_dao.getPrevNextIdx(idx,myidx,isManager);
		
		if (PrevNextInfo != null) 
		{
			System.out.println("prev : "+Utils.checkNullString(PrevNextInfo.get("prev_idx")));
			System.out.println("next : "+Utils.checkNullString(PrevNextInfo.get("next_idx")));
			
			mav.addObject("prev_idx", PrevNextInfo.get("prev_idx"));
			mav.addObject("next_idx", PrevNextInfo.get("next_idx"));
		}
		mav.addObject("isManager", isManager);
		mav.addObject("myidx", myidx);
		mav.addObject("login_name", login_name);
		mav.addObject("login_team", login_team);
		mav.addObject("login_chmod", login_chmod);
		mav.addObject("image_dir", image_dir);
		mav.addObject("isPop", isPop);
		return mav;
	}
	
	@RequestMapping("/getApprovalLine")
	@ResponseBody
	public HashMap<String, Object> getApprovalLine(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("msg", "로그인 세션이 만료되었습니다.");
			map.put("isSuc", "fail");
			
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager); 
	
		map.put("isSuc", "success");
		map.put("data", data);
		
		return map;
	}
	
	@RequestMapping("/urgent_mail")
	@ResponseBody
	public HashMap<String, Object> urgent_mail(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("msg", "로그인 세션이 만료되었습니다.");
			map.put("isSuc", "fail");
			
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString();
		String myName = session.getAttribute("login_name").toString();
		String myEmail = session.getAttribute("login_email").toString();
		String isManager = session.getAttribute("isManager").toString();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String target_idx = Utils.checkNullString(request.getParameter("target_idx"));
		
		//HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager); 
		String doc_nm="";
		if (doc_type.equals("100")) 
		{
			doc_nm = "근태신청서";
		}
		else if(doc_type.equals("101"))
		{
			doc_nm = "지출결의서";
		}
		else if(doc_type.equals("102"))
		{
			doc_nm = "주말출근신청서";
		}
		else if(doc_type.equals("103"))
		{
			doc_nm = "연장근무신청서";
		}
		else if(doc_type.equals("104"))
		{
			doc_nm = "품의서";
		}
		else if(doc_type.equals("105"))
		{
			doc_nm = "포상신청서";
		}
		
		try {
			HashMap<String, Object> getWaterInfo = dosign_dao.getWaterInfo(target_idx); 
			String waiter_mail="";
			String waiter_nm="";
			if (getWaterInfo!=null)
			{
				waiter_mail = getWaterInfo.get("email").toString();
				waiter_nm = getWaterInfo.get("name").toString();
			}
			
			String mail_msg = "<a href=http://sale.musign.net/family/dosign/detail?idx="+idx+"&doc_type="+doc_type+">"+doc_nm+"_"+myName+"</a>";
			Utils.send_Dosign_mail("urgent",waiter_mail, waiter_nm, "", "", "", mail_msg);
			main_dao.insMailLog(myidx,"긴급메일");
			map.put("isSuc", "success");
			map.put("msg", "성공적으로 전송 되었습니다.");
		} catch (Exception e) {
			map.put("isSuc", "fail");
			map.put("msg", "전송에 실패했습니다. 관리자에게 문의주세요.");
		}
		//map.put("data", data);
		
		return map;
	}
	
	@RequestMapping("/getChmod")
	@ResponseBody
	public HashMap<String, Object> getChmod(HttpServletRequest request) {
		
		String useridx = Utils.checkNullString(request.getParameter("useridx"));
		String chmod = dosign_dao.getChmod(useridx); 
	
		HashMap<String, Object> map = new HashMap<>();
		map.put("chmod", chmod);
		
		return map;
	}
	
	@RequestMapping("/chkApprovalLine")
	@ResponseBody
	public HashMap<String, Object> chkApprovalLine(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();   
		if (session.getAttribute("login_idx")==null) {
			map.put("msg", "로그인 세션이 만료되었습니다.");
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString(); //실제
		String isManager = session.getAttribute("isManager").toString();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String content = Utils.checkNullString(request.getParameter("content")); //실제
		
	
		int chk_flag = 0;
	
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager); 		
		
		String approval_chk="";
		String approval_date="";
		String approval_content="";
		
		String[] approval_line = (data.get("approval_line").toString()).split("\\|");
		String[] approval_chk_arr = (data.get("approval_chk").toString()).split("\\|");
		String[] approval_date_arr = (data.get("approval_date").toString()).split("\\|");
		String[] approval_content_arr = (data.get("approval_content").toString()).split("\\|");
		
		//해당 승인자 차례일 때 값 세팅
		for (int i = 0; i < approval_line.length; i++) {
			if (approval_line[i].equals(myidx)) 
			{
				chk_flag = i;
				approval_chk_arr[i] = myidx;
				approval_date_arr[i] = Utils.getNowTime();
				approval_content_arr[i] = content;
			}
			approval_chk 	 +=approval_chk_arr[i]+"|";
			approval_date 	 +=approval_date_arr[i]+"|";
			approval_content +=approval_content_arr[i]+"|";
		}
		
		String waiter = Utils.getWaiter(data.get("approval_line").toString(),approval_chk);
			
		/*
		if (!waiter.equals("")) 
		{
			HashMap<String, Object> getWaterInfo = dosign_dao.getWaterInfo(waiter); 		
			if (getWaterInfo!=null)
			{
				System.out.println("********* send mail start *********");
				String waiter_mail = getWaterInfo.get("email").toString();
				String waiter_nm = getWaterInfo.get("name").toString();
				String target_nm = data.get("kor_nm").toString();
				String target_doc_type = data.get("doc_type").toString();
				Utils.send_Dosign_mail(waiter_mail, waiter_nm, idx, target_nm, target_doc_type);
				System.out.println("********* send mail end *********");
			}
		}
		*/
		//String step = Utils.getStep(session.getAttribute("login_chmod").toString(),user_dao); //실제
		String step = session.getAttribute("login_chmod_nm").toString()+"승인"; //실제
		//String step = Utils.getChmod_kor("4",user_dao); //테스트용
		
		int result = dosign_dao.doApprove(idx,step,waiter,approval_chk,approval_date,approval_content);
		
		if (result > 0) 
		{
			map.put("msg", "저장 되었습니다.");
		}
		else 
		{
			map.put("msg", "관리자에게 문의해주세요.");
		}
		
		
		//map.put("data", data);
		
		return map;
	}
	
	
	@RequestMapping("/chkReturn")
	@ResponseBody
	public HashMap<String, Object> chkReturn(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();   
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("msg", "로그인 세션이 만료되었습니다.");
			return map;
		}
		String myidx = session.getAttribute("login_idx").toString(); //실제
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String content = Utils.checkNullString(request.getParameter("content")); //실제
	
		int result = dosign_dao.doReturn(idx,content,myidx);
		
		if (result > 0) {
			map.put("msg", "반려 되었습니다.");
		}else {
			map.put("msg", "관리자에게 문의해주세요.");
		}
		
		
		//map.put("data", data);
		
		return map;
	}
	
	@RequestMapping("/chkFinal")
	@ResponseBody
	public HashMap<String, Object> chkFinal(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();   
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("msg", "로그인 세션이 만료되었습니다.");
			return map;
		}
		String myidx = session.getAttribute("login_idx").toString(); //실제
		String idx = Utils.checkNullString(request.getParameter("idx"));
	
		int result = dosign_dao.doFinalPass(idx,myidx);
		
		if (result > 0) {
			map.put("msg", "최종 승인 되었습니다.");
		}else {
			map.put("msg", "관리자에게 문의해주세요.");
		}
		
		
		//map.put("data", data);
		
		return map;
	}
	
}

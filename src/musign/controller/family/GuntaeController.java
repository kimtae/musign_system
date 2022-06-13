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
import musign.model.family.GuntaeDAO;
import musign.model.family.MainDAO;
import musign.model.family.TempDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/guntae/*")
public class GuntaeController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	
	@Autowired
	private MainDAO main_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private GuntaeDAO guntae_dao;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/guntae/list");	
		HttpSession session = request.getSession();    
		String isManager="";
		String login_team="";
		if (session.getAttribute("login_idx")!=null) 
		{
			isManager = session.getAttribute("isManager").toString();			
			login_team = session.getAttribute("login_team_nm").toString();		
			
		}
		mav.addObject("isManager", isManager);
		mav.addObject("login_team_nm", login_team);
		return mav;
	}
	
	@RequestMapping("/getGuntaeList")
	@ResponseBody
	public HashMap<String, Object> getGuntaeList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		String teamidx = session.getAttribute("login_team").toString();
		String chk_teamidx = session.getAttribute("login_team").toString();
		String chmodidx = session.getAttribute("login_chmod").toString();
		String levelidx = session.getAttribute("login_level").toString();
		String leaderChk="N";
		
		System.out.println("myidx : "+myidx);
		System.out.println("isManager : "+isManager);
		System.out.println("teamidx : "+teamidx);
		System.out.println("chmodidx : "+chmodidx);
		
		
		if (Integer.parseInt(teamidx) < 3 ) //team idx가 HQ, 경영지원이라면
		{
			teamidx=""; //모든 직원 검색을 위한 세팅
		}
		
		if (Integer.parseInt(chmodidx) < 4 ) //chmod idx가 팀장 이상이라면
		{
			leaderChk="Y"; //모든 직원 검색을 위한 세팅
		}
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		String day_status = Utils.checkNullString(request.getParameter("day_status"));
		
		List<HashMap<String, Object>> listCnt = null;
		if (chk_teamidx.equals("2")) 
		{
			 listCnt = guntae_dao.getGuntaeListCountByManager(myidx,isManager,search_name,start_ymd,end_ymd,day_status,teamidx,chmodidx,leaderChk);
		}
		else
		{			
			 listCnt = guntae_dao.getGuntaeListCount(myidx,isManager,search_name,start_ymd,end_ymd,day_status,teamidx,chmodidx,leaderChk);
		}
		
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
		
		List<HashMap<String, Object>> list = null;
		if (chk_teamidx.equals("2")) 
		{
			list = guntae_dao.getGuntaeListByManager(myidx,s_point, listSize, order_by, sort_type,isManager,search_name,start_ymd,end_ymd,day_status,teamidx,chmodidx,leaderChk); 
		}
		else
		{			
			list = guntae_dao.getGuntaeList(myidx,s_point, listSize, order_by, sort_type,isManager,search_name,start_ymd,end_ymd,day_status,teamidx,chmodidx,leaderChk); 
		}
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
	
	
	@RequestMapping("/uptGuntaeData")
	@ResponseBody
	public HashMap<String, Object> uptGuntaeData(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		String submit_year = Utils.checkNullString(request.getParameter("submit_year"));
		String min_time = Utils.checkNullString(request.getParameter("min_time"));
		String max_time = Utils.checkNullString(request.getParameter("max_time"));
		String late_time = Utils.checkNullString(request.getParameter("late_time"));
		String over_work_time = Utils.checkNullString(request.getParameter("over_work_time"));
		String over_night_work_time = Utils.checkNullString(request.getParameter("over_night_work_time"));
		String whole_work_time = Utils.checkNullString(request.getParameter("whole_work_time"));
		String day_status = Utils.checkNullString(request.getParameter("day_status"));
		
		HashMap<String, Object> map = new HashMap<>();
		int result = guntae_dao.uptGuntaeData(user_idx,submit_year,min_time,max_time,late_time,over_work_time,over_night_work_time,whole_work_time,day_status);
		if (result > 0) 
		{
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "관리자에게 문의주세요.");
		}
		
		
		return map;
	}
}

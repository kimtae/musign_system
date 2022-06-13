package musign.controller.family;

import java.io.File;
import java.text.ParseException;
import java.util.Enumeration;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.KpiDAO;
import musign.model.family.TeamDAO;

@Controller
@RequestMapping("/family/kpi/*")
public class KpiController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@Autowired
	private KpiDAO kpi_dao;
	
	@Autowired
	private TeamDAO team_dao;
	

	@RequestMapping("/insKpi")
	public ModelAndView insKpi(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/kpi/insKpi");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return mav;
		}
		
		String user_idx = Utils.checkNullString(session.getAttribute("login_idx"));
		mav.addObject("user_idx", user_idx);
		
		
		return mav;
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/kpi/list");
		
		return mav;
	}
	
	@RequestMapping("/insKpi_leader")
	public ModelAndView insKpi_leader(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/kpi/insKpi_leader");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return mav;
		}
		
		String user_idx = Utils.checkNullString(request.getParameter("idx"));
		mav.addObject("user_idx", user_idx);
		
		String myidx = session.getAttribute("login_idx").toString();
		String teamidx = session.getAttribute("login_team").toString();
		String chmodidx = session.getAttribute("login_chmod").toString();
		if (Integer.parseInt(teamidx) < 3 ) //team idx가 HQ, 경영지원이라면
		{
			teamidx=""; //모든 직원 검색을 위한 세팅
			chmodidx="3";
		}
		List<HashMap<String, Object>> team_list = team_dao.getTeamList(myidx,teamidx,chmodidx,"","","","","","");
		mav.addObject("team_list", team_list);
		
		return mav;
	}
	@RequestMapping("/insKpi_proc")
	@ResponseBody
	public HashMap<String, Object> insKpi_proc(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		String user_idx = Utils.checkNullString(session.getAttribute("login_idx"));
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		else
		{
			map.put("user_idx", user_idx);
		}
		
		try
		{
			int sizeLimit = 5000*1024*1024; //10메가 까지 가능
			
			String uploadPath = upload_dir+"kpi/";
			
			File dir = new File(uploadPath);
			if (!dir.exists()) { // 디렉토리가 존재하지 않으면
				dir.mkdirs(); // 디렉토리 생성
			}
			
			MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
			String year = Utils.checkNullString(multi.getParameter("year"));
			String period = Utils.checkNullString(multi.getParameter("period"));
			
			map.put("year", year);
			map.put("period", period);
			
			map.put("target", Utils.checkNullString(multi.getParameter("target")));
			map.put("detail", Utils.checkNullString(multi.getParameter("detail")));
			
			String output_file = "";
			String tmp_ = Utils.checkNullString(multi.getOriginalFileName("output_file"));
			if("".equals(tmp_))
			{
				output_file += Utils.checkNullString(multi.getParameter("output_file_ori"));
			}
			else
			{
				output_file += Utils.convertFileName(tmp_, uploadPath, 4);
			}
			map.put("output_file", output_file);
			
			int cnt = 0;
			if(kpi_dao.getKpi(user_idx, year) == null)
			{
				cnt = kpi_dao.insKpi(map);
			}
			else
			{
				cnt = kpi_dao.upKpi(map);
			}
			
			if(cnt == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "KPI 등록 중, 오류가 발생하였습니다.");
				return map;
			}
			
			map.put("target1", Utils.checkNullString(multi.getParameter("target1")));
			map.put("target2", Utils.checkNullString(multi.getParameter("target2")));
			map.put("target3", Utils.checkNullString(multi.getParameter("target3")));
			map.put("target4", Utils.checkNullString(multi.getParameter("target4")));
			map.put("target5", Utils.checkNullString(multi.getParameter("target5")));
			
			map.put("detail1", Utils.checkNullString(multi.getParameter("detail_list1")));
			map.put("detail2", Utils.checkNullString(multi.getParameter("detail_list2")));
			map.put("detail3", Utils.checkNullString(multi.getParameter("detail_list3")));
			map.put("detail4", Utils.checkNullString(multi.getParameter("detail_list4")));
			map.put("detail5", Utils.checkNullString(multi.getParameter("detail_list5")));
			
			map.put("detail_date1", Utils.checkNullString(multi.getParameter("detail_date_list1")));
			map.put("detail_date2", Utils.checkNullString(multi.getParameter("detail_date_list2")));
			map.put("detail_date3", Utils.checkNullString(multi.getParameter("detail_date_list3")));
			map.put("detail_date4", Utils.checkNullString(multi.getParameter("detail_date_list4")));
			map.put("detail_date5", Utils.checkNullString(multi.getParameter("detail_date_list5")));
			
			map.put("detail_step1", Utils.checkNullString(multi.getParameter("detail_step_list1")));
			map.put("detail_step2", Utils.checkNullString(multi.getParameter("detail_step_list2")));
			map.put("detail_step3", Utils.checkNullString(multi.getParameter("detail_step_list3")));
			map.put("detail_step4", Utils.checkNullString(multi.getParameter("detail_step_list4")));
			map.put("detail_step5", Utils.checkNullString(multi.getParameter("detail_step_list5")));
			
			String cnt_list1[] = Utils.checkNullString(multi.getParameter("cnt_list1")).split("\\|");
			String output_file1 = "";
			for(int i = 0; i < cnt_list1.length; i++)
			{
				String tmp = Utils.checkNullString(multi.getOriginalFileName("output_file1_"+cnt_list1[i]));
				if("".equals(tmp))
				{
					output_file1 += Utils.checkNullString(multi.getParameter("output_file_ori1_"+cnt_list1[i]))+"|";
				}
				else
				{
					output_file1 += Utils.convertFileName(tmp, uploadPath, (i+1))+"|";
				}
			}
			map.put("output_file1", output_file1);
			
			String cnt_list2[] = Utils.checkNullString(multi.getParameter("cnt_list2")).split("\\|");
			String output_file2 = "";
			for(int i = 0; i < cnt_list2.length; i++)
			{
				String tmp = Utils.checkNullString(multi.getOriginalFileName("output_file2_"+cnt_list2[i]));
				if("".equals(tmp))
				{
					output_file2 += Utils.checkNullString(multi.getParameter("output_file_ori2_"+cnt_list2[i]))+"|";
				}
				else
				{
					output_file2 += Utils.convertFileName(tmp, uploadPath, (i+1))+"|";
				}
			}
			map.put("output_file2", output_file2);
			
			String cnt_list3[] = Utils.checkNullString(multi.getParameter("cnt_list3")).split("\\|");
			String output_file3 = "";
			for(int i = 0; i < cnt_list3.length; i++)
			{
				String tmp = Utils.checkNullString(multi.getOriginalFileName("output_file3_"+cnt_list3[i]));
				if("".equals(tmp))
				{
					output_file3 += Utils.checkNullString(multi.getParameter("output_file_ori3_"+cnt_list3[i]))+"|";
				}
				else
				{
					output_file3 += Utils.convertFileName(tmp, uploadPath, (i+1))+"|";
				}
			}
			map.put("output_file3", output_file3);
			
			String cnt_list4[] = Utils.checkNullString(multi.getParameter("cnt_list4")).split("\\|");
			String output_file4 = "";
			for(int i = 0; i < cnt_list4.length; i++)
			{
				String tmp = Utils.checkNullString(multi.getOriginalFileName("output_file4_"+cnt_list4[i]));
				if("".equals(tmp))
				{
					output_file4 += Utils.checkNullString(multi.getParameter("output_file_ori4_"+cnt_list4[i]))+"|";
				}
				else
				{
					output_file4 += Utils.convertFileName(tmp, uploadPath, (i+1))+"|";
				}
			}
			map.put("output_file4", output_file4);
			
			String cnt_list5[] = Utils.checkNullString(multi.getParameter("cnt_list5")).split("\\|");
			String output_file5 = "";
			for(int i = 0; i < cnt_list5.length; i++)
			{
				String tmp = Utils.checkNullString(multi.getOriginalFileName("output_file5_"+cnt_list5[i]));
				if("".equals(tmp))
				{
					output_file5 += Utils.checkNullString(multi.getParameter("output_file_ori5_"+cnt_list5[i]))+"|";
				}
				else
				{
					output_file5 += Utils.convertFileName(tmp, uploadPath, (i+1))+"|";
				}
			}
			map.put("output_file5", output_file5);
			
			if(kpi_dao.getOkr(user_idx, year, period) == null)
			{
				cnt = kpi_dao.insOkr(map);
			}
			else
			{
				cnt = kpi_dao.upOkr(map);
			}
			
			
			
			if(cnt == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "OKR 등록 중, 오류가 발생하였습니다.");
				return map;
			}
			
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알수없는 에러가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping("/insKpi_leader_proc")
	@ResponseBody
	public HashMap<String, Object> insKpi_leader_proc(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		String user_idx = Utils.checkNullString(request.getParameter("team_idx"));
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		else
		{
			map.put("user_idx", user_idx);
		}
		
		try
		{
			String year = Utils.checkNullString(request.getParameter("year"));
			String period = Utils.checkNullString(request.getParameter("period"));
			
			map.put("year", year);
			map.put("period", period);
			
			int cnt = 0;
			
			map.put("interv_date", Utils.checkNullString(request.getParameter("interv_date")));
			map.put("interv_comment", Utils.checkNullString(request.getParameter("interv_comment")));
			map.put("is_end1", Utils.checkNullString(request.getParameter("is_end_list1")));
			map.put("is_end2", Utils.checkNullString(request.getParameter("is_end_list2")));
			map.put("is_end3", Utils.checkNullString(request.getParameter("is_end_list3")));
			map.put("is_end4", Utils.checkNullString(request.getParameter("is_end_list4")));
			map.put("is_end5", Utils.checkNullString(request.getParameter("is_end_list5")));
			map.put("comment1", Utils.checkNullString(request.getParameter("comment_list1")));
			map.put("comment2", Utils.checkNullString(request.getParameter("comment_list2")));
			map.put("comment3", Utils.checkNullString(request.getParameter("comment_list3")));
			map.put("comment4", Utils.checkNullString(request.getParameter("comment_list4")));
			map.put("comment5", Utils.checkNullString(request.getParameter("comment_list5")));
			map.put("comment_date1", Utils.checkNullString(request.getParameter("comment_date_list1")));
			map.put("comment_date2", Utils.checkNullString(request.getParameter("comment_date_list2")));
			map.put("comment_date3", Utils.checkNullString(request.getParameter("comment_date_list3")));
			map.put("comment_date4", Utils.checkNullString(request.getParameter("comment_date_list4")));
			map.put("comment_date5", Utils.checkNullString(request.getParameter("comment_date_list5")));
			
			if(kpi_dao.getOkr(user_idx, year, period) == null)
			{
				cnt = kpi_dao.insOkr_leader(map);
			}
			else
			{
				cnt = kpi_dao.upOkr_leader(map);
			}
			
			if(cnt == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "OKR 등록 중, 오류가 발생하였습니다.");
				return map;
			}
			
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알수없는 에러가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping("/okrSubmit")
	@ResponseBody
	public HashMap<String, Object> okrSubmit(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		try
		{
			
			String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
			String year = Utils.checkNullString(request.getParameter("year"));
			String period = Utils.checkNullString(request.getParameter("period"));
			String step = Utils.checkNullString(request.getParameter("step"));
			
			map.put("user_idx", user_idx);
			map.put("year", year);
			map.put("period", period);
			map.put("step", step);
			
			int cnt = 0;
			cnt = kpi_dao.upOkr_step(map);
			if(cnt == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "OKR 등록 중, 오류가 발생하였습니다.");
				return map;
			}
			
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알수없는 에러가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping("/getKpi")
	@ResponseBody
	public HashMap<String, Object> getKpi(HttpServletRequest request) {
		
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		String year = Utils.checkNullString(request.getParameter("year"));
		
		HashMap<String, Object> data = kpi_dao.getKpi(user_idx, year);
		return data;
	}
	@RequestMapping("/getOkr")
	@ResponseBody
	public HashMap<String, Object> getOkr(HttpServletRequest request) {
		
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		String year = Utils.checkNullString(request.getParameter("year"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		
		HashMap<String, Object> data = kpi_dao.getOkr(user_idx, year, period);
		return data;
	}
	@RequestMapping("/getUser")
	@ResponseBody
	public HashMap<String, Object> getUser(HttpServletRequest request) {
		
		String user_idx = Utils.checkNullString(request.getParameter("user_idx"));
		
		HashMap<String, Object> data = kpi_dao.getUser(user_idx);
		return data;
	}
	
	
	@RequestMapping("/getKpiList")
	@ResponseBody
	public HashMap<String, Object> getDosignList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
	
		String search_name = Utils.checkNullString(request.getParameter("search_name"));

		
		List<HashMap<String, Object>> listCnt = kpi_dao.getKpiListCount(search_name);
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
		
		List<HashMap<String, Object>> list = kpi_dao.getKpiList(s_point, listSize, order_by, sort_type,search_name); 
		
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
	
}

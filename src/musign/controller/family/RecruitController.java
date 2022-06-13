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
import musign.model.family.RecruitDAO;
import musign.model.family.MainDAO;
import musign.model.family.TempDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/recruit/*")
public class RecruitController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private RecruitDAO rec_dao;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/recruit/list");	
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/recruit/write");	
		return mav;
	}
	
	@RequestMapping("/getRecruitList")
	@ResponseBody
	public HashMap<String, Object> getSaleList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
	
		List<HashMap<String, Object>> TotallistCnt = rec_dao.getRecruitCount();
		List<HashMap<String, Object>> listCnt = rec_dao.getRecruitCount();
		int TotalCnt = Integer.parseInt(TotallistCnt.get(0).get("CNT").toString());
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
		

		
		List<HashMap<String, Object>> list = rec_dao.getRecruitList(s_point, listSize, order_by, sort_type); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("TotalCnt", TotalCnt);
		map.put("listCount", listCount);
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	@RequestMapping("/getRecinfo")
	@ResponseBody
	public HashMap<String, Object> getRecinfo(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		String rec_idx = Utils.checkNullString(request.getParameter("rec_idx"));
		HashMap<String, Object> data = rec_dao.getRecinfo(rec_idx);
		if (data !=null) 
		{
			map.put("data", data);
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 ERROR발생.");
			
		}
		return map;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/recruit/detail");
		
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "세션이 만료되었습니다.");
			return mav;
		}
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		HashMap<String, Object> data = rec_dao.getRecinfo(idx);
		
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
			if (key.equals("story_cont")) 
			{
				mav.addObject(key, Utils.repWord(data.get(key).toString()));
			}
		}
		mav.addObject("isSuc", "success");
		return mav;
	}
	
	
	@RequestMapping("/getRecruitArea")
	@ResponseBody
	public HashMap<String, Object> getRecruitArea(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		List<HashMap<String, Object>> list = rec_dao.getRecruitArea(); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
	
		
		return map;
	}
	
	@RequestMapping("/uptRecArea")
	@ResponseBody
	public HashMap<String, Object> uptRecArea(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String chk_val = Utils.checkNullString(request.getParameter("chk_val"));
		
		rec_dao.uptRecArea(idx,chk_val);
    	map.put("isSuc", "success");
    	map.put("msg", "저장되었습니다.");
	    
		return map;
	}
}

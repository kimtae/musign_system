package musign.controller.family;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.MoDAO;

@Controller
@RequestMapping("/family/mo/*")
public class MoController {

   private final Logger log = Logger.getLogger(this.getClass());
   
   @Autowired
   private MoDAO mo_dao;
   
   //유지보수 대시보드
   @RequestMapping("/main")
   public ModelAndView main(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/main");

      return mav;
   }
   
   //유지보수 프로젝트 리스트 페이지
   @RequestMapping("/list")
   public ModelAndView list(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/list");

      return mav;
   }
   
   //유지보수 리스트 페이지
   @RequestMapping("/target_list")
   public ModelAndView target_list(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/target_list");

      return mav;
   }
   
   //유지보수 상세 페이지
   @RequestMapping("/target_detail")
   public ModelAndView target_detail(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/target_detail");

      return mav;
   }
   
   @RequestMapping("/contract_info")
   public ModelAndView contract_info(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/contract_info");

      return mav;
   }
  
   //프로젝트 등록 페이지
   @RequestMapping("/write")
   public ModelAndView write(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/write");

      List<HashMap<String, Object>> getGradeList = mo_dao.getGradeList();
      List<HashMap<String, Object>> getProjectList = mo_dao.getProjectList();
      
      mav.addObject("getGradeList", getGradeList);
      mav.addObject("getProjectList", getProjectList);
      
      return mav;
   }
   
   //유지보수 상세 페이지 - 유지보수 요청서
   @RequestMapping("/sub_offer")
   public ModelAndView sub_offer(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/sub_offer");

      return mav;
   }
   
   //유지보수 상세 페이지 - 상세 업무 현황
   @RequestMapping("/sub_work_status")
   public ModelAndView sub_work_status(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/sub_work_status");

      return mav;
   }
   
   //유지보수 상세 페이지 - 캘린더
   @RequestMapping("/sub_calender")
   public ModelAndView sub_calender(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/sub_calender");

      return mav;
   }
  
   //유지보수 상세 페이지 - 관리자 메모
   @RequestMapping("/sub_memo")
   public ModelAndView sub_memo(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/sub_memo");

      return mav;
   }
   
   //유지보수 상세 페이지 - 정산설정
   @RequestMapping("/sub_set")
   public ModelAndView sub_set(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/sub_set");

      return mav;
   }
   
   //플랜 등록 페이지
   @RequestMapping("/plan")
   public ModelAndView plan(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/plan");

      return mav;
   }
   
   //노임 단가 등록 페이지
   @RequestMapping("/wage")
   public ModelAndView wage(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/wage");

      return mav;
   }
   
   //유지보수 항목 등록 페이지
   @RequestMapping("/cate_add")
   public ModelAndView cate_add(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/family/mo/cate_add");

      return mav;
   }
   
	@RequestMapping("/getMoPlanList")
	@ResponseBody
	public HashMap<String, Object> getMoPlanList(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = mo_dao.getMoPlanList();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping("/addMoPlan")
	@ResponseBody
	public HashMap<String, Object> addMoPlan(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		mo_dao.addMoPlan();
		
		map.put("isSuc", "success");
		return map;
	}
	
	@RequestMapping("/delMoPlan")
	@ResponseBody
	public HashMap<String, Object> delMoPlan(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		mo_dao.delMoPlan(idx);
		
		map.put("isSuc", "success");
		return map;
	}
	
	@RequestMapping("/uptMoPlan")
	@ResponseBody
	public HashMap<String, Object> uptMoPlan(HttpServletRequest request) {
		
		String[] grade_idx_arr = Utils.checkNullString(request.getParameter("grade_idx")).split("\\|");
		String[] grade_nm_arr = Utils.checkNullString(request.getParameter("grade_nm")).split("\\|");
		String[] mon_amount_arr = Utils.checkNullString(request.getParameter("mon_amount")).split("\\|");
		String[] t_mon_amount_arr = Utils.checkNullString(request.getParameter("t_mon_amount")).split("\\|");
		String[] per_amount_arr = Utils.checkNullString(request.getParameter("per_amount")).split("\\|");
		String[] year_amount_arr = Utils.checkNullString(request.getParameter("year_amount")).split("\\|");
		
		System.out.println("grade_idx_arr.length : "+grade_idx_arr.length);
		System.out.println("grade_nm_arr.length : "+grade_nm_arr.length);
		
		for (int i = 0; i < grade_idx_arr.length; i++) {
			System.out.println("grade_idx_arr : "+grade_idx_arr[i]);
			System.out.println("grade_nm_arr : "+grade_nm_arr[i]);
			System.out.println("mon_amount_arr : "+mon_amount_arr[i]);
			System.out.println("t_mon_amount_arr : "+t_mon_amount_arr[i]);
			System.out.println("per_amount_arr : "+per_amount_arr[i]);
			System.out.println("year_amount_arr : "+year_amount_arr[i]);
			
			mo_dao.uptMoPlan(grade_idx_arr[i],grade_nm_arr[i],mon_amount_arr[i],t_mon_amount_arr[i],per_amount_arr[i],year_amount_arr[i]);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장 되었습니다.");
		return map;
	}
	
	
	@RequestMapping("/getMoCateList")
	@ResponseBody
	public HashMap<String, Object> getMoCateList(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = mo_dao.getMoCateList();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping("/addMoCate")
	@ResponseBody
	public HashMap<String, Object> addMoCate(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		mo_dao.addMoCate();
		
		map.put("isSuc", "success");
		return map;
	}
	
	
	@RequestMapping("/delMoCate")
	@ResponseBody
	public HashMap<String, Object> delMoCate(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		mo_dao.delMoCate(idx);
		
		map.put("isSuc", "success");
		return map;
	}
	
	@RequestMapping("/add_project")
	@ResponseBody
	public HashMap<String, Object> add_project(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx 				= Utils.checkNullString(request.getParameter("idx"));
		String project_type 	= Utils.checkNullString(request.getParameter("project_type"));
		String sale_idx 		= Utils.checkNullString(request.getParameter("sale_idx"));
		String grade 			= Utils.checkNullString(request.getParameter("grade"));
		String edit_cnt 		= Utils.checkNullString(request.getParameter("edit_cnt"));
		String manager_nm		= Utils.checkNullString(request.getParameter("manager_nm"));
		String manager_level 	= Utils.checkNullString(request.getParameter("manager_level"));
		String phone_no1 		= Utils.checkNullString(request.getParameter("phone_no1"));
		String phone_no2 		= Utils.checkNullString(request.getParameter("phone_no2"));
		String phone_no3 		= Utils.checkNullString(request.getParameter("phone_no3"));
		String email 			= Utils.checkNullString(request.getParameter("email"));
		String business_no 		= Utils.checkNullString(request.getParameter("business_no"));
		String contract_amt 	= Utils.checkNullString(request.getParameter("contract_amt"));
		String start_ymd 		= Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd 			= Utils.checkNullString(request.getParameter("end_ymd"));
		String month_amt 		= Utils.checkNullString(request.getParameter("month_amt"));
		String month_cal_day 	= Utils.checkNullString(request.getParameter("month_cal_day"));
		String tax_date 		= Utils.checkNullString(request.getParameter("tax_date"));
		String mr_idx 			= Utils.checkNullString(request.getParameter("mr_idx"));
		String mr_sub_idx 		= Utils.checkNullString(request.getParameter("mr_sub_idx"));
		String user_id 			= Utils.checkNullString(request.getParameter("user_id"));
		String user_pw 			= Utils.checkNullString(request.getParameter("user_pw"));
		String ftp_id 			= Utils.checkNullString(request.getParameter("ftp_id"));
		String ftp_pw 			= Utils.checkNullString(request.getParameter("ftp_pw"));
		String db_id 			= Utils.checkNullString(request.getParameter("db_id"));
		String db_pw 			= Utils.checkNullString(request.getParameter("db_pw"));
		
		if (idx.equals("")) 
		{
			mo_dao.add_project(project_type, sale_idx,  grade, 		edit_cnt, 		manager_nm,  manager_level,
							   phone_no1,	 phone_no2, phone_no3,  email,	  		business_no, contract_amt,
							   start_ymd,	 end_ymd,   month_amt,  month_cal_day,	tax_date,	 
							   user_id,   	 user_pw,   ftp_id,     ftp_pw,      	db_id,
							   db_pw);	
			map.put("msg", "등록 되었습니다.");
		}
		else
		{
			mo_dao.update_project(idx,			 project_type,  sale_idx,   grade, 			edit_cnt, 	 manager_nm,  manager_level,
							      phone_no1,	 phone_no2, 	phone_no3,  email,	  		business_no, contract_amt,
							      start_ymd,	 end_ymd,   	month_amt,  month_cal_day,	tax_date,	 
							      user_id,   	 user_pw,       ftp_id,     ftp_pw,         db_id,
							      db_pw);
			map.put("msg", "저장 되었습니다.");
		}
		
		map.put("isSuc", "success");
		return map;
	}
}
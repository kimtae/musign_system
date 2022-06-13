package musign.controller.mumul;

import java.io.File;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.mumul.MumulDAO;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/mumul/*")
public class MumulController {
	
	@Value("${upload_dir}")
	private String upload_dir;
	@Value("${image_dir}")
	private String image_dir;
	
	@Autowired
	private MumulDAO mu_dao;
	
	private final Logger log = Logger.getLogger(this.getClass());

	// 로그인 페이지
	@RequestMapping("/login")
	public ModelAndView main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/mumul/login");
		
		return mav;
	}
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/mumul/view");
		List<HashMap<String, Object>> list = mu_dao.getOneDep();
		mav.addObject("list", list);
		return mav;
	}
	
	// 로그인 실행
	@RequestMapping("/login_proc")
	public ModelAndView login_proc(HttpServletRequest request) throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/mumul/login_proc");
		
		String login_id = Utils.checkNullString(request.getParameter("login_id"));
		String login_pw = Utils.checkNullString(request.getParameter("login_pw"));
		
		try
		{
			if("ad_musign".equals(login_id) && "mu_abwkdlsqhdks*".equals(login_pw))
			{
				HttpSession session = request.getSession();
				session.setAttribute("login_id", login_id);
				mav.addObject("isSuc", "success");
				return mav;
			}
			else
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "회원 정보가 없습니다.");
				return mav;
			}
			
		}
		catch(Exception e)
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알수없는 에러가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// 로그아웃 
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/mumul/logout");
		HttpSession session = request.getSession();
		session.invalidate();
		return mav;
	}
	
	// 카테고리 관리
	@RequestMapping("/cate_list")
	public ModelAndView cate_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/mumul/cate_list");
		List<HashMap<String, Object>> list = mu_dao.getCateList("Y");
		JSONArray jsonArray = new JSONArray();
		mav.addObject("list", jsonArray.fromObject(list));
		return mav;
	}
	@RequestMapping("/delCate")
	@ResponseBody
	public HashMap<String, Object> delCate(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		map.put("idx", idx);
		
		try
		{
			mu_dao.delCate(map);
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
			return map;
		}
		return map;
	}
	@RequestMapping("/addPlease")
	@ResponseBody
	public HashMap<String, Object> addPlease(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String val = Utils.checkNullString(request.getParameter("val"));
		
		map.put("val", val);
		
		try
		{
			mu_dao.addPlease(map);
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
			return map;
		}
		return map;
	}
	@RequestMapping("/saveContents")
	@ResponseBody
	public HashMap<String, Object> saveContents(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String contents = Utils.checkNullString(request.getParameter("contents"));
		String view_type = Utils.checkNullString(request.getParameter("view_type"));
		
		map.put("idx", idx);
		map.put("contents", contents);
		map.put("view_type", view_type);
		
		try
		{
			mu_dao.saveContents(map);
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
			return map;
		}
		return map;
	}
	@RequestMapping("/getContents")
	@ResponseBody
	public HashMap<String, Object> getContents(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		map.put("idx", idx);
		
		HashMap<String, Object> data = mu_dao.getContents(map);
		return data;
	}
	@RequestMapping("/getNextCate")
	@ResponseBody
	public List<HashMap<String, Object>> getNextCate(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		map.put("idx", idx);
		
		List<HashMap<String, Object>> list = mu_dao.getNextCate(map);
		return list;
	}
	@RequestMapping("/getSearchCate")
	@ResponseBody
	public List<HashMap<String, Object>> getSearchCate(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String search_val = Utils.checkNullString(request.getParameter("search_val"));
		
		map.put("search_val", search_val);
		
		List<HashMap<String, Object>> list = mu_dao.getSearchCate(map);
		return list;
	}
	@RequestMapping("/saveCate")
	@ResponseBody
	public HashMap<String, Object> saveCate(HttpServletRequest request) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		String dep = Utils.checkNullString(request.getParameter("dep"));
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String par = Utils.checkNullString(request.getParameter("par"));
		String cate_nm = Utils.checkNullString(request.getParameter("cate_nm"));
		String is_show = Utils.checkNullString(request.getParameter("is_show"));
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		if("".equals(is_show)) 
		{
			is_show = "Y";
		}
			
		
		map.put("dep", dep);
		map.put("idx", idx);
		map.put("par", par);
		map.put("cate_nm", cate_nm);
		map.put("is_show", is_show);
		map.put("sort", sort);
		
		try
		{
			int cnt = mu_dao.isInCate(map);
			if(cnt > 0)
			{
				mu_dao.upCate(map);
			}
			else
			{
				mu_dao.insCate(map);
			}
			map.put("isSuc", "success");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
			return map;
		}
		
		return map;
	}
	
}
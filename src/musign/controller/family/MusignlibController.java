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
import musign.model.family.MusignlibDAO;
import musign.model.family.TempDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/musign_lib/*")
public class MusignlibController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private MainDAO main_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private MusignlibDAO musign_lib_dao;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/musign_lib/list");	
	
		return mav;
	}
	
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/musign_lib/detail");	
	
		String idx = Utils.checkNullString(request.getParameter("idx"));
		HashMap<String, Object> getPostContentInfo = musign_lib_dao.getPostContentInfo(idx);
		
		mav.addObject("post_content", getPostContentInfo.get("post_content"));
		return mav;
	}

	@RequestMapping("/getMusignlibList")
	@ResponseBody
	public HashMap<String, Object> getMusignlibList(HttpServletRequest request) {
		
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_title = Utils.checkNullString(request.getParameter("search_title"));
		String search_content = Utils.checkNullString(request.getParameter("search_content"));
		
		List<HashMap<String, Object>> listCnt = musign_lib_dao.getMusignlibListCount(search_title,search_content);
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
		
		List<HashMap<String, Object>> list = musign_lib_dao.getMusignlibList(s_point, listSize, order_by, sort_type,search_title,search_content); 
		
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

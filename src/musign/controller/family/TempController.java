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
import musign.model.family.TempDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/temp/*")
public class TempController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private DosignDAO dosign_dao;
	
	@Autowired
	private TempDAO temp_dao;
	
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
		mav.setViewName("/WEB-INF/pages/family/temp/list");	
		return mav;
	}
	
	@RequestMapping("/getTempList")
	@ResponseBody
	public HashMap<String, Object> getTemplist(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_con = Utils.checkNullString(request.getParameter("search_con"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String cust_fg = Utils.checkNullString(request.getParameter("cust_fg"));
		String encd_list = Utils.checkNullString(request.getParameter("encd_list"));
		
		
		
		List<HashMap<String, Object>> listCnt = temp_dao.getTempListCount(myidx,isManager);
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
		
		List<HashMap<String, Object>> list = temp_dao.getTempList(myidx,s_point, listSize*page, order_by, sort_type,isManager); 
		
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

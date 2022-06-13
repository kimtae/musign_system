package musign.controller.family;

import java.io.File;
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
import musign.model.family.RoomDAO;

@Controller
@RequestMapping("/family/room/*")
public class RoomController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@Autowired
	private RoomDAO room_dao;
	

//	@RequestMapping("/list")
//	public ModelAndView list(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/WEB-INF/pages/family/room/list");
//		
//		HttpSession session = request.getSession();
//		if (session.getAttribute("login_idx")==null) {
//			return mav;
//		}
//		String user_idx = Utils.checkNullString(session.getAttribute("login_idx"));
//		mav.addObject("user_idx", user_idx);
//		
//		List<HashMap<String, Object>> list = room_dao.getRoomList();
//		mav.addObject("list", list);
//		return mav;
//	}
	@RequestMapping("/insRoom")
	public ModelAndView insRoom(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/room/insRoom");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return mav;
		}
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		if(!"".equals(idx)) 
		{
			HashMap<String, Object> data = room_dao.getRoomOne(idx);
			mav.addObject("data", data);
			mav.addObject("idx", idx);
		}
		
		String user_idx = Utils.checkNullString(session.getAttribute("login_idx"));
		mav.addObject("user_idx", user_idx);
		
		List<HashMap<String, Object>> list1 = room_dao.getRoomList("대");
		List<HashMap<String, Object>> list2 = room_dao.getRoomList("중");
		List<HashMap<String, Object>> list3 = room_dao.getRoomList("소");
		mav.addObject("list1", list1);
		mav.addObject("list2", list2);
		mav.addObject("list3", list3);
		
		return mav;
	}
	@RequestMapping("/insRoom_proc")
	@ResponseBody
	public HashMap<String, Object> insRoom_proc(HttpServletRequest request) {
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
			String room_nm = Utils.checkNullString(request.getParameter("room_nm"));
			String member = Utils.checkNullString(request.getParameter("member"));
			String start_date = Utils.checkNullString(request.getParameter("start_date")).replace("-", "").replace(":","").replace(" ", "");
			String end_date = Utils.checkNullString(request.getParameter("end_date")).replace("-", "").replace(":","").replace(" ", "");
			String usage = Utils.checkNullString(request.getParameter("usage"));
			
			map.put("room_nm", room_nm);
			map.put("member", member);
			map.put("start_date", start_date);
			map.put("end_date", end_date);
			map.put("usage", usage);

			String idx = Utils.checkNullString(request.getParameter("idx"));
			
			int cnt = 0;
			if(room_dao.getRoom(room_nm, start_date, end_date, idx) != null)
			{
				map.put("isSuc", "fail");
				map.put("msg", "중복되는 시간에 예약이 되어있습니다.");
				return map;
			}
			else
			{
				
				if("".equals(idx))
				{
					cnt = room_dao.insRoom(map);
				}
				else
				{
					map.put("idx", idx);
					cnt = room_dao.upRoom(map);
				}
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
	@RequestMapping("/delRoom")
	@ResponseBody
	public HashMap<String, Object> delRoom(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();    
		String user_idx = Utils.checkNullString(session.getAttribute("login_idx"));
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		try
		{
			String idx = Utils.checkNullString(request.getParameter("idx"));
			
			map.put("idx", idx);
			int cnt = 0;
			cnt = room_dao.delRoom(idx);
			
			if(cnt == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "삭제 실패");
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
	
	
}

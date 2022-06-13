package musign.controller.family;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.SalesDAO;
import musign.model.family.TeamDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/team/*")
public class TeamController {

	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Value("${image_dir}")
	private String image_dir;
	
	// 게시판 dao
	@Autowired
	private SalesDAO seles_dao;
	
	// user dao
	@Autowired
	private UserDAO user_dao;

	@Autowired
	private TeamDAO team_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/team/list");
		
		return mav;
	}
	

	@RequestMapping("/getTeamList")
	@ResponseBody
	public HashMap<String, Object> getTeamList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString();
		String teamidx = session.getAttribute("login_team").toString();
		String chmodidx = session.getAttribute("login_chmod").toString();
		String levelidx = session.getAttribute("login_level").toString();
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_chmod = Utils.checkNullString(request.getParameter("search_chmod"));
		String search_level = Utils.checkNullString(request.getParameter("search_level"));
		String search_use_yn = Utils.checkNullString(request.getParameter("search_use_yn"));
		String search_year = Utils.checkNullString(request.getParameter("search_year"));
		String search_period = Utils.checkNullString(request.getParameter("search_period"));
		
		if (Integer.parseInt(teamidx) < 3 ) //team idx가 HQ, 경영지원이라면
		{
			teamidx=""; //모든 직원 검색을 위한 세팅
		}
		
		List<HashMap<String, Object>> list = team_dao.getTeamList(myidx,teamidx,chmodidx,search_name,search_chmod,search_level,search_use_yn,search_year,search_period); 
		List<HashMap<String, Object>> teamlist = team_dao.getTeam(teamidx); 
		List<HashMap<String, Object>> chmodlist = team_dao.getChmod(chmodidx,teamidx); 
		List<HashMap<String, Object>> levellist = team_dao.getLevel(levelidx,teamidx); 
		
		System.out.println(list);
		
		map.put("list",list);
		map.put("teamlist",teamlist);
		map.put("chmodlist",chmodlist);
		map.put("levellist",levellist);
		
		return map;
	}
	
	@RequestMapping("/getOut")
	@ResponseBody
	public HashMap<String, Object> getOut(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return map;
		}
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String leave_date = Utils.checkNullString(request.getParameter("leave_date"));
		int result = team_dao.getOut(idx,leave_date); 
		if (result > 0) 
		{
			map.put("isSuc", "success");
			map.put("msg", "처리 되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알수 없는 Error발생 관리자에게 문의하세요.");
		}
		return map;
	}
	
	@RequestMapping("/updateMemberInfo")
	@ResponseBody
	public HashMap<String, Object> updateMemberInfo(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return map;
		}

		String[] member_idx = Utils.checkNullString(request.getParameter("member_idx_list")).split("\\|");
		String[] member_team_idx = Utils.checkNullString(request.getParameter("member_team_list")).split("\\|");
		String[] member_chmod_idx = Utils.checkNullString(request.getParameter("member_chmod_list")).split("\\|");
		String[] member_level_idx = Utils.checkNullString(request.getParameter("member_level_list")).split("\\|");
		String[] member_sign_date= Utils.checkNullString(request.getParameter("member_sign_list")).split("\\|");
		String[] member_auth = Utils.checkNullString(request.getParameter("member_auth_list")).split("\\|");
		String[] member_card_no = Utils.checkNullString(request.getParameter("member_card_list")).split("\\|");
			
		try {
			
			for (int i = 0; i < member_idx.length; i++) {
				team_dao.updateMemberInfo(member_idx[i],member_team_idx[i],member_chmod_idx[i],member_level_idx[i],member_sign_date[i],member_auth[i],member_card_no[i]); 
			}
		
			map.put("isSuc", "success");
			map.put("msg", "처리 되었습니다.");
		
		} catch (Exception e) {
			// TODO: handle exception
			map.put("isSuc", "fail");
			map.put("msg", "알수 없는 Error발생 관리자에게 문의하세요.");

		}

		return map;
	}
	
	
	
}
package musign.controller.family;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;
import musign.model.family.OperDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/oper/*")
public class OperController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	// oper DAO
	@Autowired
	private OperDAO oper_dao;
	
	// user DAO
	@Autowired
	private UserDAO user_dao;
	
	// 카드 목록 페이지
	@RequestMapping("/card")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/oper/card");
		
		List<HashMap<String, Object>> teamList = user_dao.getTeamList();
		
		mav.addObject("teamList", teamList);
	
		return mav;
	}
	
	// 카드 목록 조회
	@RequestMapping("/getCard")
	@ResponseBody
	public HashMap<String, Object> getCardList(HttpServletRequest request){
		
		String search_cont = request.getParameter("search_cont");
		
		List<HashMap<String, Object>> list = oper_dao.getCardList(search_cont);
		List<HashMap<String, Object>> teamList = user_dao.getTeamList();
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list); 
		map.put("teamList", teamList);
		
		return map;
	}
	
	// 카드 단일 조회 페이지
	@RequestMapping("/detail_card")
	@ResponseBody
	public HashMap<String, Object> detail_card(HttpServletRequest request) {
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		HashMap<String, Object> data = oper_dao.getCardOne(idx);
		HashMap<String, Object> map = new HashMap<>();
		map.put("data", data); 
	
		return map;
	}
	
	// 카드 등록 기능
	@RequestMapping("/card_write_proc")
	public ModelAndView card_write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/oper/card_write_proc");
		
		String bank = Utils.checkNullString(request.getParameter("insBank"));
		String account_num1= Utils.checkNullString(request.getParameter("insNum1"));
		String account_num2= Utils.checkNullString(request.getParameter("insNum2"));
		String account_num3= Utils.checkNullString(request.getParameter("insNum3"));
		String account_num4= Utils.checkNullString(request.getParameter("insNum4"));
		String account_num= account_num1+"-"+account_num2+"-"+account_num3+"-"+account_num4;
		String onwner = Utils.checkNullString(request.getParameter("insOwner"));
		String pre_pay_yn = Utils.checkNullString(request.getParameter("insPre_pay_yn"));
		
		oper_dao.insCard(bank, account_num, onwner,pre_pay_yn);
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");

		return mav;
	}
	
	// 카드 수정 기능
	@RequestMapping("/card_edit_proc")
	public ModelAndView edit_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/board/edit_proc");
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String method = ""; //Utils.checkNullString(request.getParameter("idx"));
		String bank = Utils.checkNullString(request.getParameter("insBank"));
		String account_num1= Utils.checkNullString(request.getParameter("insNum1"));
		String account_num2= Utils.checkNullString(request.getParameter("insNum2"));
		String account_num3= Utils.checkNullString(request.getParameter("insNum3"));
		String account_num4= Utils.checkNullString(request.getParameter("insNum4"));
		String account_num= account_num1+"-"+account_num2+"-"+account_num3+"-"+account_num4;
		String onwner = Utils.checkNullString(request.getParameter("insOwner"));
		String pre_pay_yn = Utils.checkNullString(request.getParameter("insPre_pay_yn"));
		
		oper_dao.upCard(method, bank, pre_pay_yn, account_num, onwner,idx);
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		
		return mav;
	}
	
	// 게시물 삭제 
	@RequestMapping("/delCard")
	@ResponseBody
	public HashMap<String, Object> delBoard(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		oper_dao.delCard(idx);
	
		map.put("isSuc", "success");
		map.put("msg", "삭제되었습니다.");
		
		return map;
	}
	
	
	
}

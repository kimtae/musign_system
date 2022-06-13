package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class MainDAO extends SqlSessionDaoSupport{

	private String NS = "/family/mainMapper";
	
	// 메인페이지  게시글 목록 조회
	public List<HashMap<String, Object>> main_getBoardList() {
		HashMap<String, Object> map = new HashMap<>();
	
		return getSqlSession().selectList(NS + ".main_getBoardList", map);
			
	}

	
	public List<HashMap<String, Object>> getUserLeave(String cal_year, String cal_mon, String google_chk, String leave_chk, String none_leave_chk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cal_year", cal_year);
		map.put("cal_mon", cal_mon);
		map.put("google_chk", google_chk);
		map.put("leave_chk", leave_chk);
		map.put("none_leave_chk", none_leave_chk);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUserLeave", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGoogleList(String cal_year, String cal_mon) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cal_year", cal_year);
		map.put("cal_mon", cal_mon);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGoogleList", map);
		return list;
	}
	

	// 게시물 삭제
	public void delGoogleCal() {
		HashMap<String, Object> map = new HashMap<>();
		getSqlSession().delete(NS + ".delGoogleCal", map);
	}
	
	// 게시물 등록
	public void insGoogleCal(String doc_text) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("doc_text", doc_text);				
		getSqlSession().insert(NS + ".insGoogleCal", map);	
	}
	
	public HashMap<String, Object> getSignCnt(String myidx, String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		return getSqlSession().selectOne(NS + ".getSignCnt", map);
	}
	
	
	public List<HashMap<String, Object>> getSignList(String myidx, String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSignList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getLeaderListForMail(String ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("ymd",  ymd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLeaderListForMail", map);
		return list;
	}
	
	public void insMailLog(String idx,String cont) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);	
		map.put("cont", cont);	
		getSqlSession().insert(NS + ".insMailLog", map);	
	}
	
	//프로젝트 영업 미접수 조회
	public HashMap<String, Object> getSaleCnt() {
		HashMap<String, Object> map = new HashMap<>();
		return getSqlSession().selectOne(NS + ".getSaleCnt", map);
	}
	
	public List<HashMap<String, Object>> getSaleList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSaleList", map);
		return list;
	}
	
}

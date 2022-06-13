package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class DosignDAO extends SqlSessionDaoSupport{

	private String NS = "/family/dosignMapper";
	
	// 메인페이지  게시글 목록 조회
	public List<HashMap<String, Object>> main_getBoardList() {
		HashMap<String, Object> map = new HashMap<>();
	
		return getSqlSession().selectList(NS + ".main_getBoardList", map);
			
	}
	
	// 메인페이지 게시물 클릭시 조회
	public HashMap<String, Object> main_getBoardOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".main_getBoardOne", map);
	}
	
	public List<HashMap<String, Object>> getDosignListCount(String myidx,String isManager,String search_name, String start_ymd,String end_ymd, 
															String doc_type_search,String content_search,String step_search,String imsi_yn, String use_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("doc_type_search", doc_type_search);
		map.put("content_search", content_search);
		map.put("step_search", step_search);
		map.put("imsi_yn", imsi_yn);
		map.put("use_yn", use_yn);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDosignListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getDosignList(String myidx,int s_rownum, int e_rownum, String order_by, String sort_type,String isManager,
														String search_name, String start_ymd,String end_ymd, String doc_type_search,String content_search,String step_search,String imsi_yn,String use_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("isManager", isManager);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("doc_type_search", doc_type_search);
		map.put("content_search", content_search);
		map.put("step_search", step_search);
		map.put("imsi_yn", imsi_yn);
		map.put("use_yn", use_yn);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDosignList", map);
		return list;
	}
	
	public HashMap<String, Object> getApprovalLine(String myidx,String idx,String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("idx", idx);
		map.put("isManager", isManager);
		return getSqlSession().selectOne(NS + ".getApprovalLine", map);
	}
	
	public HashMap<String, Object> getDocInfo(String doc_idx,String doc_type,String doc_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("doc_idx", doc_idx);
		map.put("doc_type", doc_type);
		map.put("doc_nm", doc_nm);
		return getSqlSession().selectOne(NS + ".getDocInfo", map);
	}
	
	public String getPayMethodNm(String pay_method) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pay_method", pay_method);
		return getSqlSession().selectOne(NS + ".getPayMethodNm", map);
	}
	
	public String getChmod(String useridx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("useridx", useridx);
		return getSqlSession().selectOne(NS + ".getChmod", map);
	}
	
	
	
	public int doApprove(String idx,String step, String waiter,String approval_chk, String approval_date, String approval_content) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("step", step);
		map.put("waiter", waiter);
		map.put("approval_chk", approval_chk);
		map.put("approval_date", approval_date);
		map.put("approval_content", approval_content);
		return getSqlSession().update(NS + ".doApprove", map);
	}
	
	public int doReturn(String idx,String content, String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("content", content);
		map.put("myidx", myidx);
		return getSqlSession().update(NS + ".doReturn", map);
	}
	
	public int doFinalPass(String idx,String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("myidx", myidx);
		return getSqlSession().update(NS + ".doFinalPass", map);
	}
	
	public HashMap<String, Object> chkManager(String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		return getSqlSession().selectOne(NS + ".chkManager", map);
	}
	
	public HashMap<String, Object> getPrevNextIdx(String idx,String myidx,String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		return getSqlSession().selectOne(NS + ".getPrevNextIdx", map);
	}
	
	public HashMap<String, Object> getWaterInfo(String waiter_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("waiter_idx", waiter_idx);
		return getSqlSession().selectOne(NS + ".getWaterInfo", map);
	}

}

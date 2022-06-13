package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class SalesDAO extends SqlSessionDaoSupport {

	private String NS = "/family/salesMapper";

	public List<HashMap<String, Object>> getSaleUserList() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSaleUserList");
		return list;
	}
	
	public List<HashMap<String, Object>> saleServiceList() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".saleServiceList");
		return list;
	}
	
	public HashMap<String, Object> getSaleInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getSaleInfo",map);
		return data;
	}
	
	public int insSale(String myidx,String service_type,String project_type,String project_budget,String start_ymd,String end_ymd,String select_way,String site_url,
			String project_cont,String filename_arr,String filename_ori_arr,String user_company,String user_manager, String user_type,
			String user_phone,String user_email,String user_biz_no,String known_path,String info_yn) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("service_type", service_type);
		map.put("project_type", project_type);
		map.put("project_budget", project_budget);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("select_way", select_way);
		map.put("site_url", site_url);
		
		map.put("project_cont", project_cont);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("user_company", user_company);
		map.put("user_manager", user_manager);
		map.put("user_type", user_type);
		map.put("user_phone", user_phone);
		map.put("user_email", user_email);
		map.put("user_biz_no", user_biz_no);
		map.put("known_path", known_path);
		map.put("info_yn", info_yn);

		getSqlSession().insert(NS + ".insSale", map);
		
		return Utils.checkNullInt(map.get("idx"));
	}
	
	
	
	public void uptSale(String myidx,String service_type,String project_type,String project_budget,String start_ymd,String end_ymd,String select_way,String site_url,
			String project_cont,String filename_arr,String filename_ori_arr,String user_company,String user_manager, String user_type,
			String user_phone,String user_email,String user_biz_no,String known_path,String info_yn,String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("service_type", service_type);
		map.put("project_type", project_type);
		map.put("project_budget", project_budget);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("select_way", select_way);
		map.put("site_url", site_url);
		map.put("project_cont", project_cont);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("user_company", user_company);
		map.put("user_manager", user_manager);
		map.put("user_type", user_type);
		map.put("user_phone", user_phone);
		map.put("user_email", user_email);
		map.put("user_biz_no", user_biz_no);
		map.put("known_path", known_path);
		map.put("info_yn", info_yn);
		map.put("idx", idx);
		getSqlSession().update(NS + ".uptSale", map);
	}
	
	public int insEstimate(int sale_idx,String comment, String important_yn) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_idx", sale_idx);
		map.put("comment", comment);
		map.put("important_yn", important_yn);
		return getSqlSession().insert(NS + ".insEstimate", map);
	}
	
	public void uptEstimate(String idx,String comment, String important_yn) {
		HashMap<String, Object> map = new HashMap<>();

		map.put("idx", idx);
		map.put("comment", comment);
		map.put("important_yn", important_yn);
		getSqlSession().update(NS + ".uptEstimate", map);
	}
	
	
	public void chooseManager(String idx,String manager_idx,String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("manager_idx", manager_idx);
		map.put("myidx", myidx);
		getSqlSession().update(NS + ".chooseManager", map);
	}
	
	
	public List<HashMap<String, Object>> getSaleListCount(String myidx,String isManager, String start_ymd,String end_ymd, 
			String step,String sale_manager,String sale_service,String search_cont, String upt_start_ymd, String upt_end_ymd,
			String important_yn, String choice, String known_path, String budget
			) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("step", step);
		map.put("sale_manager", sale_manager);
		map.put("sale_service", sale_service);
		map.put("search_cont", search_cont);
		map.put("upt_start_ymd", upt_start_ymd);
		map.put("upt_end_ymd", upt_end_ymd);
		map.put("important_yn", important_yn);
		map.put("choice", choice);
		map.put("known_path", known_path);
		map.put("budget", budget);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSaleListCount", map);
		return list;
		}
		
	public List<HashMap<String, Object>> getSaleList(String myidx,int s_rownum, int e_rownum, String order_by, String sort_type,String isManager,
			String start_ymd,String end_ymd, String step,String sale_manager,String sale_service, String search_cont, String upt_start_ymd, String upt_end_ymd,
			String important_yn, String choice, String known_path, String budget) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("isManager", isManager);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("step", step);
		map.put("sale_manager", sale_manager);
		map.put("sale_service", sale_service);
		map.put("search_cont", search_cont);
		map.put("upt_start_ymd", upt_start_ymd);
		map.put("upt_end_ymd", upt_end_ymd);
		map.put("important_yn", important_yn);
		map.put("choice", choice);
		map.put("known_path", known_path);
		map.put("budget", budget);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSaleList", map);
		return list;
	}
	
	public HashMap<String, Object> getManagerInfo(String manager_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("manager_idx", manager_idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getManagerInfo",map);
		return data;
	}
	
	public HashMap<String, Object> getTargetInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getTargetInfo",map);
		return data;
	}
	
	public HashMap<String, Object> getTeamLeaderMail(String manager_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("manager_idx", manager_idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getTeamLeaderMail",map);
		return data;
	}
	
	public int checkMiddleStep(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().update(NS + ".checkMiddleStep", map);
	}
	
	public int doContract(String idx,String chk_val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("chk_val", chk_val);
		return getSqlSession().update(NS + ".doContract", map);
	}
	
	public int chooseContractStep(String idx,String step_value) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("step_value", step_value);
		return getSqlSession().update(NS + ".chooseContractStep", map);
	}
	
	public int doDelete(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().delete(NS + ".doDelete", map);
	}
	
	public HashMap<String, Object> getSaleComment(String sale_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_idx", sale_idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getSaleComment",map);
		return data;
	}
	
}

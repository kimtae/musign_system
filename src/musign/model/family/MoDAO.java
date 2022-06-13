package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class MoDAO extends SqlSessionDaoSupport{

	private String NS = "/family/moMapper";
	public List<HashMap<String, Object>> getSystem() {
		
		return getSqlSession().selectList(NS + ".getSystem");
	}
	
	public List<HashMap<String, Object>> getMoPlanList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMoPlanList", map);
		return list;
	}
	
	public void addMoPlan() {
		HashMap<String, Object> map = new HashMap<>();
		getSqlSession().insert(NS + ".addMoPlan", map);
	}
	
	public void delMoPlan(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().delete(NS + ".delMoPlan", map);
	}
	
	public void uptMoPlan(String idx,String grade_nm,String mon_amount,String t_mon_amount,String per_amount,String year_amount) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("grade_nm", grade_nm);
		map.put("mon_amount", mon_amount);
		map.put("t_mon_amount", t_mon_amount);
		map.put("per_amount", per_amount);
		map.put("year_amount", year_amount);
		
		getSqlSession().update(NS + ".uptMoPlan", map);

	}
	
	public List<HashMap<String, Object>> getMoCateList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMoCateList", map);
		return list;
	}
	
	public void addMoCate() {
		HashMap<String, Object> map = new HashMap<>();
		getSqlSession().insert(NS + ".addMoCate", map);
	}
	
	public void delMoCate(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().delete(NS + ".delMoCate", map);
	}
	
	public List<HashMap<String, Object>> getGradeList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGradeList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getProjectList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getProjectList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getMrList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMrList", map);
		return list;
	}
	
	public void add_project(String project_type,String sale_idx,	String grade,	  String edit_cnt,		String manager_nm,  String manager_level, 
							String phone_no1,   String phone_no2,	String phone_no3, String email,   		String business_no, String contract_amt,
							String start_ymd, 	String end_ymd, 	String month_amt, String month_cal_day, String tax_date,    
							String user_id, 	String user_pw,     String ftp_id, 	  String ftp_pw, 		String db_id, 
							String db_pw) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("project_type", project_type);	map.put("sale_idx", sale_idx);			map.put("grade", grade);
		map.put("edit_cnt",edit_cnt );			map.put("manager_nm", manager_nm);		map.put("manager_level", manager_level);
		map.put("phone_no1", phone_no1);		map.put("phone_no2", phone_no2);		map.put("phone_no3",phone_no3);
		map.put("email", email);				map.put("business_no", business_no);	map.put("contract_amt", contract_amt);
		map.put("start_ymd", start_ymd);		map.put("end_ymd", end_ymd);			map.put("month_amt", month_amt);
		map.put("month_cal_day", month_cal_day);map.put("tax_date", tax_date);			
		map.put("user_id", user_id);			map.put("user_pw", user_pw);
		map.put("ftp_id", ftp_id);				map.put("ftp_pw", ftp_pw);				map.put("db_id", db_id);
		map.put("db_pw", db_pw);
		getSqlSession().insert(NS + ".add_project", map);
	}
	
	public void update_project(String idx,		   String project_type, String sale_idx,	String grade,	  		String edit_cnt,		
							   String manager_nm,  String manager_level, 
							   String phone_no1,   String phone_no2,	String phone_no3,   String email,   		String business_no, String contract_amt,
							   String start_ymd,   String end_ymd, 		String month_amt,   String month_cal_day,   String tax_date,    
							   String user_id, 	   String user_pw,      String ftp_id, 		String ftp_pw, 			String db_id, 
							   String db_pw) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("project_type", project_type);	map.put("sale_idx", sale_idx);			map.put("grade", grade);
		map.put("edit_cnt",edit_cnt );			map.put("manager_nm", manager_nm);		map.put("manager_level", manager_level);
		map.put("phone_no1", phone_no1);		map.put("phone_no2", phone_no2);		map.put("phone_no3",phone_no3);
		map.put("email", email);				map.put("business_no", business_no);	map.put("contract_amt", contract_amt);
		map.put("start_ymd", start_ymd);		map.put("end_ymd", end_ymd);			map.put("month_amt", month_amt);
		map.put("month_cal_day", month_cal_day);map.put("tax_date", tax_date);			
		map.put("user_id", user_id);			map.put("user_pw", user_pw);
		map.put("ftp_id", ftp_id);				map.put("ftp_pw", ftp_pw);				map.put("db_id", db_id);
		map.put("db_pw", db_pw);
		getSqlSession().insert(NS + ".update_project", map);
		}
}

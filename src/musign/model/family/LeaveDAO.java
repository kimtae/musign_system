package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class LeaveDAO extends SqlSessionDaoSupport {

	private String NS = "/family/leaveMapper";

	public List<HashMap<String, Object>> getLeaveList(String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLeaveList", map);
		return list;
	}
	
	public HashMap<String, Object> chkLeave(String target_year,String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("target_year", target_year);
		map.put("idx", idx);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".chkLeave", map);
		return list;
	}
	
	public int addLeave(String title,String target_year) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("title", title);
		map.put("target_year", target_year);
		getSqlSession().insert(NS + ".addLeave", map);
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public void uptLeave(String idx,String title,String target_year) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("title", title);
		map.put("target_year", target_year);
		getSqlSession().update(NS + ".uptLeave", map);
	}
	
	public int delLeave(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().delete(NS + ".delLeave", map);
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int delLeaveUser(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().delete(NS + ".delLeaveUser", map);
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public void addLeaveUser(int idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().insert(NS + ".addLeaveUser", map);
	}
	
	public List<HashMap<String, Object>> getLeaveUserList(String target_year,String search_name, String search_team, String search_chmod, String search_level, String search_use_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("target_year", target_year);
		map.put("search_name", search_name);
		map.put("search_team", search_team);
		map.put("search_chmod", search_chmod);
		map.put("search_level", search_level);
		map.put("search_use_yn", search_use_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLeaveUserList", map);
		return list;
	}
	
	public void saveUserLeave(String idx,String leave_cnt,String user_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("leave_cnt", leave_cnt);
		map.put("user_idx", user_idx);
		getSqlSession().update(NS + ".saveUserLeave", map);
	}
	
	public int addHoliday(String locdate,String dateName) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("locdate", locdate);
		map.put("dateName", dateName);
		return getSqlSession().update(NS + ".addHoliday", map);
	}
	
	
	public HashMap<String, Object> chkHoliday(String locdate) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("locdate", locdate);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".chkHoliday", map);
		return list;
	}
	
	public HashMap<String, Object> chkHoliday_one(String holiday_info, String target_day) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("holiday_info", holiday_info);
		map.put("target_day", target_day);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".chkHoliday_one", map);
		return list;
	}
	
	
	public HashMap<String, Object> getTargetYear(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".getTargetYear", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getLeaveUserDetailCount(String user_idx, String start_ymd,String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLeaveUserDetailCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getLeaveUserDetailList(int s_rownum, int e_rownum, String order_by, String sort_type,String user_idx, String start_ymd,String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("user_idx", user_idx);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLeaveUserDetailList", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getHolidayListCount(String search_name, String start_ymd,String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getHolidayListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getHolidayList(int s_rownum, int e_rownum, String order_by, String sort_type,String search_name, String start_ymd,String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getHolidayList", map);
		return list;
	}
	
	public int addHoliday_one(String holiday_info,String target_day) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("holiday_info", holiday_info);
		map.put("target_day", target_day);
		return getSqlSession().insert(NS + ".addHoliday_one", map);
	}
}

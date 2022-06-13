package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class GuntaeDAO extends SqlSessionDaoSupport{

	private String NS = "/family/guntaeMapper";
	
	
	public List<HashMap<String, Object>> getGuntaeListCount(String myidx,String isManager,String search_name, String start_ymd,String end_ymd,String day_status,String teamidx, String chmodidx,String leaderChk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("day_status", day_status);
		map.put("teamidx", teamidx);
		map.put("chmodidx", chmodidx);
		map.put("leaderChk", leaderChk);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGuntaeListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGuntaeList(String myidx,int s_rownum, int e_rownum, String order_by, String sort_type,String isManager,String search_name, String start_ymd,String end_ymd, String day_status,String teamidx, String chmodidx,String leaderChk) {
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
		map.put("day_status", day_status);
		map.put("teamidx", teamidx);
		map.put("chmodidx", chmodidx);
		map.put("leaderChk", leaderChk);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGuntaeList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGuntaeListCountByManager(String myidx,String isManager,String search_name, String start_ymd,String end_ymd,String day_status,String teamidx, String chmodidx,String leaderChk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("day_status", day_status);
		map.put("teamidx", teamidx);
		map.put("chmodidx", chmodidx);
		map.put("leaderChk", leaderChk);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGuntaeListCountByManager", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGuntaeListByManager(String myidx,int s_rownum, int e_rownum, String order_by, String sort_type,String isManager,String search_name, String start_ymd,String end_ymd, String day_status,String teamidx, String chmodidx,String leaderChk) {
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
		map.put("day_status", day_status);
		map.put("teamidx", teamidx);
		map.put("chmodidx", chmodidx);
		map.put("leaderChk", leaderChk);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGuntaeListByManager", map);
		return list;
	}
	
	public int uptGuntaeData(String user_idx, String submit_year, String min_time, String max_time, String late_time, String over_work_time, String over_night_work_time, String whole_work_time, String day_status) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("submit_year", submit_year);
		map.put("min_time", min_time);
		map.put("max_time", max_time);
		map.put("late_time", late_time);
		map.put("over_work_time", over_work_time);
		map.put("over_night_work_time", over_night_work_time);
		map.put("whole_work_time", whole_work_time);
		map.put("day_status", day_status);
		return getSqlSession().update(NS + ".uptGuntaeData", map);
	}

}

package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class TeamDAO extends SqlSessionDaoSupport {

	private String NS = "/family/teamMapper";
	
	public List<HashMap<String, Object>> getTeamList(String myidx,String teamidx, String chmodidx,String search_name,String search_chmod,String search_level,String search_use_yn,String search_year, String search_period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("teamidx", teamidx);
		map.put("chmodidx", chmodidx);
		map.put("search_name", search_name);
		map.put("search_chmod", search_chmod);
		map.put("search_level", search_level);
		map.put("search_use_yn", search_use_yn);
		map.put("search_year", search_year);
		map.put("search_period", search_period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTeamList", map);
		return list;
	}

	public int getOut(String idx, String leave_date) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("leave_date", leave_date);
		return getSqlSession().update(NS + ".getOut", map);
	}
	
	public List<HashMap<String, Object>> getTeam(String teamidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("teamidx", teamidx);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTeam", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getChmod(String chmodidx,String teamidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chmodidx", chmodidx);
		map.put("teamidx", teamidx);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getChmod", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getLevel(String levelidx,String teamidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("levelidx", levelidx);
		map.put("teamidx", teamidx);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLevel", map);
		return list;
	}

	public void updateMemberInfo(String member_idx,String member_team_idx,String member_chmod_idx,String member_level_idx,String member_sign_date,String member_auth,String card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_idx", member_idx);
		map.put("member_team_idx", member_team_idx);
		map.put("member_chmod_idx", member_chmod_idx);
		map.put("member_level_idx", member_level_idx);
		map.put("member_sign_date", member_sign_date);
		map.put("member_auth", member_auth);
		map.put("card_no", card_no);
		getSqlSession().update(NS + ".updateMemberInfo", map);
	}
	
}

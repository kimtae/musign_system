package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class KpiDAO extends SqlSessionDaoSupport{

	private String NS = "/family/kpiMapper";
	
	public int insKpi(HashMap<String, Object> map) {
		return getSqlSession().insert(NS + ".insKpi", map);
	}
	public int insOkr(HashMap<String, Object> map) {
		return getSqlSession().insert(NS + ".insOkr", map);
	}
	public int upKpi(HashMap<String, Object> map) {
		return getSqlSession().update(NS + ".upKpi", map);
	}
	public int upOkr(HashMap<String, Object> map) {
		return getSqlSession().update(NS + ".upOkr", map);
	}
	
	public int insOkr_leader(HashMap<String, Object> map) {
		return getSqlSession().insert(NS + ".insOkr_leader", map);
	}
	public int upOkr_leader(HashMap<String, Object> map) {
		return getSqlSession().update(NS + ".upOkr_leader", map);
	}
	public int upOkr_step(HashMap<String, Object> map) {
		return getSqlSession().update(NS + ".upOkr_step", map);
	}
	
	
	public HashMap<String, Object> getKpi(String user_idx, String year) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("year", year);
		return getSqlSession().selectOne(NS + ".getKpi", map);
	}
	public HashMap<String, Object> getOkr(String user_idx, String year, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("year", year);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".getOkr", map);
	}
	public HashMap<String, Object> getUser(String user_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		return getSqlSession().selectOne(NS + ".getUser", map);
	}
	
	public List<HashMap<String, Object>> getKpiListCount(String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getKpiListCount", map);
		return list;
		}
	
	public List<HashMap<String, Object>> getKpiList(int s_rownum, int e_rownum, String order_by, String sort_type, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("search_name", search_name);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getKpiList", map);
		return list;
		}
}

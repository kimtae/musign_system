package musign.model.mumul;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class MumulDAO extends SqlSessionDaoSupport{

	private String NS = "/mumul/mumulMapper";
	
	public List<HashMap<String, Object>> getCateList(String isShow) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("isShow", isShow);
		return getSqlSession().selectList(NS + ".getCateList", map);
	}
	public void delCate(HashMap<String, Object> map) {
		getSqlSession().delete(NS + ".delCate", map);
	}
	public void addPlease(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".addPlease", map);
	}
	public void saveContents(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".saveContents", map);
	}
	public HashMap<String, Object> getContents(HashMap<String, Object> map) {
		return getSqlSession().selectOne(NS + ".getContents", map);
	}
	public List<HashMap<String, Object>> getOneDep() {
		return getSqlSession().selectList(NS + ".getOneDep");
	}
	public List<HashMap<String, Object>> getNextCate(HashMap<String, Object> map) {
		return getSqlSession().selectList(NS + ".getNextCate", map);
	}
	public List<HashMap<String, Object>> getSearchCate(HashMap<String, Object> map) {
		return getSqlSession().selectList(NS + ".getSearchCate", map);
	}
	public int isInCate(HashMap<String, Object> map) {
		return getSqlSession().selectOne(NS + ".isInCate", map);
	}
	public void upCate(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".upCate", map);
	}
	public void insCate(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".insCate", map);
	}
	
}

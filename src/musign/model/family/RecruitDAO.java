package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class RecruitDAO extends SqlSessionDaoSupport{

	private String NS = "/family/recruitMapper";
	
	public List<HashMap<String, Object>> getRecruitCount() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecruitCount", map);
		return list;
		}
		
	public List<HashMap<String, Object>> getRecruitList(int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecruitList", map);
		return list;
	}
	
	public HashMap<String, Object> getRecinfo(String rec_idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("rec_idx", rec_idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getRecinfo",map);
		return data;
	}
	
	public List<HashMap<String, Object>> getRecruitArea() {
		HashMap<String, Object> map = new HashMap<>();
	
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecruitArea", map);
		return list;
	}
	
	public void uptRecArea(String idx,String chk_val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("chk_val", chk_val);
		getSqlSession().update(NS + ".uptRecArea", map);
	}
}

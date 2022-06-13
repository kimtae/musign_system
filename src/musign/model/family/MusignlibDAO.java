package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class MusignlibDAO extends SqlSessionDaoSupport{

	private String NS = "/family/musignlibMapper";
	
	
	public List<HashMap<String, Object>> getMusignlibListCount(String search_title, String search_content) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_title", search_title);
		map.put("search_content", search_content);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMusignlibListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getMusignlibList(int s_rownum, int e_rownum, String order_by, String sort_type,String search_title, String search_content) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_title", search_title);
		map.put("search_content", search_content);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMusignlibList", map);
		return list;
	}
	
	public HashMap<String, Object> getPostContentInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getPostContentInfo", map);
		return data;
	}
}

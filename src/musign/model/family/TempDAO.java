package musign.model.family;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

public class TempDAO extends SqlSessionDaoSupport{

	private String NS = "/family/tempMapper";
	
	public List<HashMap<String, Object>> getTempListCount(String myidx,String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("isManager", isManager);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTempListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTempList(String myidx,int s_rownum, int e_rownum, String order_by, String sort_type,String isManager) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("isManager", isManager);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTempList", map);
		return list;
	}

}

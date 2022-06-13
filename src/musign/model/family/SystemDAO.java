package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class SystemDAO extends SqlSessionDaoSupport{

	private String NS = "/family/systemMapper";
	public List<HashMap<String, Object>> getSystem() {
		
		return getSqlSession().selectList(NS + ".getSystem");
	}

}

package musign.model.mo;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class OfferDAO extends SqlSessionDaoSupport{

	private String NS = "/family/moMapper";
	public List<HashMap<String, Object>> getSystem() {
		
		return getSqlSession().selectList(NS + ".getSystem");
	}

}

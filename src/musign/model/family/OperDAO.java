package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class OperDAO extends SqlSessionDaoSupport {
	
	// mapper 객체 생성
	private String NS = "/family/operMapper";
	
	// 카드 목록 조회
	public List<HashMap<String, Object>> getCardList(String search_cont) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_cont", search_cont);
		return getSqlSession().selectList(NS + ".getCardList", map);
	}
	
	// 카드 단일 조회
	public HashMap<String, Object> getCardOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".getCardOne", map);
	}
	
	// 카드 등록
	public void insCard(String bank, String account_num, String owner, String pre_pay_yn) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("bank", bank);							// 은행명
		map.put("account_num", account_num);			// 카드번호
		map.put("owner", owner);						// 사용처
		map.put("pre_pay_yn", pre_pay_yn);				// 선지급 여부
		
		getSqlSession().insert(NS + ".insCard", map);	
	}
	
	// 카드 등록시 팀원 목록
	public List<HashMap<String, Object>> getTeamList() {
		
		return getSqlSession().selectList(NS + ".getTeamList");
	}
	
	// 카드 수정
	public void upCard(String method, String bank, String pre_pay_yn, String account_num, String owner, String idx) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("method", method);						
		map.put("bank", bank);							// 은행명
		map.put("pre_pay_yn", pre_pay_yn);				// 선지급 여부
		map.put("account_num", account_num);			// 카드번호
		map.put("owner", owner);						// 사용처
		map.put("idx", idx);							// index
		
		getSqlSession().update(NS + ".upCard", map);
	}
	
	// 게시물 삭제
	public void delCard(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("idx", idx);
		getSqlSession().delete(NS + ".delCard", map);
	}
	
	
	
}

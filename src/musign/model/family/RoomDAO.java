package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class RoomDAO extends SqlSessionDaoSupport{

	private String NS = "/family/roomMapper";

	public HashMap<String, Object> getRoom(String room_nm, String start_date, String end_date, String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("room_nm", room_nm);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".getRoom", map);
	}
	public HashMap<String, Object> getRoomOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".getRoomOne", map);
	}
	public List<HashMap<String, Object>> getRoomList(String room_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("room_nm", room_nm);
		return getSqlSession().selectList(NS + ".getRoomList", map);
	}
	public int insRoom(HashMap<String, Object> map) {
		return getSqlSession().insert(NS + ".insRoom", map);
	}
	public int upRoom(HashMap<String, Object> map) {
		return getSqlSession().update(NS + ".upRoom", map);
	}
	public int delRoom(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().delete(NS + ".delRoom", map);
	}
	
	
}

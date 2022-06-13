package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class UserDAO extends SqlSessionDaoSupport{

	private String NS = "/family/userMapper";
	public List<HashMap<String, Object>> getUser() {
		
		return getSqlSession().selectList(NS + ".getUser");
	}
	
	public HashMap<String, Object> admin_login(String login_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_id", login_id);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".admin_login", map);
		return data;
	}
	
	public HashMap<String, Object> loginCheck(String login_id, String login_pw) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_id", login_id);
		map.put("login_pw", login_pw);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".loginCheck", map);
		return data;
	}
	
	public HashMap<String, Object> getUserInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUserInfo", map);
		return data;
	}
	
	public List<HashMap<String, Object>> getTeamList() {
		
		return getSqlSession().selectList(NS + ".getTeamList");
	}
	
	public List<HashMap<String, Object>> getLevelList() {
		
		return getSqlSession().selectList(NS + ".getLevelList");
	}
	
	public HashMap<String, Object> idCheck(String join_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("join_id", join_id);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".idCheck", map);
		return data;
	}
	
	public HashMap<String, Object> mailCheck(String mail) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("mail", mail);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".mailCheck", map);
		return data;
	}
	
	public List<HashMap<String, Object>> getleaveInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectList(NS + ".getleaveInfo", map);
	}
	
	public HashMap<String, Object> phoneCheck(String phone_no1, String phone_no2, String phone_no3) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("phone_no1", phone_no1);
		map.put("phone_no2", phone_no2);
		map.put("phone_no3", phone_no3);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".phoneCheck", map);
		return data;
	}
	
	
	
	public int insUser(String join_id, String join_pw, String join_email,String join_phone1, String join_phone2, 
						String join_phone3, String join_name,String join_sign_date, String join_team, String join_level,String sale_auth) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("join_id", join_id);
		map.put("join_pw", join_pw);
		map.put("join_email", join_email);
		map.put("join_phone1", join_phone1);
		map.put("join_phone2", join_phone2);
		map.put("join_phone3", join_phone3);
		map.put("join_name", join_name);
		map.put("join_sign_date", join_sign_date);
		map.put("join_team", join_team);
		map.put("join_level", join_level);
		map.put("sale_auth", sale_auth);
		
		return getSqlSession().insert(NS + ".insUser", map);
	}
	
	public HashMap<String, Object> getLeaderList() {
		
		return getSqlSession().selectOne(NS + ".getLeaderList");
	}
	
	public String getChmod_kor(String chmod) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chmod", chmod);
		return getSqlSession().selectOne(NS + ".getChmod_kor",map);
	}
	
	
	public HashMap<String, Object> getMyInfo(String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getMyInfo", map);
		return data;
	}
	
	public List<HashMap<String, Object>> getMyTeam(String myteam,String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myteam", myteam);
		map.put("myidx", myidx);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMyTeam", map);
		return list;
	}
	
	public int uptMyInfo(String myidx,String name,String pw,String email,String phone1,String phone2,String phone3,String level,String team,
						String sign_date,String line_value1,String line_value2,String line_value3, String mycolor) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("name", name);
		map.put("pw", pw);
		map.put("email", email);
		map.put("phone1", phone1);
		map.put("phone2", phone2);
		map.put("phone3", phone3);
		map.put("level", level);
		map.put("team", team);
		map.put("sign_date", sign_date);
		map.put("line_value1", line_value1);
		map.put("line_value2", line_value2);
		map.put("line_value3", line_value3);
		map.put("mycolor", mycolor);
		
		return getSqlSession().update(NS + ".uptMyInfo", map);
	}
	
	// 그룹 구성원 팀 조회
	public List<HashMap<String, Object>> getGroupTeamList() {
		HashMap<String, Object> map = new HashMap<>();
		return getSqlSession().selectList(NS + ".getGroupTeamList", map);
	}	
	
	// 그룹 구성원 팀원 조회
	public List<HashMap<String, Object>> getGroupPeopleList() {
		HashMap<String, Object> map = new HashMap<>();
		return getSqlSession().selectList(NS + ".getGroupPeopleList", map);
	}	
	
	
	public int uptLastLogin(String id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		return getSqlSession().update(NS + ".uptLastLogin", map);
	}
	
	
	public HashMap<String, Object> userInfo(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".userInfo", map);
		return data;
	}
	
	public HashMap<String, Object> getNewUserInfo(String login_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_id", login_id);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getNewUserInfo", map);
		return data;
	}
	
	public int insNewUserToLeave(String new_user_idx) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("new_user_idx", new_user_idx);
		return getSqlSession().insert(NS + ".insNewUserToLeave", map);
	}

	public void insTeamChart(String chart_file, String chart_file_ori) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("chart_file", chart_file);
		map.put("chart_file_ori", chart_file_ori);
		
		getSqlSession().insert(NS + ".insTeamChart", map);
	}

	public HashMap<String, Object> selectNew() {
		HashMap<String, Object> map = new HashMap<>();
		
		return  getSqlSession().selectOne(NS + ".selectNew", map);
	}
}

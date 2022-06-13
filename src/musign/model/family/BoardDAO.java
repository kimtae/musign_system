package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class BoardDAO extends SqlSessionDaoSupport {

	private String NS = "/family/boardMapper";

	// 게시글 목록 조회
	public List<HashMap<String, Object>> getBoardList(String search_type,String searchName) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("searchName", searchName);
		return getSqlSession().selectList(NS + ".getBoardList", map);
	}

	// 게시글 단일 조회
	public HashMap<String, Object> getBoardOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".getBoardOne", map);
	}

	// 이전 게시글 단일 조회
	public HashMap<String, Object> prev_getBoardOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".prev_getBoardOne", map);
	}
	
	// 다음 게시글 단일 조회
	public HashMap<String, Object> next_getBoardOne(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".next_getBoardOne", map);
	}
	
	// 게시물 등록
	public void insBoard(String title, String cont, String user_idx, String board_type, String board_file, String board_file_ori) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("user_idx", user_idx);				// 유저 index
		map.put("title", title);					// 제목
		map.put("cont", cont);						// 내용
		map.put("board_type", board_type);			// 구분
		map.put("board_file", board_file);			// 구분
		map.put("board_file_ori", board_file_ori);	// 구분
		
		getSqlSession().insert(NS + ".board_write", map);	
	}
	
	// 게시물 수정
	public void upBoard(String title, String cont, String idx, String board_type, String board_file, String board_file_ori) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("title", title);					// 제목
		map.put("cont", cont);						// 내용
		map.put("idx", idx);						// index
		map.put("board_type", board_type);			// 공지, 일반 수정
		map.put("board_file", board_file);			// 파일업로드 수정
		map.put("board_file_ori", board_file_ori);	// 파일업로드 수정
		
		getSqlSession().update(NS + ".board_edit", map);
	}
	
	// 게시물 삭제
	public void delBoard(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("idx", idx);
		getSqlSession().delete(NS + ".board_del", map);
	}
	
	public List<HashMap<String, Object>> getfilelist() {
		HashMap<String, Object> map = new HashMap<>();

		return getSqlSession().selectList(NS + ".getfilelist", map);
	}
}

package musign.model.family;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import musign.classes.Utils;

public class AllowDAO extends SqlSessionDaoSupport{

	private String NS = "/family/allowMapper";
	
	
	public List<HashMap<String, Object>> getCardList() {
		
		return getSqlSession().selectList(NS + ".getCardList");
	}
	
	public int insJicul(String myidx,String attach_idx,String title,String content,String purpose,String company,String pay_date,String pay_method,String use_method,
			String detail_cont_list,String detail_pay_list,String filename_arr,String filename_ori_arr,String total_amt,String doc_type) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("title", title);
		map.put("content", content);
		map.put("purpose", purpose);
		map.put("company", company);
		map.put("pay_date", pay_date);
		map.put("pay_method", pay_method);
		map.put("use_method", use_method);
		map.put("detail_cont_list", detail_cont_list);
		map.put("detail_pay_list", detail_pay_list);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("total_amt", total_amt);
		map.put("doc_type", doc_type);
		getSqlSession().insert(NS + ".insJicul", map);
	
		return Utils.checkNullInt(map.get("idx"));		
	}
	
	public int uptJicul(String myidx,String attach_idx,String title,String content,String purpose,String company,String pay_date,String pay_method,String use_method,
			String detail_cont_list,String detail_pay_list,String filename_arr,String filename_ori_arr,String total_amt,String doc_type,String idx) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("title", title);
		map.put("content", content);
		map.put("purpose", purpose);
		map.put("company", company);
		map.put("pay_date", pay_date);
		map.put("pay_method", pay_method);
		map.put("use_method", use_method);
		map.put("detail_cont_list", detail_cont_list);
		map.put("detail_pay_list", detail_pay_list);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("total_amt", total_amt);
		map.put("doc_type", doc_type);
		map.put("idx", idx);
		getSqlSession().update(NS + ".uptJicul", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int insJumal(String myidx,String attach_idx,String jumal_work_day,String jumal_hour,String jumal_cont,String doc_type) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("jumal_work_day", jumal_work_day);
		map.put("jumal_hour", jumal_hour);
		map.put("jumal_cont", jumal_cont);
		map.put("doc_type", doc_type);
		getSqlSession().insert(NS + ".insJumal", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int uptJumal(String attach_idx,String jumal_work_day,String jumal_hour,String jumal_cont,String idx) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("attach_idx", attach_idx);
		map.put("jumal_work_day", jumal_work_day);
		map.put("jumal_hour", jumal_hour);
		map.put("jumal_cont", jumal_cont);
		map.put("idx", idx);
		getSqlSession().update(NS + ".uptJumal", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	
	public int insGuntae(String myidx,String attach_idx,String guntae_leave_type,String shifter,String guntae_start_ymd,String guntae_end_ymd,
						String total_hour,String guntae_cont,String filename_arr,String filename_ori_arr,String doc_type,double sum_leave_cnt) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("guntae_leave_type", guntae_leave_type);
		map.put("shifter", shifter);
		map.put("guntae_start_ymd", guntae_start_ymd);
		map.put("guntae_end_ymd", guntae_end_ymd);
		map.put("total_hour", total_hour);
		map.put("guntae_cont", guntae_cont);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("doc_type", doc_type);
		map.put("sum_leave_cnt", sum_leave_cnt);
		getSqlSession().insert(NS + ".insGuntae", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int uptGuntae(String myidx,String attach_idx,String guntae_leave_type,String shifter,String guntae_start_ymd,String guntae_end_ymd,
			String total_hour,String guntae_cont,String filename_arr,String filename_ori_arr,String doc_type,String idx,double sum_leave_cnt) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("guntae_leave_type", guntae_leave_type);
		map.put("shifter", shifter);
		map.put("guntae_start_ymd", guntae_start_ymd);
		map.put("guntae_end_ymd", guntae_end_ymd);
		map.put("total_hour", total_hour);
		map.put("guntae_cont", guntae_cont);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("doc_type", doc_type);
		map.put("idx", idx);
		map.put("sum_leave_cnt", sum_leave_cnt);
		
		getSqlSession().update(NS + ".uptGuntae", map);
		
		return Utils.checkNullInt(map.get("idx"));
		}
	
	public int insYeonjang(String myidx,String attach_idx,String yeonjang_work_day,String yeonjang_hour,String yeonjang_cont,String doc_type) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("yeonjang_work_day", yeonjang_work_day);
		map.put("yeonjang_hour", yeonjang_hour);
		map.put("yeonjang_cont", yeonjang_cont);
		map.put("doc_type", doc_type);
		getSqlSession().insert(NS + ".insYeonjang", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int uptYeonjang(String attach_idx,String yeonjang_work_day,String yeonjang_hour,String yeonjang_cont,String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("attach_idx", attach_idx);
		map.put("yeonjang_work_day", yeonjang_work_day);
		map.put("yeonjang_hour", yeonjang_hour);
		map.put("yeonjang_cont", yeonjang_cont);
		map.put("idx", idx);
		getSqlSession().update(NS + ".uptYeonjang", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int insRoundRobin(String myidx,String attach_idx,String rr_title,String rr_purpose,String rr_company,
							String start_ymd,String end_ymd,String rr_cont, String detail_cont_list, String detail_pay_list,
							String filename_arr,String filename_ori_arr,String total_amt,String doc_type) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("rr_title", rr_title);
		map.put("rr_purpose", rr_purpose);
		map.put("rr_company", rr_company);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("rr_cont", rr_cont);
		map.put("detail_cont_list", detail_cont_list);
		map.put("detail_pay_list", detail_pay_list);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("total_amt", total_amt);
		map.put("doc_type", doc_type);
		getSqlSession().insert(NS + ".insRoundRobin", map);
		
		return Utils.checkNullInt(map.get("idx"));
		}
	
	public int uptRoundRobin(String attach_idx,String rr_title,String rr_purpose,String rr_company,
							String start_ymd,String end_ymd,String rr_cont, String detail_cont_list, String detail_pay_list,
							String filename_arr,String filename_ori_arr,String total_amt,String idx) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("attach_idx", attach_idx);
		map.put("rr_title", rr_title);
		map.put("rr_purpose", rr_purpose);
		map.put("rr_company", rr_company);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("rr_cont", rr_cont);
		map.put("detail_cont_list", detail_cont_list);
		map.put("detail_pay_list", detail_pay_list);
		map.put("filename_arr", filename_arr);
		map.put("filename_ori_arr", filename_ori_arr);
		map.put("total_amt", total_amt);
		map.put("idx", idx);
		getSqlSession().update(NS + ".uptRoundRobin", map);
		return Utils.checkNullInt(map.get("idx"));
		}
	
	
	public int insPrize(String myidx,String attach_idx,String prize_target,String prize_cont,String prize_value,String doc_type, String prize_target_year) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("attach_idx", attach_idx);
		map.put("prize_target", prize_target);
		map.put("prize_cont", prize_cont);
		map.put("prize_value", prize_value);
		map.put("doc_type", doc_type);
		map.put("prize_target_year", prize_target_year);
		getSqlSession().insert(NS + ".insPrize", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public int uptPrize(String attach_idx,String prize_target,String prize_cont,String prize_value,String idx, String prize_target_year) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("attach_idx", attach_idx);
		map.put("prize_target", prize_target);
		map.put("prize_cont", prize_cont);
		map.put("prize_value", prize_value);
		map.put("idx", idx);
		map.put("prize_target_year", prize_target_year);
		getSqlSession().update(NS + ".uptPrize", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	
	public void insLine(String myidx,int jicul_idx,String ref_line,String waiter,String approval_line,String chk_line,String date_chk,String doc_type,String content,String imsi_yn) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		map.put("doc_idx", jicul_idx);
		map.put("ref_line", ref_line);
		map.put("waiter", waiter);
		map.put("approval_line", approval_line);
		map.put("chk_line", chk_line);
		map.put("date_chk", date_chk);
		map.put("doc_type", doc_type);
		map.put("content", content);
		map.put("imsi_yn", imsi_yn);
		
		
		getSqlSession().insert(NS + ".insLine", map);

	}
	
	
	public void uptLine(String ref_line,String waiter,String approval_line,String chk_line,String date_chk,String content,String imsi_yn,String idx) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("ref_line", ref_line);
		map.put("waiter", waiter);
		map.put("approval_line", approval_line);
		map.put("chk_line", chk_line);
		map.put("date_chk", date_chk);
		map.put("content", content);
		map.put("imsi_yn", imsi_yn);
		map.put("idx", idx);
		
		getSqlSession().update(NS + ".uptLine", map);

	}
	
	public List<HashMap<String, Object>> getAttachList(String myidx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("myidx", myidx);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttachList", map);
		return list;
	}
	
	public HashMap<String, Object> getNewsFileName(String doc_type,String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("doc_type", doc_type);
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".getNewsFileName", map);
	}
	
	public List<HashMap<String, Object>> chkMyLeave(String user_idx,String start_ymd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("end_y", end_ymd.split("-")[0]);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".chkMyLeave", map);
		return list;
	}
	
	public HashMap<String, Object> getMyLeave(String user_idx,String targetYmd,int early_temp) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("targetYmd", targetYmd);
		map.put("early_temp", early_temp);
		return getSqlSession().selectOne(NS + ".getMyLeave", map);
	}
	
	public HashMap<String, Object> getLeaveCnt(String guntae_start_ymd, String guntae_end_ymd, String targetYmd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("guntae_start_ymd", guntae_start_ymd);
		map.put("guntae_end_ymd", guntae_end_ymd);
		map.put("targetYmd", targetYmd);
		return getSqlSession().selectOne(NS + ".getLeaveCnt", map);
	}
	
	public int delLine(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		getSqlSession().update(NS + ".delLine", map);
	
		return Utils.checkNullInt(map.get("idx"));
	}
	
	public HashMap<String, Object> chk_imsi(String idx) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		return getSqlSession().selectOne(NS + ".chk_imsi", map);
	}
	
}

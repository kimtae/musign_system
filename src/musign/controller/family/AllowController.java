package musign.controller.family;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sun.mail.iap.Response;

import musign.classes.Utils;
import musign.model.family.AllowDAO;
import musign.model.family.BoardDAO;
import musign.model.family.DosignDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/allow/*")
public class AllowController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Value("${image_dir}")
	private String image_dir;
	
	@Autowired
	private BoardDAO board_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private AllowDAO allow_dao;
	
	@Autowired
	private DosignDAO dosign_dao;

	@RequestMapping("/write")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/write");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return mav;
		}
		
		
		String myidx = session.getAttribute("login_idx").toString();
		
		HashMap<String, Object> getMyInfo = user_dao.getMyInfo(myidx);
		HashMap<String, Object> leaderList = user_dao.getLeaderList();
		mav.addObject("getMyInfo", getMyInfo);
		mav.addObject("leaderList", leaderList);
		return mav;
	}
	
	@RequestMapping("/edit")
	public ModelAndView edit(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/write");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login_idx")==null) {
			return mav;
		}
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="";
		if (doc_type.equals("100")){ doc_nm = "detail_guntae"; }
		else if(doc_type.equals("101")){ doc_nm = "detail_jicul"; }
		else if(doc_type.equals("102")){ doc_nm = "detail_jumal"; }
		else if(doc_type.equals("103")){ doc_nm = "detail_yeonjang"; }
		else if(doc_type.equals("104")){ doc_nm = "detail_roundrobin"; }
		else if(doc_type.equals("105")){ doc_nm = "detail_prize"; }
		
		String myidx = session.getAttribute("login_idx").toString();
		
		HashMap<String, Object> getMyInfo = user_dao.getMyInfo(myidx);
		HashMap<String, Object> leaderList = user_dao.getLeaderList();
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		
		mav.addObject("doc_nm", doc_nm);
		mav.addObject("getMyInfo", getMyInfo);
		mav.addObject("leaderList", leaderList);
		return mav;
	}
	
	@RequestMapping("/detail_guntae")
	public ModelAndView detail_guntae(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_guntae");

		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_guntae";

		String targetYmd="";
		
		int early_temp=0; //조퇴의 경우 사용할 임시 변수
		
		double leave_cnt =0.0;
		double sum_leave_cnt =0.0;
		double user_leave = 0;
		double over_leave = 0;
		double prize_leave = 0;
		double use_leave = 0;
		double use_cancel_leave = 0;
		/*
		double late_leave = 0;				double late_cnt = 0;
		*/
		double early_leave = 0;				double early_cnt = 0;
		double early_cancel_leave = 0;		double early_cancel_cnt = 0;
		double half_leave = 0.0;			double half_cnt = 0.0;
		double half_cancel_leave = 0.0;		double half_cancel_cnt= 0.0;
		
		double result =0.0;
		
		List<HashMap<String, Object>> getMyTeamList = user_dao.getMyTeam(myteam,myidx);
		mav.addObject("getMyTeamList", getMyTeamList);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy"); 
		Date now = new Date(); 
		targetYmd = format.format(now); 
		
		sum_leave_cnt += leave_cnt;
		
		HashMap<String, Object> myleave = allow_dao.getMyLeave(myidx,targetYmd,early_temp);
		 user_leave 		= Double.parseDouble(myleave.get("user_leave").toString());								//부여연차
		 over_leave 		= Double.parseDouble(myleave.get("over_leave").toString());								//야근연차
		 prize_leave 		= Double.parseDouble(myleave.get("prize_leave").toString());							//포상연차
		 use_leave 			= Double.parseDouble(myleave.get("use_leave").toString());								//사용연차
		 use_cancel_leave 	= Double.parseDouble(myleave.get("use_cancel_leave").toString());						//사용취소연차
		 
		 //late_cnt 		= Double.parseDouble(myleave.get("late_leave").toString());									//지각횟수
		 /*미개발  조퇴와 같이 쿼리에서 처리할 것*/
		 //late_leave = (late_cnt >= 0) ? late_cnt % 3 : 0;															//지각연차 
		 
		 early_cnt 		= Double.parseDouble(myleave.get("early_leave").toString());								//조퇴회수
		 early_cancel_cnt = Double.parseDouble(myleave.get("early_cancel_leave").toString());						//조퇴취소횟수
		 early_leave = ( (early_cnt + (early_cancel_cnt * -1)) >= 0 ) ? (early_cnt + (early_cancel_cnt * -1)) : 0;	//조퇴연차
		 
		 half_cnt 		= Double.parseDouble(myleave.get("half_leave").toString());									//반차횟수
		 half_cancel_cnt 	= Double.parseDouble(myleave.get("half_cancel_leave").toString());						//반차취소횟수
		 half_leave  = ( half_cnt + (half_cancel_cnt*-1) >= 0 ) ? half_cnt + (half_cancel_cnt*-1) : 0;				//반차사용연차
		
		 
		 //(부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차 + 지각연차 + 조퇴연차 + 반차사용연차)
		 //result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + late_leave + early_leave + half_leave);
		 result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave  + early_leave + half_leave);
		
		mav.addObject("left_guntae", result);
		
		
		
		
		//권한 체크
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
	
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		return mav;
	}
	
	@RequestMapping("/detail_jicul")
	public ModelAndView detail_jicul(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_jicul");
		
		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_jicul";

		List<HashMap<String, Object>> cardList = allow_dao.getCardList();
		mav.addObject("cardList", cardList);
		
		//권한 체크용
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
		
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		mav.addObject("image_dir", image_dir);

		return mav;
	}
	
	@RequestMapping("/detail_jumal")
	public ModelAndView detail_jumal(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_jumal");

		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_jumal";
		
		
		List<HashMap<String, Object>> getMyTeamList = user_dao.getMyTeam(myteam,myidx);
		mav.addObject("getMyTeamList", getMyTeamList);
		
		//권한 체크
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
	
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		
		return mav;
	}
	@RequestMapping("/detail_prize")
	public ModelAndView detail_prize(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_prize");
		
		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_prize";
		
		List<HashMap<String, Object>> getMyTeamList = user_dao.getMyTeam(myteam,myidx);
		mav.addObject("getMyTeamList", getMyTeamList);
		
		List<HashMap<String, Object>> getUserList = user_dao.getUser();
		mav.addObject("getUserList", getUserList);
		
		
		//권한 체크용
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
		
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		return mav;
	}
	@RequestMapping("/detail_roundrobin")
	public ModelAndView detail_roundrobin(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_roundrobin");
		
		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_roundrobin";
		
		//권한 체크용
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
		
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		mav.addObject("image_dir", image_dir);
		
		return mav;
	}
	@RequestMapping("/detail_yeonjang")
	public ModelAndView detail_yeonjang(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/allow/detail_yeonjang");

		HttpSession session = request.getSession();
		String myteam = session.getAttribute("login_team").toString();
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String doc_idx = Utils.checkNullString(request.getParameter("doc_idx"));
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String doc_nm ="doc_yeonjang";
		
		//권한 체크용
		HashMap<String, Object> data = dosign_dao.getApprovalLine(myidx,idx,isManager);
		if (data==null) {
			mav.addObject("authChk", "-1");
			return mav;
		}
		
		//결제라인 값 세팅
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		//doc_info에 담긴 각 테이블 정보를 ModelAndView에 넣어줌
		HashMap<String, Object> doc_info = dosign_dao.getDocInfo(doc_idx,doc_type,doc_nm);
		for (String key : doc_info.keySet()) {
			if (!key.toString().equals("idx")) {
				System.out.println(key+":"+doc_info.get(key));				
				mav.addObject(key, doc_info.get(key));
			}		
		}
		
		mav.addObject("idx", idx);
		mav.addObject("doc_idx", doc_idx);
		mav.addObject("doc_type", doc_type);
		mav.addObject("image_dir", image_dir);	
		
		return mav;
	}
	
	@RequestMapping("/write_jicul")
	@ResponseBody
	public HashMap<String, Object> write_jicul(HttpServletRequest request) throws IOException, ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		int sizeLimit = 5000*1024*1024; //10메가 까지 가능
		
        String uploadPath = upload_dir+"jicul_receipt/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
        
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        
		String myidx = session.getAttribute("login_idx").toString();
		
		//수정용 idx
		String idx =Utils.checkNullString(multi.getParameter("idx"));
		String doc_idx =Utils.checkNullString(multi.getParameter("doc_idx"));
		
		String approval_line = Utils.checkNullString(multi.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(multi.getParameter("ref_line_store"));
		String jicul_use_method = Utils.checkNullString(multi.getParameter("jicul_use_method"));
		String attach_idx = Utils.checkNullString(multi.getParameter("attach_store"));
		String jicul_pay_method = Utils.checkNullString(multi.getParameter("jicul_pay_method"));
		String jicul_pay_date = Utils.checkNullString(multi.getParameter("jicul_pay_date"));
		String jicul_title = Utils.checkNullString(multi.getParameter("jicul_title"));
		String jicul_purpose = Utils.checkNullString(multi.getParameter("jicul_purpose"));
		String jicul_company = Utils.checkNullString(multi.getParameter("jicul_company"));
		String jicul_cont = Utils.repWord(Utils.checkNullString(multi.getParameter("jicul_cont")));
		String detail_cont_list = Utils.checkNullString(multi.getParameter("detail_cont_list"));
		String detail_pay_list = Utils.checkNullString(multi.getParameter("detail_pay_list"));
		String total_amt = Utils.checkNullString(multi.getParameter("total_amt"));
		String imsi_yn = Utils.checkNullString(multi.getParameter("imsi_yn"));
		
		String[] fileNm_list = Utils.checkNullString(multi.getParameter("fileNm_list")).split("\\|");
		
		for (int i = 0; i < fileNm_list.length; i++) {
			System.out.println("fileNm_list : "+fileNm_list[i]);
		}
		
		String doc_type="101";
		String filename="";
		String filename_ori="";
		String filename_arr="";
		String filename_ori_arr="";
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		
		
		int seq =1;
		Enumeration<String> names = multi.getFileNames();
		
		ArrayList<String> file_temp = new ArrayList<String>();
		ArrayList<String> file_ori_temp = new ArrayList<String>();
		
		while(names.hasMoreElements())
		{
			String retName = names.nextElement().toString();
			System.out.println(multi.getOriginalFileName(retName));
			//filename = Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq);
			//filename_ori = Utils.checkNullString(multi.getFilesystemName(retName));
			
			file_temp.add(Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq));
			file_ori_temp.add(Utils.checkNullString(multi.getFilesystemName(retName)));
			seq++;
		}
		
		Collections.reverse(file_temp);
		Collections.reverse(file_ori_temp);

		for (int i = 0; i < file_temp.size(); i++) {
			System.out.println();
			System.out.println("filename_ori : "+file_ori_temp.get(i));
			filename_arr +=  file_temp.get(i)+"|";
			filename_ori_arr +=  file_ori_temp.get(i)+"|";
		}
		
		
		
		int jicul_idx=0;
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);		

		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			HashMap<String, Object> data = allow_dao.getNewsFileName("doc_jicul",doc_idx);
			
			//
			String[] dbfilename=data.get("detail_receipt").toString().split("\\|");
			String[] dbfilename_ori=data.get("detail_receipt_ori").toString().split("\\|");
			
			filename="";
			filename_ori="";
			
			String[] uploadname =filename_arr.split("\\|");
			String[] uploadname_ori =filename_ori_arr.split("\\|");
			
			int upload_cnt=0;
			for (int i = 0; i < fileNm_list.length; i++) {
				//같은 이름의 파일을 올렸거나 or 새로운 파일이면
				boolean db = Arrays.asList(dbfilename_ori).contains(fileNm_list[i]);
				if (!db)
				{
					System.out.println("new");
					filename +=uploadname[upload_cnt]+"|";
					filename_ori +=uploadname_ori[upload_cnt]+"|";
					upload_cnt++;
				}
				else if(db)
				{
					for (int j = 0; j < dbfilename_ori.length; j++) {
						if (fileNm_list[i].equals(dbfilename_ori[j])) {							
							filename +=dbfilename[j]+"|";
							filename_ori +=dbfilename_ori[j]+"|";
						}
					}
				}
			}
			jicul_idx = allow_dao.uptJicul(myidx,attach_idx,jicul_title,jicul_cont,jicul_purpose,jicul_company,jicul_pay_date,jicul_pay_method,jicul_use_method,
					detail_cont_list,detail_pay_list,filename,filename_ori,total_amt,doc_type,doc_idx);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
				
			//allow_dao.uptLine(myidx,jicul_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		else
		{
			jicul_idx = allow_dao.insJicul(myidx,attach_idx,jicul_title,jicul_cont,jicul_purpose,jicul_company,jicul_pay_date,jicul_pay_method,jicul_use_method,
					detail_cont_list,detail_pay_list,filename_arr,filename_ori_arr,total_amt,doc_type);
			
			allow_dao.insLine(myidx,jicul_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		return map;
	}

	@RequestMapping("/write_jumal")
	@ResponseBody
	public HashMap<String, Object> write_jumal(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString();
		
		//수정용 idx
		String idx =Utils.checkNullString(request.getParameter("idx"));
		String doc_idx =Utils.checkNullString(request.getParameter("doc_idx"));
		
		String attach_idx = Utils.checkNullString(request.getParameter("attach_store"));

		String approval_line = Utils.checkNullString(request.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(request.getParameter("ref_line_store"));
		String jumal_work_day = Utils.checkNullString(request.getParameter("jumal_work_day"));
		String jumal_hour1 = Utils.checkNullString(request.getParameter("jumal_hour1"));
		String jumal_hour2 = Utils.checkNullString(request.getParameter("jumal_hour2"));
		String jumal_hour3 = Utils.checkNullString(request.getParameter("jumal_hour3"));
		String jumal_hour4 = Utils.checkNullString(request.getParameter("jumal_hour4"));
		
		String jumal_hour = jumal_hour1+""+jumal_hour2+""+jumal_hour3+""+jumal_hour4;
		
		String jumal_cont = Utils.repWord(Utils.checkNullString(request.getParameter("jumal_cont")));
		String imsi_yn = Utils.checkNullString(request.getParameter("imsi_yn"));
		String doc_type="102";
		
		int jumal_idx = 0;
		
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);		
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		
		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			jumal_idx = allow_dao.uptJumal(attach_idx,jumal_work_day,jumal_hour,jumal_cont,doc_idx);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
		}
		else
		{
			jumal_idx = allow_dao.insJumal(myidx,attach_idx,jumal_work_day,jumal_hour,jumal_cont,doc_type);
			allow_dao.insLine(myidx,jumal_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);			
		}
		
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		return map;
	}

	@RequestMapping("/write_guntae")
	@ResponseBody
	public HashMap<String, Object> write_guntae(HttpServletRequest request) throws IOException, ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		int sizeLimit = 5000*1024*1024; //10메가 까지 가능
		
        String uploadPath = upload_dir+"guntae_receipt/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
        
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        
		String myidx = session.getAttribute("login_idx").toString();

		//수정용 idx
		String idx =Utils.checkNullString(multi.getParameter("idx"));
		String doc_idx =Utils.checkNullString(multi.getParameter("doc_idx"));
		String attach_idx = Utils.checkNullString(multi.getParameter("attach_store"));
		String approval_line = Utils.checkNullString(multi.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(multi.getParameter("ref_line_store"));
		String guntae_leave_type = Utils.checkNullString(multi.getParameter("guntae_leave_type"));
		String shifter = Utils.checkNullString(multi.getParameter("shifter"));
		String guntae_start_ymd = Utils.checkNullString(multi.getParameter("guntae_start_ymd"));
		String guntae_start_hour1 = Utils.checkNullString(multi.getParameter("guntae_start_hour1"));
		String guntae_start_hour2 = Utils.checkNullString(multi.getParameter("guntae_start_hour2"));
		String guntae_end_ymd = Utils.checkNullString(multi.getParameter("guntae_end_ymd"));
		String guntae_end_hour1 = Utils.checkNullString(multi.getParameter("guntae_end_hour1"));
		String guntae_end_hour2 = Utils.checkNullString(multi.getParameter("guntae_end_hour2"));
		String total_hour = guntae_start_hour1+""+guntae_start_hour2+""+guntae_end_hour1+""+guntae_end_hour2;
		String guntae_cont = Utils.repWord(Utils.checkNullString(multi.getParameter("guntae_cont")));
		String imsi_yn = Utils.checkNullString(multi.getParameter("imsi_yn"));
		String[] fileNm_list = Utils.checkNullString(multi.getParameter("fileNm_list")).split("\\|");
		String doc_type="100";
		String filename="";
		String filename_ori="";
		String filename_arr="";
		String filename_ori_arr="";
		String leave_idx="";
		String targetYmd="";
		
		int early_temp=0; //조퇴의 경우 사용할 임시 변수
		
		double leave_cnt =0.0;
		double sum_leave_cnt =0.0;
		double user_leave = 0;
		double over_leave = 0;
		double prize_leave = 0;
		double use_leave = 0;
		double use_cancel_leave = 0;
		/*
		double late_leave = 0;				double late_cnt = 0;
		*/
		double early_leave = 0;				double early_cnt = 0;
		double early_cancel_leave = 0;		double early_cancel_cnt = 0;
		double half_leave = 0.0;			double half_cnt = 0.0;
		double half_cancel_leave = 0.0;		double half_cancel_cnt= 0.0;
		
		double result =0.0;
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		
		List<HashMap<String, Object>> leave_chk = allow_dao.chkMyLeave(myidx,guntae_start_ymd,guntae_end_ymd);
		if (leave_chk.size() > 0) 
		{
			for (int i = 0; i < leave_chk.size(); i++) {
				if (Double.parseDouble(leave_chk.get(i).get("cnt").toString()) > 0.0) 
				{
					targetYmd = leave_chk.get(i).get("date_ymd").toString();
					
					HashMap<String, Object> getLeaveCnt = allow_dao.getLeaveCnt(guntae_start_ymd,guntae_end_ymd,targetYmd);
					leave_cnt = Double.parseDouble(getLeaveCnt.get("cnt").toString());
					if (guntae_leave_type.equals("오전반차") || guntae_leave_type.equals("오후반차")) 
					{
						leave_cnt=0.5;
					}
					else if(guntae_leave_type.equals("반차취소"))
					{
						leave_cnt=-0.5;
					}
					else if(guntae_leave_type.equals("연차취소"))
					{
						leave_cnt=leave_cnt*-1;
					}
					else if(!guntae_leave_type.equals("연차"))
					{
						leave_cnt=0.0;
					}
					
					if (guntae_leave_type.equals("조퇴")) 
					{
						early_temp = 1;
					}
					sum_leave_cnt += leave_cnt;
					
					HashMap<String, Object> myleave = allow_dao.getMyLeave(myidx,targetYmd,early_temp);
					 user_leave 		= Double.parseDouble(myleave.get("user_leave").toString());								//부여연차
					 over_leave 		= Double.parseDouble(myleave.get("over_leave").toString());								//야근연차
					 prize_leave 		= Double.parseDouble(myleave.get("prize_leave").toString());							//포상연차
					 use_leave 			= Double.parseDouble(myleave.get("use_leave").toString());								//사용연차
					 use_cancel_leave 	= Double.parseDouble(myleave.get("use_cancel_leave").toString());						//사용취소연차
					 
					 
					 //late_cnt 		= Double.parseDouble(myleave.get("late_leave").toString());									//지각횟수
					 
					 /*미개발  조퇴와 같이 쿼리에서 처리할 것*/
					 //late_leave = (late_cnt >= 0) ? late_cnt % 3 : 0;															//지각연차 
					 
					 early_cnt 		= Double.parseDouble(myleave.get("early_leave").toString());								//조퇴회수
					 early_cancel_cnt = Double.parseDouble(myleave.get("early_cancel_leave").toString());						//조퇴취소횟수
					 early_leave = ( (early_cnt + (early_cancel_cnt * -1)) >= 0 ) ? (early_cnt + (early_cancel_cnt * -1)) : 0;	//조퇴연차
					 
					 half_cnt 		= Double.parseDouble(myleave.get("half_leave").toString());									//반차횟수
					 half_cancel_cnt 	= Double.parseDouble(myleave.get("half_cancel_leave").toString());						//반차취소횟수
					 half_leave  = ( half_cnt + (half_cancel_cnt*-1) >= 0 ) ? half_cnt + (half_cancel_cnt*-1) : 0;				//반차사용연차
					
					 
					 //(부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차 + 지각연차 + 조퇴연차 + 반차사용연차)
					 //result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + late_leave + early_leave + half_leave);
					 result =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave  + early_leave + half_leave);
					 System.out.println("target_year(신청연도): "+targetYmd);
					 System.out.println("신청기간 : "+guntae_start_ymd + " ~ "+guntae_end_ymd);
					 System.out.println("leave_cnt(신청연차) : "+leave_cnt);
					 System.out.println("sum_leave_cnt(신청연차 연도별 합계) : "+sum_leave_cnt);
					 System.out.println("user_leave(부여연차) : "+user_leave);
					 System.out.println("over_leave(야근연차) : "+over_leave);
					 System.out.println("prize_leave(포상연차) : "+prize_leave);
					 System.out.println("use_leave(사용연차) : "+use_leave);
					 System.out.println("use_cancel_leave(사용취소연차) : "+use_cancel_leave);
					 //System.out.println("late_leave(부여연차) : "+late_leave);
					 System.out.println("early_leave(조퇴연차) : "+early_leave);
					 System.out.println("half_leave(반차사용연차) : "+half_leave);
					 System.out.println("result(연차현황) : "+result); 
					 
					if (guntae_leave_type.equals("연차") || guntae_leave_type.equals("오전반차") || guntae_leave_type.equals("오후반차") || guntae_leave_type.equals("조퇴")) 
					{
						if (  result <= 0.0 )
						{
							map.put("isSuc", "return");
							map.put("msg", targetYmd+"년도에 남은 연차가 없습니다.");
							return map;
						}
						
						if ( (result + (leave_cnt*-1) ) < 0.0) 
						{
							//신청 연차 확인용
							//result =  ((user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + late_leave + early_leave + half_leave))-leave_cnt ;
							result =  ((user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + early_leave + half_leave))-leave_cnt ;
							System.out.println("result(신청현황) : "+result); 
							
							map.put("isSuc", "return");
							map.put("msg", targetYmd+"년도에 신청 가능한 연차가 모자랍니다.");
							return map;
						}
					}
				}
				else
				{
					map.put("isSuc", "return");
					map.put("msg", "연차가 부여되지 않은 연도가 있습니다. 다시 확인해 주세요.");
					return map;
				}
			}
		}
		else
		{
			map.put("isSuc", "return");
			map.put("msg", "알수 없는 Error 발생 관리자에게 문의주세요.");
			return map;
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/// 상단부의 연차 사용 검증이 끝났다면 하단의 입력부 실행 start
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		int seq =0 ;
		Enumeration<String> names = multi.getFileNames();
		
		ArrayList<String> file_temp = new ArrayList<String>();
		ArrayList<String> file_ori_temp = new ArrayList<String>();
		
		while(names.hasMoreElements())
		{
			String retName = names.nextElement().toString();
			System.out.println(multi.getOriginalFileName(retName));
			//filename = Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq);
			//filename_ori = Utils.checkNullString(multi.getFilesystemName(retName));
			
			file_temp.add(Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq));
			file_ori_temp.add(Utils.checkNullString(multi.getFilesystemName(retName)));
			seq++;
		}
		
		Collections.reverse(file_temp);
		Collections.reverse(file_ori_temp);

		for (int i = 0; i < file_temp.size(); i++) {
			System.out.println();
			System.out.println("filename_ori : "+file_ori_temp.get(i));
			filename_arr +=  file_temp.get(i)+"|";
			filename_ori_arr +=  file_ori_temp.get(i)+"|";
		}
		
		
		int guntae_idx = 0;
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);		
		
		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			HashMap<String, Object> data = allow_dao.getNewsFileName("doc_guntae",doc_idx);
			
			//DB에 저장된 파일이름
			String[] dbfilename=data.get("detail_receipt").toString().split("\\|");
			String[] dbfilename_ori=data.get("detail_receipt_ori").toString().split("\\|");
		
			filename="";
			filename_ori="";
			
			//업로드한 파일이름
			String[] uploadname =filename_arr.split("\\|");
			String[] uploadname_ori =filename_ori_arr.split("\\|");
			
			int upload_cnt=0;
			
			for (int i = 0; i < fileNm_list.length; i++) 
			{
				boolean db = Arrays.asList(dbfilename_ori).contains(fileNm_list[i]);
				//같은 이름의 파일을 올렸거나 or 새로운 파일이면
				if (!db)
				{
					System.out.println("new");
					filename +=uploadname[upload_cnt]+"|";
					filename_ori +=uploadname_ori[upload_cnt]+"|";
					upload_cnt++;
				}
				//아니라면 DB에 있던 값으로 세팅
				else if(db)
				{
					for (int j = 0; j < dbfilename_ori.length; j++) 
					{
						if (fileNm_list[i].equals(dbfilename_ori[j])) 
						{							
							filename +=dbfilename[j]+"|";
							filename_ori +=dbfilename_ori[j]+"|";
						}
					}
				}
			}
			
			if (filename.equals("|")) 
			{
				filename="";
				filename_ori="";
			}

			guntae_idx = allow_dao.uptGuntae(myidx,attach_idx,guntae_leave_type,shifter,guntae_start_ymd,guntae_end_ymd,
									total_hour,guntae_cont,filename,filename_ori,doc_type,doc_idx,sum_leave_cnt);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
			
		}
		else 
		{
			guntae_idx = allow_dao.insGuntae(myidx,attach_idx,guntae_leave_type,shifter,guntae_start_ymd,guntae_end_ymd,
									total_hour,guntae_cont,filename_arr,filename_ori_arr,doc_type,sum_leave_cnt);
			allow_dao.insLine(myidx,guntae_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		return map;
		
	}
	
	
	@RequestMapping("/write_yeonjang")
	@ResponseBody
	public HashMap<String, Object> write_yeonjang(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		
		String myidx = session.getAttribute("login_idx").toString();
		
		//수정용 idx
		String idx =Utils.checkNullString(request.getParameter("idx"));
		String doc_idx =Utils.checkNullString(request.getParameter("doc_idx"));
		
		String attach_idx = Utils.checkNullString(request.getParameter("attach_store"));

		String approval_line = Utils.checkNullString(request.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(request.getParameter("ref_line_store"));
		String yeonjang_work_day = Utils.checkNullString(request.getParameter("yeonjang_work_day"));
		String yeonjang_work_hour1 = Utils.checkNullString(request.getParameter("yeonjang_work_hour1"));
		String yeonjang_work_hour2 = Utils.checkNullString(request.getParameter("yeonjang_work_hour2"));
		String yeonjang_work_hour3 = Utils.checkNullString(request.getParameter("yeonjang_work_hour3"));
		String yeonjang_work_hour4 = Utils.checkNullString(request.getParameter("yeonjang_work_hour4"));
		
		String yeonjang_hour = yeonjang_work_hour1+""+yeonjang_work_hour2+""+yeonjang_work_hour3+""+yeonjang_work_hour4;
		
		String yeonjang_cont = Utils.repWord(Utils.checkNullString(request.getParameter("yeonjang_cont")));
		String imsi_yn = Utils.checkNullString(request.getParameter("imsi_yn"));
		String doc_type="103";
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		
		/*
		HashMap<String, Object> chk_date = allow_dao.chk_imsi(idx);
		System.out.println("imsi_yn : "+imsi_yn);
		System.out.println("chk_date.get(\"step\") : "+chk_date.get("step"));
		if (imsi_yn.equals("E") && (!chk_date.get("step").toString().equals("제출") || !chk_date.get("step").toString().equals("임시")))
		{
			map.put("msg", "결재가 통과된 서류입니다.");	
			map.put("isSuc", "success");
			return map;
		}
		*/
		
		int yeonjang_idx = 0;
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);		
		
		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			yeonjang_idx = allow_dao.uptYeonjang(attach_idx,yeonjang_work_day,yeonjang_hour,yeonjang_cont,doc_idx);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
		}
		else
		{
			yeonjang_idx = allow_dao.insYeonjang(myidx,attach_idx,yeonjang_work_day,yeonjang_hour,yeonjang_cont,doc_type);
			allow_dao.insLine(myidx,yeonjang_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		return map;
	}
	
	@RequestMapping("/write_roundrobin")
	@ResponseBody
	public HashMap<String, Object> write_roundrobin(HttpServletRequest request) throws IOException, ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		int sizeLimit = 5000*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"rr_receipt/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
        
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        
		String myidx = session.getAttribute("login_idx").toString();
		
		//수정용 idx
		String idx =Utils.checkNullString(multi.getParameter("idx"));
		String doc_idx =Utils.checkNullString(multi.getParameter("doc_idx"));
		
		String attach_idx = Utils.checkNullString(multi.getParameter("attach_store"));
		String approval_line = Utils.checkNullString(multi.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(multi.getParameter("ref_line_store"));
		String rr_title = Utils.checkNullString(multi.getParameter("rr_title"));
		String rr_purpose = Utils.checkNullString(multi.getParameter("rr_purpose"));
		String rr_company = Utils.checkNullString(multi.getParameter("rr_company"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd"));
		String rr_cont = Utils.repWord(Utils.checkNullString(multi.getParameter("rr_cont")));	
		String detail_cont_list = Utils.checkNullString(multi.getParameter("detail_cont_list"));
		String detail_pay_list = Utils.checkNullString(multi.getParameter("detail_pay_list"));
		String total_amt = Utils.checkNullString(multi.getParameter("total_amt"));
		String imsi_yn = Utils.checkNullString(multi.getParameter("imsi_yn"));
		
		String[] fileNm_list = Utils.checkNullString(multi.getParameter("fileNm_list")).split("\\|");
		
		String doc_type="104";
		
		String filename="";
		String filename_ori="";
		String filename_arr="";
		String filename_ori_arr="";
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		try {
			
		
		int seq =1;
		Enumeration<String> names = multi.getFileNames();
		
		ArrayList<String> file_temp = new ArrayList<String>();
		ArrayList<String> file_ori_temp = new ArrayList<String>();
		
		while(names.hasMoreElements())
		{
			String retName = names.nextElement().toString();
			System.out.println(multi.getOriginalFileName(retName));
			//filename = Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq);
			//filename_ori = Utils.checkNullString(multi.getFilesystemName(retName));
			
			file_temp.add(Utils.convertFileName(multi.getFilesystemName(retName), uploadPath, seq));
			file_ori_temp.add(multi.getFilesystemName(retName));
			seq++;
		}
		
		Collections.reverse(file_temp);
		Collections.reverse(file_ori_temp);
		
		for (int i = 0; i < file_temp.size(); i++) {
			System.out.println();
			System.out.println("filename_arr : "+file_temp.get(i));
			System.out.println("filename_ori : "+file_ori_temp.get(i));
			filename_arr +=  file_temp.get(i)+"|";
			filename_ori_arr +=  file_ori_temp.get(i)+"|";
		}
		
		int rr_idx = 0;
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);		
		
		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			HashMap<String, Object> data = allow_dao.getNewsFileName("doc_roundrobin",doc_idx);
			
			//
			String[] dbfilename=data.get("detail_receipt").toString().split("\\|");
			String[] dbfilename_ori=data.get("detail_receipt_ori").toString().split("\\|");
			
			filename="";
			filename_ori="";
			
			String[] uploadname =filename_arr.split("\\|");
			String[] uploadname_ori =filename_ori_arr.split("\\|");
			
			int upload_cnt=0;
			for (int i = 0; i < fileNm_list.length; i++) {
				//같은 이름의 파일을 올렸거나 or 새로운 파일이면
				boolean db = Arrays.asList(dbfilename_ori).contains(fileNm_list[i]);
				if (!db)
				{
					System.out.println("new");
					filename +=uploadname[upload_cnt]+"|";
					filename_ori +=uploadname_ori[upload_cnt]+"|";
					upload_cnt++;
				}
				else if(db)
				{
					for (int j = 0; j < dbfilename_ori.length; j++) {
						if (fileNm_list[i].equals(dbfilename_ori[j])) {							
							filename +=dbfilename[j]+"|";
							filename_ori +=dbfilename_ori[j]+"|";
						}
					}
				}
			}
			
			rr_idx = allow_dao.uptRoundRobin(attach_idx,rr_title,rr_purpose,rr_company,start_ymd,end_ymd,rr_cont,
					detail_cont_list,detail_pay_list,filename,filename_ori,total_amt,doc_idx);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
			
		}
		else
		{
			rr_idx = allow_dao.insRoundRobin(myidx,attach_idx,rr_title,rr_purpose,rr_company,start_ymd,end_ymd,rr_cont,
					detail_cont_list,detail_pay_list,filename_arr,filename_ori_arr,total_amt,doc_type);

			allow_dao.insLine(myidx,rr_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		} catch (Exception e) {
			map.put("msg", "알 수 없는 오류가 발생했습니다. 관리자에게 문의주세요.");
		}
		return map;
	}
	
	@RequestMapping("/write_prize")
	@ResponseBody
	public HashMap<String, Object> write_prize(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		String myidx = session.getAttribute("login_idx").toString();

		//수정용 idx
		String idx =Utils.checkNullString(request.getParameter("idx"));
		String doc_idx =Utils.checkNullString(request.getParameter("doc_idx"));
		
		String attach_idx = Utils.checkNullString(request.getParameter("attach_store"));

		String approval_line = Utils.checkNullString(request.getParameter("approval_line_store"));
		String ref_line = Utils.checkNullString(request.getParameter("ref_line_store"));
		String prize_target = Utils.checkNullString(request.getParameter("prize_target"));
		String prize_target_year = Utils.checkNullString(request.getParameter("prize_target_year"));		
		String prize_cont = Utils.checkNullString(request.getParameter("prize_cont"));
		String prize_value = Utils.checkNullString(request.getParameter("prize_value"));
		String imsi_yn = Utils.checkNullString(request.getParameter("imsi_yn"));
		String doc_type="105";
		
		int prize_idx = 0;
		String chk_line = Utils.getChkline(approval_line);
		String content = chk_line;
		String waiter = Utils.getWaiter(approval_line,chk_line);
		
		if (imsi_yn.equals("D")) 
		{
			allow_dao.delLine(idx);
			map.put("msg", "삭제 되었습니다.");
			map.put("isSuc", "success");
			return map;
		}
		
		if (imsi_yn.equals("E") || imsi_yn.equals("Y")) 
		{
			prize_idx = allow_dao.uptPrize(attach_idx,prize_target,prize_cont,prize_value,doc_idx,prize_target_year);
			allow_dao.uptLine(ref_line,waiter,approval_line,chk_line,chk_line,content,imsi_yn,idx);
		}
		else
		{
			prize_idx = allow_dao.insPrize(myidx,attach_idx,prize_target,prize_cont,prize_value,doc_type,prize_target_year);
			allow_dao.insLine(myidx,prize_idx,ref_line,waiter,approval_line,chk_line,chk_line,doc_type,content,imsi_yn);
		}
		
		if (imsi_yn.equals("Y")) 
		{
			map.put("msg", "임시 저장되었습니다.");				
		}
		else 
		{
			map.put("msg", "제출되었습니다.");	
		}
		
		map.put("isSuc", "success");
		return map;
	}
	
	@RequestMapping("/getAttachList")
	@ResponseBody
	public HashMap<String, Object> getAttachList(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();       
		String myidx = session.getAttribute("login_idx").toString();
		List<HashMap<String, Object>> attachList = allow_dao.getAttachList(myidx);
		
		map.put("attachList", attachList);
		return map;
	}
	

}

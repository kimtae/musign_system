package musign.controller.family;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.SalesDAO;
import musign.model.family.UserDAO;

@Controller
@RequestMapping("/family/sales/*")
public class SalesController {

	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Value("${image_dir}")
	private String image_dir;
	
	// 게시판 dao
	@Autowired
	private SalesDAO seles_dao;
	
	// user dao
	@Autowired
	private UserDAO user_dao;

	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/sales/write");
		
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "세션이 만료되었습니다.");
			return mav;
		}
		String myidx = session.getAttribute("login_idx").toString();
		String sale_auth = session.getAttribute("sale_auth").toString();
		
		mav.addObject("myidx", myidx);
		mav.addObject("sale_auth", sale_auth);
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		List<HashMap<String, Object>> saleUserList = seles_dao.getSaleUserList();
		
		if (!idx.equals("")) {
			HashMap<String, Object> saleData = seles_dao.getSaleInfo(idx);
			if (saleData==null) {
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "부적절한 접근입니다.");
				return mav;
			}
			
			for (String key : saleData.keySet()) {
				System.out.println(key+":"+saleData.get(key));				
				mav.addObject(key, saleData.get(key));
				if (key.equals("project_cont")) 
				{
					mav.addObject(key, Utils.repWord(saleData.get(key).toString()));
				}
			}
			
			mav.addObject("image_dir", image_dir);
			mav.addObject("idx", idx);
		}
		
		mav.addObject("saleUserList", saleUserList);
		
		mav.addObject("isSuc", "success");
		return mav;
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/sales/list");
		List<HashMap<String, Object>> saleUserList = seles_dao.getSaleUserList();
		List<HashMap<String, Object>> saleServiceList = seles_dao.saleServiceList();
		
		mav.addObject("saleUserList", saleUserList);
		mav.addObject("saleServiceList", saleServiceList);
		return mav;
	}
	
	@RequestMapping("/voucher")
	public ModelAndView voucher(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/sales/voucher");

		return mav;
	}
	
	
	@RequestMapping("/write_sale")
	@ResponseBody
	public HashMap<String, Object> write_sale(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		try {
			int sizeLimit = 500*1024*1024; //500메가 까지 가능
			
	        String uploadPath = upload_dir+"sales_receipt/";
	        
	        File dir = new File(uploadPath);
			if (!dir.exists()) // 디렉토리가 존재하지 않으면
			{ 
				dir.mkdirs(); // 디렉토리 생성
			}
			MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	        
			String myidx = session.getAttribute("login_idx").toString();
			String idx = Utils.checkNullString(multi.getParameter("idx"));
			String user_company = Utils.checkNullString(multi.getParameter("user_company"));	//고객사 회사명
			String user_type = Utils.checkNullString(multi.getParameter("user_type"));			//고객사 업종/업태
			String user_manager = Utils.checkNullString(multi.getParameter("user_manager"));	//고객사 담당자
			String user_phone = Utils.checkNullString(multi.getParameter("user_phone"));		//고객사 연락처1
			String user_email = Utils.checkNullString(multi.getParameter("user_email"));		//고객사 이메일
			String info_yn = Utils.checkNullString(multi.getParameter("info_yn"));				//고객사 개인정보 동의
			String important_yn = Utils.checkNullString(multi.getParameter("important_yn"));	//유력건 체크 
			
			//String market_yn = Utils.checkNullString(multi.getParameter("market_yn"));			//고객사 마케팅 수신 동의
			info_yn = info_yn.equals("")?"N":"Y";
			important_yn = important_yn.equals("")?"N":"Y";
			//market_yn = market_yn.equals("")?"N":"Y";
			
			//System.out.println("info_yn : "+info_yn);
			//System.out.println("market_yn : "+market_yn);
			
			
			String user_biz_no = Utils.checkNullString(multi.getParameter("user_biz_no"));							//고객사 사업자등록번호
			String[] fileNm_list = Utils.checkNullString(multi.getParameter("fileNm_list")).split("\\|");			//고객사 첨부파일
			String service_type = Utils.checkNullString(multi.getParameter("service_type_arr"));					//문의사항 서비스
			String project_type = Utils.repWord(Utils.checkNullString(multi.getParameter("project_type_arr")));		//문의사항 프로젝트
			String project_budget = Utils.checkNullString(multi.getParameter("project_budget"));					//문의사항 예산
			String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd"));								//문의사항 착수일		
			String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd"));									//문의사항 오픈일
			String select_way = Utils.checkNullString(multi.getParameter("select_way"));							//문의사항 선정방식			
			String site_url = Utils.checkNullString(multi.getParameter("site_url"));								//문의사항 기존 사이트 주소			
			//String project_title = Utils.checkNullString(multi.getParameter("project_title"));					//문의사항 프로젝트 이름			
			String project_cont = Utils.repWord(Utils.checkNullString(multi.getParameter("project_cont")));			//문의사항 프로젝트 내용	
			String known_path = Utils.checkNullString(multi.getParameter("known_path_arr"));						//문의사항 유입경로			
			
			
			String filename="";
			String filename_ori="";
			String filename_arr="";
			String filename_ori_arr="";
			
			
			//////////////견적내용 
			String comment = Utils.repWord(Utils.checkNullString(multi.getParameter("comment")));
			//////////////
			
			
			int seq =1;
			Enumeration<String> names = multi.getFileNames();
			
			while(names.hasMoreElements())
			{
				String retName = names.nextElement().toString();
				System.out.println(multi.getOriginalFileName(retName));
				filename = Utils.convertFileName(Utils.checkNullString(multi.getFilesystemName(retName)), uploadPath, seq);
				filename_ori = Utils.checkNullString(multi.getFilesystemName(retName));
				seq++;
				
				filename_arr +=  filename+"|";
				filename_ori_arr +=  filename_ori+"|";
			}
			
			
			if (!idx.equals("")) 
			{
				
				System.out.println("filename_arr : "+filename_arr);
				System.out.println("filename_ori_arr : "+filename_ori_arr);
				
				HashMap<String, Object> data = seles_dao.getSaleInfo(idx);
				//
				String[] dbfilename=data.get("file").toString().split("\\|");
				String[] dbfilename_ori=data.get("file_ori").toString().split("\\|");
				
				filename="";
				filename_ori="";
				
				System.out.println("fileNm_list : "+Utils.checkNullString(multi.getParameter("fileNm_list")));
				System.out.println("db file : "+data.get("file_ori").toString());
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
							if (fileNm_list[i].equals(dbfilename_ori[j])) 
							{							
								filename +=dbfilename[j]+"|";
								filename_ori +=dbfilename_ori[j]+"|";
							}
						}
					}
				}
	
				seles_dao.uptSale(myidx,service_type,project_type,project_budget,start_ymd,end_ymd,select_way,site_url,project_cont,filename,filename_ori,
						user_company,user_manager,user_type,user_phone,user_email,user_biz_no,known_path,info_yn,idx);
				seles_dao.uptEstimate(idx,comment,important_yn);
			}
			else
			{
				int sale_idx = seles_dao.insSale(myidx,service_type,project_type,project_budget,start_ymd,end_ymd,select_way,site_url,project_cont,filename_arr,filename_ori_arr,
						user_company,user_manager,user_type,user_phone,user_email,user_biz_no,known_path,info_yn);
				
				int result = seles_dao.insEstimate(sale_idx,comment,important_yn);
				
				if (result > 0) 
				{
					Utils.sendJandiAlarm_New(sale_idx,session,seles_dao);
				}
				
			}
			
			
			if (!idx.equals("")) 
			{
				map.put("msg", "수정 되었습니다.");				
			}
			else 
			{
				map.put("msg", "저장 되었습니다.");	
			}
			
			map.put("isSuc", "success");
			return map;
        } catch (Exception e) {
        	map.put("isSuc", "fail");
        	map.put("msg", "알 수 없는 오류 발생.");
    		return map;
		}
        
	}
	
	
	
	@RequestMapping("/chooseManager")
	@ResponseBody
	public HashMap<String, Object> chooseManager(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) {
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		String myidx = session.getAttribute("login_idx").toString();
		String myName = session.getAttribute("login_name").toString();
		String myTeam = session.getAttribute("login_team_nm").toString();
		String myChmod = session.getAttribute("login_chmod_nm").toString();
		
		String idx =Utils.checkNullString(request.getParameter("idx"));
		String manager_idx =Utils.checkNullString(request.getParameter("manager_idx"));
		
		seles_dao.chooseManager(idx,manager_idx,myidx);
		
		if (!manager_idx.equals("")) {
			
			HashMap<String, Object> manager_data = seles_dao.getManagerInfo(manager_idx);
			HashMap<String, Object> target_data = seles_dao.getTargetInfo(idx);
			
			String TeamLeaderMail = Utils.checkNullString(seles_dao.getTeamLeaderMail(manager_idx).get("email"));
			String target_project = Utils.checkNullString(target_data.get("user_company"));
			String manager_mail = Utils.checkNullString(manager_data.get("email"));
			String manager_name = Utils.checkNullString(manager_data.get("name"));
			
			String result = Utils.send_mail(manager_mail,idx,target_project,manager_name,TeamLeaderMail);
			System.out.println("메일 리절트 : "+result);
			
			////////////////////////////////////////잔디 알림 start////////////////////////////////////////////////////////////
			
			String target_name = Utils.getUserNameByIdx(user_dao,manager_idx);
			String target_chmod_nm = Utils.getUserChmodByIdx(user_dao,manager_idx);
			String target_team_nm = Utils.getUserTeamByIdx(user_dao,manager_idx);
			
			
			HashMap<String, Object> post = new HashMap<>();
			post.put("body", "담당자 지정 알림");
			post.put("connectColor", "#FAC11B");
			
			List<HashMap<String, String>> connectInfo = new ArrayList<>();
			connectInfo.add(new HashMap<String, String>(){  private static final long serialVersionUID = 1L; { 
				put("title", "담당자가 지정 되었습니다."); 
				put("description", myName+"("+myTeam+"_"+myChmod+")님이 "+target_name+"("+target_team_nm+"_"+target_chmod_nm+")님을 프로젝트 담당자로 지정했습니다.");
			}});
			connectInfo.add(new HashMap<String, String>(){  private static final long serialVersionUID = 1L; { 
				put("title", "URL"); 
				put("description", "http://sale.musign.net/family/sales/write?idx="+idx);
			}});
			
			//리스트맵 -> JsonArray로 변환
			JsonArray ja = new JsonArray();
			for(int i = 0; i < connectInfo.size(); i++) {
				JsonObject chip = new JsonObject();
				chip.addProperty("title", connectInfo.get(i).get("title"));
				chip.addProperty("description", connectInfo.get(i).get("description"));
				ja.add(chip);
			}
			//Hashmap에 JsonArray추가 
			post.put("connectInfo", ja);
			//Hashmap -> json string
			String js = new Gson().toJson(post);
			
			
			byte[] resMessage = null;
			try {
				String api_url = "https://wh.jandi.com/connect-api/webhook/21137853/b0cea55dff7498ffa20575c083a893d4";
				URL url = new URL(api_url);
				String jsonData = js; //위에서 작성한 JSON string
				
				HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
				conn.setRequestProperty("Accept", "application/vnd.tosslab.jandi-v2+json");
				conn.setRequestProperty("Content-Type", "application/json");
				conn.setRequestMethod("POST");
				conn.setDoInput(true);
				conn.setDoOutput(true);
				
				OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
				os.write(jsonData);
				os.flush();
				os.close();
				
				DataInputStream in = new DataInputStream(conn.getInputStream());
				ByteArrayOutputStream bout = new ByteArrayOutputStream();
				
				byte[] buf = new byte[2048];
				while (true) {
				int n = in.read(buf);
				if (n == -1) break;
					bout.write(buf, 0, n);
				}
				bout.flush();
				resMessage = bout.toByteArray();
				conn.disconnect();
				//완료시 true
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			
		}
		
		map.put("isSuc", "success");
		map.put("msg", "저장 되었습니다.");
		return map;
	}
	
	@RequestMapping("/getSaleList")
	@ResponseBody
	public HashMap<String, Object> getSaleList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();    
		String myidx = session.getAttribute("login_idx").toString();
		String isManager = session.getAttribute("isManager").toString();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
	
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		
		String upt_start_ymd = Utils.checkNullString(request.getParameter("upt_start_ymd"));
		String upt_end_ymd = Utils.checkNullString(request.getParameter("upt_end_ymd"));
		
		String step = Utils.checkNullString(request.getParameter("step"));
		String sale_manager = Utils.checkNullString(request.getParameter("sale_manager"));
		String sale_service = Utils.checkNullString(request.getParameter("sale_service"));
		String search_cont = Utils.checkNullString(request.getParameter("search_cont"));
		
		String important_yn = Utils.checkNullString(request.getParameter("important_yn"));
		String choice = Utils.checkNullString(request.getParameter("choice"));
		String known_path = Utils.checkNullString(request.getParameter("known_path"));
		String budget = Utils.checkNullString(request.getParameter("budget"));
		
		
		
		
		
		
		List<HashMap<String, Object>> TotallistCnt = seles_dao.getSaleListCount("","","","","","","","","","","","","","");
		List<HashMap<String, Object>> listCnt = seles_dao.getSaleListCount(myidx,isManager,start_ymd,end_ymd,step,sale_manager,sale_service,search_cont,upt_start_ymd,upt_end_ymd,important_yn,choice,known_path,budget);
		int TotalCnt = Integer.parseInt(TotallistCnt.get(0).get("CNT").toString());
		int listCount = Integer.parseInt(listCnt.get(0).get("CNT").toString());
		
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 10;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		int block=5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
		    s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
		    e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		

		
		List<HashMap<String, Object>> list = seles_dao.getSaleList(myidx,s_point, listSize, order_by, sort_type,isManager,start_ymd,end_ymd,step,sale_manager,sale_service,search_cont,upt_start_ymd,upt_end_ymd,important_yn,choice,known_path,budget); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("TotalCnt", TotalCnt);
		map.put("listCount", listCount);
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	
	@RequestMapping("/checkMiddleStep")
	@ResponseBody
	public HashMap<String, Object> checkMiddleStep(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		String idx = Utils.checkNullString(request.getParameter("idx"));
		int result = seles_dao.checkMiddleStep(idx);
		if (result > 0) 
		{
			map.put("isSuc", "success");
			map.put("msg", "저장 되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 ERROR발생.");
			
		}
		return map;
	}
	
	@RequestMapping("/doContract")
	@ResponseBody
	public HashMap<String, Object> doContract(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();    
		
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		String chk_val = Utils.checkNullString(request.getParameter("chk_val"));
		
		int result =0;
		if (chk_val.equals("Y")) //계약승인
		{
			result = seles_dao.doContract(idx,chk_val) + seles_dao.chooseContractStep(idx,"4");	
		}
		else //계약페스
		{
			result = seles_dao.chooseContractStep(idx,"5");	
		}
		
		if (result > 0) 
		{
			map.put("isSuc", "success");
			map.put("msg", "저장 되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 ERROR발생.");
		}
		return map;
	}
	
	
	@RequestMapping("/doDelete")
	@ResponseBody
	public HashMap<String, Object> doDelete(HttpServletRequest request) throws ParseException {
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		String[] idx = Utils.checkNullString(request.getParameter("idx")).split("\\|");
		
		int result =0;
		for (int i = 0; i < idx.length; i++) {
			result += seles_dao.doDelete(idx[i]);	
		}
		
		if (result > 0) 
		{
			map.put("isSuc", "success");
			map.put("msg", "저장 되었습니다.");
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 ERROR발생.");
			
		}
		
		return map;
	}
	
	@RequestMapping("/getSaleComment")
	@ResponseBody
	public HashMap<String, Object> getSaleComment(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();       
		if (session.getAttribute("login_idx")==null) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "세션이 만료되었습니다.");
			return map;
		}
		String sale_idx = Utils.checkNullString(request.getParameter("sale_idx"));
		HashMap<String, Object> data = seles_dao.getSaleComment(sale_idx);
		if (data !=null) 
		{
			map.put("data", data);
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 ERROR발생.");
			
		}
		return map;
	}
	
}
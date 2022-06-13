package musign.controller.family;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.server.ServerEndpoint;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import musign.classes.Utils;
import musign.model.family.BoardDAO;
import musign.model.family.MainDAO;
import musign.model.family.UserDAO;

import java.lang.String;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;

@Controller

@RequestMapping("/family/board/*")
public class BoardController {

	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	// 게시판 dao
	@Autowired
	private BoardDAO board_dao;
	
	// user dao
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private MainDAO main_dao;

	// 게시물 목록 페이지
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/list");
		
		return mav;
	}

	// 게시판 목록 조회
	@RequestMapping("/getBoard")
	@ResponseBody
	public HashMap<String, Object> getBoard(HttpServletRequest request){

		String search_type = request.getParameter("search_type");
		String searchName = request.getParameter("searchName");
		
		List<HashMap<String, Object>> list = board_dao.getBoardList(search_type,searchName);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list); 
		
		
		return map;
	}
	// 게시물 클릭시 조회
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/detail");
		
		HttpSession session = request.getSession();
		
		String myidx = session.getAttribute("login_idx").toString();
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		
		// 게시물 상세 조회
		HashMap<String, Object> data = board_dao.getBoardOne(idx);

		// 이전게시물 조회
		HashMap<String, Object> pre_data = board_dao.prev_getBoardOne(idx);
		
		// 다음게시물 조회
		HashMap<String, Object> next_data = board_dao.next_getBoardOne(idx);
		
		// 세션 가져오기
		mav.addObject("myidx", myidx);
		// 조회
		mav.addObject("data", data);
		// 이전글 조회
		mav.addObject("pre_data", pre_data);
		// 다음글 조회
		mav.addObject("next_data", next_data);
		
		return mav;
	}
	
	// 글 등록 페이지 맵핑
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/write");
		
		return mav;
	}
		
	@RequestMapping("/write2")
	public ModelAndView write2(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView(); 
		

        
        return mav;
	}
	
	
	
//	@RequestMapping("/write2")
//	public ModelAndView write2(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/family/board/write2");
//		/*
//		try (ServerSocket server = new ServerSocket()) 
//		{
//			// 서버 초기화
//			InetSocketAddress ipep = new InetSocketAddress(9999);
//			server.bind(ipep);
//			System.out.println("Initialize complate");
//			// LISTEN 대기
//			Socket client = server.accept();
//			System.out.println("Connection");
//			// send,reciever 스트림 받아오기
//			// 자동 close
//			try (OutputStream sender = client.getOutputStream(); InputStream reciever = client.getInputStream();) 
//			{
//				// 클라이언트로 hello world 메시지 보내기
//				// 11byte 데이터
//				String message = "0000";
//				System.out.println("server send data : "+message);
//				
//				
//				byte[] data = message.getBytes();
//				sender.write(data, 0, data.length);
////				// 클라이언트로부터 메시지 받기
////				// 2byte 데이터
//				data = new byte[1024];
//				reciever.read(data, 0, data.length);
//				// 수신 메시지 출력
//				message = new String(data);
//				String out = String.format("%s", message);
//				System.out.println("server recieve data : "+out);
//			}
//		} 
//		catch (Throwable e) 
//		{
//			e.printStackTrace();
//		}
//		*/
//		return mav;
//	}
	
//	@RequestMapping("/callsocket")
//	@ResponseBody
//	public String callsocket(HttpServletRequest request) {
//		String out = "";
//		try (Socket client = new Socket()) 
//		{ 
//			// 클라이언트 초기화
//			InetSocketAddress ipep = new InetSocketAddress("127.0.0.1", 9999); //test
////			InetSocketAddress ipep = new InetSocketAddress("91.1.101.67", 9001); //바람이 분당점
//			// 접속
//			client.connect(ipep);
//			// send,reciever 스트림 받아오기
//			// 자동 close
//			try (OutputStream sender = client.getOutputStream(); InputStream receiver = client.getInputStream();) {
//				// 서버로부터 데이터 받기
//				// 11byte
//				byte[] data = new byte[1024];
//				receiver.read(data, 0, 1024);
////				// 수신메시지 출력
//				String message = new String(data);
//				out = String.format("%s", message);
//				System.out.println("client recieve data : "+out);
//				// 서버로 데이터 보내기
//				// 2byte
//				//신한 법카 대표님껄로 했을때 완성된 전문이다.
//				message = "TEST";
//				System.out.println("client send data : "+message);
//				data = message.getBytes();
//				sender.write(data, 0, data.length);
//				
//			}
//		} 
//		catch (Throwable e) 
//		{
//			e.printStackTrace();
//		}
//		//임시
//		System.out.println("testtttttttttttttt");
//		out = "0000";
//		return out;	
//	}
	
	
	// 게시물 글 등록 기능
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) throws IOException{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/write_proc");
		
		HttpSession session = request.getSession();
	
		int sizeLimit = 10*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"board/";
		
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
          
		String myidx = session.getAttribute("login_idx").toString();	
		String title = Utils.checkNullString(multi.getParameter("board_title"));
		String cont = Utils.checkNullString(multi.getParameter("board_cont"));
		String board_type = Utils.checkNullString(multi.getParameter("board_type"));
		
		String filename =	Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("board_file")), uploadPath, 1);
		String filename_ori = Utils.checkNullString(multi.getOriginalFileName("board_file"));
		
		
		board_dao.insBoard(title, cont, myidx, board_type, filename, filename_ori);
		HashMap<String, Object> getMyInfo = user_dao.getMyInfo(myidx);	
			
		mav.addObject("getMyInfo", getMyInfo);
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
			
		return mav;
	}
	
	
	// 게시물 수정 페이지
	@RequestMapping("/edit")
	public ModelAndView edit(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/edit");
		String idx = Utils.checkNullString(request.getParameter("idx"));
		HashMap<String, Object> data3 = board_dao.getBoardOne(idx);
		
		mav.addObject("data3", data3); 
		
		return mav;
	}
	
	// 게시물 수정 실행 기능 
	@RequestMapping("/edit_proc")
	public ModelAndView edit_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/family/board/edit_proc");
		
		int sizeLimit = 10*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"board/";
		
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		String idx = Utils.checkNullString(multi.getParameter("idx"));
		String title = Utils.checkNullString(multi.getParameter("title"));
		String cont = Utils.checkNullString(multi.getParameter("cont"));
		String board_type = Utils.checkNullString(multi.getParameter("board_type"));
		String filename = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("board_file")), uploadPath, 1);
		String filename_ori = Utils.checkNullString(multi.getOriginalFileName("board_file"));
		
		if("".equals(filename))
		{
			filename = Utils.checkNullString(multi.getParameter("board_file_pre"));
			filename_ori = Utils.checkNullString(multi.getParameter("board_file_ori_pre"));
		}
		
		board_dao.upBoard(title, cont, idx, board_type, filename, filename_ori);
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		
		return mav;
	}
	
	// 게시물 삭제 
	@RequestMapping("/delBoard")
	@ResponseBody
	public HashMap<String, Object> delBoard(HttpServletRequest request) {
		
		String idx = Utils.checkNullString(request.getParameter("idx"));
		board_dao.delBoard(idx);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "삭제되었습니다.");
		return map;
	}
	
}
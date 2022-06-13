<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>

<script>

var isLogin = "<%=session.getAttribute("login_user_id")%>";
var link = location.href;

if ((isLogin == null || isLogin == "null") && link.indexOf("/user/login") == -1) {
	alert("로그인 후 이용해주세요.");
	location.href = "/family/user/login";
}

var isDel = "${isDel}";
if (isDel=="Y") {
	alert("삭제된 게시물입니다.");
	location.href = "/family/dosign/list";
}


</script>

<html>
	<head>
		<meta charset="utf-8">
		
		<meta http-equiv="Cache-Control" content="no-cache"/>
		<meta http-equiv="Expires" content="0"/>
		<meta http-equiv="Pragma" content="no-cache"/>

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
		<meta name=ProgId content=Excel.Sheet>
		<meta name=Generator content="Microsoft Excel 14">
		
		<title>Musign</title>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/inc/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="/inc/js/printThis.js"></script>
		<script src="/inc/js/function.js"></script>
		<script src="/inc/js/main.js"></script>
		<script src="/inc/js/musign.js"></script>
		
		
		<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
		
		<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
		<link rel="stylesheet" type="text/css" href="/inc/css/main.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/general.css">
		<link rel="stylesheet" type="text/css" href="/inc/css/mu_layout.css">
		
		<!-- 유지보수 css -->
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_a.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_b.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_c.css" />
		<!-- 유지보수 css -->

		<link rel="stylesheet" type="text/css" href="/inc/css/board_detail.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/new_registration.css">
		<link rel="stylesheet" type="text/css" href="/inc/css/responsive.css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		
		<script>
		$(document).ready(function(){
		
			$("#printhtis").click(function(){
				jQuery("#mySelector").printThis({
				     debug: false,               // show the iframe for debugging
				     importCSS: true,            // import page CSS
				     importStyle: true,         // import style tags
				     printContainer: true,       // grab outer container as well as the contents of the selector
				     loadCSS: "/inc/css/musign.css",  // path to additional css file - us an array [] for multiple
				     pageTitle: "",              // add title to print page
				     removeInline: false,        // remove all inline styles from print elements
				     printDelay: 333,            // variable print delay
				     header: null,               // prefix to html
				     footer: null,               // postfix to html
				     base: false,                // preserve the BASE tag, or accept a string for the URL
				     formValues: true,           // preserve input/form values
				     canvas: false,              // copy canvas elements (experimental)
				     doctypeString: '...',       // enter a different doctype for older markup
				     removeScripts: false        // remove script tags from print content
				 });
			});	
			if ("${work_start_time}"!='') 
			{
				var afternoon_chk ="${afternoon_leave}";
				var morning_chk ="${morning_leave}";
					
				var work_time = new Date("${work_start_time}");
				var leave_time = new Date("${work_start_time}");
				
				
				if (afternoon_chk=='Y' || morning_chk=='Y') 
				{
					leave_time.setHours(leave_time.getHours()+4);
					leave_time.setMinutes(leave_time.getMinutes()+30);
				}
				
				if (afternoon_chk=='N' && morning_chk=='N') 
				{
					leave_time.setHours(leave_time.getHours()+9);
				}
				
				$('#leave_time').text(dateFormat(leave_time));
				
				CountDownTimer(dateFormat(leave_time), 'left_time');
				
				//근태 상태에 따른 컬러 변경
				var todayStatus = document.querySelector('.today_status'),
					statusText = todayStatus.innerText;
				if(statusText.indexOf('정상') > -1){
					todayStatus.style.backgroundColor = '#7fe765';
				}else if(statusText.indexOf('지각') > -1){
					todayStatus.style.backgroundColor = '#ffdb2a';
				}else if(statusText.indexOf('무단') > -1){
					todayStatus.style.backgroundColor = 'red';
					todayStatus.style.color = 'white';
				}else{
					todayStatus.style.backgroundColor = '#e0e0e0';
				}
			}
			
		})
	
		function CountDownTimer(dt, id) {
		     var end = new Date(dt);
		     var _second = 1000;
		     var _minute = _second * 60;
		     var _hour = _minute * 60;
		     var _day = _hour * 24;
		     var timer;
		     function showRemaining() {
		         var now = new Date();
		         var distance = end - now;
		         document.getElementById(id).style.color = "red";
		         if (distance < 0) {
		             clearInterval(timer);
		             document.getElementById(id).style.color = "blue";
		             document.getElementById(id).innerHTML = '고생하셨습니다.';
		             return;
		         }
		         var days = Math.floor(distance / _day);
		         var hours = Math.floor((distance % _day) / _hour);
		         var minutes = Math.floor((distance % _hour) / _minute);
		         var seconds = Math.floor((distance % _minute) / _second);
		         
		         document.getElementById(id).innerHTML = hours + '시간 ';
		         document.getElementById(id).innerHTML += minutes + '분 ';
		         document.getElementById(id).innerHTML += seconds + '초';
		     }
		     timer = setInterval(showRemaining, 1000);
	    }
		
		</script>
	</head>
<body>
    <div id="header">
		<div>
	    	<a href="/family/main" class="logo"><img src="/img/logo.png"></a>
		</div>
		<div class="hd_main_wrap">
	    	<!-- <div class="fl-ri">
				<a class="s-btn btn01" href="/family/user/logout">로그아웃</a>
				<a class="s-btn btn01" href="/family/user/mypage">마이페이지</a>
			</div> -->
			<div class="mu_mypage">
				<div class="pc_mydata">
					<span class="today_status">${guntae_type}</span>
					<span class="year_late">올해 지각 횟수 : <span id="late_cnt">${late_cnt}</span></span>
				</div>
				<div class="pc_mymenu">
					<a href="/family/user/mypage" class="mu_myIcon">마이페이지</a>
					<a href="/family/user/logout" class="mu_myIcon2">로그아웃</a>
				</div>
				<!-- 
				<div class="mu_mypage notice_icon">
   					<img src="/img/notice_btn.png" alt="알림버튼" class="notice_icon_btn">
   					<span class="notice_num">2</span>
				</div>
				 -->
					<div class="notice_box">
			        <div class="notice_title">
			            <div class="bell_box">
			                <div class="bell_num">
			                    <span>2</span>
			                </div>
			            </div>
			            <h3>알림</h3>
			        </div>
			        <div class="notice_tab_btn_box">
			            <label for="notice_tab_1" class="tab_label tab_add">전자결재
			                <span>1</span>
			            </label>
			            <label for="notice_tab_2" class="tab_label">영업관리
			                <span>1</span>
			            </label>
			            <label for="notice_tab_3" class="tab_label">유지보수</label>
			        </div>
			        <div class="notice_tab_page_box">
			            <input id="notice_tab_1"type="radio" class="notice_tab" name="notice_tab">
			            <input id="notice_tab_2"type="radio" class="notice_tab" name="notice_tab">
			            <input id="notice_tab_3"type="radio" class="notice_tab" name="notice_tab">
			            <div class="notice_tab_content notice_tab_content_1">
			                <div class="notice_inner_content notice_inner_content_1 notice_on">
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 26(목)</p>
			                        </div> 
			                        <div class="message_con">	
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 25(목)</p>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 24(목)</p>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="notice_tab_content notice_tab_content_2">
			                <div class="notice_inner_content notice_inner_content_1">
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 26(목)</p>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 26 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 25(목)</p>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 25 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="message_day_contain">
			                        <div class="day_num">
			                            <p>2021. 11. 24(목)</p>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="message_con">
			                            <div class="message_box">
			                                <div class="message_text">
			                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
			                                </div>
			                                <div class="message_time">
			                                    <span>21. 11. 24 11:39</span>
			                                </div>
			                                <div class="check_message">
			                                    <a href="#" class="check_message_a">바로가기</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="notice_tab_content notice_tab_content_3"></div>
			        </div>
			    </div>
			</div>
			<div class="main_time" style="text-align:right;">
				<dl>
					<dt>출근시간 : </dt>
					<dd>${work_start_time}<%-- <br>안녕하세요. ${login_name}님 --%></dd>
				</dl>
				<dl>
					<dt>퇴근예정 : </dt>
					<dd><span id="leave_time"> ${work_start_time}</span></dd>
				</dl>
				<dl>
					<dt>퇴근까지 : </dt>
					<dd><span id="left_time"></span></dd>
				</dl>
			</div>
		</div>
			
			<button type="button" class="m_btn">
				<img src="/img/main_buger.png" alt="모바일메뉴">
			</button>
		</div>
		<div class="header_dim"></div>
		<div id="m_header" style="left:-100%;">
		
			<div class="inner">
			
				<button type="button" class="m_close">
					<img src="/img/m_close_icon.png" alt="메뉴닫기">
				</button>
				<div class="top">
					<!--  <a href="/" class="logo">뮤자인 프로젝트 관리</a>-->
					출근 시간 : ${work_start_time} <br> &emsp; ${guntae_type}<br>
					<%-- 안녕하세요. ${login_name}님 --%>
					
					<!-- <div class="mypage_btn">
						<a class="s-btn btn01" href="/family/user/logout">로그아웃</a>
						<a class="s-btn btn01" href="/family/user/mypage">마이페이지</a>
					</div> -->
					<div class="mu_mypage">
						<a href="/family/user/mypage" class="mu_myIcon">마이페이지</a>
						<a href="/family/user/logout" class="mu_myIcon2">로그아웃</a>
						<div class="mu_mypage notice_icon">
		      					<img src="/img/notice_btn.png" alt="알림버튼" class="notice_icon_btn">
		      					<span class="notice_num">2</span>
		  					</div>
		  					<div class="notice_box">
					        <div class="notice_title">
					            <div class="bell_box">
					                <div class="bell_num">
					                    <span>2</span>
					                </div>
					            </div>
					            <h3>알림</h3>
					        </div>
					        <div class="notice_tab_btn_box">
					            <label for="notice_tab_1" class="tab_label tab_add">전자결재
					                <span>1</span>
					            </label>
					            <label for="notice_tab_2" class="tab_label">영업관리
					                <span>1</span>
					            </label>
					            <label for="notice_tab_3" class="tab_label">유지보수</label>
					        </div>
					        <div class="notice_tab_page_box">
					            <input id="notice_tab_1"type="radio" class="notice_tab" name="notice_tab">
					            <input id="notice_tab_2"type="radio" class="notice_tab" name="notice_tab">
					            <input id="notice_tab_3"type="radio" class="notice_tab" name="notice_tab">
					            <div class="notice_tab_content notice_tab_content_1">
					                <div class="notice_inner_content notice_inner_content_1">
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 26(목)</p>
					                        </div> 
					                        <div class="message_con">	
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 25(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 24(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <div class="notice_tab_content notice_tab_content_2">
					                <div class="notice_inner_content notice_inner_content_1">
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 26(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 25(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 24(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <div class="notice_tab_content notice_tab_content_3"></div>
					        </div>
					    </div>
					</div>
				</div>
			<div class="menu">
				<div class="scr">
					<div id="inb" class="m_menu">

						<div class="depth1">
							<a href="/family/main" class="dep1_menu">HOME</a>
						</div>


						<div class="depth1">
							<a class="dep1_menu">인사관리</a>
							<ul class="depth2 lnb-menu" style="display: none">
								<li><a href="/family/user/group"><div>
											<p>TEAM 뮤자인</p>
										</div></a></li>
								<li><a href="/family/guntae/list"><div>
											<p>근무시간 관리</p>
										</div></a></li>
								<li><a href="/family/leave/list"><div>
											<p>연차관리</p>
										</div></a></li>
					
								<c:if test="${login_team < 3 || login_chmod le 3 || login_team le 2}">
									<li><a href="/family/team/list"><div>
												<p>DB 관리</p>
											</div></a></li>
								</c:if>
								<li><a href="/family/recruit/list"><div>
											<p>채용관리</p>
										</div></a></li>
								<li><a href="/family/kpi/insKpi"><div>
											<p>KPI 작성</p>
										</div></a></li>
							</ul>
						</div>


						<div class="depth1">
							<a class="dep1_menu">전자결재 <span class="sign_number"
								onclick="getSignList();"></span></a>
							<ul class="depth2 lnb-menu" style="display: none">
								<c:if test="${login_chmod ne '1'}">
									<li><a href="/family/allow/write"><div>
												<p>결재신청</p>
											</div></a></li>
								</c:if>
								<li>
					
									<div class="dosign_num">
										<a href="/family/dosign/list" style="width: 100%;">
											<p>결재열람</p>
										</a> <span class="sign_number" onclick="getSignList();"></span>
									</div>
								</li>
							</ul>
						</div>


						<%-- <c:if test="${isManager eq 'Y'}">
							<div class="depth1">
								<a href="/family/oper/card" class="dep1_menu">카드관리</a>
							</div>
					
							<div class="depth1">
								<a href="/family/board/list" class="dep1_menu">게시판</a>
							</div>
					
						</c:if> --%>

						<div class="depth1">
							<a class="dep1_menu">프로젝트 <span class="sale_number"
								onclick="getSaleList();"></span>
							</a>
							<ul class="depth2 lnb-menu" style="display: none">
								<div>
									<c:if test="${sale_auth ne 'N'}">
										<a class="dep3_menu n1 dep3_name"> 영업</a>
										<ul class="depth3 lnb-menu gnb" style="display: none">
											<li><a href="/family/sales/list"><div class="depth_pad">
														<p>· 관리차트</p>
													</div></a></li>
											<li class="first"><a href="/family/sales/write"><div
														class="depth_pad">
														<p class="enrollment">· 신규등록 / 수정</p>
													</div></a></li>
										</ul>
									</c:if>
								</div>
					
								<div>
									<a class="dep3_menu dep3_name"> 운영 관리</a>
									<ul class="depth3 lnb-menu" style="display: none">
										<li><a href="/family/mo/main"><div class="depth_pad">
													<p>· 대시보드</p>
												</div></a></li>
										<li><a href="/family/mo/list"><div class="depth_pad">
													<p>· 관리차트</p>
												</div></a></li>
										<li><a class="dep3_menu n1 n2"><div class="depth_pad">
													<p>· 프로젝트 등록</p>
												</div></a>
					
											<ul class="depth3 depth4 lnb-menu gnb" style="display: none">
												<li><a href="/family/mo/write"><div>
															<p class="depth4_wrap">- 프로젝트 작성</p>
														</div></a>
												<li><a href="/family/mo/plan"><div>
															<p class="depth4_wrap">- 플랜등록</p>
														</div></a></li>
												<li><a href="/family/mo/cate_add"><div>
															<p class="depth4_wrap">- 유지보수 항목 등록</p>
														</div></a></li>
												<li><a href="/family/mo/wage"><div>
															<p class="depth4_wrap">- 노임단가 등록</p>
														</div></a></li>
											</ul></li>
									</ul>
								</div>
							</ul>
						</div>

	
						<div class="depth1">
							<a href="/family/room/insRoom" class="dep1_menu">회의실예약</a>
						</div>


					</div>
				</div>
			</div>				
			</div>
		</div>
		</div>

    	<div class="loading" style="display:none;">
    		<div class="loading_wrap">
    			<img src="/img/loading_bar.gif">
    		</div>
    	</div>
    	
    </div>
<script>

$(function(){
	
	/* $("#header .logo, #header .fl-ri > span , #header .fl-ri .s-btn").clone().appendTo("#m_header .top"); */
	$("#inb").clone().appendTo("#m_header .menu .scr");
	$("#m_header #inb").addClass("m_menu");

	$("#header .m_btn").click(function(){
		$("#m_header").stop().animate({
			left:0
		},500);
		$(".header_dim").addClass("on");
	});
	$("#m_header .m_close").click(function(){
		$("#m_header").stop().animate({
			"left":"-100%"
		},500);
		$(".header_dim").removeClass("on");
	});

});


function dep(menu)
{
	if($(".menu_"+menu).css("display") == "none")
	{
    	$(".depth2").slideUp();
		$(".menu_"+menu).slideDown();
	}
	else
	{
		$(".depth2").slideUp();
	}	
}

function start_loading(){
	$('.loading').show();
}

function end_loading(){
	$('.loading').hide();
}
	
</script>

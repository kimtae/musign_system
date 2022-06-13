<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
start_loading();
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

$(document).ready(function () {
	
	MaingetList();
	getMyYeonChaList();
	getLeaveUserLeave();
});

//게시판 목록 조회
function MaingetList()
{
	
	
	var f = document.fncForm;
	$.ajax({
		type : "POST", 			
		url : "./main_getBoardList",	
		dataType : "text", 		
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			//console.log(result);
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<div>'
					inner += '	<a href="javascript:dep(\'allow'+i+'\');" class="dep1_menu">';
					inner += '		<p class="board_title">'+result.list[i].title+'</p>';
					inner += ' 		<span class="board-stit">작성자 : '+result.list[i].name+' | 등록일 : '+result.list[i].submit_date+'</span>';
					inner += '	</a>';	
					inner += '</div>';
					inner += '<div class="depth2 menu_allow'+i+' slide" style="display: none;">';
					inner += '		<p class="board_cont">'+result.list[i].cont+'</p>';
					inner += '</div>';
				}
			}
			
			$("#board_target").html(inner);
			$("#board_cnt").html(result.count);
		}
	});	
}


//게시판 목록 조회
function getMyYeonChaList()
{
	
	$.ajax({
		type : "POST", 			
		url : "./getMyYeonChaList",	
		dataType : "text", 		
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			//console.log(result);
			var inner = "";
			var now = new Date();			// 현재 날짜 및 시간
			var year = now.getFullYear();	// 연도
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if (result.list[i].start_ymd.substring(0,4)==year || result.list[i].end_ymd.substring(0,4)==year) 
					{
						inner +='<tr>';
						inner +='	<td>'+nullChk(result.list[i].submit_date)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].start_ymd)+'~'+nullChk(result.list[i].end_ymd)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].leave_type)+'</td>';
						if (result.list[i].cont.length > 22) 
						{
							inner +='	<td>'+repWord(nullChk(result.list[i].cont).substring(0,22))+'... </td>';
						}
						else
						{
							inner +='	<td>'+repWord(nullChk(result.list[i].cont))+'</td>';
						}
						inner +='	<td>'+nullChk(result.list[i].day_cnt)+'</td>';
						inner +='</tr>';
					}
				}
			}
			
			$("#myYeonChaHistory").html(inner);
		}
	});	
}

function getLeaveUserLeave(){
	
	var today = new Date();
	var year = today.getFullYear();
	$.ajax({
		type : "POST", 
		url : "/family/leave/getLeaveUserList",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "",
			search_name : "",
			search_team : "",
			search_chmod : "",
			search_level : "",
			search_use_yn : "",
			targetYear : year
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			
			var temp=""; //관리자외 일반 직원들을 위한 임시 변수
			
			var sum_leave_cnt =0;
			var user_leave = 0;
			var over_leave = 0;
			var prize_leave = 0;
			var use_leave = 0;
			var use_cancel_leave = 0;
			
			var early_leave = 0;				var early_cnt = 0;
			var early_cancel_leave = 0;			var early_cancel_cnt = 0;
			var half_leave = 0;					var half_cnt = 0;
			var half_cancel_leave = 0;			var half_cancel_cnt= 0;
			var result_leave =0;
			
			for(var i = 0; i < result.list.length; i++)
			{
				if (result.list[i].user_idx == "${login_idx}") 
				{
				 
					//부여연차
					user_leave			= Number(result.list[i].user_leave);	
					over_leave 			= Number(result.list[i].over_leave);															//야근연차
					prize_leave 		= Number(result.list[i].prize_leave);															//포상연차
					use_leave 			= Number(result.list[i].use_leave);																//사용연차
					use_cancel_leave 	= Number(result.list[i].use_cancel_leave);														//사용취소연차
					
					early_cnt 			= result.list[i].early_leave;																	//조퇴회수
					early_cancel_cnt 	= result.list[i].early_cancel_leave;															//조퇴취소횟수
					early_leave 		= ( (early_cnt + (early_cancel_cnt * -1)) >= 0 ) ? (early_cnt + (early_cancel_cnt * -1)) : 0;	//조퇴연차
					
					half_cnt 			= result.list[i].half_leave;																	//반차횟수
					half_cancel_cnt 	= result.list[i].half_cancel_leave;																//반차취소횟수
					half_leave  		= ( half_cnt + (half_cancel_cnt*-1) >= 0 ) ? half_cnt + (half_cancel_cnt*-1) : 0;				//반차사용연차
					
					 
					//사용연차 
					result_use_leave = (use_leave  + half_leave + early_leave) - use_cancel_leave 
					
					 //전여연차 (부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차  + 조퇴연차 + 반차사용연차)
					//result_leave =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + early_leave + half_leave);
					result_leave =  (user_leave + over_leave + prize_leave) - (result_use_leave );
					$('#user_leave').text(result.list[i].user_leave);
					$('#prize_leave').text(result.list[i].prize_leave);
					$('#over_leave').text(result.list[i].over_leave);
					$('#use_leave').text(result_use_leave);
					//$('#early_leave').text(result.list[i].early_leave);
					$('#result_leave').text(result_leave);
				}
			}
		}
	});
}
</script>


<div id="container" class="main_contain musign_main_con">
	<div class="dash-wr musign-grid musign_main_gr no-table">
		<div class="wid-5">
			<h3>공지사항</h3>
			<p class="cap-p">총 <span id="board_cnt"></span>개의 공지사항이 있습니다.</p>
			<div id="board_target" class="board-lay main_notice">
						
			</div>
		</div>

		
		<div class="wid-5">
			<div id="yeoncha_div">
				<h3>연차사용 내역</h3>
				<p class="cap-p">
				부여연차 :<span id="user_leave"></span>
				포상연차 :<span id="prize_leave"></span>
				야근연차 :<span id="over_leave"></span>
				사용연차 :<span id="use_leave"></span> 
				<!-- 조퇴차감연차 :<span id="early_leave"></span>  -->
				잔여연차 : <span id="result_leave"></span>
			
				</p>
				<div class="main_notice2">
				<table class="board-lay">
					<tr>
						<td>작성일</td>
						<td>사용일</td>
						<td>구분</td>
						<td>사유</td>
						<td>소모</td>
					</tr>
					<tbody id="myYeonChaHistory">
					
					</tbody>
				</table>
				</div>
				
			</div>
		</div>
	</div>
<!-- =============================  켈린더 영역 시작 =============================  -->

	 
	<div class="mu_contents_lr calendar_area">
		<div class="mu_contents">
			<div class="content">
				<div class="calendar_top half_cont">
					<ul class="gochk-ul">
					 	<li><input type="checkbox" id="google_chk" name="google_chk" onchange="getUserLeave();" checked="checked"><label for="google_chk">구글 캘린더</label> </li>
					 	<li><input type="checkbox" id="leave_chk" name="leave_chk" onchange="getUserLeave();" checked="checked"><label for="leave_chk">연차 캘린더</label> </li>
					 	<li><input type="checkbox" id="none_leave_chk" name="none_leave_chk" onchange="getUserLeave();"><label for="none_leave_chk">미결재 연차 캘린더</label> </li>
					 </ul>
						 
					<div class="c_year">
				            <!-- label은 마우스로 클릭을 편하게 해줌 -->
			            <div class="cal_btn btn_left"><span onclick="prevCalendar()" class="arrow_l"></span> </div>
			            <span id="tbCalendarYM">
			                yyyy년 m월</span>
			            <div class="cal_btn btn_right"><span onclick="nextCalendar()" class="arrow_r"></span></div>
				    </div>
					<div class="mu_money popup_wrap">
						<div class="background">
							<div class="window">
							    <div class="popup">
							    	<div class="pop_cont_wrap">
							    		<h5>캘린더 생성</h5>
								  		<div class="pop_cont n1">
							  				<h3>타이틀</h3>
								  			<div class="mu_drop">
												<input type="text" class="gr_type">
											</div>
								  		</div>
								  		<div class="pop_cont n2 half_cont">
								  			<div class="pop_left">
								  				<h3>시작일</h3>
												<div class="mu_calender gr_line_w">
													<input type="text" class="date-i">
												</div>
											</div>
											<div class="pop_right">
												<h3>종료일</h3>
												<div class="mu_calender gr_line_w">
													<input type="text" class="date-i">
												</div>
											</div>
								  		</div>
								  		<div class="pop_cont n3 half_cont">
								  			<div class="popup_btn n1">
										        <button type="button" class="close_btn">취소</button>
										    </div>
										    <div class="popup_btn n2">
										        <button type="button" class="mu_add">생성</button>
										    </div>
							  			</div>
							    	</div>
							  	</div>
						    </div>
						</div>
				    </div>
				</div>
				<div class="calendar_slide">
				    <table id="calendar">
				        <tr id="c_day">
				            <td align="center">일 </td>
				            <td>월</td>
				            <td>화</td>
				            <td>수</td>
				            <td>목</td>
				            <td>금</td>
				            <td>토</td>
				        </tr>
				    </table>
				</div>
				<div class="mu_money popup_wrap">
					<div class="background">
						<div class="window">
						    <div class="popup_2">
						    	<div class="pop_cont_wrap">
						    		<h5>캘린더 수정</h5>
							  		<div class="pop_cont n1">
						  				<h3>타이틀</h3>
							  			<div class="mu_drop">
											<input type="text" class="gr_type">
										</div>
							  		</div>
							  		<div class="pop_cont n2 half_cont">
							  			<div class="pop_left">
							  				<h3>시작일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" class="date-i">
											</div>
										</div>
										<div class="pop_right">
											<h3>종료일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" class="date-i">
											</div>
										</div>
							  		</div>
							  		<div class="pop_cont n3 half_cont">
							  			<div class="popup_btn n1">
									        <button type="button" class="close_btn">취소</button>
									    </div>
									    <div class="popup_btn n2">
									        <button type="button" class="mu_add">수정</button>
									    </div>
						  			</div>
						    	</div>
						  	</div>
					    </div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- =============================  켈린더 영역 끝 =============================  -->
	<div class="popup-wr">
		<div class="popup-box">
			<div class="closeBtn">
				<input type="button" value="닫기" class="attachClose">
			</div>
			<div class="poparea"></div>
		</div>
	</div>
</div>


<script>
$(document).ready(function(){	
	buildCalendar();
	getUserLeave();
});
//달력

var start_day = "";
var end_day = "";
var year = "";
var month = "";
var today = new Date(); //오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
var date = new Date(); //today의 Date를 세어주는 역할


function prevCalendar() { //이전 달
    today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
    buildCalendar(); 
    getUserLeave();
}

function nextCalendar() { //다음 달
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
    buildCalendar(); 
    getUserLeave();
}

var day_arr = new Array();
function getUserLeave()
{
	/*
	google_chk
	leave_chk
	*/
	
	var google_chk= document.getElementById("google_chk").checked == true ? 'Y' : 'N';
	var leave_chk=document.getElementById("leave_chk").checked == true ? 'Y' : 'N';
	var none_leave_chk=document.getElementById("none_leave_chk").checked == true ? 'Y' : 'N';
	
	/*
	if (google_chk=='N' && leave_chk=='N' && none_leave_chk=='N') 
	{
		$('.day .cal-line').remove();
		return;
	}
	*/
	
	var cal_mon = today.getMonth()+1;
	var cal_year = today.getFullYear();
	if (cal_mon < 10) 
	{
		cal_mon = '0'+cal_mon;
	}
	start_loading();
	
	$.ajax({
		type : "POST", 			
		url : "./getUserLeave",	
		dataType : "text", 		
		data : 
		{
			cal_year: cal_year,
			cal_mon : cal_mon,
			google_chk : google_chk,
			leave_chk : leave_chk,
// 			google_chk : 'Y',
// 			leave_chk : 'Y',
			none_leave_chk : none_leave_chk
		},
		error : function()
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			
			day_arr = new Array(); 		// 총 날짜 저장용 배열
			var mid_day= new Array(); 		// 중간값 저장용 배열
			
			var temp="";					// 조회용 임시 저장 변수
			var sdt=null;					// start_ymd 값 저장할 데이트 객체 
			var edt=null;					// end_ymd 값 저장할 데이트 객체 
			var tdt=null;					// start_ymd ~ end_ymd 중간값 저장할 데이트 객체 
			var dateDiff=null;				// 날짜 차이별 width 계산용 변수
			var empty_chk_test='<div class="cal-line cal-line02" style="background-color: transparent;"></div>';
			if(result.list.length > 0)
			{
				$('.day .cal-line').remove();
				// 날짜 저장용 배열에 최대 31일 세팅
				for (var i = 1; i < 32; i++) {
					// 날짜 저장용 배열에 저장용 2차원 배열 선언
					day_arr[i] = new Array();
				}
				
				var push_flag=0;
				
				for(var i = 0; i < result.list.length; i++)
				{
					push_flag=0;
					
					//연차 시작/종료일 날짜 객체로 선언
					sdt = new Date(result.list[i].start_ymd);
					edt = new Date(result.list[i].end_ymd);
					
					dateDiff = Math.ceil((edt.getTime()-sdt.getTime())/(1000*3600*24));
					temp = result.list[i].start_ymd.split('-');
					//inner='<div class="cal-line target_cnt_'+i+'" onclick="target_schedule_pop('+i+')" style="background-color:'+result.list[i].user_color+'; width:'+(dateDiff+1)+'00%">'+result.list[i].kor_nm+'('+result.list[i].level_nm+')'+result.list[i].leave_type+'|'+result.list[i].start_ymd+'|'+result.list[i].end_ymd+'</div>';
					inner='<div class="cal-line target_cnt_'+i+'" onclick="target_schedule_pop('+i+')" style="background-color: #'+result.list[i].user_color+';">'+result.list[i].kor_nm+' '+result.list[i].level_nm+' '+result.list[i].leave_type+'</div>';
					
					
					
					for (var o = 0; o < 20; o++) {
						if (nullChk(day_arr[(temp[2]*1)][o])=='' || nullChk(day_arr[(temp[2]*1)][o]).indexOf('emptyp_chk')==1) 
						{
							day_arr[temp[2]*1][o]=inner;
							push_flag = o;
							//순차적으로 들어가기 위한 break
							break;
						}
					}
					
					
					//범위가 있는 연차라면 중간 값 세팅을 위한 로직
					//중복된 날짜가 있다면 2차원 배열에 값이 있는지 없는지 체크하여 최대 9번쨰 방까지 1을 채워준다
					var empty_chk='';
					if (result.list[i].start_ymd != result.list[i].end_ymd) 
					{
						//중간 값 뽑는 함수를 통해 중간 값 뽑아 저장
						mid_day = getDatesStartToLast(result.list[i].start_ymd,result.list[i].end_ymd); // getDatesStartToLast() 배열 리턴함
						//뽑힌 값 만큼 반복문 수행
						for (var j = 0; j < mid_day.length; j++) {
							//시작값과 비교하기 위해 날짜 객체로 선언
							tdt = new Date(mid_day[j]);
							if (tdt > sdt) 
							{
								temp = mid_day[j].split('-');	//시작 중간 끝, 날짜 뽑아냄
								var imsi=''; //220216 HEX코드 문제 찾기 전까지 임시로 반영
								if(result.list[i].user_color.indexOf('#') == -1){
									imsi='#';
								}

								inner = '<div class="cal-line cal-line02" style="background-color: '+imsi+result.list[i].user_color+';"></div>';
								day_arr[temp[2]*1][push_flag]=inner;
							
								for (var t = 0; t < (push_flag+1); t++) {
									if (nullChk(day_arr[temp[2]*1][t])=='') 
									{
										day_arr[temp[2]*1][t]='<div class="cal-line cal-line02 emptyp_chk" style="background-color: transparent;"></div>';
									}
								}
								
							}
						}
					}
				} //end for문
				
				var cnt=0;
				var empty_cnt=0;
				for (var i = 1; i < 32; i++) {
					if (day_arr[i].length > 0) 
					{
						inner='';
						cnt=0;
						empty_cnt=0;
						
						for (var j = 0; j < 20; j++) {
							if (nullChk(day_arr[i][j])) 
							{
								
								if (day_arr[i][j].length > 100) 
								{
									cnt++;
								}
								else
								{
									empty_cnt++;
								}
								
// 								if (
// 									  cnt > 1 &&
// 									  (cnt + empty_cnt) > 5
// 									) 
// 								{
// 									inner +='<div class="cal-line cal-more" style="color:black; width:100%" onclick="schedule_pop(\''+cal_year+'\',\''+cal_mon+'\',\''+i+'\')">'+(day_arr[i].length+1 - (cnt + empty_cnt))+'개 더보기  </div>';
// 									//inner +='<div class="cal-line" style="background-color:#000; color:white; width:100%" onclick="schedule_pop('+day_arr+')">'+(day_arr[i].length+1 - (cnt + empty_cnt))+'개 더보기  </div>';
// 									break;
// 								}
								
// 								else
// 								{
									
// 									//2022-03-07 하나만 있을 때 깨지는 거 수정
// 									if (day_arr[i].length == 2 && nullChk(day_arr[i][0])=='') 
// 									{
// 										day_arr[i][0] = '<div class="cal-line cal-line02 emptyp_chk" style="background-color: transparent;"></div>';
// 										inner += day_arr[i][0];	
// 									}

									$('.'+cal_year+'-'+cal_mon+'-'+(i < 10 ? '0' + i : i)+'-allbtn').show();
									inner += day_arr[i][j];	
//								}
							}
						}
						
						
						//데이터 세팅 부
						if (i < 10) {
							$('.'+cal_year+'-'+cal_mon+'-0'+i).append(inner);
						}
						else
						{
							$('.'+cal_year+'-'+cal_mon+'-'+i).append(inner);	
						}
					}
				}
				$('.'+cal_year+'-'+cal_mon+'-'+i).css("padding-top","0px")
			}
			else
			{
				buildCalendar();
			}
			
			end_loading();
		}
	});	
}

function schedule_pop(target_year,target_mon,target_day){
	var inner ="";
	for (var i = 0; i < day_arr[target_day].length; i++) {
		if (day_arr[target_day][i].length > 100) 
		{
			inner += day_arr[target_day][i];
		}
	}
	$(".popup-wr").show();
	$(".poparea").html(inner);
}
$(".attachClose").on("click",function(){
	$(".popup-wr").hide();
})

function target_schedule_pop(target_cnt){
	var inner =$('.target_cnt_'+target_cnt).html();
	//alert(inner);
}

</script>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
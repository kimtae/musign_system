<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
var now_date =new Date();
var now_year = now_date.getFullYear();
var now_month = now_date.getMonth();
var now_day = now_date.getDate();
var date_cnt=0;

$( document ).ready(function() {
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
			console.log(data);
			var result = JSON.parse(data);
			console.log(result);
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
			console.log(data);
			var result = JSON.parse(data);
			console.log(result);
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
			console.log(data);
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
					result_leave =  (user_leave + over_leave + prize_leave) - (result_use_leave + early_leave);
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
	<div id="calendar">
	</div>
</div>



<script>
/*
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      googleCalendarApiKey: 'AIzaSyDO5Zr6N9xDLUmMZGk1s3yh1tmqTWdoJY4',
    
      eventLimit: true,
      eventLimitText: "more",
      eventLimitClick: "popover",
      editable: false,
      droppable: false,
      dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
      events: [
    	  {
    	 	"title": 'All Day Event',
    	  	"start": '2021-09-10',
    	  	"end" : '2021-09-13'
    	  },
    	  {
    	  	"title": 'All Day Event2',
    	  	"start": '2021-09-10',
    	  },
			
    	],
      eventSources: [
          {
        	  googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
                  , className : "koHolidays"
                  , color : "#FF0000"
                  , textColor : "#FFFFFF"
          },
        ]
    });
    calendar.render();
  });
  */
  

  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      googleCalendarApiKey: 'AIzaSyDO5Zr6N9xDLUmMZGk1s3yh1tmqTWdoJY4',
	      eventLimit: true,
	      eventLimitText: "more",
	      eventLimitClick: "popover",
	      editable: false,
	      droppable: false,
	      events:function(info, successCallback, failureCallback){
	    	  
	    	  
		      
	    	  
// 	            $.ajax({
// 	                   url: './getUserLeave',
// 	                   dataType: 'text',
// 	                   success: 
// 	                       function(data) {
// 	                           var events = [];
// 	                           if(data!=null){
// 	                        	   var result = JSON.parse(data);
// 	                        	   if (result.list.length > 0) 
// 	                        	   {
// 										for (var i = 0; i < result.list.length; i++) {
// 											events.push({
// 	                                               title: result.list[i].kor_nm+"("+result.list[i].level_nm+")"+result.list[i].leave_type,
// 	                                               start: result.list[i].start_ymd+" 08:30:00",
// 	                                               end: result.list[i].end_ymd+" 18:30:00",
// 	                                                 // url: "${pageContext.request.contextPath }/detail.do?seq=",
// 	                                               color: result.list[i].user_color         
	                                               
// 	                                            }); //.push()
// 										}
// 									}
// 	                        	   /*
// 	                        	   if (result.google_list.length > 0) 
// 	                        	   {
// 	                        		   for (var i = 0; i < result.google_list.length; i++) {
// 											events.push({
// 	                                               title: result.google_list[i].cont,
// 	                                               start: result.google_list[i].start_ymd+" 08:30:00",
// 	                                               end: result.google_list[i].end_ymd+" 18:30:00",
// 	                                                 // url: "${pageContext.request.contextPath }/detail.do?seq=",
// 	                                               color: "blue"     
	                                               
// 	                                            }); //.push()
// 										}
// 								   }
// 	                        	   */
	                        	   
// 	                               console.log(events);
// 	                           }//if end                           
// 	                           successCallback(events);                               
// 	                       }//success: function end                          
// 	            }); //ajax end,
	            
	          
	        }, //events:function end
	      eventSources: [
	          {
	        	  googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
	                  , className : "koHolidays"
	                  , color : "#f7c3c3"
	          },
	        ]
	    });
	    calendar.render();
	    
	  });

  


 window.onload = function () {
	 

	 
	 $('.koHolidays').find('fc-event-title').css('color','blue');
 }
  </script>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
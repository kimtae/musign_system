<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

/* 드롭다운 */
$(document).ready(function(){
	var dropDiv2 = $('.mu_drop');
	var dropBt2 = $(".mu_drop button");
	$.each(dropDiv2, function(idex, item){		
		var dropUl2 = $(this).find("ul");
		$(this).find('button').on("click",function(){
			dropUl2.toggle();
		});
		dropUl2.click(function(){
			$(this).hide();
		});
	});	
	
	/* 선택한 드롭다운 확인 */
	var dropDiv = $('.mu_drop');
	$.each(dropDiv, function(index, item){
		var _this = $(this);
		$(this).find('ul li').click(function(){
			var dropTxt = $(this).text();
			_this.find('button').text(dropTxt);
		});		
	});
});



/* 팝업창 */
	
	$(document).ready(function(){
		
		var popup = $('.popup_wrap');
		var addBtn = popup.find($('.add_item'));
		var closeBtn = popup.find($('.close_btn'));
		addBtn.click(function(){
			$(this).siblings('div').toggleClass('show');
		})
		closeBtn.click(function(){
			$(this).parents('.background.show').removeClass('show');
		})
	})

	
	
/* 상단_탭메뉴 */
$(document).ready(function(){
	
	var mu_Tab = $('.mu_tabs > li');
	var mu_Con = $('.mu_contents_lr');
	
	$.each(mu_Tab, function(index, item){
		$(this).click(function(){
			mu_Tab.removeClass('on');
			$(this).addClass('on');
							
			mu_Con.removeClass('on');
			mu_Con.eq(index).addClass('on');
				
		});
	});
});


</script>

<!-- 유지보수 상세 페이지 - 캘린더 -->
<!-- <div id="wrap">		
	<div class="mu_content">
		<div class="mu_inner">
			
		</div>
	</div>
</div> -->



<div class="mu_contents_lr calendar_area fr_main fr_cal">
	<div class="mu_contents">
		<div class="content">
			<div class="calendar_top half_cont">
				<div class="c_year">
			            <!-- label은 마우스로 클릭을 편하게 해줌 -->
		            <div class="cal_btn btn_left"><span onclick="prevCalendar()" class="arrow_l"></span> </div>
		            <span id="tbCalendarYM">
		                yyyy년 m월</span>
		            <div class="cal_btn btn_right"><span onclick="nextCalendar()" class="arrow_r"></span></div>
			    </div>
				<div class="mu_money popup_wrap">
					<button type="button" class="add_item wide_btn show" style="display: none;">캘린더 추가</button>
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
	
		
		
		
<script>

var day_arr = new Array();
function getUserLeave()
{
	/*
	google_chk
	leave_chk
	*/
	
	var google_chk=  'N';
	var leave_chk='Y' ;
	var none_leave_chk= 'Y' ;
	
	if (google_chk=='N' && leave_chk=='N' && none_leave_chk=='N') 
	{
		$('.day .cal-line').remove();
		return;
	}
	
	var cal_mon = today.getMonth()+1;
	var cal_year = today.getFullYear();
	if (cal_mon < 10) 
	{
		cal_mon = '0'+cal_mon;
	}
	start_loading();
	
	$.ajax({
		type : "POST", 			
		url : "/family/getUserLeave",	
		dataType : "text", 		
		data : 
		{
			cal_year: cal_year,
			cal_mon : cal_mon,
			google_chk : google_chk,
			leave_chk : leave_chk,
			none_leave_chk : none_leave_chk,
			
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
			
			day_arr = new Array(); 		// 총 날짜 저장용 배열
			var mid_day= new Array(); 		// 중간값 저장용 배열
			
			var temp="";					// 조회용 임시 저장 변수
			var sdt=null;					// start_ymd 값 저장할 데이트 객체 
			var edt=null;					// end_ymd 값 저장할 데이트 객체 
			var tdt=null;					// start_ymd ~ end_ymd 중간값 저장할 데이트 객체 
			var dateDiff=null;				// 날짜 차이별 width 계산용 변수
			
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
					//1일 한개만 있는 경우
					inner='<div class="cal-line target_cnt_'+i+'" onclick="target_schedule_pop('+i+')" style="background-color:'+result.list[i].user_color+';">'+result.list[i].kor_nm+' '+result.list[i].level_nm+' '+result.list[i].leave_type+'</div>';
					
					for (var o = 0; o < 20; o++) {
						if (nullChk(day_arr[(temp[2]*1)][o])=='') 
						{
							day_arr[temp[2]*1][o]=inner;
							push_flag = o;
							//순차적으로 들어가기 위한 break
							break;
						}
					}
					
					//범위가 있는 연차라면 중간 값 세팅을 위한 로직
					//중복된 날짜가 있다면 2차원 배열에 값이 있는지 없는지 체크하여 최대 9번쨰 방까지 1을 채워준다
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
								inner = '<div class="cal-line cal-line02 target_cnt_'+i+'" style="background-color:'+result.list[i].user_color+';"></div>';
								day_arr[temp[2]*1][push_flag]=inner;
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
								
								if (
									  cnt > 1 &&
									  (cnt + empty_cnt) > 5
									) 
								{
									//2일 이상 있는 경우
									inner +='<div class="change_item cal-line cal-more" style="color:black; width:100%" onclick="schedule_pop(\''+cal_year+'\',\''+cal_mon+'\',\''+i+'\')">'+(day_arr[i].length+1 - (cnt + empty_cnt))+'개 더보기  </div>';
									//inner +='<div class="cal-line" style="background-color:#000; color:white; width:100%" onclick="schedule_pop('+day_arr+')">'+(day_arr[i].length+1 - (cnt + empty_cnt))+'개 더보기  </div>';
									break;
								}
								else
								{
									inner += day_arr[i][j];	
								}
							}
						}
						
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
			

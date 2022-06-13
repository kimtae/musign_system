<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<link rel="stylesheet" type="text/css" href="/inc/css/jquery.datetimepicker.css">
<script src="/inc/js/jquery.datetimepicker.full.min.js"></script>

<script>




$(document).ready(function(){
	
	var today = new Date();
	var yesterday = new Date(today.setDate(today.getDate() - 1));
	
	var year = yesterday.getFullYear();
	var month = ('0' + (yesterday.getMonth() + 1)).slice(-2);
	var day = ('0' + yesterday.getDate()).slice(-2);

	var dateString = year + '-' + month  + '-' + day;
	$('#start_ymd').val(dateString);
	$('#end_ymd').val(dateString);
	getList();
})


function getList()
{
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getGuntaeList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $('#list_size').val(),
			search_name : $('#user_name').val(),
			start_ymd : $('#start_ymd').val(),
			end_ymd : $('#end_ymd').val(),
			day_status : $('#day_status').val()
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
			if(result.list.length > 0)
			{
				//$("#list_target").empty();
				for(var i = 0; i < result.list.length; i++)
				{
					//if ("${isManager}") 
					if("${login_team_nm}"=='경영지원')
					{
						inner +='<tr>';
						inner +='	<td>'+(i+1)+'</td>';
						inner +='	<td>'+result.list[i].kor_nm+'</td>';
						inner +='	<td>'+result.list[i].submit_year+'</td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_min_time" class="date_time_picker" value="'+nullChk(result.list[i].min_time)+'" style="width:100%"> </td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_max_time" class="date_time_picker" value="'+nullChk(result.list[i].max_time)+'" style="width:100%"> </td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_late_time" class="time_picker" value="'+nullChk(result.list[i].late_time)+'" style="width:100%"> </td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_over_work_time" class="time_picker" value="'+nullChk(result.list[i].over_work_time)+'" style="width:100%"> </td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_over_night_work_time" class="time_picker" value="'+nullChk(result.list[i].over_night_work_time)+'" style="width:100%"> </td>';
						inner +='	<td> <input type="text" id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_whole_work_time" class="time_picker" value="'+nullChk(result.list[i].whole_work_time)+'" style="width:100%"> </td>';
						inner +='	<td>';
						inner +='		<select id="'+result.list[i].user_idx+'_'+result.list[i].submit_year+'_day_status" value="'+result.list[i].day_status+'">';
						inner +='			<option value="정상출근" '+(result.list[i].day_status=="정상출근" ? "selected" : "")+' >정상출근</option>';
						inner +='			<option value="무단퇴근" '+(result.list[i].day_status=="무단퇴근" ? "selected" : "")+'>무단퇴근</option>';
						inner +='			<option value="지각" '+(result.list[i].day_status=="지각" ? "selected" : "")+'>지각</option>';
						inner +='			<option value="결근" '+(result.list[i].day_status=="결근" ? "selected" : "")+'>결근</option>';
						inner +='			<option value="주말" '+(result.list[i].day_status=="주말" ? "selected" : "")+'>주말</option>';
						inner +='			<option value="공휴일" '+(result.list[i].day_status=="공휴일" ? "selected" : "")+'>공휴일</option>';
						inner +='			<option value="연차" '+(result.list[i].day_status=="연차" ? "selected" : "")+'>연차</option>';
						inner +='			<option value="오후반차" '+(result.list[i].day_status=="오후반차" ? "selected" : "")+'>오후반차</option>';
						inner +='			<option value="오전반차" '+(result.list[i].day_status=="오전반차" ? "selected" : "")+'>오전반차</option>';
						inner +='			<option value="조퇴" '+(result.list[i].day_status=="조퇴" ? "selected" : "")+'>조퇴</option>';
						inner +='			<option value="병가" '+(result.list[i].day_status=="병가" ? "selected" : "")+'>병가</option>';
						inner +='			<option value="경조사" '+(result.list[i].day_status=="경조사" ? "selected" : "")+'>경조사</option>';
						inner +='			<option value="예비군" '+(result.list[i].day_status=="예비군" ? "selected" : "")+'>예비군</option>';
						inner +='			<option value="교육" '+(result.list[i].day_status=="교육" ? "selected" : "")+'>교육</option>';
						inner +='			<option value="기타" '+(result.list[i].day_status=="기타" ? "selected" : "")+'>기타</option>';
						
						inner +='		</select>';
						inner +='	</td>';
						
						inner +='   <td> <input type="button" value="저장" onclick="uptUserGuntae(\''+result.list[i].user_idx+'\',\''+result.list[i].submit_year+'\');"></td>';
						inner +='</tr>';
					}
					else
					{
						inner +='<tr>';
						inner +='	<td>'+(i+1)+'</td>';
						inner +='	<td>'+result.list[i].kor_nm+'</td>';
						inner +='	<td>'+result.list[i].submit_year+'</td>';
						inner +='	<td>'+nullChk(result.list[i].min_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].max_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].late_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].over_work_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].over_night_work_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].whole_work_time)+'</td>';
						inner +='	<td>'+nullChk(result.list[i].day_status)+'</td>';
						inner +='	<td></td>';
						inner +='</tr>';
					}
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="11"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".pro-pagenation").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			
			jQuery('.date_time_picker').datetimepicker({
				  format:'Y-m-d H:i:'+'00',
				  lang:'kr'
			});
			
			jQuery('.time_picker').datetimepicker({
				  datepicker:false,
				  format:'H:i:'+'00',
				  lang:'kr'
			});
			
			end_loading();
		}
	});
}

function uptUserGuntae(user_idx,submit_year)
{
	var min_time=$("#"+user_idx+"_"+submit_year+"_min_time").val();
	var max_time=$("#"+user_idx+"_"+submit_year+"_max_time").val();
	var late_time=$("#"+user_idx+"_"+submit_year+"_late_time").val();
	var over_work_time=$("#"+user_idx+"_"+submit_year+"_over_work_time").val();
	var over_night_work_time=$("#"+user_idx+"_"+submit_year+"_over_night_work_time").val();
	var whole_work_time=$("#"+user_idx+"_"+submit_year+"_whole_work_time").val();
	var day_status=$("#"+user_idx+"_"+submit_year+"_day_status").val();
	


	
	$.ajax({
		type : "POST", 
		url : "./uptGuntaeData",
		dataType : "text",
		async : false,
		data : 
		{
			user_idx : user_idx,
			submit_year : submit_year,
			min_time : min_time,
			max_time : max_time,
			late_time : late_time,
			over_work_time : over_work_time,
			over_night_work_time : over_night_work_time,
			whole_work_time : whole_work_time,
			day_status : day_status
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
		}
		
	});
}


</script>



<div id="container">
	<div class="musign-grid guntae_responsive">
	<div class="search-wr">
		<div class="table">
			<div class="wid-4 guntae_date">
				<div class="table">
					<div class="mid-da">
						<input id="start_ymd" class="date-i" name="start_ymd">일
					</div>
					<div class="mid-s">~</div>
					<div class="mid-da">	
						<input id="end_ymd" class="date-i" name="end_ymd">일	
					</div>
				</div>
			</div>
			
			<div class="wid-3 guntae_name">
				<input class="wid-10" type="text" id="user_name" name="user_name" placeholder="이름">
			</div>
			
			<div class="wid-3 guntae_all guntae_selectBox">
				<select id="day_status" class="drop_open selectBox_M" name="day_status">
					<option value="">전체</option>
					<option value="정상출근">정상출근</option>
					<option value="무단퇴근">무단퇴근</option>
					<option value="지각">지각</option>
					<option value="결근">결근</option>
					<option value="주말">주말</option>
					<option value="공휴일">공휴일</option>
					
					<option value="연차">연차</option>
					<option value="오후반차">오후반차</option>
					<option value="오전반차">오전반차</option>
					<option value="조퇴">조퇴</option>
					<option value="병가">병가</option>
					<option value="경조사">경조사</option>
					<option value="예비군">예비군</option>
					<option value="교육">교육</option>
					<option value="기타">기타</option>
				</select>
				
				<select id="list_size" name="list_size" onchange="getList();">
					<option value="10" selected="selected">10개 보기</option>
					<option value="20" >20개 보기</option>
					<option value="50" >50개 보기</option>
					<option value="100" >100개 보기</option>
					<option value="1000" >1000개 보기</option>
				</select>	
				
			</div>
			<div class="wid-2 guntae_sch">	
				<input type="button" value="검색" onclick="javascript:page=1; getList();" class="btn btn01">
			</div>
			
			
		</div>
		
	</div>
	<table class="board-lay guntae_responsive">
		<tr>
        	<th>번호</th>
        	<th onclick="reSortAjax('sort_kor_nm');">이름</th>
        	<th onclick="reSortAjax('sort_submit_year');">출근일</th>
        	<th onclick="reSortAjax('sort_min_time');">출근 시간</th>
        	<th onclick="reSortAjax('sort_max_time');">퇴근 시간</th>
        	<th onclick="reSortAjax('sort_late_time');">지각 시간</th>
        	<th onclick="reSortAjax('sort_over_work_time');">연장 근무</th>
        	<th onclick="reSortAjax('sort_over_night_work_time');">야간 근무</th>
        	<th onclick="reSortAjax('sort_whole_work_time');">전체 근무 시간</th>
        	<th onclick="reSortAjax('sort_day_status');">상태</th>
        	<th></th>
		</tr>
  		<tbody id="list_target">
  		
  		</tbody>
	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>


<script>
var isManager = "<%=session.getAttribute("isManager")%>";

/*
if (isManager == null || isManager == "null" || isManager!='Y') {
	alert("권한이 없습니다.");
	location.href = "/main";
}
*/

$(document).ready(function(){	
	getList();
})

window.onload = function(){ 
	if (isManager!='Y') 
	{
		$('.search-wr').hide();
		$('.save_btn').hide();
	}
}


var edit_value="";
var user_idx_arr="";
function getList(){
	
	
	var use_yn="N";
	if(document.getElementById("search_use_yn").checked) 
	{
	    use_yn='Y';
	}
	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getLeaveUserList",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}",
			search_name : $('#search_name').val(),
			search_team : $('#search_team').val(),
			search_chmod : $('#search_chmod').val(),
			search_level : $('#search_level').val(),
			targetYear : '',
			
			search_use_yn : use_yn
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
			var ori_over_leave = 0;
			var prize_leave = 0;
			var use_leave = 0;
			var use_cancel_leave = 0;
			
			var early_leave = 0;				var early_cnt = 0;
			var early_cancel_leave = 0;			var early_cancel_cnt = 0;
			var half_leave = 0;					var half_cnt = 0;
			var half_cancel_leave = 0;			var half_cancel_cnt= 0;
			var result_leave =0;
			var ori_result_leave=0;
			
			for(var i = 0; i < result.list.length; i++)
			{
				user_idx_arr += result.list[i].user_idx+"|"
				 
				//부여연차
				user_leave			= Number(result.list[i].user_leave);	
				over_leave 			= Number(result.list[i].over_leave);															//야근연차
				ori_over_leave 		= Number(result.list[i].ori_over_leave);		
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
				result_use_leave = (use_leave  + half_leave + early_leave ) - use_cancel_leave 
				
				 //전여연차 (부여연차 + 야근연차 + 포상연자 + 사용취소연차) - (사용연차  + 조퇴연차 + 반차사용연차)
				//result_leave =  (user_leave + over_leave + prize_leave + use_cancel_leave) - (use_leave + early_leave + half_leave);
				
// 				if (result.list[i].NAME=="김진오") 
// 				{
// 					console.log("user_leave : "+user_leave);
// 					console.log("ori_over_leave : "+ori_over_leave);
// 					console.log("prize_leave : "+prize_leave);
// 					console.log("result_use_leave : "+result_use_leave);
// 					console.log("early_leave : "+early_leave);
// 				}
				
				result_leave =  (user_leave + over_leave + prize_leave) - (result_use_leave );
				ori_result_leave = (user_leave + ori_over_leave + prize_leave) - (result_use_leave + early_leave);
				
				
				/*
				2022-04-26
				요청으로 인해 경여지원 팀이면 무조건 관리자 권한 가지도록 수정
				*/
			
				
				
				// *노출조건
				//1.접속자가 관리자가 아니라면 각각 
				//2.대표라면 전체 직원의 연차가
				//3.본부장이라면 대표를 제외한 모든 직원의 연차가
				//4.팀장이라면 자신의 팀의 연차가
				//5.부팀장과 일반 직원이라면 자신의 연차만
				//보이도록 세팅
				if ( 																						
						(isManager!='Y' && "${chmodidx}" == 1) || 											
						(isManager!='Y' && "${chmodidx}" == 2) || 											
						(isManager!='Y' && "${chmodidx}" == 3 && result.list[i].team == "${teamidx}") ||	
						(isManager!='Y' && result.list[i].chmod >= 4 && result.list[i].user_idx == "${myidx}") 				
					) 
				{
					
					inner ="";
					
				}
	
				
				inner +='<tr>';
				inner +='	<td>'+(i+1)+'</td>';
				inner +='	<td onclick="showGuntaeHistory(\''+${idx}+'\',\''+result.list[i].user_idx+'\')">'+result.list[i].NAME+'</td>';
				inner +='	<td>'+result.list[i].team_nm+'</td>';
				inner +='	<td>'+result.list[i].chmod_nm+'</td>';
				inner +='	<td>'+result.list[i].level_nm+'</td>';
				
				//관리자가 연차 수정을 위한 부분
				if (isManager=='Y') 
				{
					//부여연차
					inner +='	<td><input type="text" id="leave_val_'+result.list[i].user_idx+'" value="'+result.list[i].user_leave+'"></td>';
				}
				else
				{
					//일반 직원 부여연차
					inner +='	<td>'+result.list[i].user_leave+'</td>';
				}
				
				//포상연차
				inner +='	<td>'+result.list[i].prize_leave+'</td>';

				//야근연차
				inner +='	<td>'+result.list[i].over_leave+'</td>';
				
				//검증용 야근연차
				//inner +='	<td style="color:red;">'+result.list[i].ori_over_leave+'</td>';
				
				//사용연차
				//inner +='	<td>'+result.list[i].use_leave+'</td>';
				inner +='	<td>'+result_use_leave+'</td>'
				
				//조퇴차감연차
				//inner +='	<td>'+result.list[i].early_leave+'</td>';

				//잔여연차
				inner +='	<td>'+result_leave+'</td>';
				
				//검증용 잔여연차
				//inner +='	<td style="color:red;">'+ori_result_leave+'</td>';
				
				inner +='</tr>';
				
				//접속자가 대표,본부장,팀장 이라면 임시 변수에 해당되는 데이터를 넣는다.
				if ( 
					(isManager!='Y' && "${chmodidx}" == 1) ||
					(isManager!='Y' && "${chmodidx}" == 2 && result.list[i].chmod!=1) ||
					(isManager!='Y' && "${chmodidx}" == 3 && result.list[i].team == "${teamidx}") 
					) 
				{
					temp +=inner;
				}
				//부팀장 or 일반 직원이라면 바로 break
				if (result.list[i].chmod >= 4 && result.list[i].user_idx == "${myidx}" && isManager!='Y') 
				{
					break;
				}
			}
			
			if (isManager!='Y' && ("${chmodidx}" == 3 || "${chmodidx}" == 2 || "${chmodidx}" == 1)) 
			{
				inner=temp;
			}
			
			$("#list_target").html(inner);

			end_loading();
		}
	});
}

function saveLeaveList(){
	if(!confirm("정말 저장하시겠습니까?"))
	{
		return;
	}
	start_loading();
	
	var arr = user_idx_arr.split('|');
	var leave_arr="";
	for (var i = 0; i < arr.length-1; i++) {
		leave_arr +=$('#leave_val_'+arr[i]).val()+'|';
	}
	$.ajax({
		type : "POST", 
		url : "./saveLeaveList",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}",
			leave_arr :leave_arr,
			user_arr :user_idx_arr
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
			location.reload();
		}
	});
}

function showGuntaeHistory(leave_idx,user_idx){
	location.href='/family/leave/user_detail?leave_idx='+leave_idx+'&user_idx='+user_idx;
}

</script>


<div id="container" class="manager">
	<div class="musign-grid">
		<div class="search-wr">
		<form id="searchForm" name="searchForm" autocomplete="off">
			<div class="table">
				<div class="wid-2">
					<input class="wid-10" type="text" id="search_name" name="search_name" placeholder="이름을 입력해주세요.">
				</div>
				
				<div class="wid-2 leave_width">
					팀 &nbsp;&nbsp;: &nbsp;&nbsp; 
					<select id="search_team">
						<option value=''>전체</option>
						<option value="1">HQ</option>
						<option value="2">경영지원</option>
						<option value="3">기획팀</option>
						<option value="4">커뮤니케이션팀</option>
						<option value="5">디자인A팀</option>
						<option value="6">디자인B팀</option>
						<option value="7">개발팀(FRONT)</option>
						<option value="8">개발팀(BACK)</option>
					</select>
				</div>
				
				<div class="wid-2 leave_width">
					직급  &nbsp;&nbsp;: &nbsp;&nbsp; 
					<select id="search_chmod">
						<option value=''>전체</option>
						<option value="1">대표이사</option>
						<option value="2">본부장</option>
						<option value="3">팀장</option>
						<option value="4">부팀장</option>
						<option value="5">일반</option>
					</select>
				</div>
				
				<div class="wid-2 leave_width">
					직책  &nbsp;&nbsp;: &nbsp;&nbsp;  
					<select id="search_level">
						<option value=''>전체</option>
						<option value="1">대표이사</option>
						<option value="2">본부장</option>
						<option value="3">수석</option>
						<option value="4">책임</option>
						<option value="5">선임</option>
						<option value="6">주임</option>
						<option value="7">사원</option>
					</select>
				</div>
				
				<div class="wid-2">
					퇴사자 포함 여부 : <input type="checkbox" id="search_use_yn" style="width:13px;">
				</div>
				<div class="wid-2">	
					<input type="button" value="검색" onclick="getList()" class="btn btn01">
				</div>
				
			</div>
			
		</form>
	</div>
	
       	
    	<table class="board-lay table-comm table-fm">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
    		<tr class="th">
            	<th>No.</th>
            	<th>이름</th>
            	<th>팀</th>
            	<th>직급</th>
            	<th>직책</th>
            	<th>부여연차</th>
            	<th>포상연차</th>
            	<th>야근연차</th>
            	<!-- <th style="color:red;">검증용 야근연차</th>  -->
            	<th>사용연차</th>
            	<!-- <th>조퇴차감연차</th>  -->
            	<th>잔여연차</th>
				<!--<th style="color:red;">검증용 잔여연차</th> -->
    		</tr>
    		<tbody id="list_target">

			</tbody>
    	</table>
    	<input type="button" class="save_btn" value="저장" onclick="saveLeaveList();">
    </div>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>


<script>
var isTeamLeader = "<%=session.getAttribute("login_chmod")%>";
var teamidx = "<%=session.getAttribute("login_team")%>";
if (isTeamLeader == null || isTeamLeader == "null" || isTeamLeader > '3') 
{
	if(teamidx >= 3)
	{
		alert("권한이 없습니다.");
		location.href = "/family/main";
	}
}

$(document).ready(function(){
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	
	var tmp = 1;
	if(month >= 1 && month <= 3){tmp = 1;}
	else if(month >= 4 && month <= 6){tmp = 2;}
	else if(month >= 7 && month <= 9){tmp = 3;}
	else if(month >= 10 && month <= 12){tmp = 4;}
	
	$("#search_year").val(year);
	$("#search_period").val(tmp);
	
	getList();
})


//회원 idx저장용 전역변수 쉽게 쓰려고 선언
var member_idx_list ="";
function getList(val){
	
	var search_year = $("#search_year").val();
	var search_period = $("#search_period").val();
	
	
	var use_yn="N";
	if(document.getElementById("search_use_yn").checked) 
	{
	    use_yn='Y';
	}
	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getTeamList",
		dataType : "text",
		async : false,
		data : 
		{
			//search_name : $('#search_name').val(),
			//start_ymd : $('#start_ymd').val(),
			//end_ymd : $('#end_ymd').val()
			search_name : $('#search_name').val(),
			search_chmod : $('#search_chmod').val(),
			search_level : $('#search_level').val(),
			search_use_yn : use_yn,
			search_year : search_year,
			search_period : search_period
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
			for(var i = 0; i < result.list.length; i++)
			{
				member_idx_list +=result.list[i].idx+'|';
					
				inner +='<tr id="member_'+result.list[i].idx+'">';
				inner +='	<td>'+(i+1)+'</td>';
				inner +='	<td>'+result.list[i].NAME+'</td>';
				
				
				/////teamlist setting start
				inner +='	<td>';
				inner +='		<select id="team_value_'+result.list[i].idx+'" name="team_value">';
				var selected ="";
				for (var j = 0; j < result.teamlist.length; j++)
				{
					selected ="";
					if(result.list[i].team == result.teamlist[j].idx)
					{
						selected = "selected";
					}
						inner +='		<option value="'+result.teamlist[j].idx+'" '+selected+'>'+result.teamlist[j].team_kr+'</option>';
				}
				inner +='		</select>';
				inner +='	</td>';
				/////teamlist setting end
				
				/////chmodlist setting start
				inner +='	<td>';
				inner +='		<select id="chmod_value_'+result.list[i].idx+'" name="chmod_value">';
				for (var k = 0; k < result.chmodlist.length; k++)
				{
					selected ="";
					if(result.list[i].chmod == result.chmodlist[k].idx)
					{
						selected = "selected";
					}
					inner +='		<option value="'+result.chmodlist[k].idx+'" '+selected+'>'+result.chmodlist[k].name+'</option>';
				}
				inner +='		</select>';
				inner +='	</td>';
				/////chmodlist setting end
				
				/////levellist setting start
				inner +='	<td>';
				inner +='		<select id="level_value_'+result.list[i].idx+'" name="level_value">';
				for (var p = 0; p < result.levellist.length; p++)
				{
					selected ="";
					if(result.list[i].level == result.levellist[p].idx)
					{
						selected = "selected";
					}
					inner +='		<option value="'+result.levellist[p].idx+'" '+selected+'>'+result.levellist[p].name+'</option>';
				}
				inner +='		</select>';
				inner +='	</td>';
				/////levellist setting end
				if ("${login_team}"==2) 
				{
					inner +='	<td> <input type="text" class="card_no" id="car_no_'+result.list[i].idx+'" value="'+nullChk(result.list[i].card_no)+'"></td>';
				}
				else
				{
					inner +='	<td> <input type="text" class="card_no" id="car_no_'+result.list[i].idx+'" value="'+nullChk(result.list[i].card_no)+'" readonly></td>';
				}
				inner +='	<td> <input class="date-i" id="sign_value_'+result.list[i].idx+'" value="'+nullChk(result.list[i].regi_date)+'" readonly></td>';
				
				//접속자의 팀이 hq, 기획, 커뮤라면 영업권한 보이게
				if ("${login_team}"==1 || "${login_team}"==2 || "${login_team}"==3 || "${login_team}"==4) 
				{
					inner +='	<td>';
					//불러온 회원의 소속이 hq,기획,커뮤라면 
					if (result.list[i].team_nm == "기획팀" || result.list[i].team_nm == "경영지원" || result.list[i].team_nm=="커뮤니케이션팀" || result.list[i].team_nm=="HQ") 
					{
						
						inner +='		<select id="sale_auth_'+result.list[i].idx+'" name="sale_auth">';
						inner +='			<option value="N" '+((result.list[i].sale_auth=="N") ? "selected" : "")+'>일반</option>';
						inner +='			<option value="R" '+((result.list[i].sale_auth=="R") ? "selected" : "")+'>읽기</option>';
						inner +='			<option value="W" '+((result.list[i].sale_auth=="W") ? "selected" : "")+'>쓰기</option>';
						inner +='			<option value="M" '+((result.list[i].sale_auth=="M") ? "selected" : "")+'>관리</option>';
						inner +='		</select>';
					}
					inner +='	</td>';
				}
				inner +='	<td> <input class="date-i" id="sign_end_value_'+result.list[i].idx+'" value="'+nullChk(result.list[i].leave_date)+'" readonly></td>';
				inner +='	<td><input type="button" value="퇴사" onclick="getOut(\''+result.list[i].idx+'\');" >';
				inner +='	<input type="button" value="KPI" onclick="javascript:location.href=\'/family/kpi/insKpi_leader?idx='+result.list[i].idx+'\'" >';
				inner += '	<span style="width: 120px; display: inline-block;">'
				var tmp = nullChk(result.list[i].step);
				if(tmp == "") {tmp = "작성중";}
				inner +='	'+result.list[i].now_period+'분기 - '+tmp;
				inner += '	</span>'
				inner +='	</td>';
				inner +='</tr>';
			}
			$("#list_target").html(inner);
			
			
			
			dateInit();
			end_loading();
		}
	});
}


function saveMemberInfo(){
	
	if(!confirm("회원 정보를 수정 하시겠습니까?"))
	{
		return;
	}	
	
	var member_team_list = "";
	var member_chmod_list = "";
	var member_level_list = "";
	var member_sign_list = "";
	var member_auth_list = "";
	var member_card_list = "";

	var arr = member_idx_list.split('|');
	
	for (var i = 0; i < arr.length-1; i++) 
	{
		member_team_list += $('#team_value_'+arr[i]).val()+"|";
		member_chmod_list += $('#chmod_value_'+arr[i]).val()+"|";
		member_level_list += $('#level_value_'+arr[i]).val()+"|";
		member_sign_list += $('#sign_value_'+arr[i]).val()+"|";
		member_card_list += $('#car_no_'+arr[i]).val()+"|";
		
		if (nullChk($('#sale_auth_'+arr[i]).val())!="") 
		{
			member_auth_list += $('#sale_auth_'+arr[i]).val()+"|";
		}
		else
		{
			member_auth_list += "N|";
		}
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./updateMemberInfo",
		dataType : "text",
		async : false,
		data : 
		{
			member_idx_list : member_idx_list,
			member_team_list : member_team_list,
			member_chmod_list : member_chmod_list,
			member_level_list : member_level_list,
			member_sign_list : member_sign_list,
			member_auth_list : member_auth_list,
			member_card_list : member_card_list
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
			if (result.isSuc=="success") 
			{
				getList();
			}
		}
	});
}

function getOut(idx){
	
	if(!confirm("퇴사 처리를 하시겠습니까?"))
	{
		return;
	}	
	
	if ($('#sign_end_value_'+idx).val()=='') 
	{
		alert('퇴사일을 설정해주세요.');
		return;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getOut",
		dataType : "text",
		async : false,
		data : 
		{
			idx : idx,
			leave_date : $('#sign_end_value_'+idx).val()
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
			if (result.isSuc=="success") 
			{
				getList();
			}
		}
	});
	
}

</script>


<div id="container" class="manager team_contain">
	
	
	<input type="text" id="search_name" name="search_name" placeholder="이름을 입력해주세요." style="width:157px;">

	직급 &nbsp;&nbsp;:  &nbsp;&nbsp;<select id="search_chmod">
			<option value=''>전체</option>
			<option value="1">대표이사</option>
			<option value="2">본부장</option>
			<option value="3">팀장</option>
			<option value="4">부팀장</option>
			<option value="5">일반</option>
		 </select>	
	<span class="team_responsive">퇴사자 포함 여부 &nbsp;&nbsp; :  &nbsp;&nbsp;<input type="checkbox" id="search_use_yn"> 
	<input type="button" class="team_sch" value="검색" onclick="getList()">	 
	<input type="button" value="저장" onclick="saveMemberInfo();"> 
		&nbsp;&nbsp;&nbsp;&nbsp;KPI &nbsp;&nbsp;:  &nbsp;&nbsp;
		<select id="search_year" onchange="getList('okr')">
			<option value="2022">2022</option>
			<option value="2023">2023</option>
		 </select>	
		<select id="search_period" onchange="getList('okr')">
			<option value="1">1분기</option>
			<option value="2">2분기</option>
			<option value="3">3분기</option>
			<option value="4">4분기</option>
		 </select>	
	</span> 
   	<table class="board-lay table-comm table-fm">
		<colgroup>
			<col width="5%"/>
			<col width=""/>
			<col width=""/>
			<col width=""/>
			<col width=""/>
			<col width="15%"/>
			<col width="8%"/>
			<col width=""/>
			<col width="8%"/>
			<col width=""/>
			
		</colgroup>
   		<tr class="th">
           	<th>No.</th>
           	<th>이름</th>
           	<th>팀</th>
           	<th>직책</th>
           	<th>직급</th>
	      	<th>카드번호</th>
           	<th>입사일</th>
           	<!-- HQ / 기획 / 커뮤 아니면 노출 X -->
           	<c:if test="${login_team eq '1' or login_team eq '2' or login_team eq '3' or login_team eq '4'}">
	           	<th>영업권한</th>
           	</c:if>
	        <th>퇴사일</th>
           	
           	<th></th>
           	
   		</tr>
   		<tbody id="list_target" >

		</tbody>
   	</table>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script src="https://www.lgkids.co.kr/es_all/plugins/jscolor-2.0.5/jscolor.js"></script>
<script>
	

var leader_name_arr = '${leaderList.name}'.split('|');
var leader_chmod_arr = '${leaderList.chmod}'.split('|');
var leader_idx_arr = '${leaderList.idx}'.split('|');
var line_storage_1_arr='${getMyInfo.line_storage_1}'.split('|');
var line_storage_2_arr='${getMyInfo.line_storage_2}'.split('|');
var line_storage_3_arr='${getMyInfo.line_storage_3}'.split('|');
var approval_cnt=0;
$(document).ready(function(){
	
	var email = '${getMyInfo.email}'.split('@');
	$('#email').val(email[0]);
	
	if ('${getMyInfo.line_storage_1}'!= "") {	//저장한 라인1 load
    	for (var i = 0; i < line_storage_1_arr.length-1; i++) {
  			
    		add_approval('1');
    		$("#approval_select_1_"+(approval_cnt-1)).val(line_storage_1_arr[i]);	
    		approval_cnt++;
    	}
	}

	if ('${getMyInfo.line_storage_2}'!="") {	//저장한 라인2 load
    	for (var i = 0; i < line_storage_2_arr.length-1; i++) {
    	
    		add_approval('2');
    		$("#approval_select_2_"+(approval_cnt-1)).val(line_storage_2_arr[i]);	
    		approval_cnt++;
    	}
	}
	
	if ('${getMyInfo.line_storage_3}'!="") {	//저장한 라인3 load
    	for (var i = 0; i < line_storage_3_arr.length-1; i++) {
    	
    		add_approval('3');
    		$("#approval_select_3_"+(approval_cnt-1)).val(line_storage_3_arr[i]);
    		approval_cnt++;
    	}
	}
	
	
})
window.onload = function(){
	$('#level').val("${getMyInfo.level}");
	$('#team').val("${getMyInfo.team}");
}

function add_approval(num)
{
	var chk_value="";	
		chk_value= $("#approval_select_"+num+"_"+(approval_cnt-1)).val();
	if (chk_value=="")
	{
		alert('결재라인을 선택해 주세요.');
		return;
	}
	
	var inner = '';
		inner += '<div id="approval_'+num+'_'+approval_cnt+'" style="display:inline-block;vertical-align:top;">';	
		inner += '	<select class="approval_class line'+num+'" id="approval_select_'+num+'_'+approval_cnt+'" name="approval_chk">';
		inner += '	<option class="approval_option_'+approval_cnt+'"></option>';
    for (var i = 0; i < leader_name_arr.length; i++) 
    {
    	var chker=0;
        $('.line'+num).each(function(){ 
            var appro_chk = $(this).val();
        	if (appro_chk==leader_idx_arr[i]) {
        		chker=1;
    		}
        })
    
        if (chker==0 && "${getMyInfo.idx}" != leader_idx_arr[i]) //선택하지 않았고 라인에 내가 없다면
        {
        	inner += '<option class="approval_option_'+approval_cnt+'" value='+leader_idx_arr[i]+'>'+leader_name_arr[i]+'</option>'
		}
	}
    inner += '</select>';
    inner += '<input type="button" id="approval_btn_'+approval_cnt+'" value="-삭제" class="btn-del" onclick="del_approval('+approval_cnt+','+num+')">';
	inner += '</div>';
    $("#approval_edit"+num).append(inner);
    
    approval_cnt++;
}

function del_approval(idx,num)
{
	$("#approval_"+num+"_"+idx).remove();
}




function fncSubmit(){
	
	var f = document.fncForm;
	
	if (isEmpty(f.email)) 
	{
		alert("메일을 채워주세요.");
		f.email.value = "";
		f.email.focus();
		return false;
	}
	
	/*
	else if (containsHS(f.email)) 
	{
		alert("영문만 가능합니다.");
		f.email.value = "";
		f.email.focus();
		return false;
	}	
	*/
	
	if (isEmpty(f.phone_no1)) 
	{
		alert("전화번호를 채워주세요.");
		f.phone_no1.value = "";
		f.phone_no1.focus();
		return false;
	}
	else if(isNotNumber(f.phone_no1))
	{
		alert("숫자를 채워주세요.");
		f.phone_no1.value = "";
		f.phone_no1.focus();
		return false;
	}
	
	if (isEmpty(f.phone_no2)) 
	{
		alert("전화번호를 채워주세요.");
		f.phone_no2.value = "";
		f.phone_no2.focus();
		return false;
	}
	else if(isNotNumber(f.phone_no2))
	{
		alert("숫자를 채워주세요.");
		f.phone_no2.value = "";
		f.phone_no2.focus();
		return false;
	}
	
	if (isEmpty(f.phone_no3)) 
	{
		alert("전화번호를 채워주세요.");
		f.phone_no3.value = "";
		f.phone_no3.focus();
		return false;
	}
	else if(isNotNumber(f.phone_no3))
	{
		alert("숫자를 채워주세요.");
		f.phone_no3.value = "";
		f.phone_no3.focus();
		return false;
	}
	
	if (f.myColor.value=='FFFFFF') 
	{
		alert("다른 색상을 선택해주세요.");
		f.myColor.value = "";
		f.myColor.focus();
		return false;
	}
	
	if (isEmpty(f.name)) 
	{
		alert("이름을 채워주세요.");
		f.name.value = "";
		f.name.focus();
		return false;
	}
	
	if (isEmpty(f.sign_date)) 
	{
		alert("입사일을 채워주세요.");
		f.sign_date.value = "";
		f.sign_date.focus();
		return false;
	}
	
	var line_value="";
	var line_value_arr_1="";
	var line_value_arr_2="";
	var line_value_arr_3="";
	
    $('.line1').each(function()
    { 
        line_value = $(this).val();
        line_value_arr_1 = line_value_arr_1+line_value+'|';
    })
    
    line_value="";
     $('.line2').each(function()
    { 
        line_value = $(this).val();
        line_value_arr_2 = line_value_arr_2+line_value+'|';
    })
    
    line_value="";
     $('.line3').each(function()
    { 
        line_value = $(this).val();
        line_value_arr_3 = line_value_arr_3+line_value+'|';
    })
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./uptMyInfo",
		dataType : "text",
		data : 
		{
			pw : f.pw.value,
			email : f.email.value+'@musign.net',
			phone1 : f.phone_no1.value,
			phone2 : f.phone_no2.value,
			phone3 : f.phone_no3.value,
			name : f.name.value,
			sign_date : f.sign_date.value,
			team : f.team.value,
			level : f.level.value,
			line_value1 : line_value_arr_1,
			line_value2 : line_value_arr_2,
			line_value3 : line_value_arr_3,
			mycolor : f.myColor.value
			
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
</script>
<div id="container" class="user_edit">
	<div class="musign-grid">
		
    	<form id=fncForm name="fncForm">
    		<div class="btn_wrap ali-right">

    			<input type="button" value="확인" onclick="fncSubmit()" class="btn btn_black01">
    		</div>
        	<table class="board-lay">
        		<tr>
                	<th>이름</th>
                	<td><input type="text" id="name" class="edit_input" name="name" value="${getMyInfo.name}"></td>
        		</tr>
        	
        		<tr>
                	<th width="20%;">아이디</th>
                	<td width="80%;">${getMyInfo.id}</td>
        		</tr>
        		<tr>
                	<th>비밀번호</th>
                	<td><input type="password" id="pw" class="edit_input" name="pw" value=""></td>
        		</tr>
        		<tr>
                	<th>이메일</th>
                	<td><input type="text" id="email" class="edit_input" name="email" value="">@musign.net</td>
        		</tr>
        		
				<tr>
                	<th>전화번호</th>
                	<td>
                		<input id="phone_no1" name="phone_no1" value="${getMyInfo.phone_no1}" maxlength="3" autocomplete="off" readonly="readonly">
							-
						<input id="phone_no2" name="phone_no2" value="${getMyInfo.phone_no2}" maxlength="4" autocomplete="off" readonly="readonly">
							-
						<input id="phone_no3" name="phone_no3" value="${getMyInfo.phone_no3}" maxlength="4" autocomplete="off" readonly="readonly">
                	</td>
        		</tr>
        		
        		<tr>
                	<th>My Color</th>
                	<td>
                		<input class="form-control jscolor" name="myColor" id="myColor" value="${getMyInfo.user_color}" placeholder="색상">
                	</td>
        		</tr>
        		
        		<tr>
                	<th>직급</th>
                	<td>
                		<select id="level" name="level">
							<c:forEach var="i" items="${levelList}" varStatus="loop">
								<option value="${i.idx}">${i.name}</option>
							</c:forEach>
						</select>
                	</td>
        		</tr>
        		<tr>
                	<th>소속</th>
                	<td>
                		<select id="team" name="team">
							<c:forEach var="j" items="${teamList}" varStatus="loop">
								<option value="${j.idx}">${j.team_kr}</option>
							</c:forEach>
						</select>
                	</td>
        		</tr>
				<tr>
        			<th>입사일</th>
        			<td>
						<input type="text" id="sign_date" name="sign_date" value="${getMyInfo.regi_date}"  class="date-i" />
        			</td>
        		</tr>
        		
        		<tr>
        		    <th>결재라인1</th>
    				<td id="approval_edit1">
    					<input type="button" value="추가" class="line_input" onclick="add_approval('1')">
    				</td>
        		</tr>
        		<tr>
        		    <th>결재라인2</th>
    				<td id="approval_edit2">
    					<input type="button" value="추가" class="line_input" onclick="add_approval('2')">
    				</td>
        		</tr>
        		<tr>
        		    <th>결재라인3</th>
    				<td id="approval_edit3">
    					<input type="button" value="추가" class="line_input" onclick="add_approval('3')">
    				</td>
        		</tr>
		

        	</table>    	
    	</form>
    </div>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
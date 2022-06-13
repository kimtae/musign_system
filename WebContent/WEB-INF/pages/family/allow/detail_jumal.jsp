<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>

//불러오기 세팅
$(document).ready(function(){	
	var step = "${step}";
	if (step =='제출' || step=='임시') 
	{
		var f = document.fncForm;
		
		var attach_idx_arr = "${attach_idx}".split("|");
		for (var i = 0; i < attach_idx_arr.length-1; i++) 
		{
			add_attach(attach_idx_arr[i]);
		}
		
		var approval_line_arr = "${approval_line}".split("|");
		temp_line = document.getElementsByName("approval_line");
		for (var i = 0; i < approval_line_arr.length-1; i++) 
		{
			add_approval();
			temp_line[i].value = approval_line_arr[i];
		}
		
		var ref_line_arr = "${ref_line}".split("|");
		temp_line = document.getElementsByName("ref_line");
		for (var i = 0; i < ref_line_arr.length-1; i++) 
		{
			add_ref();
			temp_line[i].value = ref_line_arr[i];
		}
		
		f.jumal_work_day.value = "${work_day}";
		f.jumal_hour1.value = "${work_hour}".substring(0,2);
		f.jumal_hour2.value = "${work_hour}".substring(2,4);
		f.jumal_hour3.value = "${work_hour}".substring(4,6);
		f.jumal_hour4.value = "${work_hour}".substring(6,8);
		
		f.jumal_cont.value = "${cont}";
		
	}
})

function fncSubmit(way)
{
	var f = document.fncForm;
	
	var temp ="";
	temp_line = document.getElementsByName("approval_line");	//결재라인값 세팅
	var approval_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].value!="") 
    	{
    		approval_line += temp_line[i].value+'|';
		}
	}

    temp_line = document.getElementsByName("ref_line");			//참조라인값 세팅
    var ref_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].value!="") {
    		ref_line += temp_line[i].value+'|';
    	}
	}
    
    temp_line = document.getElementsByName("attach_idx");	//첨부문서값 세팅
	var attach_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {

    	if (temp_line[i].innerText!="") {
    		attach_line += temp_line[i].innerText+'|';
		}
	}
    
    
    if (approval_line=="|" || approval_line=="")
    {
		alert("결재라인을 선택해주세요.");
		return;
	}
    
    if (isEmpty(f.jumal_work_day)) 
	{
		alert("지출일을 채워주세요.");
		f.jumal_work_day.value = "";
		f.jumal_work_day.focus();
		return false;
	}
    
    var start_val = Number(f.jumal_hour1.value+f.jumal_hour2.value); //예정근무시간 유효성체크
    var end_val = Number(f.jumal_hour3.value+f.jumal_hour4.value);
    
    if( start_val > end_val || start_val==end_val )
    {
    	alert("근무시간을 조절해주세요.");
    	return false;
    }
    
    if (isEmpty(f.jumal_cont)) 
	{
		alert("출근목적을 채워주세요.");
		f.jumal_cont.value = "";
		f.jumal_cont.focus();
		return false;
	}
    
    f.approval_line_store.value = approval_line;
    f.ref_line_store.value = ref_line;
    f.imsi_yn.value = way;
    f.attach_store.value = attach_line;
    
    f.action="write_jumal";
    f.enctype="";
	start_loading();
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
    		if (data.isSuc=="success") 
    		{
				alert(data.msg);
				location.href="/family/dosign/list";
			}else
			{
				alert(data.msg);
				location.href="/family/main";
			}
    		end_loading();
		}
	});
	
}
</script>


	<table class="board-lay jumal_time">
		<tr>
			<th>예정근무</th>
			<td>
				<input name="jumal_work_day" readonly="readonly" class="date-i jumal_responsive"><span class="jicul_date">일</span> 
				<select name="jumal_hour1">
					<c:forEach var="i" begin="0" end="23" varStatus="loop">
						<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
						<c:if test="${fn:length(loop_index) eq 1}">
							<option value="0${loop_index}">${loop_index}</option>
						</c:if>
						<c:if test="${fn:length(loop_index) ne 1}">
							<option value="${loop_index}">${loop_index}</option>
						</c:if>
					</c:forEach>
				</select>:

   				<select name="jumal_hour2">
   					<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
   				</select>
     
     			<span class="period-cont">~</span><span class="vis-480"></span>
     						 
     			<select name="jumal_hour3">
					<c:forEach var="i" begin="0" end="23" varStatus="loop">
						<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
						<c:if test="${fn:length(loop_index) eq 1}">
							<option value="0${loop_index}">${loop_index}</option>
						</c:if>
						<c:if test="${fn:length(loop_index) ne 1}">
							<option value="${loop_index}">${loop_index}</option>
						</c:if>
					</c:forEach>
     			</select>:
     				
     			<select name="jumal_hour4">
     				<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
     			</select>
			</td>
		</tr>
		<tr>
			<th>출근 목적</th>
			<td>
				<textarea name="jumal_cont"></textarea>
			</td>
		</tr>

	</table>

   	
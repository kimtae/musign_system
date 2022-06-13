<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		
		f.yeonjang_work_day.value = "${work_day}"; 
		f.yeonjang_work_hour1.value = "${work_hour}".substring(0,2);
		f.yeonjang_work_hour2.value = "${work_hour}".substring(2,4);
		f.yeonjang_work_hour3.value = "${work_hour}".substring(4,6);
		f.yeonjang_work_hour4.value = "${work_hour}".substring(6,8);
		f.yeonjang_cont.value = "${cont}";
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

    	if (temp_line[i].value!="") {
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
    
    
    if (isEmpty(f.yeonjang_work_day)) 
	{
		alert("지출일을 채워주세요.");
		f.yeonjang_work_day.value = "";
		f.yeonjang_work_day.focus();
		return false;
	}
    
    /*
    var start_val = Number(f.yeonjang_work_hour1.value+f.yeonjang_work_hour2.value); //예정근무시간 유효성체크
    var end_val = Number(f.yeonjang_work_hour3.value+f.yeonjang_work_hour4.value);
    
    if( start_val > end_val || start_val==end_val )
    {
    	alert("근무시간을 조절해주세요.");
    	return false;
    }
    */
    
    if (isEmpty(f.yeonjang_cont)) 
	{
		alert("신청사유를 채워주세요.");
		f.yeonjang_cont.value = "";
		f.yeonjang_cont.focus();
		return false;
	}
    
    f.approval_line_store.value = approval_line;
    f.ref_line_store.value = ref_line;
    f.imsi_yn.value = way;
    f.attach_store.value = attach_line;
    
    f.action="write_yeonjang";
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
			}
    		else
			{
				alert(data.msg);
				location.href="/family/main";
			}
    		end_loading();
		}
	});
}

</script>

	<table class="board-lay yeonjang_width">
		<tr>
			<th>근무일자</th>
			<td>
         		<input name="yeonjang_work_day" class="date-i" readonly="readonly">&nbsp;&nbsp;일 
			</td>
		</tr>
		<tr>
			<th>신청시간</th>
			<td>
		 		 <select name="yeonjang_work_hour1">
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

   				<select name="yeonjang_work_hour2">
   					<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
   				</select>
     
     			<span class="period-cont">~</span><span class="vis-480"></span>
     						 
     			<select name="yeonjang_work_hour3">
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
     				
     			<select name="yeonjang_work_hour4">
     				<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
     			</select>&nbsp;&nbsp;<span class="jicul_date">(24시 기준)</span>
			</td>
		</tr>
		<tr>
			<th>신청사유</th>
			<td><textarea name="yeonjang_cont"></textarea></td>
		</tr>				
	</table>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<link rel="stylesheet" type="text/css" href="/inc/css/jquery.datetimepicker.css">
<script src="/inc/js/jquery.datetimepicker.full.min.js"></script>
<style>
.centTd {
	text-align:center !important;
}
.leftTd {
	padding-left: 5px !important;
}
</style>
<script>
$(document).ready(function(){
    jQuery('.date_time_picker').datetimepicker({
        format:'Y-m-d H:i',
        lang:'kr',
        step:30,
        scrollMonth : false
    });
	if(nullChk('${idx}') != "")
	{
		$("#idx").val('${data.idx}');
		$("#room_nm").val('${data.room_nm}');
		$("#member").val('${data.member}');
		$("#usage").val('${data.usage}');
		
		var s_date = cutDate('${data.start_date}'.substring(0,8));
		s_date += " ";
		s_date += '${data.start_date}'.substring(8,10);
		s_date += ":";
		s_date += '${data.start_date}'.substring(10,12);
		$("#start_date").val(s_date);
		var e_date = cutDate('${data.end_date}'.substring(0,8));
		e_date += " ";
		e_date += '${data.end_date}'.substring(8,10);
		e_date += ":";
		e_date += '${data.end_date}'.substring(10,12);
		$("#end_date").val(e_date);
	}
})
function fncSubmit(){
	var date1 = $("#start_date").val()
	var date2 = $("#end_date").val()
	if(date1 == "" && date2 == "")
	{
		alert("시작시간 / 종료시간을 확인해주세요");
		$("#start_date").focus();
	}
	else if(date1 > date2)
	{
		alert("시작시간 / 종료시간을 확인해주세요");
		$("#start_date").focus();
	}
	else
	{
		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
	    		if(data.isSuc == "success")
	    		{
	    			alert("저장되었습니다.");
	    			location.href="/family/room/insRoom";
	    		}
	    		else
	    		{
	    			alert(data.msg);
	    		}
			}
		});
	}
}
function delRoom(idx)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "./delRoom",
			dataType : "text",
			async : false,
			data : 
			{
				idx : idx
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert("삭제되었습니다.");
	    			location.href="/family/room/insRoom";
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});	
	}
}
</script>
<style>
	.kpi-page table select {
		width:auto;
	}
</style>
<div id="container" class="user_edit kpi-page kpi-edit">
	<div class="musign-grid">
		<form id="fncForm" name="fncForm" method="POST" action="insRoom_proc">
			<input type="hidden" id="idx" name="idx" value="">
			<div class="btn_wrap ali-right" id="kpiBtn_div">
    			<input type="button" value="저장" onclick="fncSubmit()" class="btn btn_black01">
    		</div>
    		<div style="text-align:center; margin-top:30px;">
    			<h3>예약/수정</h3>
    		</div>
			<table class="board-lay periodClass">
				<colgroup>
					<col width="7%"/>
					<col width="20%"/>
					<col width=""/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<th>회의실</th>
					<th>참석자</th>
					<th>시간</th>
					<th>용도</th>
				</tr>
				<tr>
					<td>
						<select style="width:100%;" id="room_nm" name="room_nm">
							<option value="대">대 회의실</option>
							<option value="중">중 회의실</option>
							<option value="소">소 회의실</option>
						</select>
					</td>
					<td>
						<input type="text" id="member" name="member">
					</td>
					<td>
			    		<input id="start_date" name="start_date" class="date_time_picker" style="width:150px;" value="" readonly="readonly">
			        	~
			        	<input id="end_date" name="end_date" class="date_time_picker" style="width:150px;" value="" readonly="readonly">
					</td>
					<td>
						<input type="text" id="usage" name="usage">
					</td>
				</tr>
			</table>
    	</form>
    </div>
    <div style="text-align:center; margin-top:30px;">
		<h3>예약 내역</h3>
	</div>
    <table class="board-lay periodClass">
		<colgroup>
			<col width="7%"/>
			<col width="20%"/>
			<col width=""/>
			<col width="45%"/>
			<col width="5%"/>
			<col width="5%"/>
		</colgroup>
		<tr>
			<th>회의실</th>
			<th>참석자</th>
			<th>시간</th>
			<th>용도</th>
			<th>예약자</th>
			<th></th>
		</tr>
		<c:forEach var="i" items="${list1}" varStatus="loop">
			<tr>
				<td class="centTd">${i.room_nm} 회의실</td>
				<td class="leftTd">${i.member}</td>
				<td class="centTd">
					<fmt:parseDate var="dateString1" value="${i.start_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:parseDate var="dateString2" value="${i.end_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:formatDate value="${dateString1}" pattern="yyyy-MM-dd HH:mm" />
					~
					<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd HH:mm" />
				</td>
				<td class="leftTd">${i.usage}</td>
				<td class="centTd">${i.submit_user}</td>
				<td class="centTd">
					<c:if test="${user_idx eq i.user_idx}">
						<a href="./insRoom?idx=${i.idx}">수정</a>
						<a onclick="delRoom('${i.idx}')">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
    <table class="board-lay periodClass">
		<colgroup>
			<col width="7%"/>
			<col width="20%"/>
			<col width=""/>
			<col width="45%"/>
			<col width="5%"/>
			<col width="5%"/>
		</colgroup>
		<tr>
			<th>회의실</th>
			<th>참석자</th>
			<th>시간</th>
			<th>용도</th>
			<th>예약자</th>
			<th></th>
		</tr>
		<c:forEach var="i" items="${list2}" varStatus="loop">
			<tr>
				<td class="centTd">${i.room_nm} 회의실</td>
				<td class="leftTd">${i.member}</td>
				<td class="centTd">
					<fmt:parseDate var="dateString1" value="${i.start_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:parseDate var="dateString2" value="${i.end_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:formatDate value="${dateString1}" pattern="yyyy-MM-dd HH:mm" />
					~
					<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd HH:mm" />
				</td>
				<td class="leftTd">${i.usage}</td>
				<td class="centTd">${i.submit_user}</td>
				<td class="centTd">
					<c:if test="${user_idx eq i.user_idx}">
						<a href="./insRoom?idx=${i.idx}">수정</a>
						<a onclick="delRoom('${i.idx}')">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
    <table class="board-lay periodClass">
		<colgroup>
			<col width="7%"/>
			<col width="20%"/>
			<col width=""/>
			<col width="45%"/>
			<col width="5%"/>
			<col width="5%"/>
		</colgroup>
		<tr>
			<th>회의실</th>
			<th>참석자</th>
			<th>시간</th>
			<th>용도</th>
			<th>예약자</th>
			<th></th>
		</tr>
		<c:forEach var="i" items="${list3}" varStatus="loop">
			<tr>
				<td class="centTd">${i.room_nm} 회의실</td>
				<td class="leftTd">${i.member}</td>
				<td class="centTd">
					<fmt:parseDate var="dateString1" value="${i.start_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:parseDate var="dateString2" value="${i.end_date}" pattern="yyyyMMddHHmm" /> 
					<fmt:formatDate value="${dateString1}" pattern="yyyy-MM-dd HH:mm" />
					~
					<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd HH:mm" />
				</td>
				<td class="leftTd">${i.usage}</td>
				<td class="centTd">${i.submit_user}</td>
				<td class="centTd">
					<c:if test="${user_idx eq i.user_idx}">
						<a href="./insRoom?idx=${i.idx}">수정</a>
						<a onclick="delRoom('${i.idx}')">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
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
		
		f.guntae_leave_type.value = "${leave_type}";
		f.shifter.value = "${shifter}"
		
		f.guntae_start_hour1.value = "${total_hour}".substring(0,2);
		f.guntae_start_hour2.value = "${total_hour}".substring(2,4);
		f.guntae_end_hour1.value = "${total_hour}".substring(4,6);
		f.guntae_end_hour2.value = "${total_hour}".substring(6,8);
		
		var detail_receipt_arr = "${detail_receipt}".split("|");
		var detail_receipt_ori_arr = "${detail_receipt_ori}".split("|");
		
		//첨부자료 세팅
		for (var i = 0; i < detail_receipt_arr.length-1; i++) 
		{
			//다음 값이 비어있지 않다면 실행
			if (detail_receipt_arr[i+1] !='') 
			{
				add_guntae_detail();				
			}
			$('#detail_receipt_nm_'+i).val(detail_receipt_ori_arr[i]);
			$('#detail_receipt_nm_'+i).attr("onclick","window.open('${image_dir}jicul_receipt/"+detail_receipt_arr[i]+"', 'imgView', 'width=500', 'height=500')");
		}
	}
	if ("${cont}"!="") 
	{
		$('#guntae_cont').val(  repWord("${cont}") )
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

    temp_line = document.getElementsByName("ref_line");		//참조라인값 세팅
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
    
    temp_line = document.getElementsByClassName("upload-name");	//첨부파일 세팅
	var fileNm_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].value!="") {
    		fileNm_line += temp_line[i].value+'|';
		}
	}
    
    if (approval_line=="|" || approval_line=="")
    {
		alert("결재라인을 선택해주세요.");
		return;
	}
    
 	//대체 근무자 지정
    /*
 	if(isEmpty(f.shifter))
    {
      alert('대체 근무자를 지정해주세요.');
      return;
    }
  	*/
	
	if (isEmpty(f.guntae_start_ymd)) 
	{
		alert("신청 시작일을 채워주세요.");
		f.guntae_start_ymd.value = "";
		f.guntae_start_ymd.focus();
		return false;
	}
	
	if (isEmpty(f.guntae_end_ymd)) 
	{
		alert("신청 종료일을 채워주세요.");
		f.guntae_end_ymd.value = "";
		f.guntae_end_ymd.focus();
		return false;
	}
	
	//신청일자 데이트 형식으로 포멧
	var start_ymd =f.guntae_start_ymd.value.split('-');
	var date_start = new Date(start_ymd[0], start_ymd[1], start_ymd[2] ,f.guntae_start_hour1.value,f.guntae_start_hour2.value );
	
	var end_ymd =f.guntae_end_ymd.value.split('-');
	var date_end = new Date(end_ymd[0], end_ymd[1], end_ymd[2] ,f.guntae_end_hour1.value ,f.guntae_end_hour2.value );
	
	//console.log("date_start : "+date_start);
	//console.log("date_end : "+date_end);
	//console.log("cha : "+(date_end.getTime()-date_start.getTime()) / (1000*60*60)  );
	//console.log("guntae_leave_type : "+f.guntae_leave_type.value);
	 
	if (f.guntae_leave_type.value =="오전반차" || f.guntae_leave_type.value=="오후반차") 
	{
		if ( ((date_end.getTime()-date_start.getTime()) / (1000*60*60)) !="4.5" )   
		{
			alert('반차 시간을 조절해주세요.');
			return;
		}
	}
	
	if ((nullChk(f.guntae_leave_type.value) =="연차취소" || nullChk(f.guntae_leave_type.value) =="반차취소")  && nullChk(attach_line)=='') 
	{
		alert('취소할 문서를 첨부해주세요.');
		return;
	}
	
	
	//신청일자비교
    if(date_end <= date_start)
    {
      alert('신청일자를 확인해주세요.');
      return;
    }
	
    if (isEmpty(f.guntae_cont)) 
	{
		alert("근태사유를 채워주세요.");
		f.guntae_cont.value = "";
		f.guntae_cont.focus();
		return false;
	}

    var detail_receipt_arr = document.getElementsByClassName("detail_receipt");
    var detail_receipt_nm_arr = document.getElementsByName("detail_receipt_nm");
    
    /*
    for (var i = 0; i < detail_receipt_arr.length; i++) 
    {
 
    	if (isEmpty(detail_receipt_nm_arr[i]))
    	{
    		alert("영수증을 등록해주세요.");
    		return false;
    	}
    	
    }
    */
	
    f.approval_line_store.value = approval_line;
    f.ref_line_store.value = ref_line;
    f.imsi_yn.value = way;
    f.attach_store.value = attach_line;
    f.fileNm_list.value = fileNm_line;
    
    f.action="write_guntae";
    f.enctype="multipart/form-data";
    
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
		
    		if (data.isSuc=="success")
			{
				alert(data.msg);
				location.href="/family/dosign/list";
			}
    		else if (data.isSuc=="return") 
    		{
    			alert(data.msg);
			}
    		else
			{
				alert(data.msg);
				location.href="/family/main";
			}
		}
	});
    
}
</script>
	<table class="board-lay guntae_date2">
		<tr>
			<th>구분</th>
			<td>
				<select name="guntae_leave_type">
					<option value="연차">연차</option>
					<option value="오전반차">오전반차</option>
					<option value="오후반차">오후반차</option>
					<option value="병가">병가</option>
					<option value="경조사">경조사</option>
					<option value="예비군">예비군</option>
					<option value="교육">교육</option>
					<option value="조퇴">조퇴</option>
					<option value="기타">기타</option>
					<option value="연차취소">연차취소</option>
					<option value="반차취소">반차취소</option>
				 </select>
			</td>
		</tr>
		
		<tr>
			<th>남은연차<br>
				(*현재 연도 기준입니다.)
			</th>
			<td>
				<input type="text" id="left_guntae" name="left_guntae" class="guntae_left" value="${left_guntae}" readonly="readonly">
			</td>
		</tr>
		
		<tr>
			<th>대체근무자</th>
			<td>
				<select name="shifter" style="width:85px;">
					<option value="">없음</option>
					<c:forEach var="j" items="${getMyTeamList}" varStatus="loop">
						<option value="${j.idx}">${j.name} ${j.level_nm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>신청일자</th>
			<td>
	    		<input name="guntae_start_ymd" class="date-i" style="width:22%;" value="${start_ymd}" readonly="readonly"><span class="jicul_date">일 </span>
	        	<select name="guntae_start_hour1">
	        		<c:forEach var="i" begin="0" end="23" varStatus="loop">
						<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
						<c:if test="${fn:length(loop_index) eq 1}">
							<option value="0${loop_index}">${loop_index}</option>
						</c:if>
						<c:if test="${fn:length(loop_index) ne 1}">
							<option value="${loop_index}">${loop_index}</option>
						</c:if>
					</c:forEach>
	        	</select><span class="jicul_date">시</span>
	        	<select name="guntae_start_hour2">
	        		<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
	        	</select><span class="jicul_date">분</span>
	        	<span class="period-cont">~</span><span class="vis-767"></span>
	        	<input name="guntae_end_ymd" class="date-i" style="width:22%;" value="${end_ymd}" readonly="readonly"><span class="jicul_date">일</span>
	        	<select name="guntae_end_hour1">
	        		<c:forEach var="i" begin="0" end="23" varStatus="loop">
						<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
						<c:if test="${fn:length(loop_index) eq 1}">
							<option value="0${loop_index}">${loop_index}</option>
						</c:if>
						<c:if test="${fn:length(loop_index) ne 1}">
							<option value="${loop_index}">${loop_index}</option>
						</c:if>
					</c:forEach>
	        	</select><span class="jicul_date">시</span>
	        	<select name="guntae_end_hour2">
	        		<option value="00">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
	        	</select><span class="jicul_date">분</span>
			</td>
		</tr>
		
		<tr>
			<th>근태사유</th>
			<td><textarea id="guntae_cont" name="guntae_cont"></textarea></td>
		</tr>	
		
		<tr>
			<th>영수증</th>
			<td>
				<div id="guntae_detail">
					<div>
						 <label for="detail_receipt_0">파일첨부</label>
						 <input id="detail_receipt_nm_0" name="detail_receipt_nm" class="upload-name" value="" readonly="readonly">							
						 <input type="file" id="detail_receipt_0" class="detail_receipt" name="detail_receipt_0" onchange="checkSize(this,0)">
						 <input type="button" value="+추가" class="btn-add" onclick="add_guntae_detail()">
						<br>
					</div>
				</div>
			</td>
		</tr>		
						
	</table>				 

  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/inc/js/dosign.js"></script>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	
	var start_ymd = "${start_ymd}".split('-');
	var end_ymd = "${end_ymd}".split('-');
	var total_hour = "${total_hour}";
	
	if ("${cont}"!="") 
	{
		$('#guntae_cont').val(repWord("${cont}") );
	}
	
	$('#start_year').text(start_ymd[0]+'년');
	$('#start_mon').text(start_ymd[1]+'월');
	$('#start_day').text(start_ymd[2]+'일');
	
	$('#end_year').text(end_ymd[0]+'년');
	$('#end_mon').text(end_ymd[1]+'월');
	$('#end_day').text(end_ymd[2]+'일');
	
	$('#start_hour').text(total_hour.substring(0,2) +'시');
	$('#start_min').text(total_hour.substring(2,4) +'분');
	$('#end_hour').text(total_hour.substring(4,6) +'시');
	$('#end_min').text(total_hour.substring(6,8) +'분');
	
	var detail_receipt = "${detail_receipt}".split('|');
	var detail_receipt_ori = "${detail_receipt_ori}".split('|');
	var inner="";
	for (var i = 0; i < detail_receipt.length-1; i++) {
		inner +='<tr>';
		inner +='	<td class="color-g">영수증</td>';
		inner +="	<td><img src='/img/doc_icon.png' style='width:50px; height:50px;' onclick=\"window.open('${image_dir}guntae_receipt/"+detail_receipt[i]+"', 'imgView', 'width=500', 'height=500')\"></td>";
		inner +='</tr>';
	}
	
	$('#receipt_flag').after(inner);
})
</script>

<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>근태신청서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">
			    <table>
			    	<colgroup>
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
						<col width="11.11%">
					</colgroup>
					<tbody>
					<tr>
						<td colspan="9" class="color-g">구 분</td>
					</tr>
					
					<tr>
						<td>연 차</td>
						<td>반 차</td>
						<td>병 가</td>
						<td>경조사</td>
						<td>예비군</td>
						<td>교 육</td>
						<td>조 퇴</td>
						<td>기 타</td>
						<td>취 소</td>
					</tr>
					<tr>
						<!-- 연차 -->
						<td><c:if test="${leave_type eq '연차'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 반차 -->
						<td><c:if test="${leave_type eq '오전반차' or leave_type eq '오후반차'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 병가 -->
						<td><c:if test="${leave_type eq '병가'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 경조사 -->
						<td><c:if test="${leave_type eq '경조사'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 예비군 -->
						<td><c:if test="${leave_type eq '예비군'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 교육 -->
						<td><c:if test="${leave_type eq '교육'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 조퇴 -->
						<td><c:if test="${leave_type eq '조퇴'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 기타 -->
						<td><c:if test="${leave_type eq '기타'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
						<!-- 취소 -->
						<td><c:if test="${leave_type eq '연차취소' or leave_type eq '반차취소'}"><img src="/img/check_image.PNG" style="width:50px; height:50px;"></c:if></td>
					</tr>
				</tbody>
				</table>
				
				<table>
					<colgroup>
						<col width="20%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
					</colgroup>
					<tbody>
						<tr>
							<td class="color-g" rowspan="2">신청일시</td>
							<td id="start_year" class="ta-r">년</td>
							<td id="start_mon" class="ta-r">월</td>
							<td id="start_day" class="ta-r">일</td>
							<td id="start_hour" class="ta-r">시 </td>
							<td id="start_min" class="ta-r">분 </td>
						</tr>
						<tr>					
							<td id="end_year" class="ta-r">~ 년</td>
							<td id="end_mon" class="ta-r">월</td>
							<td id="end_day" class="ta-r">일</td>
							<td id="end_hour" class="ta-r">시 </td>
							<td id="end_min" class="ta-r">분 </td>
						</tr>
				    </tbody>
				</table>
				
				<table>
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>				
	    			<tbody>
	                    <tr>
							<td class="color-g">대체근무자</td>
	   						<td>${target_nm}</td>
	       				</tr>
	                     
	    				<tr id="receipt_flag">
	    					<td class="color-g">근태사유</td>
	    					<td>
	    						<textarea id="guntae_cont" readonly="readonly">
	    						</textarea>
	    					</td>
	    				</tr>
	    				

	           	        
	    			</tbody>
				</table>
				
			</div>
			<div class="sec sec3">
				<p>위와 같은 사유로 근태를 신청하고자 하오니 재가 부탁드립니다.</p>
			</div>
		</div>
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
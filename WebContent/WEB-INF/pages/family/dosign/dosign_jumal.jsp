<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/inc/js/dosign.js"></script>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	$('#work_hour').text(cutHour("${work_hour}"));
	
	if ("${cont}"!="") 
	{
		$('#jumal_cont').val( repWord("${cont}") );
	}
})



</script>
<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>주말출근신청서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">
			    <table border="1">
					<tr>
						<th class="color-g">신청일자</th>
						<td> ${work_day} </td>
						<th class="color-g">예정근무</th>
						<td id="work_hour"></td>
					</tr>
					<tr>			
						<th class="color-g">출근 목적</th>
						<td colspan="3">
							<textarea id="jumal_cont" readonly="readonly">
							
							</textarea>
						
						</td>
					</tr>
				</table>
			</div>
			<div class="sec sec3">
				<p>위와 같이 주말근무를 하고자 하오니 결재 부탁드립니다.</p>
			</div>
		</div>
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
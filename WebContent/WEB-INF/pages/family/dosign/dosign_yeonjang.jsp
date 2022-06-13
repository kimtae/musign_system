<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/inc/js/dosign.js"></script>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

$(document).ready(function(){
	var work_hour = "${work_hour}";
	$('#work_hour').text( work_hour.substring(0,2)+':'+work_hour.substring(2,4)
			+'~'+work_hour.substring(4,6)+':'+work_hour.substring(6,8));
	
	if ("${cont}"!="") 
	{
		$('#yeonjang_cont').val(  repWord("${cont}") );
	}
})



</script>
<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>연장근무신청서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">
			    <table>
					<tr>
		    			<th class="color-g">작성일자</th>
		    			<td><fmt:parseDate value="${submit_date}" var="fmt_date" pattern="yyyyMMddHHmmss"/><fmt:formatDate value="${fmt_date}" pattern="yyyy-MM-dd"/></td>
		    			<th class="color-g">근무일자</th>
		    			<td>${work_day}</td>
		    		</tr>
		    		<tr>
		    			<th class="color-g">신청시간</th>
		    			<td id="work_hour" colspan="3"></td>
		    		</tr>
		    		
		       		<tr>
		    			<th class="color-g">신청사유</th>
		    			<td colspan="3">
		    				<textarea id="yeonjang_cont" readonly="readonly">
		    				</textarea>
		    			</td>
		    		</tr>
				</table>
			</div>
			<div class="sec sec3">
				<p>위와 같이 연장근무 신청서를 제출하오니 허가하여 주시기 바랍니다.</p>
			</div>
		</div>
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
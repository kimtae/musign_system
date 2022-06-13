<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/inc/js/dosign.js"></script>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>


$(document).ready(function(){
	if ("${cont}"!="") 
	{
		$('#prize_cont').val(  repWord("${cont}") );
	}
})



</script>
<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>포상신청서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">
			    <table class="box-r" border="1">
			    	<colgroup>
    					<col width="46px">
    					<col width="84px">
    					<col width="84px">
    					<col width="84px">
    				</colgroup>
    			</table>
    		
    			<table class="pc">
    				<tr>
    					<td rowspan="3">추천자</td>
    					<td>부서명</td>
    					<td>${login_team_nm}</td>
    					<td rowspan="3">포상 대상자</td>
    					<td>부서명</td>
    					<td>${target_team_nm}</td>
    				</tr>
    				<tr>
    					<td>추천자명</td>
    					<td>${login_name}</td>
    					<td>대상자명</td>
    					<td>${target_nm}</td>
    				</tr>
    				<tr>
    					<td>직위</td>
    					<td>${login_chmod_nm}</td>
    					<td>직위</td>
    					<td>${target_chmod_nm}</td>
    				</tr>
    				<tr>
    					<td>포상일수</td>
    					<td colspan="5">${prize_value}일</td>
    				
    				</tr>
    				<tr>
    					<td>포상사유</td>
						<td colspan="5">
							<textarea id="prize_cont" readonly="readonly">
								
							</textarea>
						</td>
					</tr>
    			</table>
			</div>
			<div class="sec sec3">
				<p>위와 같은 사유로 포상을 신청하고자 하오니 결재하여 주시기 바랍니다.</p>
			</div>
		</div>
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
	</div>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
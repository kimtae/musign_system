<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
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
		    			location.reload();
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
<div id="container" class="user_edit kpi-page kpi-edit">
	<div class="musign-grid">
		<div class="btn_wrap ali-right" id="kpiBtn_div">
   			<input type="button" value="등록" onclick="javascript:location.href='./insRoom'" class="btn btn_black01">
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
			<c:forEach var="i" items="${list}" varStatus="loop">
				<tr>
					<td>${i.room_nm} 회의실</td>
					<td>${i.member}</td>
					<td>
						<fmt:parseDate var="dateString1" value="${i.start_date}" pattern="yyyyMMddHHmm" /> 
						<fmt:parseDate var="dateString2" value="${i.end_date}" pattern="yyyyMMddHHmm" /> 
						<fmt:formatDate value="${dateString1}" pattern="yyyy-MM-dd HH:mm" />
						~
						<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd HH:mm" />
					</td>
					<td>${i.usage}</td>
					<td>${i.submit_user}</td>
					<td>
						<c:if test="${user_idx eq i.user_idx}">
							<a href="./insRoom?idx=${i.idx}">수정</a>
							<a onclick="delRoom('${i.idx}')">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
    </div>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
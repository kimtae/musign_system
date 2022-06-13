<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

// 게시물 삭제 
function fncSubmit(idx)
{
	start_loading();
	$.ajax({
		type : "GET", //전송방식을 지정한다 (POST,GET)
		url : "./delBoard",
		dataType : "text",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
		data: { 'idx': idx },
		error : function() 
		{
			swal("통신 중 오류가 발생하였습니다.", "", "error");
		},
		success : function(data) 
		{
			alert('삭제 되었습니다.');
			location.href="/family/board/list";
		}
	});
}

$(document).ready( function() {
	 
    $("input[type=file]").change(function () {
        
        var fileInput = document.getElementById("file_detail");
        
        var files = fileInput.files;
        
        var file;
        
        for (var i = 0; i < files.length; i++) {
            
            file = files[i];

            alert(file.name);
        }
        
    });

}); 
</script>

<div id="container" >
	<div class="musign-grid">
		<!-- 전체 Wrap => entireWrap -->
		<div class="entireWrap">
			<div class="board-top">
		
				<ul class="topTitle">
					<li>제목:${data.title}<br></li>
				</ul>
		
				<ul class="BoardContents">
					<li>작성자 : ${data.name}<br></li>
					<li>작성일 : ${data.submit_date}</li>
					<li>조회수 : ${data.visit}<br></li>
				</ul>
				
			</div>
			
			<!-- <hr style="margin: 0px 50px 0px 350px;"> -->
			<div class="board_write" >
				<p>${data.cont}</p>
				<!-- 이전글 + 다음글 -->
				<ul class="text">
					<c:choose>
						<c:when test="${pre_data.idx != null}">
						   <li><a href="/family/board/detail?idx=${pre_data.idx}" class="prevText">이전글</a>
							</li>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${next_data.idx != null}">
							<li><a href="/family/board/detail?idx=${next_data.idx}" class="nextText">다음글</a>		
							</li>
						</c:when>
					</c:choose>
				</ul>
				<br/>
				<c:if test="${data.board_file ne ''}">
					<a href='/upload/board/${data.board_file}'>첨부파일 : ${data.board_file_ori}</a>
				</c:if>
						
				<div class="bdetail-bot">
				
					<!-- 목록 -->
					<div class="twoBtn">
						<form class="board-list-btn" action="list" method="get">
							<input type="submit" value="목록" class="list">
							<input type="hidden" name="idx" value="${data.idx}" class="edit">
							<!-- 본인 아이디 일때만 삭제 버튼  -->
							<c:if test="${myidx == data.user_idx}">
								<input type="button" id="delete" value="삭제" onclick="fncSubmit('${data.idx}')" class="delete">
							</c:if>
							
						</form>
					</div>
					
					<!-- 수정 -->
					<div class="repairWrap">
						<form action="edit" method="get">
							<input type="hidden" name="idx" value="${data.idx}" class="edit">
							<!-- 본인 아이디 일때만 수정  버튼  -->
							<c:if test="${myidx == data.user_idx}">	 
									<input type="submit" value="수정" class="repair">
							</c:if>
						</form>
					</div>
					
				</div>
			</div>
		</div><!-- entireWrap -->
	</div>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
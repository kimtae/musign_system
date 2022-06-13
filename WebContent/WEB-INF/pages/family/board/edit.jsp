<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

$(document).ready(function(){
	CKEDITOR.replace('board_cont'); 
	
})

function fncSubmit()
{
 	CKEDITOR.instances.board_cont.updateElement(); 
 	start_loading();
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
	    	var result = JSON.parse(data);
	    	if(result.isSuc == "success")
	    	{
	    		alert(result.msg);
// 	    		window.onbeforeunload = function(e) {} 
	    		location.href="/family/board/list";
	    	}
	    	else
	    	{
	    		alert(result.msg);
	    	}
	    	end_loading();
		}
	});
}

</script>

<div id="container" class="board_write">
	<h2 class="main-tit">수정 페이지</h2>
    <form id="fncForm"  method="post" action="./edit_proc" enctype="multipart/form-data">	
    	<input type="hidden" name="edit" value="board_edit">
    	<input type="hidden" name="idx" value="${data3.idx}">
    	<div style="width:1000px;">
			제목<input type="text" id="board_title" name="title" placeholder="제목을 입력해주세요." value="${data3.title}">
			<select id="choose_board_type" name="board_type">
				<option value="일반">일반</option>
				<option value="공지">공지</option>
			</select>
			<br>         	
    		<textarea id="board_cont" name="cont">${data3.cont}</textarea><br>
    		<c:if test="${data3.board_file ne ''}">
				<a href='/upload/board/${data3.board_file}'>등록된 첨부파일 : ${data3.board_file_ori}</a><br/>
	    		<input type="hidden" id="board_file_pre" name="board_file_pre" value="${data3.board_file}">
	    		<input type="hidden" id="board_file_ori_pre" name="board_file_ori_pre" value="${data3.board_file_ori}">
			</c:if>
    		<br />
    		<input type="file" id="board_file" name="board_file" onchange="checkSize(this)">
    		<br />
    		<br />
    		<input type="button" value="수정" onclick="fncSubmit();">
    	</div>
	</form>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
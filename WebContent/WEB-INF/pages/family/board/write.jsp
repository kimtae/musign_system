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

function fncSubmit(){

	CKEDITOR.instances.board_cont.updateElement(); 
	
	var f = document.fncForm;
		
		// 제목이 빈칸일떄,
		if(isEmpty(f.board_title))
		{
			alert("제목을 입력해주세요.");
			f.board_title.value = "";
			f.board_title.focus();
			return false;
		}
		
		// 내용이 빈칸일떄,
		if(isEmpty(f.board_cont))
		{
			alert("내용을 입력해주세요.");
			f.board_cont.value = "";
			f.board_cont.focus();
			return false;
		}

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
	<h2 class="main-tit">게시판 글쓰기</h2>
    <form id="fncForm" name="fncForm" method="post" action="write_proc" enctype="multipart/form-data">
    	<div style="max-width:1200px; margin:0 auto;">
	    	<input type="text" id="board_title" class="board_write_tit" name="board_title" placeholder="제목을 입력해주세요." value=''>
			<select id="choose_board_type" name="board_type" class="board_responsive">
				<option value="일반">일반</option>
				<option value="공지">공지</option>
			</select>
			<br>         	
    		<textarea id="board_cont" name="board_cont"></textarea><br>
    		<input type="file" id="board_file" class="write_file" name="board_file" onchange="checkSize(this)">
    		<input type="button" value="전송" onclick="fncSubmit();">
    	</div>
	</form>	
</div>

<!-- footer  -->
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>


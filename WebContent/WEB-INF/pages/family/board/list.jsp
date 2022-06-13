<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

var search_type = $('#search_type').val()
var search_cont = $('#searchName').val()

// 검색창이 빈칸일때
$(document).ready(function() {
    if(search_type != '')
    {
        $("#search_type").val(search_type);
    }
    if(search_cont != '')
    {
        $("#search_cont").val(search_cont);
    }
    getList();
});

// 게시판 목록 조회
function getList()
{
	var f = document.fncForm;
	start_loading();
	$.ajax({
		type : "POST", 			
		url : "./getBoard",	
		dataType : "text", 		
		data : 
		{
			search_type : f.search_type.value,
			searchName : f.searchName.value
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			console.log(result);
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+[result.list.length-i]+'</td>';
					inner += '  <td>'+result.list[i].board_type+'</td>';
					inner += '	<td><a href="detail?idx='+result.list[i].idx+'&visit='+result.list[i].visit+'">'+result.list[i].title+'</a></td>';
					inner += '	<td>'+result.list[i].name+'</td>';
					inner += '	<td>'+result.list[i].submit_date+'</td>';
					inner += '  <td>'+result.list[i].visit+'</td>';
					inner += '</tr>';
				}
			}
			
			$("#list_target").html(inner);
			end_loading();
		}
	});	
}
</script>

<div id="container" class="manager_edit">
	<!-- 글등록  -->
	<div class="musign-grid">			 
        
    	
    	<!-- 게시판 검색 기능  -->
        <div class="search-wrap board_sch">
	        <form id="fncForm" name="fncForm" method="GET" onsubmit="return false"> 
	            <select name="search_type" id="search_type">
	            	<option value="title">제목</option>
	            	<option value="both">제목+내용</option>
	            	<option value="type">종류</option>
	            </select>
	            <input type="text" name="searchName" id="searchName" placeholder="검색어를 입력해 주세요."  class="board_text" onkeydown="excuteEnter(getList)">
	            <input type="button" value="검색" onclick="getList()" class="btn btn_black01">
	            
		            <input type="button" value="글 등록" class="btn btn_black01 board_enroll" onclick="javascript:location.href='./write'">
		    	
	         </form>
        </div>
        
        <!-- 게시판 목록 -->
        <table class="board-lay">
            <tr align="center">
             <td>No</td> <td>구분</td> <td style="width:400px;">제목</td> <td>글쓴이</td> <td>날짜</td> <td>조회</td>
            </tr>          
	 		<tbody id="list_target">
			</tbody>
        </table>
       
        
	</div>
</div>

<!-- footer  -->
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>

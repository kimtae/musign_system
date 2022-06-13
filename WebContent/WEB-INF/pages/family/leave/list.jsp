<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>

var isManager = "<%=session.getAttribute("isManager")%>";
/*
if (isManager == null || isManager == "null" || isManager!='Y') {
	alert("권한이 없습니다.");
	location.href = "/main";
}
*/

$(document).ready(function(){	
	getList();
})

window.onload = function(){
	if (isManager!='Y') 
	{
		$('.btn').hide();
	}
}


var edit_idx="";

// 연차 등록/수정 팝업창 조절 
function show_leave(way){
	edit_idx="";
	$('#leave_title').val('');
	$('#leave_start_ymd').val('');
	$('#leave_end_ymd').val('');
	
	$('.attach_div').show();
	if (way=="write") 
	{
		$('.add_holiday').hide();		
		$('.edit_leave').hide();		
		$('.add_leave').show();
	}
	else
	{
		var arr = way.split('_');
		edit_idx =arr[0];
		$('#leave_title').val(arr[1]);
		$('#leave_start_ymd').val(arr[2]);
		$('#leave_end_ymd').val(arr[3]);
		$('#selYear').val(arr[4]);
		
		$('.edit_leave').show();	
		$('.add_holiday').show();
		$('.add_leave').hide();
	}
}

function getList(){
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getLeaveList",
		dataType : "text",
		async : false,
		data : 
		{
			search_name : $('#search_name').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			for(var i = 0; i < result.list.length; i++)
			{
				inner +='<tr>';
				inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\'">'+(i+1)+'</td>';
				inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\'">'+result.list[i].title+'</td>';
				inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\'">'+result.list[i].target_year+'</td>';
				inner +='	<td><input type="button" class="btn_black01 btn" value="수정" onclick="show_leave(\''+result.list[i].idx+'_'+result.list[i].title+'_'+result.list[i].start_ymd+'_'+result.list[i].end_ymd+'_'+result.list[i].target_year+'\')"></td>';
				inner +='</tr>';
			}
			$("#list_target").html(inner);
			end_loading();
		}
	});
	
}

</script>

<!-- 등록 / 수정 팝업 include start-->
<jsp:include page="/WEB-INF/pages/family/leave/write.jsp"/>
<!-- 등록 / 수정 팝업 include end-->


<div id="container" class="manager">
	<div class="musign-grid">
       	<div class="header-search">
            <input type="button" class="search btn_black01 btn" value="연차 등록" onclick="show_leave('write');">
            <input type="button" class="search btn_black01 btn" value="휴일 리스트" onclick="javscript:location.href='/family/leave/holiday_list'">
       	</div>
       	
    	<table class="board-lay table-comm table-fm leave_responsive">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			
    		<tr class="th">
            	<th>No.</th>
            	<th>제목</th>
            	<th>해당 연도</th>
            	<th></th>
    		</tr>
    		
    		<tbody id="list_target">

			</tbody>
    	</table>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
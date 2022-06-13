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


function getList(){
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getRecruitArea",
		dataType : "text",
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			var chk_flag="";
			for(var i = 0; i < result.list.length; i++)
			{
				inner +='<tr>';
				inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\'">'+(i+1)+'</td>';
				inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\'">'+result.list[i].area_nm+'</td>';
				inner +='	<td>';
				inner +='		<select id="use_yn_'+result.list[i].idx+'">';
				if (result.list[i].use_yn=='Y') 
				{
					inner +='			<option value="Y" selected>Y</option>';
					inner +='			<option value="N">N</option>';
				}
				else
				{
					inner +='			<option value="Y">Y</option>';
					inner +='			<option value="N" selected>N</option>';
				}
				
				inner +='		</select>';
				inner +='	</td>';
				inner +='	<td> <input type="button" value="저장" onclick="save_rec_area(\''+result.list[i].idx+'\')"> </td>';
				inner +='</tr>';
			}
			$("#list_target").html(inner);
			end_loading();
		}
	});
	
}


function save_rec_area(idx){
	if(!confirm("수정 사항을 반여하시겠습니까?"))
	{
		return;
	}
	
	var chk_val = $('#use_yn_'+idx).val();
	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./uptRecArea",
		dataType : "text",
		async : false,
		data : 
		{
			idx : idx,
			chk_val : chk_val
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			if (result.isSuc=="success") 
			{
				getList();
			}
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
       	
    	<table class="board-lay table-comm table-fm leave_responsive">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			
    		<tr class="th">
            	<th>No.</th>
            	<th>지원분야</th>
            	<th>오픈여부</th>
            	<th></th>
    		</tr>
    		
    		<tbody id="list_target">

			</tbody>
    	</table>
    </div>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
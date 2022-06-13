<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>

$(document).ready(function(){
	getList();
})


function getList()
{
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getMusignlibList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			search_title : $('#search_title').val(),
			search_content : $('#search_content').val()
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
			if(result.list.length > 0)
			{
				//$("#list_target").empty();
				for(var i = 0; i < result.list.length; i++)
				{
					inner+='<tr>';
					inner+='	<td>'+(i+1)+'</td>';
					inner+='	<td onclick="javascript:location.href=\'/family/musign_lib/detail?idx='+result.list[i].idx+'\' ">'+result.list[i].post_title+'</td>';
					inner+='</tr>';
					
				}
			}
		
			
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".pro-pagenation").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			

			
			end_loading();
		}
	});
}


</script>



<div id="container">
	<div class="musign-grid guntae_responsive">
	<div class="search-wr">
		<div class="table">
	
			
			<div class="wid-3 guntae_name">
				<input class="wid-10" type="text" id="search_title" name="search_title" placeholder="검색할  제목을 입력해주세요.">
				<input class="wid-10" type="text" id="search_content" name="search_content" placeholder="검색할 내용을 입력해주세요.">
			</div>
			
		
			<div class="wid-2 guntae_sch">	
				<input type="button" value="검색" onclick="javascript:page=1; getList();" class="btn btn01">
			</div>
			
			
		</div>
		
	</div>
	<table class="board-lay guntae_responsive">
		<tr>
        	<th>번호</th>
        	<th onclick="reSortAjax('sort_post_title');">제목</th>
        	<th></th>
		</tr>
  		<tbody id="list_target">
  		
  		</tbody>
	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
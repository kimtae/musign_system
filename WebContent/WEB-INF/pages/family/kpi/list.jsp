<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(document).ready(function() {
	getList();
});

function getList()
{

	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getKpiList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
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
			
			
			if(result.list.length > 0)
			{
		
				$("#list_target").empty();
				
				inner +='<tr>';
				inner +='	<th>팀</th>';
				inner +='	<th>이름</th>';
				inner +='	<th>직급</th>';
				inner +='	<th>게시글 시점</th>';
				inner +='	<th>첨부파일</th>';
				inner +='</tr>';
				var output_arr='';
				for(var i = 0; i < result.list.length; i++)
				{
					output_arr = result.list[i].output_file.split('|');
					inner +='<tr>';
					inner +='	<td>'+result.list[i].team_nm+'</td>';
					inner +='	<td>'+result.list[i].name+'</td>';
					inner +='	<td>'+result.list[i].chmod_nm+'</td>';
					inner +='	<td>'+result.list[i].period+'분기</td>';
					
					inner +='<td>';
					for (var j = 0; j < output_arr.length; j++) {			
						if (nullChk(output_arr[j])!='') 
						{
							inner +='	<a href="/upload/kpi/'+output_arr[j]+'">다운로드</a><br>';							
						}
					}
					inner +='</td>';
					inner +='</tr>';
				}
				
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="18"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
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
	<div class="musign-grid">
	<div class="search-wr">
		<form id="searchForm" name="searchForm" autocomplete="off">
			<div class="table">
				<div class="wid-2 dosign_name">
					<input class="wid-10" type="text" id="search_name" name="search_name" placeholder="이름">
				</div>
			</div>
			<div class="table">
				<div class="wid-2 dosign_btn">	
					<input type="button" value="검색" onclick="getList()" class="btn btn01">
				</div>
			</div>
		</form>
	</div>
	<table id="list_target" class="board-lay dosign_scroll">
	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
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
	
	$.ajax({
		type : "POST", 
		url : "./getLeaveUserDetailList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			user_idx : "${user_idx}",
			start_ymd : $('#start_ymd').val(),
			end_ymd : $('#end_ymd').val()
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
				for (var i = 0; i < result.list.length; i++) {
					inner +='<tr>';
					inner +='	<td>'+(i+1)+'</td>';
					inner +='	<td>'+result.list[i].leave_type+'</td>';
					inner +='	<td>'+nullChk(result.list[i].shifter_nm)+'</td>';
					inner +='	<td>'+result.list[i].start_ymd+'</td>';
					inner +='	<td>'+result.list[i].end_ymd+'</td>';
					inner +='	<td>'+result.list[i].day_cnt+'</td>';
					inner +='</tr>';
				}
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".pro-pagenation").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});
	
}



</script>



<div id="container">
	<div class="musign-grid">
	<div class="search-wr">
		<div class="table">
			
			<div class="wid-7">
				<div class="table">
					<div class="mid-da">
						<input id="start_ymd" class="date-i" name="start_ymd">일
					</div>
					<div class="mid-s">~</div>
					<div class="mid-da">	
						<input id="end_ymd" class="date-i" name="end_ymd">일	
					</div>
				</div>
			</div>
			<div class="wid-2 user_sch">	
				<input type="button" value="검색" onclick="javascript:page=1; getList();" class="btn btn01">
			</div>
		</div>
	</div>
	<table class="board-lay">
		<tr>
        	<th>번호</th>
        	<th onclick="reSortAjax('sort_leave_type');">종류</th>
        	<th onclick="reSortAjax('sort_shifter');">대체자</th>
        	<th onclick="reSortAjax('sort_start_ymd');">연차 시작일</th>
        	<th onclick="reSortAjax('sort_end_ymd');">연차 종료일</th>
        	<th onclick="reSortAjax('sort_day_cnt');">연차 일수</th>
		</tr>
  		<tbody id="list_target">
  		
  		</tbody>
	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
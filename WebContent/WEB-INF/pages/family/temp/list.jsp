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
		url : "./getTempList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			search_name : $('#search_name').val(),
			start_ymd : $('#submit_date7').val(),
			end_ymd : $('#submit_date8').val()
			
			
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
				inner +='	<th>번호</th>';
				inner +='	<th>이름</th>';
				inner +='	<th>소속</th>';
				inner +='	<th>직급</th>';
				inner +='	<th>종류</th>';
				inner +='	<th>상태</th>';
				inner +='</tr>';
				
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr onclick="javascript:location.href=\'/dosign/detail?idx='+result.list[i].idx+'&doc_type='+result.list[i].doc_type+'&imsi_yn=Y\' ">';
					inner +='	<td>'+result.list[i].doc_type+'-'+result.list[i].doc_idx+'-'+result.list[i].idx+'</td>';
					inner +='	<td>'+result.list[i].kor_nm+'</td>';
					inner +='	<td>'+result.list[i].team_kr+'</td>';
					inner +='	<td>'+result.list[i].level_nm+'</td>';
					inner +='	<td>'+result.list[i].doc_name+'</td>';
					inner +='	<td>'+result.list[i].step+'</td>';
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
			$("#list_target").append(inner);
			$(".pro-pagenation").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});
}
</script>



<div id="container">
	<div class="musign-grid">
	<div class="search-wr">
		<form id="searchForm" name="searchForm" method="post" action="doSign.php" autocomplete="off">
			<div class="table">
				<div class="wid-3">
					<input class="wid-10" type="text" id="name_search" name="name_search" placeholder="이름">
				</div>
				<div class="wid-7">
					<div class="table">
						<div class="mid-da">
							<input id="submit_date7" name="start_ymd">일
						</div>
						<div class="mid-s">~</div>
						<div class="mid-da">	
							<input id="submit_date8" name="end_ymd">일	
						</div>
					</div>
				</div>
			</div>
			<div class="table">
			
				<div class="wid-2">
					<select id="doc_type_search" name="doc_type_search">
						<option value="">전체</option>
    					<option value="100">근태신청서</option>
    					<option value="101">지출결의서</option>
    					<option value="102">주말출근신청서</option>
    					<option value="103">연장근무신청서</option>
    					<option value="104">품의서</option>
    					<option value="105">포상신청서</option>
					</select>
				</div>	
				<div class="wid-4">
					<input type="text" id="content_search" name="content_search" placeholder="내용" value=""><br>
				</div>
				<div class="wid-2">
					<select id="step_search" name="step_search">
						<option value="">전체</option>
						<option value="제출">제출</option>
						<option value="반려">반려</option>
						<option value="팀장승인">팀장승인</option>
						<option value="본부장승인">본부장승인</option>
						<option value="대표이사승인">대표이사승인</option>
						<option value="결재">결재</option>
					</select>
				</div>
				<div class="wid-2">	
					<input type="button" value="검색" onclick="getList()" class="btn btn01">
				</div>
			</div>
		</form>
	</div>
	<table id="list_target" class="board-lay">
		<tr>
        	<th>번호</th>
        	<th>이름</th>
        	<th>소속</th>
        	<th>직급</th>
        	<th>종류</th>
        	<th>상태</th>
		</tr>
  

	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>

</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
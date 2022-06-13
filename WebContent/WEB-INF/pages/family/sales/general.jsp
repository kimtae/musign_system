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
		url : "./getSaleList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			
			start_ymd : $('#start_ymd').val(),
			end_ymd : $('#end_ymd').val(),
			step : $('#step').val(),
			sale_manager : $('#sale_manager').val()
			
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
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">';
					inner +='	<td><input type="checkbox" class="chk_sale" value="'+result.list[i].idx+'"></td>';
					inner +='	<td>'+result.list[i].step+'</td>';
					inner +='	<td>'+result.list[i].NAME+'</td>';
					inner +='	<td>'+result.list[i].submit_date+'</td>';
					inner +='	<td>'+result.list[i].user_company+'</td>';
					inner +='	<td>'+result.list[i].user_type+'</td>';
					inner +='	<td>'+result.list[i].user_manager+'</td>';
					inner +='	<td>'+result.list[i].phone_no+'</td>';
					inner +='	<td>'+result.list[i].user_email+'</td>';
					inner +='	<td>'+result.list[i].service_type.slice(0,-1)+'</td>';
					inner +='	<td>'+result.list[i].project_type.slice(0,-1)+'</td>';
					inner +='	<td>'+result.list[i].project_budget+'</td>';
					inner +='	<td>'+result.list[i].start_ymd+'</td>';
					inner +='	<td>'+result.list[i].end_ymd+'</td>';
					inner +='	<td>'+result.list[i].select_way+'</td>';
					inner +='	<td>'+result.list[i].site_url+'</td>';
					inner +='	<td>'+result.list[i].known_path.slice(0,-1)+'</td>';
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
		}
	});
}
</script>

<div id="container">
	<h1 class="name">관리차트 - (일반)</h1>
	<div class="state">
		<select id="step">
			<option value="">진행상태</option>
			<option value="1" class="red"><div></div>문의/접수</option>
			<option value="2" class="orange"><p></p>준비중</option>
			<option value="3" class="orange"><p></p>협의중</option>
			<option value="4" class="green"><p></p>계약</option>
			<option value="5" class="green"><p></p>패스</option>
		</select>
	</div>
	
	<div class="state2">
		<select id="sale_manager" name="sale_manager">
			<option value="" selected="selected">담당자</option>
			<c:forEach var="i" items="${saleUserList}" varStatus="loop">
				<option value="${i.idx}">${i.name}</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="calendar">
		<h6>기간설정 :</h6>
		<div class="calendar1"><input type="date" id="start_ymd" class="cal_date"></div>
		<div class="calendar2">~</div>
		<div class="calendar3"><input type="date" id="end_ymd" class="cal_date"></div>
		<div class="calendar4">적용</div>
	</div>	
	<div class="board_wrap">
		<table class="board">
			<tr>
				<th colspan="3">구분</th>
				<th colspan="5">1. 고객정보</th>
				<th colspan="8">2. 질의항목</th>
			</tr>
			<tr>
				<th><input type="checkbox" onclick="chkAll();"></th>
				<th>상태</th>
				<th>담당자</th>
				<th>문의 일자</th>
				<th>1. 회사명</th>
				<th>2. 업종형태</th>
				<th>3. 담당자명</th>
				<th>4. 연락처</th>
				<th>5. 이메일</th>
				<th>1. 서비스</th>
				<th>2. 프로젝트 성격</th>
				<th>3. 프로젝트 예산</th>
				<th>4. 착수 시점</th>
				<th>5. 오픈 예정일</th>
				<th>6. 선정방식</th>
				<th>7. 기존 사이트 주소</th>
				<th>8. 유입경로</th>
			</tr>
			<tbody id="list_target">
			
			</tbody>
		</table>
	</div>
	<div class="down_bt">엑셀 다운로드</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
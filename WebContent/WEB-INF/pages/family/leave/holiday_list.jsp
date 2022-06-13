<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="musign.classes.*" %>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>


$(document).ready(function(){
	$('.attach_div').hide();
	getList();
})


function getList()
{
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getHolidayList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			search_name : $('#search_name').val(),
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
					inner +='	<td>'+result.list[i].day+'</td>';
					inner +='	<td>'+result.list[i].info+'</td>';
					inner +='</tr>';
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

function show_addHoliday(){
	$('.attach_div').show();
}

function close_div(){
	$('.attach_div').hide();
}


function addHoliday_one(){
	$.ajax({
		type : "POST", 
		url : "./addHoliday_one",
		dataType : "text",
		async : false,
		data : 
		{
			holiday_info : $('#holiday_info').val(),
			target_day : $('#target_day').val()
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
				location.reload();
			}
		}
	});
}

</script>

<div class="attach_div" style="display: none;">
	<div class="closeBtn">
		<input type="button" onclick="close_div();" value="닫기" class="attachClose">
	</div>
	<div class="root_tableWrap">
		<div class="tableWrap">
			<div class="tableBox holi_responsive3">
				설명 &nbsp;&nbsp;:&nbsp;&nbsp; <input id="holiday_info" class="holi_detail" name="holiday_info" type="text">
					<span class="holi_responsive">해당일&nbsp;&nbsp; :&nbsp;&nbsp; <input id="target_day" class="date-i holi_responsive2" name="target_day">
				
				<!-- list.jsp 페이지에서  등록/수정/석제 노출 조절 -->
				<input type="button" value="휴일추가" class="add_leave holi_add" onclick="addHoliday_one();"></span>
			</div><!-- class="tableBox" -->
		</div><!-- class="tableWrap" -->
	</div>
</div>


<div id="container">
	<div class="musign-grid">
	<div class="header-search">
        
   	</div>
	<div class="search-wr">
	
		<div class="table">
			
			<div class="wid-7 holiday_responsive">
				<div class="table holi_date">
					<div class="mid-da">
						<input id="start_ymd" class="date-i" name="start_ymd">일
					</div>
					<div class="mid-s">~</div>
					<div class="mid-da">	
						<input id="end_ymd" class="date-i" name="end_ymd">일	
					</div>
				</div>							
			</div>														
			<div class="wid-3 holiday_responsive2">
				<input class="wid-10 holi_name" type="text" id="search_name" name="search_name" placeholder="휴일명을 입력해주세요.">
			</div>
			<div class="holi_btn">	
				<input type="button" value="검색" onclick="javascript:page=1; getList();" class="btn btn01">
			</div>
			<input type="button" class="search btn_black01 btn" value="휴일 등록" onclick="show_addHoliday();">
		</div>
		<div class="table">
			
		</div>
	</div>
	<table class="board-lay">
		<tr>
        	<th>번호</th>
        	<th onclick="reSortAjax('sort_day');">일자</th>
        	<th onclick="reSortAjax('sort_info');">설명</th>
		</tr>
  		<tbody id="list_target">
  		
  		</tbody>
	</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>

</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
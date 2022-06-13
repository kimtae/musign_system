<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/excelDown.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(document).ready(function(){
	$("body").addClass("body-board-list");
	getList();
	
	$("#chk_all").change(function() 
	{
		if($("#chk_all").is(":checked"))
		{
			$('.chk_rec').prop("checked", true);
		}
		else
		{
			$('.chk_rec').prop("checked", false);
		}
	});
})


function getList(page_val)
{
	if (nullChk(page_val)!="") 
	{
		page = page_val;
	}
	
	$.ajax({
		type : "POST", 
		url : "./getRecruitList",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			//listSize : $('#list_size').val(),
			listSize : '10'
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
			$('#recruit_cnt').text('총 '+result.TotalCnt+'개 / 결과 '+result.listCount+'개');
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr>';
					inner +='	<td><input type="checkbox" class="chk_rec" value="'+result.list[i].idx+'"></td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].submit_date)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_name)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].want_area_nm.slice(0,-1))+'</td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_phone)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_email)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_address)+'</td>';
					inner +='	<td class="sale_comment_text" style="display:none">'+repWord(nullChk(result.list[i].story_cont))+'</td>';
					inner +='	<td class="sale_comment_btn" onclick="getRecinfo('+result.list[i].idx+')">보기</td>';
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

function getRecinfo(rec_idx){
	$.ajax({
		type : "POST", 
		url : "./getRecinfo",
		dataType : "text",
		async : false,
		data : 
		{
			rec_idx : rec_idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (nullChk(result.data.story_cont)!='') 
			{
				alert(repWord(result.data.story_cont));
			}
			else
			{
				alert('등록된 코멘트가 없습니다.');
			}
		}
	}); 
}

</script>

<div id="container">
	<div class="header-search">
        <input type="button" class="search btn_black01 btn" value="채용 ON / OFF" onclick="javascript:location.href='./write' ">
   	</div>
	<h1 class="name">관리차트</h1>
	<div class="searchBox">
	<!-- 
		<div class="state">
			<p>검색어</p>
			<input type="text" id="search_cont" name="search_cont" placeholder="회사명 /업종형태 /코멘트 내용이 검색됩니다." onkeypress="javascript:excuteEnter(getList);" style="width:125%">
		</div>
	 -->
	</div>
	
	<div class="list_top_wrap">
		<div class="state_box">
			<!-- 
			<div class="state">
				<p>진행상태  </p>
				<select id="step" onchange="getList(1);">
					<option value="">전체</option>
					<option value="1" class="red"><div></div>문의/접수</option>
					<option value="2" class="orange"><p></p>준비중</option>
					<option value="3" class="orange"><p></p>협의중</option>
					<option value="4" class="green"><p></p>계약</option>
					<option value="5" class="green"><p></p>패스</option>
				</select>
			</div>
			
			<div class="state">
				<p>담당자 </p> 
				<select id="sale_manager" name="sale_manager" onchange="getList(1);">
					<option value="" selected="selected">전체</option>
					<c:forEach var="i" items="${saleUserList}" varStatus="loop">
						<option value="${i.idx}">${i.name}</option>
					</c:forEach>
				</select>
			</div>
			
			<div class="state">
				<p>서비스 종류  </p>
				<select id="sale_service" name="sale_service" onchange="getList(1);">
					<option value="" selected="selected">전체</option>
					<c:forEach var="i" items="${saleServiceList}" varStatus="loop">
						<option value="${i.service_no}">${i.service_nm}</option>
					</c:forEach>
				</select>
			</div>
			
			
		</div>	
		
	
		<div class="calendar_box">
			<div class="calendar chart-calendar">
				<h6>수정일정 기간설정 </h6>
				<div class="calendar1"><input type="date" id="upt_start_ymd" class="cal_date" style="height:29px;"></div>
				<div class="calendar2">~</div>
				<div class="calendar3"><input type="date" id="upt_end_ymd" class="cal_date" style="height:29px;"></div>
				<br>
				
				<h6>기간설정 </h6>
				<div class="calendar1"><input type="date" id="start_ymd" class="cal_date" style="height:29px;"></div>
				<div class="calendar2">~</div>
				<div class="calendar3"><input type="date" id="end_ymd" class="cal_date" style="height:29px;"></div>
				
				
				<div class="list_option">
					<div class="calendar4" onclick="doDelete();">삭제</div>
				<div class="calendar4" onclick="getList();">적용</div>
					<select id="list_size" name="list_size" onchange="getList();">
						<option value="10" selected="selected">10개 보기</option>
						<option value="20" >20개 보기</option>
						<option value="50" >50개 보기</option>
						<option value="100" >100개 보기</option>
						<option value="1000" >1000개 보기</option>
						
					</select>	
					
				</div>	
				
				
				
			</div>	
		-->
		</div>
	</div>

	<div id="recruit_cnt"></div>
	<div class="board_wrap">
		<table id="excelTable" class="board">
			<thead>
			
				<!--<tr style="display:none;">
					<th colspan="3">구분</th>
					<th colspan="5">고객정보</th>
					<th colspan="8">질의항목</th>
				</tr>-->
				<tr>
					<th><input type="checkbox" id="chk_all"></th> 
					<th onclick="reSortAjax('sort_submit_date');">지원일자</th>
					<th onclick="reSortAjax('sort_user_name');">지원자</th>
					<th onclick="reSortAjax('sort_want_area_nm');">지원분야</th>
					<th onclick="reSortAjax('sort_user_phone');">전화번호</th>
					<th onclick="reSortAjax('sort_user_email');">이메일</th>
					<th onclick="reSortAjax('sort_user_address');">참고 사이트</th>
					<th onclick="reSortAjax('sort_story_cont');">상세</th>
				</tr>
			</thead>
			<tbody id="list_target">
			
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
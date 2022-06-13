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
	$("body").addClass("body-board-list body-sales-list");
	getList();
	
	$("#chk_all").change(function() 
	{
		if($("#chk_all").is(":checked"))
		{
			$('.chk_sale').prop("checked", true);
		}
		else
		{
			$('.chk_sale').prop("checked", false);
		}
	});
})


function getList(page_val)
{
	if (nullChk(page_val)!="") 
	{
		page = page_val;
	}
	
	setCookie("page",page,1);
	setCookie("order_by", order_by,1);
	setCookie("sort_type", sort_type,1);
	setCookie('listSize', $('#list_size').val(),1);
	setCookie('start_ymd',$('#start_ymd').val(),1);
	setCookie('end_ymd',$('#end_ymd').val(),1);
	setCookie('step',$('#step').val(),1);
	

	
	
	setCookie('important',$('#important_project').val(),1);
	
	
	setCookie('sale_manager',$('#sale_manager').val(),1);
	setCookie('sale_service',$('#sale_service').val(),1);
	setCookie('search_cont',$('#search_cont').val(),1);
	setCookie('upt_start_ymd',$('#upt_start_ymd').val(),1);
	setCookie('upt_end_ymd',$('#upt_end_ymd').val(),1);
	
	
	var important_yn = 'N';

	if ($('#important_chk').prop('checked')) 
	{
		important_yn='Y';
	}
	
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
			listSize : $('#list_size').val(),
			start_ymd : $('#start_ymd').val(),
			end_ymd : $('#end_ymd').val(),
			step : $('#step').val(),
			
			important_yn : important_yn,
			choice : $('#choice').val(),
			known_path : $('#known_path').val(),
			budget : $('#Budget').val(),

			sale_manager : $('#sale_manager').val(),
			sale_service : $('#sale_service').val(),
			search_cont : $('#search_cont').val(),
			upt_start_ymd : $('#upt_start_ymd').val(),
			upt_end_ymd : $('#upt_end_ymd').val(),
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
			console.log(result);
			$('#sale_cnt').text('결과 '+result.list.length+'개 / 총 '+result.TotalCnt+'개');
			if(result.list.length > 0)
			{
					
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr>';
					inner +='	<td><input type="checkbox" class="chk_sale" value="'+result.list[i].idx+'"></td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].step)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].important_yn)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].NAME)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_company)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].select_way)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].project_budget)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].known_path.slice(0,-1))+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].submit_date)+'</td>';
					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].update_date)+'</td>';
					inner +='	<td class="sale_comment_text" style="display:none">'+repWord(nullChk(result.list[i].comment))+'</td>';
					inner +='	<td class="sale_comment_btn" onclick="getSaleComment('+result.list[i].idx+')" ><span>보기</span></td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_type)+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].known_path.slice(0,-1))+'</td>';
//					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_phone)+'</td>';
//					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_email)+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].user_manager)+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].service_type.slice(0,-1))+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].project_type.slice(0,-1))+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].start_ymd)+'</td>';
// 					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].end_ymd)+'</td>';
//					inner +='	<td onclick="javascript:location.href=\'write?idx='+result.list[i].idx+'\' ">'+nullChk(result.list[i].site_url)+'</td>';
					
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

function excelDown()
{
	var filename = "관리차트";
	var table = "excelTable";
	$('.sale_comment_text').show();
	$('.sale_comment_btn').hide();
	$('.sale_comment_btn').text('');
    exportExcel(filename, table);
    
    $('.sale_comment_text').hide();
    $('.sale_comment_btn').text('보기');
    $('.sale_comment_btn').show();
	
    
}

function doDelete(){
	
	
	var idx ="";
	$('.chk_sale').each(function(){ 
		if ($(this).prop('checked')==true) 
		{
			idx +=$(this).val()+"|";
		}
	})
	
	if (idx=="") 
	{
		alert('삭제할 게시물을 선택해주세요.');
		return;
	}
	
	if(!confirm("정말 삭제하시겠습니까?"))
	{
		return;
	}
	
	if (idx=="") 
	{
		alert("삭제할 게시글을 선택해주세요.");
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./doDelete",
		dataType : "text",
		async : false,
		data : 
		{
			idx : idx
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

function getSaleComment(sale_idx){
	$.ajax({
		type : "POST", 
		url : "./getSaleComment",
		dataType : "text",
		async : false,
		data : 
		{
			sale_idx : sale_idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (nullChk(result.data.comment)!='') 
			{
				alert(repWord(result.data.comment));
			}
			else
			{
				alert('등록된 코멘트가 없습니다.');
			}
		}
	}); 
}
</script>

<div id="container" class="sales_list">
	<h1 class="name">관리차트</h1>
	<div class="searchBox">
		<div class="state">
			<p class="search_tit">검색어</p>
			<input type="text" id="search_cont" name="search_cont" placeholder="회사명 /업종형태 /코멘트 내용이 검색됩니다." onkeypress="javascript:excuteEnter(getList);" style="width:125%">
		</div>
		<div class="list_top_wrap">
			<div class="calendar_box">
				<div class="calendar chart-calendar">
<!-- 					<div class="list_search_box"> -->
<!-- 						<h6 class="search_tit">수정일정 기간설정 </h6> -->
<!-- 						<div class="calendar1"><input type="date" id="upt_start_ymd" class="cal_date"></div> -->
<!-- 						<div class="calendar2">-</div> -->
<!-- 						<div class="calendar3"><input type="date" id="upt_end_ymd" class="cal_date"></div> -->
<!-- 					</div> -->
					<div class="list_search_box">
						<h6 class="search_tit">기간설정 </h6>
						<select name="date_srot_list" id="date_srot_list" class="date_srot_list">
							<option value="submit_date">문의일</option>
							<option value="update_date">수정일</option>
							<option value="start_date">착수일</option>
							<option value="end_date">오픈일</option>
						</select>
						<div class="calendar1"><input type="date" id="start_ymd" class="cal_date"></div>
						<div class="calendar2">-</div>
						<div class="calendar3"><input type="date" id="end_ymd" class="cal_date"></div>
						<div id="important_project" class="important_project" onclick="getList(1)">
							<h6 class="search_tit">유력</h6>
							<input type="checkbox" id="important_chk" class="important_chk" />
						</div>
					</div>
				</div>	
			</div>
			<div class="state_box">
				
				<div class="state">
					<p class="search_tit">담당자 </p> 
					<select id="sale_manager" name="sale_manager" onchange="getList(1);">
						<option value="" selected="selected">전체</option>
						<c:forEach var="i" items="${saleUserList}" varStatus="loop">
							<option value="${i.idx}">${i.name}</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="state">
					<p class="search_tit">진행상황 </p>
					<select id="step" onchange="getList(1);">
						<option value="">전체</option>
						<option value="1" class="red"><div></div>문의/접수</option>
						<option value="2" class="orange"><p></p>담당자확인</option>
						<option value="3" class="orange"><p></p>초기컨텍</option>
						<option value="4" class="orange"><p></p>견적서송부</option>
						<option value="5" class="orange"><p></p>추가협의</option>
						<option value="6" class="green"><p></p>계약</option>
						<option value="7" class="green"><p></p>패스</option>
					</select>
				</div>
				
				<div class="state">
					<p class="search_tit">선정방식 </p>
					<select id="choice" onchange="getList(1);">
						<option value="">전체</option>
						<option value="01">수의계약</option>
						<option value="02">가격입찰</option>
						<option value="03">제안입찰</option>
						<option value="04">미정</option>
						<option value="05">기타</option>
					</select>
				</div>
				
				<div class="state">
					<p class="search_tit">유입경로 </p>
					<select id="known_path" onchange="getList(1);">
						<option value="">전체</option>
						<option value="01">기존고객사</option>
						<option value="02">지인소개</option>
						<option value="03">지디웹</option>
						<option value="04">디비컷</option>
						<option value="05">구글 검색</option>
						<option value="06">네이버 검색</option>
						<option value="07">수출바우처 사이트</option>
						<option value="08">뮤자인블로그</option>
						<option value="09">기타</option>
					</select>
				</div>
				
				<div class="state">
					<p class="search_tit">예산 </p>
					<select id="Budget" onchange="getList(1);">
						<option value="">전체</option>
						<option value="01">3천만원 미만</option>
						<option value="02">3~5천만원 미만</option>
						<option value="03">5~1억원 미만</option>
						<option value="04">1~2억원미만</option>
						<option value="05">2억원~3억원 미만</option>
						<option value="06">3억원이상</option>
					</select>
				</div>
				
			</div>	
		</div>
	</div>
	
	<div class="alignment_wrap">
		<div id="sale_cnt"></div>
				
		<div class="list_option">
			<select id="list_size" name="list_size" onchange="getList();">
				<option value="10" selected="selected">10개 보기</option>
				<option value="20" >20개 보기</option>
				<option value="50" >50개 보기</option>
				<option value="100" >100개 보기</option>
				<option value="1000" >1000개 보기</option>					
			</select>
			<div class="calendar4 del_btn" onclick="doDelete();">삭제</div>
		</div>	
	</div>
	
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
					<th onclick="reSortAjax('sort_step_no');">진행상황</th>
					<th onclick="reSortAjax('sort_important');">유력</th>
					<th onclick="reSortAjax('sort_name');">담당자</th>
					<th onclick="reSortAjax('sort_user_company');">회사명</th>
					<th onclick="reSortAjax('sort_select_way');">선정방식</th>
					<th onclick="reSortAjax('sort_project_budget');">예산</th>
					<th onclick="reSortAjax('sort_known_path');">유입경로</th>
					<th onclick="reSortAjax('sort_submit_date');">문의 일자</th>
					<th onclick="reSortAjax('sort_update_date');">수정 일자</th>
					<th>코멘트</th>
<!-- 					<th onclick="reSortAjax('sort_user_type');">업종형태</th> -->
<!-- 					<th onclick="reSortAjax('sort_user_manager');">담당자명</th> -->
					<!--<th>연락처</th>
					<th>이메일</th>-->
<!-- 					<th onclick="reSortAjax('sort_service_type');">서비스</th> -->
<!-- 					<th onclick="reSortAjax('sort_project_type');">프로젝트 성격</th> -->
<!--  			        <th onclick="reSortAjax('sort_start_ymd');">착수 시점</th> -->
<!-- 					<th onclick="reSortAjax('sort_end_ymd');">오픈 예정일</th> -->
					<!--<th>기존 사이트 주소</th>
					<th>유입경로</th>-->
				</tr>
			</thead>
			<tbody id="list_target">
			
			</tbody>
		</table>
	</div>
	<div class="list_btn_wrap">
		<div class="down_bt list_down_bt" onclick="excelDown();">엑셀 다운로드</div>	
	</div>
	<jsp:include page="/WEB-INF/pages/family/common/paging_new.jsp"/>
</div>

<script>
$( document ).ready(function() {
	
	
	getCookie('listSize')      != '' ? $('#list_size').val(getCookie('listSize'))          : $('#list_size').val();
	getCookie('start_ymd')     != '' ? $('#start_ymd').val(getCookie('start_ymd'))         : $('#start_ymd').val();
	getCookie('end_ymd')       != '' ? $('#end_ymd').val(getCookie('end_ymd'))             : $('#end_ymd').val(); 
	getCookie('step')          != '' ? $('#step').val(getCookie('step'))                   : $('#step').val(); 
	getCookie('important')     != '' ? $('#important_project').val(getCookie('important')) : $('#important_project').val();
	getCookie('sale_manager')  != '' ? $('#sale_manager').val(getCookie('sale_manager'))   : $('#sale_manager').val();
	getCookie('sale_service')  != '' ? $('#sale_service').val(getCookie('sale_service'))   : $('#sale_service').val();
	getCookie('search_cont')   != '' ? $('#search_cont').val(getCookie('search_cont'))     : $('#search_cont').val();
	getCookie('upt_start_ymd') != '' ? $('#upt_start_ymd').val(getCookie('upt_start_ymd')) : $('#upt_start_ymd').val();
	getCookie('upt_end_ymd')   != '' ? $('#upt_end_ymd').val(getCookie('upt_end_ymd'))     : $('#upt_end_ymd').val();
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
});
</script>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
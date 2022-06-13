<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>


function getList()
{
	var use_yn="N";
	if(document.getElementById("use_yn").checked) 
	{
	    use_yn='Y';
	}
	
	
	setCookie("page", page);
	setCookie("order_by", order_by);
	setCookie("sort_type", sort_type);
	setCookie('start_ymd',$('#submit_date7').val());
	setCookie('end_ymd',$('#submit_date8').val());         
	setCookie('search_name',$('#search_name').val(),9999);         
	setCookie('content_search',$('#content_search').val());   
	setCookie('imsi_yn',$('#imsi_yn').val());  
	setCookie('doc_type_search',$('#doc_type_search').val());
	setCookie('step_search',$('#step_search').val());
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getDosignList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			
			search_name : $('#search_name').val(),
			start_ymd : $('#submit_date7').val(),
			end_ymd : $('#submit_date8').val(),
			doc_type_search : $('#doc_type_search').val(),
			content_search : $('#content_search').val(),
			step_search : $('#step_search').val(),
			imsi_yn : $('#imsi_yn').val(),
			use_yn : use_yn
			
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
				inner +='	<th>작성일</th>';
				inner +='	<th>상태</th>';
				inner +='</tr>';
				
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr onclick="javascript:location.href=\'detail?idx='+result.list[i].idx+'&doc_type='+result.list[i].doc_type+'\' ">';
					inner +='	<td>'+result.list[i].doc_type+'-'+result.list[i].doc_idx+'-'+result.list[i].idx+'</td>';
					inner +='	<td>'+result.list[i].kor_nm+'</td>';
					inner +='	<td>'+result.list[i].team_kr+'</td>';
					inner +='	<td>'+result.list[i].level_nm+'</td>';
					inner +='	<td>'+result.list[i].doc_name+'</td>';
					inner +='	<td>'+cutDate(result.list[i].submit_date)+'</td>';
					if (result.list[i].imsi_yn=='N') {
						inner +='	<td>'+result.list[i].step+'</td>';												
					}
					else
					{
						inner +='	<td>임시</td>';	
					}
					
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


function setCookie(cname,cvalue) {

	  var d = new Date();
	  var exdays = 1;
	  d.setTime(d.getTime() + (60*60*24));

	  var expires = "expires="+ d.toUTCString();

	  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";

	} 

function getCookie(cname) {

	  var name = cname + "=";

	  var decodedCookie = decodeURIComponent(document.cookie);

	  var ca = decodedCookie.split(';');

	  for(var i = 0; i <ca.length; i++) {

	    var c = ca[i];

	    while (c.charAt(0) == ' ') {

	      c = c.substring(1);

	    }

	    if (c.indexOf(name) == 0) {

	      return c.substring(name.length, c.length);

	    }

	  }

	  return "";

	} 
</script>



<div id="container">
	<div class="musign-grid">
	<div class="search-wr">
		<form id="searchForm" name="searchForm" autocomplete="off">
			<div class="table">
				<div class="wid-6 dosign_date">
					<div class="table">
						<div class="mid-da">
							<input id="submit_date7" class="date-i" name="start_ymd">일
						</div>
						<div class="mid-s">~</div>
						<div class="mid-da">	
							<input id="submit_date8" class="date-i" name="end_ymd">일	
						</div>
					</div>
				</div>
				<div class="wid-2 dosign_name">
					<input class="wid-10" type="text" id="search_name" name="search_name" placeholder="이름">
				</div>
				<div class="wid-4 dosign_detail">
					<input type="text" id="content_search" name="content_search" placeholder="내용" value=""><br>
				</div>
				
				
			</div>
			<div class="table">
				<div class="wid-2 dosign_all">
					<select id="imsi_yn" name="imsi_yn">
						<option value="">전체</option>
    					<option value="N">결재서류</option>
    					<option value="Y">임시서류</option>
					</select>
				</div>	
				<div class="wid-2 dosign_all dosign_responsive">
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
				
				
				<div class="wid-2 dosign_all">
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
				
				<div class="dosign_del" style="text-align:left; padding-left:6px;">
					퇴사자 포함 : <input type="checkbox" id="use_yn" name="use_yn" style="width:13px;"><br>
				</div>
				
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

<script>
$(document).ready(function() {


	
	
	getCookie('start_ymd') 		 != '' ? $('#submit_date7').val(getCookie('start_ymd')) 		 : $('#submit_date7').val();
	getCookie('end_ymd') 		 != '' ? $('#submit_date8').val(getCookie('end_ymd')) 			 : $('#submit_date8').val();
	getCookie('search_name') 	 != '' ? $('#search_name').val(getCookie('search_name')) 		 : $('#search_name').val();
	getCookie('content_search')  != '' ? $('#content_search').val(getCookie('content_search'))   : $('#content_search').val();
	getCookie('imsi_yn') 		 != '' ? $('#imsi_yn').val(getCookie('imsi_yn')) 				 : $('#imsi_yn').val();
	getCookie('doc_type_search') != '' ? $('#doc_type_search').val(getCookie('doc_type_search')) : $('#doc_type_search').val();
	getCookie('step_search') 	 != '' ? $('#step_search').val(getCookie('step_search')) 		 : $('#step_search').val();
	getCookie('use_yn') 		 != '' ? use_yn = getCookie('use_yn') 							 : use_yn;
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	
	
	getList();
});
</script>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
//일반유저
if ("${authChk}"=="-1") 
{
	alert("권한이 없습니다.");
	location.href="/family/dosign/list";
}

//관리자용
if ("${approval_wait}"!="" && "${isManager}"=="Y") 
{ 
	//결재라인에 관리자가 없다면 out
	var approval_line_arr = "${approval_line}".split("|");
	var temp = false;
	for (var i = 0; i < approval_line_arr.length; i++) {
		if (approval_line_arr[i] != "${myidx}") 
		{
			temp = true;
			break;
		}
	}
	
	if (temp == false) 
	{
		alert("권한이 없습니다.");
		location.href="/family/dosign/list";
	}
}

$(document).ready(function(){
	//getList();
	$('.conmment_div').hide();
	$('.return_div').hide();
	
	var attach_idx = "${attach_idx}";
	if (attach_idx!="") 
	{
		var attach_idx_arr = attach_idx.split('|');
		var attach_idx="";
		var doc_nm="";
		
		var inner ='';
		inner +='<h3>* 첨부문서</h3>';
		for (var i = 0; i < attach_idx_arr.length-1; i++) 
		{
			attach_idx = attach_idx_arr[i].split('-');
			
			if (attach_idx[0] =='100'){doc_nm = "근태신청서";}
			else if (attach_idx[0] =='101') { doc_nm = "지출결의서"; }
			else if (attach_idx[0] =='102') { doc_nm = "주말출근신청서"; }
			else if (attach_idx[0] =='103') { doc_nm = "연장근무신청서"; }
			else if (attach_idx[0] =='104') { doc_nm = "품의서"; }
			else if (attach_idx[0] =='105') { doc_nm = "포상신청서"; }
			
			inner +="<a class='win-btn' href=\"javascript:winOpen('/family/dosign/detail?idx="+attach_idx[2]+"&doc_type="+attach_idx[0]+"&isPop=Y')\">"+attach_idx_arr[i]+" | "+doc_nm+"</a> <br>";
		}
		
		$("#attach_link").html(inner);
		$("#attach_link").show();
	}
	else
	{
		$("#attach_link").hide();
	}
	
	if ("${isPop}"!="") 
	{
	    $('#header').hide();
	    $('#inb').hide();
	    $('#footer').hide();
	    $('#comment_area').hide();
	}
	
})

function winOpen(url)
{
    var name = "popup";
    var option = "width = 870, height = 900, top = 10, left = 200, location = no, scrollbars=yes";
    window.open(url, name, option);
    
}

function movePage(idx)
{
	var arr= idx.split('_');
	location.href='/family/dosign/detail?idx='+arr[0]+'&doc_type='+arr[1];
}
</script>
<div id="comment_area" class="all-detop table">

	<c:if test="${myidx eq user_idx && step eq '제출'}">
		<div class="text-right">		
			<a href="javascript:location.href='/family/allow/edit?idx=${idx}&doc_idx=${doc_idx}&doc_type=${doc_type}'"><input id="modify" type="button" value="수정"></a>
		</div>
	</c:if>

	<div class='conmment_div give_back_div02 on'><!-- 반려사유  display:none상태-->
		<div class="popup_wrapper">
			<h3>답변을 남겨주세요.</h3>
			<textarea id='comment' style="width:100%; height:150px;"></textarea><br>
			<div class="give-btn">
				<input type="button" value="전송" onclick='approve_chk("${idx}");'>
			</div>
		</div>
	</div>
	
	<div class='return_div give_back_div02 on'><!-- 반려사유  display:none상태-->
		<div class="popup_wrapper">
			<h3>반려 사유를 남겨주세요.</h3>
			<textarea id='return_comment' style="width:100%; height:150px;"></textarea><br>
			<div class="give-btn">
				<input type="button" value="전송" onclick='return_chk("${idx}");'>
			</div>
		</div>
	</div>
	<div>
		<c:if test="${prev_idx ne null}">
			<button class="dosign_btn" onclick="movePage('${prev_idx}');">이전</button>
		</c:if>
		
		<c:if test="${next_idx ne null}">
			<button class="dosign_btn" onclick="movePage('${next_idx}');">다음</button>
		</c:if>
		
		<button class="dosign_btn" onclick="javascript:location.href='/family/dosign/list'">목록</button>
	</div>
	
	
	<div id="attach_link" class="Attached section give_back_div02">

	</div>
	
</div>
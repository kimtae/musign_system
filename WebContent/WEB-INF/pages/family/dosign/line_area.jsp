<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>

$(document).ready(function(){
	getList();
})	

function getList()
{
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getApprovalLine",
		dataType : "text",
		data : 
		{
			idx : "${idx}",
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			if (result.isSuc =="fail") 
			{
				alert(result.msg);
				location.href="/main";
			}
			
			var approval_line = result.data.approval_line.split('|');
			var approval_chk = result.data.approval_chk.split('|');
			var approval_date = result.data.approval_date.split('|');
			var approval_content = result.data.approval_content.split('|');
			var myidx = '${myidx}';
			var user_idx = result.data.user_idx;	
			
			var top_inner ='';
			top_inner +='<td rowspan="2">결<br>재</td>';
			top_inner +='<td class="appro_td">신청자</td>';
			
			
			for (var i = 0; i < approval_line.length-1; i++) 
			{
				top_inner +='<td>'+convChmod(approval_line[i])+'</td>';	
			}

			var bottom_inner ='';
			bottom_inner+='<td><img src="/img/check_image.PNG" style="width:50px; height:50px;"></td>';
			
			for (var i = 0; i < approval_line.length-1; i++) 
			{
				
				bottom_inner+='<td>';
				
				if (
					myidx!=user_idx && 											//작성자가 아니고
					approval_chk[i]=="X" &&  									//승인자가 승인을 안했고
					approval_line[i]==result.data.approval_wait && 				//해당 승인자 차례고
					approval_line[i]==myidx && 									//자기것만 보여야하고
					approval_line[i]!=nullChk(result.data.return_idx) 			//반려하지 않았다면
					) 
				{
					
					bottom_inner+='		<input type="button" value="승인" onclick="show_comment(\'approve\')">';
					bottom_inner+='		<input type="button" value="반려" onclick="show_comment(\'return\')">';
				}
				
				else if(
					myidx==user_idx && 											//작성자이고
					approval_chk[i]=="X" &&  									//승인자가 승인을 안했고
					approval_line[i]==result.data.approval_wait && 				//해당 승인자 차례고
					nullChk(result.data.return_idx)!=result.data.approval_wait  //반려당하지 않았다면
					) 
				{
					//bottom_inner+='		<input type="button" value="승인" onclick="show_comment()">';
					bottom_inner+='		<input type="button" value="긴급메일" onclick="urgent_mail(\''+approval_line[i]+'\')">';
				}
				else if (
					approval_line[i]==approval_chk[i] && 						//승인자가 승인을 했고
					approval_line[i]!=result.data.approval_wait &&				//해당 승인자 차례가 아니라면
					nullChk(result.data.return_idx)!=approval_chk[i] 			//반려당하지 않았다면
					) 
				{
					bottom_inner+='		<img src="/img/check_image.PNG" style="width:50px; height:50px;"><br>'+cutDate(approval_date[i])+'<br>';
					if (approval_content[i]!="") {
						bottom_inner+='		<input type="button" value="확인" onclick="commemt_chk(\'${idx}\',\''+approval_line[i]+'\',\'approve\')">';
					}
				}
				else if (
					approval_line[i]==result.data.return_idx 					//결재라인에 반려가 있다면
					//&& result.data.return_idx==result.data.approval_wait 			
					) 
				{
					bottom_inner+='		<input type="button" value="반려" onclick="commemt_chk(\'${idx}\',\''+approval_line[i]+'\',\'return\')">';
				}
				else
				{
				//	console.log("myidx :"+myidx);
				//	console.log("user_idx :"+user_idx);
				//	console.log("approval_line :"+approval_line[i]);
				//	console.log("approval_chk :"+approval_chk[i]);
				//	console.log("approval_wait :"+result.data.approval_wait);
					bottom_inner+='';
				}
				bottom_inner+='</td>';
			}
			
			$('#approval_line_top').html(top_inner);
			$('#approval_line_bottom').html(bottom_inner);
			end_loading();
		}
	});
}

function urgent_mail(user_idx)
{
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./urgent_mail",
		dataType : "text",
		data : 
		{
			idx : "${idx}",
			target_idx : user_idx,
			doc_type : "${doc_type}"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			//if (result.isSuc =="fail") 
			//{
				alert(result.msg);
				//location.href="/main";
			//}
			
			end_loading();
		}
	});
}

</script>

<div class="sec sec1">
		<ul class="box-l">
       		<li>문서번호 : ${doc_type}-${doc_idx}-${idx}</li>
       		<li>작성일자 : 
       		
       		<fmt:parseDate value="${submit_date}" var="fmt_date" pattern="yyyyMMddHHmmss"/>
			<fmt:formatDate value="${fmt_date}" pattern="yyyy.MM.dd"/>
       		
       		</li>
   			<li>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속 : ${writer_team_nm}</li>
   			<li>직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위 : ${writer_chmod_nm}</li>
   			<li>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명 : ${writer_nm}</li>
		</ul>
		<table class="box-r">
				<colgroup>
					<col width="46px">
					<col width="84px">
					<col width="84px">
					<col width="84px">
				</colgroup>
				<tbody>
	
				<tr id="approval_line_top">
				
				</tr>
				<tr id="approval_line_bottom">
				
				</tr>
		</tbody>
	</table>
</div>
<div class="sec inner">
	<!-- 최종 결재시 보이게 -->
	<c:if test="${final_date ne null}">
  	 최종 결재일 : <fmt:parseDate value="${final_date}" var="fmt_date" pattern="yyyyMMddHHmmss"/><fmt:formatDate value="${fmt_date}" pattern="yyyy.MM.dd"/>
  	</c:if>
</div>
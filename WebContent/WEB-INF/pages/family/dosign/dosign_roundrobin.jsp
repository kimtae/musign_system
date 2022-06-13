<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/inc/js/dosign.js"></script>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	
	if ("${title}"!="") 
	{
		$('#rr_title').text( repWord("${title}"));
	}
	
	if ("${purpose}"!="") 
	{
		$('#rr_purpose').text( repWord("${purpose}"));
	}
	
	if ("${company}"!="") 
	{
		$('#rr_company').text( repWord("${company}"));
	}
	
	if ("${cont}"!="") 
	{
		$('#rr_cont').val( repWord("${cont}"));
	} 
	getInfo();
	
	var ref_team_nm="${ref_team_nm}";
	var ref_nm ="${ref_nm}";
	
	if (ref_nm!="") 
	{
		ref_nm=ref_nm.split('|');
		ref_team_nm=ref_team_nm.split('|');
		var inner ='';
			inner +='<tr>';
			inner +='	<td rowspan="2" >협조부서</td>';
		for (var i = 0; i < ref_team_nm.length-1; i++) {
			inner +='	<td class="ref_td">'+ref_team_nm[i]+'</td>';
		}
			inner +='</tr>';
			inner +='<tr>';
		
		for (var i = 0; i < ref_nm.length-1; i++) {
			inner +='	<td>'+ref_nm[i]+'</td>';
		}
			inner +='</tr>';
		$("#ref_area").show();
		$("#ref_target").html(inner);
	}
	
})

function getInfo(){
	var detail_cont = "${detail_cont}".split('|');
	var detail_amt = "${detail_amt}".split('|');
	var detail_receipt = "${detail_receipt}".split('|');
	var detail_receipt_ori = "${detail_receipt_ori}".split('|');
	
	var inner="";
	var sum=0;
	for (var i = 0; i < detail_cont.length-1; i++) 
	{
		sum +=detail_amt[i]*1; 
		inner +='<tr>';
		inner +='<th>'+(i+1)+'</th>';
		inner +='<th colspan="3">'+detail_cont[i]+'</th>';
		inner +='<th>'+comma(detail_amt[i])+'</th>';
		
		
		if (nullChk(detail_receipt[i])!='') 
		{
			inner +='<th colspan="2">';
			inner +="	<img src='/img/doc_icon.png' style='width:50px; height:50px;' onclick=\"window.open('${image_dir}rr_receipt/"+detail_receipt[i]+"', 'imgView', 'width=500', 'height=500')\">";
			inner +='</th>';
		}
		else
		{
			inner +='<th colspan="2">등록된 영수증이<br> 없습니다.</th>';
		}
		inner +='</tr>';
	}
	
	inner +="<tr>";
	inner +='<th colspan="6">합계 : '+comma(sum)+'</th>';
	inner +="</tr>";

	$('#list_area').after(inner);
	
	
}

</script>
<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>품의서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">

					<div id="ref_area">
		    			<span style="display: table;margin: 0 auto;">최&nbsp;종&nbsp;결&nbsp;재&nbsp;권&nbsp;자&nbsp;의 &nbsp;&nbsp;의&nbsp;견 &nbsp;&nbsp;및 &nbsp;&nbsp;지&nbsp;시&nbsp;사&nbsp;항</span>
		    			<table class="box-r" border='1'>
		    				<colgroup>
		    					<col width="46px">
		    					<col width="84px">
		    					<col width="84px">
		    					<col width="84px">
		    				</colgroup>
		    				<tbody id="ref_target">

		    				</tbody>
		    			</table>
		    		</div>
	    			
	    			<table>
	    				<tr>
	    					<td >제목</td> 
	    					<td colspan="6" id="rr_title"></td>
	    				</tr>

	    				<tr>
	    					<td colspan="6" class="text-left">
	    						1. 목적 : <span id="rr_purpose"></span><br>
	    						2. 업체 : <span id="rr_company"></span><br>
	    						3. 용역기간 : ${start_ymd} ~ ${end_ymd}<br>
	    						4. 내용 : <textarea id="rr_cont" readonly="readonly"></textarea><br>
	    					</td>
	    				</tr>
           		        <tr id="list_area">
           		        	<th class="color-g">No.</th>
           		        	<th class="color-g" colspan="3">내용</th>
           		        	<th class="color-g">금액</th>
           		        	<th class="color-g" colspan="2">영수증보기</th>
           		        </tr>
	    			</table>

			   </div>
			<div class="sec sec3">
				<p>위와 같은 사유로 품의하고자 하오니 결재하여 주시기 바랍니다.</p>
			</div>
		</div>
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
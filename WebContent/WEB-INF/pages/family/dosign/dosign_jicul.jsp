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
		$('#jicul_title').text(repWord("${title}"));
	}

	if ("${purpose}"!="")
	{
		$('#jicul_purpose').text(repWord("${purpose}"));
	}
	
	if ("${company}"!="")
	{
		$('#jicul_company').text(repWord("${company}"));
	}
	
	if ("${cont}"!="") 
	{
		$('#jicul_cont').val(repWord("${cont}"));
	}

	getInfo();
})

function getInfo(){
	var detail_cont = "${detail_cont}".split('|');
	var detail_amt = "${detail_amt}".split('|');
	var detail_receipt = "${detail_receipt}".split('|');
	var detail_receipt_ori = "${detail_receipt_ori}".split('|');
	
	var inner="";
	for (var i = 0; i < detail_cont.length-1; i++) {
		inner +='<tr>';
		inner +='	<th>'+(i+1)+'</th>';
		inner +='	<th colspan="3">'+detail_cont[i]+'</th>';
		inner +='	<th>'+comma(detail_amt[i])+'</th>';
		
		if (nullChk(detail_receipt[i])!='') 
		{
			inner +='<th colspan="2">';
			inner +="	<img src='/img/doc_icon.png' style='width:50px; height:50px;' onclick=\"window.open('${image_dir}jicul_receipt/"+detail_receipt[i]+"', 'imgView', 'width=500', 'height=500')\">";
			inner +='</th>';
		}
		else
		{
			inner +='<th colspan="2">등록된 영수증이<br> 없습니다.</th>';
		}
		inner +='</tr>';
	}
	$('#list_area').after(inner);
	
	
}

</script>
<div id="container">
	<div class="musign-grid musign-grid02">
		<jsp:include page="/WEB-INF/pages/family/dosign/comment_area.jsp"/>
		<div id="mySelector" class="container">
			<h2>지출결의서</h2>
					<jsp:include page="/WEB-INF/pages/family/dosign/line_area.jsp"/>
			   <div class="sec sec2">
			    <table border="1">
			    
					<tr>
						<th rowspan="2" class="color-g">경비구분</th>
						<td rowspan="2"> ${use_method}</td>
						<th rowspan="2" class="color-g">결제수단</th>
						<td rowspan="2"> ${pay_method}</td>
						<th class="color-g">신청일자</th>
						<td><fmt:parseDate value="${submit_date}" var="fmt_date" pattern="yyyyMMddHHmmss"/><fmt:formatDate value="${fmt_date}" pattern="yyyy-MM-dd"/> </td>
					</tr>
					
					<tr>			
						<th class="color-g">지출일</th>
						<td>${pay_date}</td>
					</tr>
					
					<tr>
						<th class="color-g">제목</th>
						<td colspan="5" id="jicul_title"></td>
					</tr>
					
					<tr>
						<th class="color-g">내역 및 용도</th>
						<td colspan="5" class="text-left">
							1. 목적 : <span id="jicul_purpose"></span><br> 
							2. 업체 : <span id="jicul_company"></span><br> 
							3. 기타내용 : <textarea id="jicul_cont" readonly="readonly"></textarea><br> 
						</td>
					</tr>
					
			        <tr id="list_area">
			        	<th class="color-g">No.</th>
			        	<th class="color-g" colspan="3">내용</th>
			        	<th class="color-g">금액</th>
			        	<th class="color-g" colspan="2">영수증보기</th>
			        </tr>
			        
					<tr>
						<th class="color-g">총 금액</th>
						
						<td colspan="5" id="total_amt"><fmt:formatNumber value="${total_amt }" pattern="#,###"/></td>
					</tr>
					
				</table>
			</div>
			<div class="sec sec3">
				<p>위와 같이 지출하고자 하오니 결재바랍니다.</p>
			</div>
		</div>
		
		<c:if test="${isManager eq 'Y'}">
			<input type="button" value="결재" onclick="final_approve('${idx}')">
			<input type="button" value="반려" onclick="show_comment('return')">
		</c:if>
		
		<c:if test="${step eq '반려'}">
			<c:if test="${return_idx ne null}">
				<input type="button" value="반려 확인" onclick="javascript:alert('${return_why}');">
			</c:if>
		</c:if>
		
	</div>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
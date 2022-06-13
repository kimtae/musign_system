<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>

//불러오기 세팅
$(document).ready(function(){	
	var step = "${step}";
	if (step =='제출' || step=='임시') 
	{
		var f = document.fncForm;
		
		var attach_idx_arr = "${attach_idx}".split("|");
		for (var i = 0; i < attach_idx_arr.length-1; i++) 
		{
			add_attach(attach_idx_arr[i]);
		}
		
		var approval_line_arr = "${approval_line}".split("|");
		temp_line = document.getElementsByName("approval_line");
		for (var i = 0; i < approval_line_arr.length-1; i++) 
		{
			add_approval();
			temp_line[i].value = approval_line_arr[i];
		}
		
		var ref_line_arr = "${ref_line}".split("|");
		temp_line = document.getElementsByName("ref_line");
		for (var i = 0; i < ref_line_arr.length-1; i++) 
		{
			add_ref();
			temp_line[i].value = ref_line_arr[i];
		}
		
		f.jicul_use_method.value = "${use_method}";
		f.jicul_pay_method.value = "${pay_method}";
		f.jicul_pay_date.value = "${pay_date}";
		f.jicul_title.value = "${title}";
		f.jicul_purpose.value = "${purpose}";
		f.jicul_company.value = "${company}";
		f.jicul_cont.value = repWord("${cont}");
		
		var detail_cont_arr = "${detail_cont}".split("|");
		var detail_amt_arr = "${detail_amt}".split("|");
		var detail_receipt_arr = "${detail_receipt}".split("|");
		var detail_receipt_ori_arr = "${detail_receipt_ori}".split("|");
		
		//첨부자료 세팅
		for (var i = 0; i < detail_cont_arr.length-1; i++) {
			$('#detail_cont_'+i).val(detail_cont_arr[i]);
			$('#detail_pay_'+i).val(detail_amt_arr[i]);
			$('#detail_receipt_nm_'+i).val(detail_receipt_ori_arr[i]);
			$('#detail_receipt_nm_'+i).attr("onclick","window.open('${image_dir}jicul_receipt/"+detail_receipt_arr[i]+"', 'imgView', 'width=500', 'height=500')");
			
			//다음 값이 비어있지 않다면 실행
			if (detail_cont_arr[i+1] !='') 
			{
				add_jicul_detail();				
			}
		}

		
	}
})


function fncSubmit(way)
{
	
	var f = document.fncForm;
	var total_amt =0;
	
	var temp ="";
	temp_line = document.getElementsByName("approval_line");	//결재라인값 세팅
	var approval_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {

    	if (temp_line[i].value!="") {
    		approval_line += temp_line[i].value+'|';
		}
	}

    temp_line = document.getElementsByName("ref_line");		//참조라인값 세팅
    var ref_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].value!="") {
    		ref_line += temp_line[i].value+'|';
    	}
	}
    
	temp_line = document.getElementsByName("attach_idx");	//첨부문서값 세팅
	var attach_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {

    	if (temp_line[i].innerText!="") {
    		attach_line += temp_line[i].innerText+'|';
		}
	}
    
    temp_line = document.getElementsByClassName("upload-name");	//첨부파일 세팅
	var fileNm_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {

    	if (temp_line[i].value!="") {
    		fileNm_line += temp_line[i].value+'|';
		}
	}
    
    if (approval_line=="|" || approval_line=="")
    {
		alert("결재라인을 선택해주세요.");
		return;
	}
	
	if (isEmpty(f.jicul_pay_date)) 
	{
		alert("지출일을 채워주세요.");
		f.jicul_pay_date.value = "";
		f.jicul_pay_date.focus();
		return false;
	}
	
	if (isEmpty(f.jicul_title)) 
	{
		alert("제목을 채워주세요.");
		f.jicul_title.value = "";
		f.jicul_title.focus();
		return false;
	}
	
	if (isEmpty(f.jicul_purpose)) 
	{
		alert("목적을 채워주세요.");
		f.jicul_purpose.value = "";
		f.jicul_purpose.focus();
		return false;
	}
	
	if (isEmpty(f.jicul_company)) 
	{
		alert("업체를 채워주세요.");
		f.jicul_purpose.value = "";
		f.jicul_purpose.focus();
		return false;
	}

	
	var detail_cont_arr = document.getElementsByName("detail_cont");
	var detail_pay_arr = document.getElementsByName("detail_pay");
	var detail_receipt_arr = document.getElementsByClassName("detail_receipt");
	var detail_receipt_nm_arr = document.getElementsByName("detail_receipt_nm");
	
	var detail_cont_list = "";
	var detail_pay_list ="";
	//var detail_receipt_list ="";
	
    for (var i = 0; i < detail_cont_arr.length; i++) 
    {	
    	if (isEmpty(detail_cont_arr[i]))
    	{
    		alert("내용를 입력해주세요.");
    		detail_cont_arr[i].value = "";
    		detail_cont_arr[i].focus();
    		return false;
    	}
    	
    	if (isEmpty(detail_pay_arr[i]))
    	{
    		alert("금액을 입력해주세요.");
    		detail_pay_arr[i].value = "";
    		detail_pay_arr[i].focus();
    		return false;
    	}
    	else if(isNotNumber(detail_pay_arr[i]))
    	{
    		alert("숫자만 입력해주세요.");
    		detail_pay_arr[i].value = "";
    		detail_pay_arr[i].focus();
    		return false;
    	}
    	
    	if (isEmpty(detail_receipt_nm_arr[i]))
    	{
    		alert("영수증을 등록해주세요.");
    		return false;
    	}
    	
    	detail_cont_list += detail_cont_arr[i].value+'|';
    	detail_pay_list += detail_pay_arr[i].value+'|';
    	total_amt += Number(detail_pay_arr[i].value); 
    	//detail_receipt_list += detail_receipt_arr[i].value.match(/[^\\]+$/)+'|';
	}
    f.approval_line_store.value = approval_line;
    f.ref_line_store.value = ref_line;
    f.detail_cont_list.value = detail_cont_list;
    f.detail_pay_list.value = detail_pay_list;
    f.total_amt.value = total_amt;
    f.imsi_yn.value = way;
    f.attach_store.value = attach_line;
    f.fileNm_list.value = fileNm_line;
    
    f.action="write_jicul";
    f.enctype="multipart/form-data";
    start_loading();
	$("#fncForm").ajaxSubmit({ 
		success: function(data)
		{
			console.log(data);
    		if (data.isSuc=="success") 
    		{
				alert(data.msg);
				location.href="/family/dosign/list";
			}
    		else
			{
				alert(data.msg);
				location.href="/family/main";
			}
    		end_loading();
		}
	});

	
}
</script>

	<table class="board-lay board-mo">		
		<tr>
			<th>경비구분</th>
			<td>
				<select id="jicul_use_method" name="jicul_use_method">
					<option value="교통비">교통비</option>
					<option value="광고비">광고비</option>
					<option value="외주용역비">외주용역비</option>
					<option value="물품구입비">물품구입비</option>
					<option value="식대비">식대비</option>
					<option value="기타">기타</option>
				</select>
			</td>
		</tr>    					
		
		<tr>
			<th>카드번호</th>
			<td>
				<select id="jicul_pay_method" name="jicul_pay_method">
					<option value="14">미결제(카드결제)</option>
					<option value="15">미결제(계좌이체)</option>
					<option value="16">결제(개인카드)</option>
					
					<c:forEach var="j" items="${cardList}" varStatus="loop">
						<option value="${j.idx}">결제( ${j.bank} : ${j.account_num} )</option>
					</c:forEach>
				</select>
			</td>
		</tr>

		<tr>
			<th>지출일</th>
			<td><input id="jicul_pay_date" name="jicul_pay_date" class="date-i" value="" readonly="readonly">&nbsp;&nbsp;<span class="jicul_date">일</span></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input id="jicul_title" name="jicul_title"></td>
		</tr>
		<tr>
			<th>목적</th>
			<td><input id="jicul_purpose" name="jicul_purpose"></td>
		</tr>
		
		<tr>
			<th>업체</th>
			<td><input id="jicul_company" name="jicul_company"></td>
		</tr>

		<tr>
			<th>기타 내용</th>
			<td><textarea id="jicul_cont" name="jicul_cont"></textarea><br><br>
				<span class="jicul_ad">*계좌이체시 통장사본, 사업자 등록증 첨부</span>
			</td>
		</tr>
		
		<tr>
			<th></th>
			<td class="jicul_contbox">
				<div id="jicul_detail">
					<div>
						<span class="jicul_br">
							<span>
							내용 : <input type="text" id="detail_cont_0" name="detail_cont">						
							금액 : <input type="text" id="detail_pay_0" name="detail_pay">
							</span>
							<span class="file_height">
							<label for="detail_receipt_0">파일첨부</label>
							 <input id="detail_receipt_nm_0" name="detail_receipt_nm" class="upload-name" value="" readonly="readonly">							
							 <input type="file" id="detail_receipt_0" class="detail_receipt" name="detail_receipt_0" onchange="checkSize(this,0)">
							 <input type="button" value="+추가" class="btn-add" onclick="add_jicul_detail()">
							 </span>
						

						</span>
						
							 
						
					</div>
				</div>
			</td>
		</tr>
 	</table>  			

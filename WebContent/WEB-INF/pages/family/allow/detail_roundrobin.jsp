<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
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
		
		f.rr_title.value = "${title}";
		f.rr_purpose.value ="${purpose}";
		f.rr_company.value="${company}";
		f.start_ymd.value = "${start_ymd}";
		f.end_ymd.value="${end_ymd}";
		f.rr_cont.value =repWord("${cont}");
		
		var detail_cont_arr = "${detail_cont}".split("|");
		var detail_amt_arr = "${detail_amt}".split("|");
		var detail_receipt_arr = "${detail_receipt}".split("|");
		var detail_receipt_ori_arr = "${detail_receipt_ori}".split("|");
		//첨부자료 세팅
		for (var i = 0; i < detail_receipt_arr.length-1; i++) 
		{
			$('#detail_cont_'+i).val(detail_cont_arr[i]);
			$('#detail_pay_'+i).val(detail_amt_arr[i]);
			$('#detail_receipt_nm_'+i).val(detail_receipt_ori_arr[i]);
			$('#detail_receipt_nm_'+i).attr("onclick","window.open('${image_dir}rr_receipt/"+detail_receipt_arr[i]+"', 'imgView', 'width=500', 'height=500')");
			//다음 값이 비어있지 않다면 실행
			if (detail_receipt_arr[i+1] !='') 
			{
				add_rr_detail();				
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

    temp_line = document.getElementsByName("ref_line");			//참조라인값 세팅
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
    
    if (isEmpty(f.rr_title)) 
	{
		alert("제목을 채워주세요.");
		f.rr_title.value = "";
		f.rr_title.focus();
		return false;
	}
    
    if (isEmpty(f.rr_purpose)) 
	{
		alert("목적을 채워주세요.");
		f.rr_purpose.value = "";
		f.rr_purpose.focus();
		return false;
	}
    
    if (isEmpty(f.rr_company)) 
	{
		alert("용업 업체를 채워주세요.");
		f.rr_company.value = "";
		f.rr_company.focus();
		return false;
	}
    
    if (isEmpty(f.start_ymd)) 
	{
		alert("용업 시작일을 채워주세요.");
		f.start_ymd.value = "";
		f.start_ymd.focus();
		return false;
	}
    
    if (isEmpty(f.end_ymd)) 
	{
		alert("용업 종료일을 채워주세요.");
		f.end_ymd.value = "";
		f.end_ymd.focus();
		return false;
	}
    
	//신청일자 데이트 형식으로 포멧
	var start_ymd =f.start_ymd.value.split('-');
	var date_start = new Date(start_ymd[0], start_ymd[1], start_ymd[2] ,00,00);
	
	var end_ymd =f.end_ymd.value.split('-');
	var date_end = new Date(end_ymd[0], end_ymd[1], end_ymd[2] ,11,59);
	
	//신청일자비교
    if(date_end <= date_start)
    {
      alert('용역일자를 확인해주세요.');
      return;
    }
    
    
    if (isEmpty(f.rr_cont)) 
	{
		alert("내용을 채워주세요.");
		f.rr_cont.value = "";
		f.rr_cont.focus();
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
    	
    	/*
    	if (isEmpty(detail_receipt_nm_arr[i]))
    	{
    		alert("영수증을 등록해주세요.");
    		return false;
    	}
    	*/
    	
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
    
    f.action="write_roundrobin";
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

	
	
	<table class="board-lay pum_width">
		<tr>
			<th>제목</th>
			<td><input type="text" name="rr_title" class="pum"></td>
		</tr>
                  <!-- yeongjae -->
		<tr>
			<th>목적</th>
			<td>
				<input name="rr_purpose">
 				</td>
		</tr>
		<tr>
			<th>업체</th>
			<td>
				<input name="rr_company">
 			</td>
		</tr>
		<tr>
			<th>용역기간</th>
			<td>
				<input name="start_ymd" class="date-i" readonly="readonly">
				&nbsp;~&nbsp;
				<input name="end_ymd" class="date-i" readonly="readonly">
 			</td>
		</tr>
			<!-- yeongjae END -->
		<tr>
			<th>내용</th>
			<td><textarea name="rr_cont"></textarea></td>
		</tr>
		
		<tr>
			<th></th>
			<td class="">
				<div id="rr_detail">
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
							 <input type="button" value="+추가" class="btn-add" onclick="add_rr_detail()">
						</span>
							 
						
						</span>
					
							 
						
					</div>
				</div>
			</td>
		</tr>
	</table>
		
  			
  	<div class="allow-cap">
		<h4>*작성법</h4>
  		<ul>
			<li> 목적 : 품의 목적 기재</li>
			<li>업체명 : 해당 거래처 기재</li>
			<li>증빙구분 : 세금계산서, 영수증, INVOICE 등 증빙구분하여 기재</li>
			<li>증빙일자 : 해당 증빙일자를 기재 (세금계산서 작성일, 영수증 발급일 등)</li>
			<li>지급요청일 : 해당 비용품의건에 대한 지급요청일을 기재 <br>
				- 사전 협의되지 않은 건에 대해서는, 회사 규정대로 집행</li>
			<li>지급방법 : 계좌이체, 현금지급 등 자금집행요청방법을 기재</li>
			<li>지급금액 : 해당 비용품의건에 대한 지급금액을 아라비아 숫자로 기재</li>
			<li>지급내역 : 해당 건에 대한 간략한 내역 기재</li>
			<li>협조부서 : 협조부서를 추가하여 추가 결재까지 확인</li>
		 </ul>
	</div>

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
		
		f.prize_target.value = "${target}";
		f.prize_cont.value ="${cont}";
		f.prize_value.value = "${prize_value}";
		
		
	}
})
	
function fncSubmit(way)
{
	var f = document.fncForm;
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
    
    if (approval_line=="|" || approval_line=="")
    {
		alert("결재라인을 선택해주세요.");

	}
    
    if (isEmpty(f.prize_cont)) 
	{
		alert("포상사유를 채워주세요.");
		f.prize_cont.value = "";
		f.prize_cont.focus();
		return false;
	}
    
    
    if (isEmpty(f.prize_value)) 
	{
		alert("포상일수를 채워주세요.");
		f.prize_value.value = "";
		f.prize_value.focus();
		return false;
	}
    
    if (isNotNumber(f.prize_value)) 
	{
		alert("숫자로 채워주세요.");
		f.prize_value.value = "";
		f.prize_value.focus();
		return false;
	}
    
    f.approval_line_store.value = approval_line;
    f.ref_line_store.value = ref_line;
    f.imsi_yn.value = way;
    f.attach_store.value = attach_line;
    
    f.action="write_prize";
    f.enctype="";
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
	<table class="board-lay prize_width">
		<tr>
			<th>포상대상</th>
			<td>
				<select name="prize_target" style="width:132px;">
					<c:forEach var="j" items="${getUserList}" varStatus="loop">
						<option value="${j.idx}">${j.name} ${j.level_nm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>포상연도</th>
			<td>
				<select name="prize_target_year" style="width:80px;">
					<option value="2023">2023</option>
					<option value="2022">2022</option>
					<option value="2021" selected="selected">2021</option>
					<option value="2020">2020</option>
				</select>
			</td>
		</tr>
			
		<tr>
			<th>포상사유<br>*육하원칙에 따라<br> 작성해주십시오.</th>
			<td><textarea name="prize_cont"></textarea></td>
		</tr>	
		
		<tr>
			<th>포상일수</th>
			<td><input type="text"  name="prize_value" class="prize_date">&nbsp;&nbsp;<span class="jicul_date">일</span></td>
		</tr>
	</table>

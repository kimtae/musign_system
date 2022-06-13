<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<style>
.detail_receipt{display: none;}
.Information_wrap .edit,
.check_wrap .edit {position:relative;}
.Information_wrap .edit:before,
.check_wrap .edit:before {
	content:'';
	display:inline-block;
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:transparent;
	z-index:11111;
}

</style>

<script>
var sale_auth = "<%=session.getAttribute("sale_auth")%>";
var link = location.href;

if (sale_auth == 'N') 
{
	alert("페이지 권한이 없습니다.");
	location.href = "/family/main";
}

$(window).scroll(function(){

    try {
        var winST = $(window).scrollTop();
        var winH = $(window).height();
        var gnbT = 0;
        var oft = $(".bottom_hide").offset().top;
        if(winST > gnbT )
        {
            $(".side_info_box").addClass("fixed");
            if (winST >= oft - winH)
            {
                $(".side_info_box").addClass("fixed-bottom");
            }
            else
            {
                $(".side_info_box").removeClass("fixed-bottom");
            }
        }
        else
        {
            $(".side_info_box").removeClass("fixed");
        }
    }
    catch(e) {

    }
});
$(document).ready(function(){
	
	
	$("body").addClass("body-board-write body-sales-write")
	//////////// lnb active ////////////
	$(".lnb-menu > li").find(".enrollment").addClass("active");
	
	var isSuc="${isSuc}";
	if (isSuc=="fail") 
	{
		alert("${msg}");
		location.href="/main";
	}
	
	var idx ='${idx}';
	if (idx!='') 
	{
		
		//////////// lnb active ////////////
		$(".lnb-menu > li").find(".enrollment").removeClass("active");
		$(".lnb-menu > li").find(".write").addClass("active");

		//////////// 그저 수정 기능을 위한 세팅 ///////////////////
		$('.qna td').each(function(){ 
			$(this).addClass('edit');
		})
		
		$('.Information td').each(function(){ 
		if (nullChk($(this).attr('id'))!='file_area') 
		{
			$(this).addClass('edit');
		}
		})
		
		$('#site_url').attr('readonly',true);
		$('#project_cont').attr('readonly',true);
		
		$('#start_ymd').hide();
		$('#end_ymd').hide();
		$('#start_ymd_for_show').show();
		$('#end_ymd_for_show').show();
		$('#start_ymd_for_show').val("${start_ymd}");
		$('#end_ymd_for_show').val("${end_ymd}");
		////////////그저 수정 기능을 위한 세팅 ///////////////////
		
		var f = document.fncForm;
		$('#step1_date').text(cutDate("${submit_date}"));
		$('#step2_date').text(cutDate("${manager_date}"));
		$('#step3_date').text(cutDate("${sale_date}"));
		
		//계약 or 페스 전이고 협의중이라면 show
		if("${sale_date}" !="" && "${contract_yn}"=="N")
		{
			$('#contract_y').show();
			$('#contract_n').show();
		}
		
		//계약이나 페스가 되었다면 hide
		if ("${step}" == '4' || "${step}" =='5') 
		{
			$('#contract_y').hide();
			$('#contract_n').hide();
		}
		
		//if ("${contract_date}" !="" && "${contract_yn}" =='Y') 
		if ("${step}" == '4') 
		{
			$('#step4').addClass("state_fit");
			$('#step4_date').text(cutDate("${contract_date}"));
		}
		
		//프로젝트가 페스 되었다면
		if ("${step}" == '5') 
		{
			$('#step4').addClass("state_fit");
			$('#step4').text('패스');
		}
		//계약 성공이라면
		else if ("${step}" == '4') 
		{
			$('#step4').addClass("state_fit");
			$('#step4_date').text(cutDate("${contract_date}"));
		}
		else if("${step}" == '3')
		{
			$('#step3').addClass("state_fit");
		}
		else if("${step}" == '2')
		{
			$('#step2').addClass("state_fit");
		}
		else 
		{
			$('#step1').addClass("state_fit");
		}
		
		f.sale_manager.value ="${manager_idx}";
		
		//$('#manager_nm').text(nullChk(f.sale_manager.options[f.sale_manager.selectedIndex].text));
		
		f.user_company.value="${user_company}";
		f.user_type.value="${user_type}";
		f.user_manager.value="${user_manager}";
		f.user_phone.value="${user_phone}";
		f.user_email.value="${user_email}";
		
		
		if ("${important_yn}"=="Y") 
		{
			f.important_yn.checked=true;	
		}
		
		if ("${info_yn}"=="Y") 
		{
			f.info_yn.checked=true;	
		}
		/*
		if ("${market_yn}"=="Y") {
			f.market_yn.checked=true;	
		}
		*/
		f.user_biz_no.value="${user_biz_no}";
		
		if ("${file}"!="") 
		{
			var file_arr = "${file}".split("|");
			var file_or_arr = "${file_ori}".split("|"); 
			for (var i = 0; i < file_or_arr.length-1; i++) 
			{
				add_file();
				$('#detail_receipt_nm_'+i).val(file_or_arr[i]);
				var url ="";
				var url_chk = file_arr[i].split('/');
				if (url_chk[1]=="upload") 
				{
					url = "https://musign.net"+file_arr[i];	
				}
				else
				{
					url = "${image_dir}sales_receipt/"+file_arr[i];					
				}
				$('#detail_receipt_nm_'+i).attr("onclick","window.open('"+url+"', 'imgView', 'width=500', 'height=500')");
			}
		}
		
		//첨부파일 버튼 비활성화용
		$('.filebtn').hide();

		
		var service_type_arr =  "${service_type}".split("|");
		var service_line = document.getElementsByName("service_type");
		for (var i = 0; i < service_type_arr.length-1; i++) 
		{
			for (var j = 0; j < service_line.length; j++) 
			{
				if (service_line[j].value==service_type_arr[i]) 
				{
					service_line[j].checked=true;
				}
			}
		}
		
		var project_type_arr =  "${project_type}".split("|");
		var project_line = document.getElementsByName("project_type");
		for (var i = 0; i < project_type_arr.length-1; i++) 
		{
			for (var j = 0; j < project_line.length; j++) 
			{
				if (project_line[j].value==project_type_arr[i]) 
				{
					project_line[j].checked=true;
				}
			}
		}
		
		var budget_line = document.getElementsByName("project_budget");
		for (var i = 0; i < budget_line.length; i++) 
		{
			if (budget_line[i].value == "${project_budget}") 
			{
				budget_line[i].checked=true;
			}
		}
		$('#start_ymd').val("${start_ymd}");
		$('#end_ymd').val("${end_ymd}");
		
		var select_way_line = document.getElementsByName("select_way");
		for (var i = 0; i < select_way_line.length; i++) 
		{
			if (select_way_line[i].value == "${select_way}") 
			{
				select_way_line[i].checked=true;
			}
		}
		
		f.site_url.value="${site_url}";
		f.project_cont.value=repWord("${project_cont}");
		
		var known_path_arr =  "${known_path}".split("|");
		var known_path_line = document.getElementsByName("known_path");
		for (var i = 0; i < known_path_arr.length-1; i++) 
		{
			for (var j = 0; j < known_path_line.length; j++) 
			{
				if (known_path_line[j].value==known_path_arr[i]) 
				{
					known_path_line[j].checked=true;
				}
			}
		}
		
		f.comment.value =repWord("${comment}");
		
	}
	
	//견적금액 항목 추가시 "견적내용"칸 자동조절
	$(".btn_price").click(function(){
		var _height = $(".progress_wrap").height();
		$(".progress_wrap > h3").height(_height);
		$(".progress_wrap > h3").css("line-height",_height+"px");
	})
	
})

var detail_cnt=0;
function add_file()
{
	var inner = "";
	inner += '<div id="detail_'+detail_cnt+'">';
	inner += '	<input id="detail_receipt_nm_'+detail_cnt+'" class="upload-name file_nm" name="detail_receipt_nm" value="" readonly="readonly">';
	inner += '	<input type="file" id="detail_receipt_'+detail_cnt+'" class="detail_receipt" name="detail_receipt_'+detail_cnt+'" onchange="checkSize(this,'+detail_cnt+')">';
	inner += '	<label class="filebtn" for="detail_receipt_'+detail_cnt+'">+</label>';
	inner += '	<input type="button" value="-" class="btn-del filebtn" onclick="del_detail('+detail_cnt+')">';
	inner += '	<br>';
	inner += '</div>';
	$("#file_area").append(inner);
	detail_cnt ++;
}

function del_detail(idx)
{
	$("#detail_"+idx).remove();
}

var sale_cnt=0;
function add_sale()
{
	var inner = "";
	inner += '<tr id="sale_list_'+sale_cnt+'">';
	inner += '	<td>'+sale_cnt+'</td>';
	inner += '	<td><input type="text" placeholder="15,000,000" class="price"></td>';
	inner += '	<td><button class="writing_bt">작성하기</button></td>';
	inner += '	<td>열람</td>';
	inner += '	<td>자동등록</td>';
	inner += '	<td class="del_btn_input"> <input type="button" value="삭제" onclick="del_sale('+sale_cnt+');"> </td>';
	inner += '</tr>';
	$("#sale_target").append(inner);
	sale_cnt ++;
}
function del_sale(idx)
{
	$("#sale_list_"+idx).remove();
}


function chooseManager()
{
	
	var manager_idx = $('#sale_manager').val();
	if (manager_idx=="") 
	{
		alert("담당자를 선택해주세요.");
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./chooseManager",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}",
			manager_idx : manager_idx
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


function client_info_edit(){
	alert("수정이 가능합니다.");
	
	$('.qna td').each(function(){ 
		$(this).removeClass('edit');
	})

	$('.Information td').each(function(){ 
		$(this).removeClass('edit');
	})
	
	$('#site_url').attr('readonly',false);
	$('#project_cont').attr('readonly',false);
	$('#start_ymd').show();
	$('#end_ymd').show();
	$('#start_ymd_for_show').hide();
	$('#end_ymd_for_show').hide();
}

//협의중
function check_middle_step(){

	$.ajax({
		type : "POST", 
		url : "./checkMiddleStep",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}"
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

function doContract(chk_val){
	if(!confirm("정말 저장하시겠습니까?"))
	{
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./doContract",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}",
			chk_val : chk_val
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


function fncSubmit(){
	
	var f = document.fncForm;
	var temp_line ="";
	temp_line = document.getElementsByName("service_type");	//결재라인값 세팅
	var service_type_arr = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].checked==true ) 
    	{
    		service_type_arr += temp_line[i].value+'|';
		}
	}
    
    temp_line = document.getElementsByName("project_type");	//결재라인값 세팅
	var project_type_arr = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].checked==true ) 
    	{
    		project_type_arr += temp_line[i].value+'|';
		}
	}
    
    temp_line = document.getElementsByName("known_path");	//결재라인값 세팅
	var known_path_arr = "";
    for (var i = 0; i < temp_line.length; i++) 
    {
    	if (temp_line[i].checked==true ) 
    	{
    		known_path_arr += temp_line[i].value+'|';
		}
	}

    temp_line = document.getElementsByClassName("file_nm");	//첨부파일 세팅
	var fileNm_line = "";
    for (var i = 0; i < temp_line.length; i++) 
    {

    	if (temp_line[i].value!="") 
    	{
    		fileNm_line += temp_line[i].value+'|';
		}
	}
    
    f.service_type_arr.value = service_type_arr;
	f.project_type_arr.value = project_type_arr;
	f.known_path_arr.value = known_path_arr;
	f.fileNm_list.value = fileNm_line;
	
    if (f.user_company.value=="") 
	{
		alert("회사명을 작성해주세요.");
		f.user_company.focus();
		return;
	}
    
    if (f.user_manager.value=="") 
	{
		alert("담당자를 작성해주세요.");
		f.user_manager.focus();
		return;
	}
    
    if (f.user_type.value=="") 
	{
		alert("업종 업태를 작성해주세요.");
		f.user_type.focus();
		return;
	}
    
    if (!isCellPhone(f.user_phone.value)) 
	{
		alert("유효하지 않는 전화번호입니다.");
		f.user_phone.focus();
		return;
	}
	
    
    var email_chk = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (f.user_email.value=="" || !email_chk.test(f.user_email.value)) 
	{
		alert("올바른 이메일 주소를 입력하세요")
		f.user_email.focus();
		return;
	}
    
    if (f.project_budget.value=="") 
	{
		alert("프로젝트 예산을 정해주세요.");
		return;
	}
    
    var start_ymd =$('#start_ymd').val().split('-');
	var date_start = new Date(start_ymd[0], start_ymd[1], start_ymd[2] ,'00','00');
	
	var end_ymd =$('#end_ymd').val().split('-');
	var date_end = new Date(end_ymd[0], end_ymd[1], end_ymd[2] ,'11','11');
	
    /*
    if (start_ymd=="") 
	{
    	$('#start_ymd').focus();
		alert("착수일정을 설정해주세요.");
		return;
	}
    
    if (end_ymd=="") 
	{
    	$('#end_ymd').focus();
		alert("오픈일정을 설정해주세요.");
		return;
	}
    */
    
    if (date_end < date_start) 
    {
    	alert("프로젝트 기간을 다시 설정해주세요.");
		return;
	}
    console.log("date_start : "+date_start);
    console.log("date_end : "+date_end);
    
    if (f.select_way.value=="") 
	{
		alert("프로젝트의 선정방식을 골라주세요.");
		return;
	}
    
    /*
    if (f.project_title.value=="") 
	{
		alert("프로젝트의 제목을 작성해주세요.");
		f.project_title.focus();
		return;
	}
    */
    
    if (f.project_cont.value=="") 
	{
		alert("프로젝트의 문의 내용을 작성해주세요.");
		f.project_cont.focus();
		return;
	}
    
    if ("${idx}"!="" && f.sale_manager.value =="") 
    {
		alert('담당자를 지정해주세요.');
		return;
	}
    
	f.action="/family/sales/write_sale";
	$("#fncForm").ajaxSubmit({ 
		success: function(data)
		{
			console.log(data);
			alert(data.msg);
		}
	});
}
// 사이트 주소 복사
function clip(){
	var isRight = true;
	if($("#site_url").val().trim() == ''){
		alert($(this).attr("data-name")+" 사이트 주소를 입력하세요.");
        isRight = false;
        return false;
	}else{
		var url = '';
    	var textarea = document.createElement("textarea");
    	document.body.appendChild(textarea);
    	url = $("#site_url").val();
    	textarea.value = url;
    	textarea.select();
    	document.execCommand("copy");
    	document.body.removeChild(textarea);
    	alert("URL이 복사되었습니다.")
	}
}

</script>


<div id="container">

	<form id="fncForm" name="fncForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="idx" value="${idx}">
		<input type="hidden" name="service_type_arr">
		<input type="hidden" name="project_type_arr">
		<input type="hidden" name="known_path_arr">
		<input type="hidden" name="fileNm_list"> 
		<input type="hidden" name="start_ymd"> 
		<input type="hidden" name="end_ymd"> 
		
		
		<div class="top">
			
			<div class="back_button">
				<a href="/family/sales/list"><img src="/img/back_arrow.png"></a>
			</div>
			
			<div class="card_wrap">
				<p class="card">고객카드</p>
				<c:if test="${idx ne null }">
					<p class="card" id="manager_nm">${manager_nm}</p>
				</c:if>
			</div>
			
			<c:if test="${manager_idx eq myidx and step eq '2'}">
				<p class="middle_step card" onclick="check_middle_step();">협의중</p>
			</c:if>
			
			<c:if test="${user_company ne null }">
				<h1 class="top_title"><em>회사명</em> ${user_company}</h1>
			</c:if>
			
			<c:if test="${user_company eq null }">
				<h1 class="top_title">신규 등록</h1>
			</c:if>
			
			
			<div class="write_info_box">
			
			
				<div class="write_info_left">
					<ul class="status_wrap">
						<li>
							<div id="step1">문의/접수</div>
							<p id="step1_date"></p>
						</li>
						<li>
							<div id="step2">준비중</div>
							<p id="step2_date"></p>
						</li>
						<li>
							<div id="step3">협의중</div>
							<p id="step3_date"></p>
						</li>
						<li>
							<div id="step4">계약</div>
							<p id="step4_date"></p>
						</li>
					</ul>
					
					<h3 class="write_tit">진행상황</h5>
					<select id="step" onchange="">
						<option value="">전체</option>
						<option value="1" class="red"><div></div>문의/접수</option>
						<option value="2" class="orange"><p></p>담당자확인</option>
						<option value="3" class="orange"><p></p>초기컨텍</option>
						<option value="4" class="orange"><p></p>견적서송부</option>
						<option value="5" class="orange"><p></p>추가협의</option>
						<option value="6" class="green"><p></p>계약</option>
						<option value="7" class="green"><p></p>패스</option>
					</select>
					<div id="important_project" class="important_project">
						<input type="checkbox" id="important_yn" name="important_yn" class="important_yn" />
						<h6>유력</h6>
					</div>
				</div>
			
				<c:if test="${idx ne null }">
					<div class="write_info_right">
					
						<div class="status">
							
								<div class="manager_box">
									<p class="manager_info_text">영업 담당자 :</p>
									<select id="sale_manager" name="sale_manager">
										<option value="" selected="selected">담당자 분장 +</option>
										<c:forEach var="i" items="${saleUserList}" varStatus="loop">
											<option value="${i.idx}">${i.name}</option>
										</c:forEach>
									</select>
									<c:if test="${sale_auth eq 'M'}">
										<div class="bt" onclick="chooseManager();">분장</div> 
									</c:if>
								</div>
							
						</div>
					</div>
					
				</c:if>
			</div>
			
			
		</div>
		<div class="cellbox">
			<div class="Information_wrap cell cell2">
					<div class="side_info_box">
					<table class="Information">
						<tr class="tr_title">
							<th colspan="14">기본정보</th>
							<!-- <th colspan="7" id="manager_nm"></th>-->
						</tr>
						<tr>
							<th>회사명</th>
							<td><input type="text" name="user_company" value=""></td>
							<th>서비스</th>
							<td>
								<select name="service_type" id="service_type" class="service_type">
									<option value="01">기업사이트</option>	
									<option value="02">이커머스</option>
									<option value="03">마이크로사이트</option>
									<option value="04">패키지디자인</option>
									<option value="05">디지털마케팅</option>
									<option value="06">서버관리 서비스</option>
									<option value="07">제품소개사이트</option>
									<option value="08">BX</option>
									<option value="09">카탈로그제작</option>
									<option value="10">수출바우처</option>
									<option value="11">기타</option>
								</select>
							</td>	
						</tr>
						<tr>
							<th>업종/업태</th>
							<td><input type="text" name="user_type" value=""></td>
							<th>프로젝트유형</th>
							<td>
								<select name="project_type" id="project_type" class="project_type">
									<option value="01">신규구축</option>	
									<option value="02">리뉴얼</option>
									<option value="03">유지보수</option>
									<option value="04">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td><input type="text" name="user_manager" value=""></td>	
							<th>예산</th>
							<td>
								<select name="project_budget" id="project_budget" class="project_budget">
									<option value="01">3천만원 미만</option>	
									<option value="02">3~5천만원 미만</option>
									<option value="03">5~1억원 미만</option>
									<option value="04">1~2억원미만</option>
									<option value="05">2억원~3억원 미만</option>
									<option value="06">3억원이상</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" name="user_phone" value=""></td>	
							<th>착수일</th>
							<td>
								<input type="date" id="start_ymd" name="start_ymd" value=""/>
								<input type="text" id="start_ymd_for_show" value="" style="display: none;" readonly>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="user_email" value="" style="width:250px;"></td>
							<th>오픈일</th>
							<td>
								<input type="date" id="end_ymd" name="end_ymd"  value=""/>
								<input type="text" id="end_ymd_for_show" value="" style="display: none;" readonly/>
							</td>	
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td><input type="text" name="user_biz_no" value=""></td>	
							<th>선정박식</th>
							<td>
								<select name="select_way" id="select_way" class="select_way">
									<option value="01">수의계약</option>	
									<option value="02">가격입찰</option>
									<option value="03">제안입찰</option>
									<option value="04">미정</option>
									<option value="05">기타</option>
								</select>
							</td>
						</tr>	
						<tr>
							<th>개인정보 동의</th>
							<td><input type="checkbox" name="info_yn"></td>
							<th>기존 사이트 주소</th>
							<td><input type="text" id="site_url" name="site_url" value=""><span class="clip_btn"><a href="javascript:void(0);" onclick="clip(); return false;">복사</a></span></td>
						</tr>
						<!-- 
						<tr>
							<th>마케팅 수신 동의</th>
							<td><input type="checkbox" name="market_yn"></td>
						</tr>
						 -->
						 <tr>
						 	<th>
								유입경로
							</th>
							<td colspan="3">
								<div class="known_path_box">
									<div>
										<input type="checkbox" name="known_path" value="01">
										<p>기존고객사</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="02">
										<p>지인소개</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="03">
										<p>지디웹</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="04">
										<p>디비컷</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="05">
										<p>구글 검색</p>	
									</div>
									<div>
										<input type="checkbox" name="known_path" value="06">
										<p>네이버 검색</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="07">
										<p>수출바우처 사이트</p>
									</div>
									<div>
										<input type="checkbox" name="known_path" value="08">
										<p>뮤자인블로그</p>	
									</div>
									<div>
										<input type="checkbox" name="known_path" value="09">
										<p>기타</p>
									</div>
								</div>
							</td>	
						 </tr>
					</table>
				</div>	
			</div>
		
			<div class="qna_wrap cell cell1">
			<div class="x_scroll">
				<table class="qna">
					<tr>
						<th>레퍼런스</th>
						<td>
							<input type="text" id="reference_url" name="reference_url" value="">
						</td>
					</tr>
					<tr>
						<th>
							프로젝트 상세내용
						</th>
						<td colspan="11"><textarea id="project_cont" name="project_cont"></textarea></td>
					</tr>
					 <tr>
						<th class="btn_file">첨부파일
							<span class="btn_file btn_write_abs" onclick="add_file();">+</span>
						</th>
						<td id="file_area">
						
						</td>
					 </tr>					
				</table>
				</div>	
				
				<div class="progress_wrap">
					<table class="progress1">
						<thead>
						<tr class="tr_title">
							<th colspan="6">견적내용</th>
						</tr>
						<tr>
							<th>NO</th>
							<th class="btn_price">견적 금액</th>
							<th>견적서 작성</th>
							<th>견적서</th>
							<th>견적 발송일</th>
							<th><span onclick="add_sale();">추가</span></th>
						</tr>
						</thead>
						<tbody id="sale_target">
		
						</tbody>
						
					</table>
					<div class="progress2_bt">
						<div class="progress2_bt1">견적서 첨부</div>
						<div class="progress2_bt2">발송</div>
					</div>
					<table class="progress2">
						<tr>
							<th>견적메일작성</th>
							<td colspan="3"><input type="text" placeholder="이메일을 작성해주세요."></td>
						</tr>
						<tr>
							<th>코멘트</th>
							<td colspan="4"><textarea name="comment"></textarea></td>
						</tr>
						<tr>
							<th>미팅내용 +</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th>미팅캘린더</th>
							<td>
								<input type="date" name=""/>    
							</td>
							<th>계약여부</th>
							<td style="padding-left:10px">
								<input type="button" id="contract_y" name="contract_y" value="계약승인" onclick="doContract('Y');" style="display: none;">
								<input type="button" id="contract_n" name="contract_n" value="계약패스" onclick="doContract('N');" style="display: none;"> 
							</td>
						</tr>
					</table>
				</div>
			</div>
				
		</div>
		

		<div class="footer_bt write_footer_bt">
			<div class="btn_center_wrap">
				<div>
					<input type="button" value="수정" onclick="client_info_edit();">
				</div>	
							
				<c:if test="${sale_auth eq 'M' or sale_auth eq 'W'}">
					<div onclick="fncSubmit();">저장</div>
				</c:if>
			</div>
		</div>
	</form>
</div>
<div class="bottom_hide"></div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Compatible" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Musign</title>
<link rel="stylesheet" type="text/css" href="/inc/css/general.css" />
<link rel="stylesheet" type="text/css" href="/inc/css/family_musign.css" />
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
<script src="/inc/js/domain_chk_family.js"></script>


<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://www.lgkids.co.kr/es_all/plugins/jscolor-2.0.5/jscolor.js"></script>
<script>

$(document).ready(function(e){
	
	
	$("#join_id").on("keyup",function(){
		
		var f = document.fncForm;
		$.post(
				
			"idCheck",
			{id : f.join_id.value},
			function(data){
				
				if(data){
					if ($('#join_id').val()!="") 
					{	
						$('.check_id_div').html(data.result);
						$('.check_id_div').css("color","red");
					}
					else
					{
						$('.check_id_div').html("ID를 입력해 주세요.");
						$('.check_id_div').css("color","black");
					}
				}
			}
		);
	});
	
	$("#join_email").on("keyup",function(){
		
		var f = document.fncForm;
		$.post(
			"mailCheck",
			{mail : f.join_email.value+'@musign.net'},
			function(data){
				
				if(data){
					
					if ($('#join_email').val()!="") 
					{				
						$('.check_mail_div').html(data.result);
						$('.check_mail_div').css("color","red");
					}
					else
					{
						$('.check_mail_div').html("MAIL을 입력해 주세요.");
						$('.check_mail_div').css("color","black");
					}
				}
			}
		);
	});
	
	$("#join_phone_no3").on("keyup",function(){
		
		var f = document.fncForm;

		$.post(
			"phoneCheck",
			{
				phone_no1 : f.join_phone_no1.value,
				phone_no2 : f.join_phone_no2.value,
				phone_no3 : f.join_phone_no3.value
			},
			
			function(data){
				
				if(data){
					if ($('#join_phone_no1').val()!="" && $('#join_phone_no2').val()!="" && $('#join_phone_no3').val()!="") 
					{				
						$('.check_phone_div').html(data.result);
						$('.check_phone_div').css("color","red");
					}
					else
					{
						$('.check_phone_div').html("전화번호를 입력해 주세요.");
						$('.check_phone_div').css("color","black");
					}
				}
			}
			
		);
		
		
	});
	
});

function fncSubmit(){
	
	var f = document.fncForm; // 주석테스트  //동현테스트 //주석테스트2
	
	
	$('.duplFlag').each(function(){ 
		if ($(this).text()=="중복 아이디입니다.") {
			alert("중복된 내용이 있습니다.");
			return false;
		}
	})

	

	if (isEmpty(f.join_id))
	{
		alert("ID를 채워주세요.");
		f.join_id.value = "";
		f.join_id.focus();
		return false;
		
	}
	if (isEmpty(f.join_pw))
	{
		alert("비밀번호를 채워주세요.");
		f.join_pw.value = "";
		f.join_pw.focus();
		return false;
		
	}
	
	if (isEmpty(f.join_email)) 
	{
		alert("메일을 채워주세요.");
		f.join_email.value = "";
		f.join_email.focus();
		return false;
	}
	/*
	if (containsHS(f.join_email)) 
	{
		alert("영문만 가능합니다.");
		f.join_email.value = "";
		f.join_email.focus();
		return false;
	}	
	*/
	
	if (isEmpty(f.join_phone_no1)) 
	{
		alert("전화번호를 채워주세요.");
		f.join_phone_no1.value = "";
		f.join_phone_no1.focus();
		return false;
	}
	
	if(isNotNumber(f.join_phone_no1))
	{
		alert("숫자를 채워주세요.");
		f.join_phone_no1.value = "";
		f.join_phone_no1.focus();
		return false;
	}
	
	if (isEmpty(f.join_phone_no2)) 
	{
		alert("전화번호를 채워주세요.");
		f.join_phone_no2.value = "";
		f.join_phone_no2.focus();
		return false;
	}
	
	if(isNotNumber(f.join_phone_no2))
	{
		alert("숫자를 채워주세요.");
		f.join_phone_no2.value = "";
		f.join_phone_no2.focus();
		return false;
	}
	
	if (isEmpty(f.join_phone_no3)) 
	{
		alert("전화번호를 채워주세요.");
		f.join_phone_no3.value = "";
		f.join_phone_no3.focus();
		return false;
	}
	
	if (f.myColor.value=='FFFFFF') 
	{
		alert("다른 색상을 선택해주세요.");
		f.myColor.value = "";
		f.myColor.focus();
		return false;
	}
	
	if(isNotNumber(f.join_phone_no3))
	{
		alert("숫자를 채워주세요.");
		f.join_phone_no3.value = "";
		f.join_phone_no3.focus();
		return false;
	}
	
	if (isEmpty(f.join_name)) 
	{
		alert("이름을 채워주세요.");
		f.join_name.value = "";
		f.join_name.focus();
		return false;
	}
	
	if (isEmpty(f.sign_date)) 
	{
		alert("입사일을 채워주세요.");
		f.sign_date.value = "";
		f.sign_date.focus();
		return false;
	}
	
	if ($('.check_phone_div').text()=='이미 가입이 된 전화번호입니다.') 
	{
		alert("이미 가입이 된 전화번호입니다.");
		f.join_phone_no1.value = "";
		f.join_phone_no2.value = "";
		f.join_phone_no3.value = "";
		f.join_phone_no1.focus();
		return false;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./join_proc",
		dataType : "text",
		data : 
		{
			id : f.join_id.value,
			pw : f.join_pw.value,
			email : f.join_email.value+'@musign.net',
			phone1 : f.join_phone_no1.value,
			phone2 : f.join_phone_no2.value,
			phone3 : f.join_phone_no3.value,
			name : f.join_name.value,
			sign_date : f.sign_date.value,
			team : f.team.value,
			level : f.level.value
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			if (result.isSuc="success") {
				alert("환영합니다.");
				location.href="/family/main";
			}else{
				alert("관리자에게 문의해주세요.");
			}
			end_loading();
		}
	});
	
	
}

function start_loading(){
	$('.loading').show();
}

function end_loading(){
	$('.loading').hide();
}
</script>
<style>
.loading {
	width:100%;
	height:100%;
	position:fixed;
	left:0;
	top:0;
	background: rgba(0,0,0,0.5);
	z-index: 9999;
}
.loading img {
	position:absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	
}
</style>


</head>
<body>
<div class="join_wrap">
		<!-- 로고 -->
		<div class="logo">
			<a class="logo-wr" href="/family/user/login">
				<img alt="로고이미지" src="/img/logo.png">
			</a>
		</div>
		<!-- 로고제외전체 정보입력칸 -->    
			<form id="fncForm" name="fncForm">
			<div class="Account">
				 	<div class="join-row idInterval">
				 		<div class="jro-tit">아이디</div>
						<div class="jro-input"><input id="join_id" name="join_id" autocomplete="off"><div class="check_id_div duplFlag">ID를 입력해 주세요.</div><br class="deleteBr"></div>
				 	</div>
				 	<div class="join-row">
				 		<div class="jro-tit">비밀번호</div>
						<div class="jro-input"><input id="join_pw" name="join_pw" autocomplete="off" type="password"><br></div>
				 	</div>
				 	<div class="join-row emailPart">
				 		<div class="jro-tit">이메일</div>  
						<div class="jro-input"><input id="join_email" name="join_email" autocomplete="off"><span class="emailText">@&nbsp;musign.net</span><br>
							<div class="check_mail_div duplFlag">MAIL을 입력해 주세요.</div><br class="deleteBr">
						</div>
				 	</div>
				 	<div class="join-row">
				 		<div class="jro-tit">전화번호</div>  
						<div class="jro-input join-phone">
							<input id="join_phone_no1" name="join_phone_no1" maxlength="3" autocomplete="off">
							-
							<input id="join_phone_no2" name="join_phone_no2" maxlength="4" autocomplete="off">
							-
							<input id="join_phone_no3" name="join_phone_no3" maxlength="4" autocomplete="off">
							<br>
							<div class="check_phone_div duplFlag">전화번호를 입력해 주세요.</div><br class="deleteBr">
				 		</div>
				 	</div>
				 	<div class="join-row">
				 		<div class="jro-tit">MyColor</div> 
				 		<div class="jro-input"><input class="form-control jscolor" name="myColor" id="myColor" placeholder="색상을 선택해주세요."><br></div>
				 	</div>
				 	<div class="join-row">
				 		<div class="jro-tit">이름</div>  
						<div class="jro-input"><input id="join_name" name="join_name" autocomplete="off"><br></div>
				 	</div>
				 	
				 	<div class="join-row emailPart">
				 		<div class="jro-tit">입사일</div>  
						<div class="jro-input">
							<input type="text" id="sign_date" name="sign_date"  class="date-i" />
						</div>
				 	</div>
				 	
			</div>
		<!-- 팀 + 직급 -->
				<div class="join-row">
					<div class="jro-tit">팀</div>  
					<div class="jro-input">
					
						<select id="team" name="team">
							<c:forEach var="j" items="${teamList}" varStatus="loop">
								<option value="${j.idx}">${j.team_kr}</option>
							</c:forEach>
						</select>
						
						<br>
					</div>
				</div>
				
				<div class="join-row">
					<div class="jro-tit">직급</div> 
					<div class="jro-input">
					
						<select id="level" name="level">
							<c:forEach var="i" items="${levelList}" varStatus="loop">
								<option value="${i.idx}" <c:if test="${i.name eq '사원'}">selected</c:if> >${i.name}</option>
							</c:forEach>
						</select>
						
						<br>
					</div>
				</div>
				
		 	</form> 
				
			<!-- 버튼2개 -->
			<div class="btnWrap">
				<a href="/family/user/login">이전</a>
				<input type="button" onclick="fncSubmit()" value="등록" class="btn_login btn btn01">
			</div>
			    
</div><!-- class="join_wrap" -->
<div class="loading" style="display:none;">
	<div class="loading_wrap">
		<img src="/img/loading_bar.gif">
	</div>
</div>
</body>
</html>


<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>

var isLogin = "<%=session.getAttribute("login_user_id")%>";
var link = location.href;
if (isLogin != "null") {
	location.href = "/family/main";
}

if ("${msg}"!="") {
	alert("${msg}");	
}

</script>


<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="Compatible" content="no-cache"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<title>Musign</title>
		<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
		<link rel="stylesheet" type="text/css" href="/inc/css/general.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign.css" />
		<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
		<script src="/inc/js/domain_chk_family.js"></script>

<script>

function enter_check_login()
{
	if(event.keyCode == 13){
		login();
		return;
	}
}
function login()
{
	if($("#login_user_id").val() == "")
	{
		alert("아이디를 입력해주세요.");
		$("#login_user_id").focus();
		return;
	}
	if($("#login_pw").val() == "")
	{
		alert("비밀번호를 입력해주세요.");
		$("#login_pw").focus();
		return;
	}
	start_loading();
	$("#loginForm").ajaxSubmit({
		success: function(data)
		{
    		var result = JSON.parse(data);
    		if(result.isSuc == "success")
    		{
    			alert(result.msg);
    			location.replace('/');
    		}
    		else
    		{
    			alert('아이디와 비밀번호를 확인해주세요.');
    		}
    		end_loading();
		}
	});
}

function go_sign_in(){
	location.href="/family/user/join";
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
		<div class="login_wrp">
			<div class="page_login">
				<a class="logo-wr" href="http://musign.net/" target="_blank">
					<img alt="로고이미지" src="/img/logo.png">
				</a>
		    	<form id="loginForm" name="loginForm" method="post" action="/family/user/login_proc">
		        	<div class="log-line"><input type="text" id="login_user_id" name="login_user_id" placeholder="Username"></div>       	
		        	<input type="password" id="login_pw" name="login_pw" placeholder="Password" onkeydown="javascript:enter_check_login();">
		        	<div class="chk-wrap chkbox">
		        		<input type="checkbox" id="remember_pw" name="remember_pw"/>        		
		        		<label for="remember_pw"><span></span>기억하기</label>
		        	</div>
		        	<input type="button" onclick="login()" value="LOGIN" class="btn_login btn btn01">
		        	<input type="button" onclick="go_sign_in()" id='sign_up' value="SIGN UP"  class="btn_login btn btn01">
		    	</form>
		    </div>
		</div>
		
    	<div class="loading" style="display:none;">
    		<div class="loading_wrap">
    			<img src="/img/loading_bar.gif">
    		</div>
    	</div>
    	
	</body>
</html>


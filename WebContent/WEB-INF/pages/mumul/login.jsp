<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>Mumul</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
		<script>
			function enter_check_login()
			{
				if(event.keyCode == 13){
					fncSubmit()
					return;
				}
			}
			
			function fncSubmit()
			{
				var validationFlag = "Y";
				$(".notEmpty").each(function() 
				{
					if ($(this).val() == "") 
					{
						alert(this.dataset.name+"을(를) 입력해주세요.");
						$(this).focus();
						validationFlag = "N";
						return false;
					}
				});
				
				if(validationFlag == "Y")
				{
					$("#fncForm").ajaxSubmit({
						success: function(data)
						{
							console.log(data);
							var result = JSON.parse(data);
				    		if(result.isSuc == "success")
				    		{
				    			alert('환영합니다')
				    			location.href="/mumul/cate_list";
				    		}
				    		else
				    		{
				    			alert(result.msg);
				    		}
						}
					});
				}
			}
		</script>
	</head>
	<body>
		<div class="login_wrap">
			<div class="page_login">
				<div class="inner">
					<div class="logo"><img src="/img/logo.png" /></div>
					<form id="fncForm" name="fncForm" method="post" action="./login_proc">
						<div class="log-line">
							<input type="text" data-name="아이디" id="login_id" name="login_id" class="notEmpty" placeholder="아이디" />
							<input type="password" data-name="비밀번호" id="login_pw" name="login_pw" class="notEmpty" onkeypress="enter_check_login()" placeholder="비밀번호" />
						</div>  
						
						<input type="button" onclick="fncSubmit()" value="로그인" class="btn_login"/>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
	<script type="text/javascript" src="/inc/js/musign.js"></script>
	<script type="text/javascript" src="/inc/js/function.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<link rel="stylesheet" href="/inc/css/jquery.scrollbar.css" />
	<link rel="stylesheet" href="/inc/css/mumul.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
	<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/inc/js/jquery.scrollbar.min.js"></script>
	<script>
	document.addEventListener('click', function(e){
		//console.log(e.target);
	})
	document.addEventListener('DOMContentLoaded', function(e){
		mumulWindow = document.getElementById('mumul');
		document.querySelector('.mumul_open_btn').addEventListener('click', function(e){
			muChat.open(mumulWindow);
		});
	});
	$(document).ready(function(){
		
	});
	function selCate(obj, idx)
	{
		$(".mumul_popup").hide();
		$.ajax({
			type : "POST", 
			url : "/mumul/getContents",
			dataType : "text",
			async:false,
			data : 
			{
				idx : idx
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				
				var inner = '<div class="chat_box mu_user"><p>'+$(obj).text()+'</p></div>'; //클릭한거 
				
				if(result.view_type == "pop")
			    {
					inner += "<div class='chat_box mu_ad'>아래 링크를 클릭하시면 궁금하신 내용을 확인하실 수 있습니다.<button type='button' class='popup_open' onclick='popupOpen()'>확인하기</button></div>";
					$("#popLayer").html(repWord("<h3 class='popup_title'>" + result.cate_nm + "</h3><div class='popup_cont'>"+ nullChk(result.contents)) + "</div>");
			    }
				else if(result.view_type == "link")
				{
					inner += "<div class='chat_box mu_ad'><a href='"+repWord(nullChk(result.contents))+"' target='_blank' class='popup_open'>누르면이동</a></div>";
				}
				else if(result.view_type == "direct")
				{
					inner += "<div class='chat_box mu_ad'><span>"+repWord(nullChk(result.contents))+"</span></div>";
				}
				$("#target").append(inner);
			}
		});	
		$.ajax({
			type : "POST", 
			url : "/mumul/getNextCate",
			dataType : "text",
			async:false,
			data : 
			{
				idx : idx
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data),
					chatInner = document.getElementById('target');
				
				var inner = "";
				if(result.length != 0) {inner += "<div class='chat_box'>";}
				for(var i = 0; i < result.length; i++)
				{
					inner += '<button type="button" onclick="selCate(this, '+nullChk(result[i].idx)+')" class="mu_cate">'+nullChk(result[i].cate_nm)+'</button>';
				}
				if(result.length != 0) {inner += "</div>";}
				$("#target").append(inner);
				
				var targetScrollTop = chatInner.scrollHeight > document.querySelector('.mumul_chat').clientHeight ? chatInner.scrollHeight : 0;
				chatInner.scrollTop = targetScrollTop;
			}
		});	
	}
	function searchCate()
	{
		if($("#search_val").val() == "")
		{
			var tmp = '<div class="chat_box mu_ad"><p>검색어를 입력해주세요</p></div>';
			$("#target").append(tmp);
		}
		else
		{
			$.ajax({
				type : "POST", 
				url : "/mumul/getSearchCate",
				dataType : "text",
				async:false,
				data : 
				{
					search_val : $("#search_val").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					console.log(data);
					var result = JSON.parse(data);
					
					var inner = '<div class="mu_user">'+$("#search_val").val()+'</div>'; //검색한거
					
					if(result.length != 0) {inner += "<div>";}
					for(var i = 0; i < result.length; i++)
					{
						inner += '<a onclick="selCate(this, '+nullChk(result[i].idx)+')" class="mu_cate">'+nullChk(result[i].cate_nm)+'</a>';
					}
					if(result.length != 0) {inner += "</div>";}
					
					
					//검색결과가 없을때
					if(result.length == 0)
					{
						inner += '<div class="chat_box mu_ad"><p>검색결과가 없슴다.</p></div>';
						inner += '<div class="chat_box mu_cate"><button type="button" onclick="addPlease(\''+$("#search_val").val()+'\')">관리자에게 요청하기</button></div>';
					}
					//검색결과가 없을때
					
					$("#target").append(inner);
					$("#search_val").val('');
					
					console.log(document.documentElement.scrollTop);
					
				}
			});	
		}
	}
	function addPlease(val)
	{
		$.ajax({
			type : "POST", 
			url : "/mumul/addPlease",
			dataType : "text",
			async:false,
			data : 
			{
				val : val
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			var inner = '<div class="mu_ad">관리자에게 요청되었습니다.<br>빠른시일내에 업데이트 블라블라~~~</div>'; //검색한거
	    			$("#target").append(inner);
	    		}
			}
		});	
	}
	
	var mumulWindow;
	var muChat = {
		open: function(chatWindow){
			chatWindow.classList.add('chat_on');			
			//console.log(chatWindow);
			$(chatWindow).find('#target').scrollbar({
				'onUpdate': function(){
					console.log(this.scrolly.offset);
				}
				/* scrolly: $('.mumul_chat > .scroll-y') */
			});	
		},
		close: function(chatWindow){
			chatWindow.classList.remove('chat_on');
		}
	}
	function popupOpen()
	{
		$(".mumul_popup").show();
	}
	function popupClose(){
		$(".mumul_popup").hide();
	}
	
	</script>
</head>

<body>

	<div class="mumul_quick">
		<span class="quick_text">궁금한 게 있다면 물어보세요!</span>
		<a href="#mumul" class="mumul_open_btn"><img src="/img/mumul/mumul_quick_icon.svg" alt="뮤물에게 물어보세요"></a>
	</div>
	
	<div id="mumul">
		<div class="mumul_dim"></div>
		<div class="mumul_inner">
			<div class="mumul_cont">
				<div class="mumul_top">
					<div class="mumul_title">
						<span class="mumul_icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" viewBox="0 0 27 27" fill="none">
							    <circle cx="13.5" cy="13.5" r="13.5" fill="#FFD000"/>
							    <path fill="#000" stroke="#fff" d="m6.069 7.983 7.145 1.489-1.489 7.144-7.145-1.488zM15.998 10.052l7.145 1.489-1.49 7.144-7.144-1.488z"/>
							    <g filter="url(#lqp33ypopa)">
							        <path d="m12.865 13.597 1.805.376" stroke="#fff"/>
							    </g>
							    <defs>
							        <filter id="lqp33ypopa" x="8.764" y="13.108" width="10.009" height="9.355" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
							            <feFlood flood-opacity="0" result="BackgroundImageFix"/>
							            <feColorMatrix in="SourceAlpha" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
							            <feOffset dy="4"/>
							            <feGaussianBlur stdDeviation="2"/>
							            <feComposite in2="hardAlpha" operator="out"/>
							            <feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
							            <feBlend in2="BackgroundImageFix" result="effect1_dropShadow_88_6"/>
							            <feBlend in="SourceGraphic" in2="effect1_dropShadow_88_6" result="shape"/>
							        </filter>
							    </defs>
							</svg>
						</span>
						<h4>무엇이 궁금하신가요?</h4>
					</div>
					<button type="button" class="reset_btn">
						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="16" viewBox="0 0 14 16" fill="none">
							<g clip-path="url(#clip0_88_7)">
								<path d="M11.9559 13.927C11.321 14.5711 10.5651 15.086 9.73074 15.4427C8.86829 15.8105 7.93915 16.0002 7.00015 16.0002C6.06115 16.0002 5.13201 15.8105 4.26956 15.4427C3.43516 15.086 2.67926 14.5711 2.04439 13.927C1.40521 13.2814 0.897537 12.52 0.549086 11.6843C-0.181726 9.92803 -0.181726 7.95685 0.549086 6.20058C0.897537 5.36489 1.40521 4.60344 2.04439 3.95784C2.67926 3.3138 3.43516 2.79892 4.26956 2.44216C5.13154 2.07293 6.06099 1.88319 7.00015 1.88472V0L10.8733 2.6888L7.00015 5.37759V3.53005C4.0564 3.53005 1.66159 5.95806 1.66159 8.94318C1.66159 11.9283 4.0564 14.3563 7.00015 14.3563C9.9439 14.3563 12.3387 11.9283 12.3387 8.94318H14.0002C14.002 9.88399 13.8157 10.8158 13.4519 11.685C13.1032 12.5205 12.5953 13.2817 11.9559 13.927Z" fill="black" fill-opacity="0.15"/>
							</g>
							<defs>
								<clipPath id="clip0_88_7">
									<rect width="14" height="16" fill="white"/>
								</clipPath>
							</defs>
						</svg>
						<span class="text_hidden">초기화</span>
					</button>
				</div>
				<!-- 채팅 영역 -->
				<div class="mumul_chat">
					<div id="target" class="scrollbar-inner">
						<div class="chat_box mu_ad">
							<p>어서오십셔</p>
						</div>
						<div class="chat_box">
							<c:forEach var="i" items="${list}" varStatus="loop">
								<button type="button" onclick="selCate(this, '${i.idx}')" class="mu_cate">${i.cate_nm}</button>
							</c:forEach>
						</div>
					</div>
					<div class="scroll-element scroll-y">
						<div class="scroll-element_outer">
							<div class="scroll-element_size"></div>
							<div class="scroll-element_track"></div>
							<div class="scroll-bar" style="width: 3px;"></div>
						</div>
					</div>
				</div>
				<!-- 채팅 영역 -->
			</div>
			
			<!-- 검색바 영역 -->
			<div class="mumul_search">
				<div class="search_inner">
					<span class="all_menu">
						<a href="#mumulMenu" class="menu_btn">
							<span class="text_hidden">메뉴</span>
							<span class="menu_bar top_menu_bar"></span>
							<span class="menu_bar middle_menu_bar"></span>
							<span class="menu_bar bottom_menu_bar"></span>
						</a>
					</span>
					<span class="search_input">
						<input type="text" id="search_val" name="search_val" placeholder="검색어를 입력하세요." onkeypress="excuteEnter(searchCate)"/>
						<button type="button" onclick="searchCate()" class="search_btn"><img src="/img/mumul/search_btn.svg" alt="검색하기"></button>
					</span>
				</div>
			</div>
			<button type="button" class="mu_close_btn" onclick="muChat.close(mumulWindow);"><img src="/img/mumul/window_close_btn.svg" alt="뮤물 닫기"></button>
		</div>
	</div>
	<!-- 검색바 영역 -->
	
	<div class="mumul_popup" style="display:none;">
		<div class="popup_content">
			<div id="popLayer"></div>
			<button type="button" class="popup_close" onclick="popupClose();"><img src="/img/mumul/popup_close_btn.svg" alt="팝업 닫기"></button>
		</div>
	</div>
</body>
</html>
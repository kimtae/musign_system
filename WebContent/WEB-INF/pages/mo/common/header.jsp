<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>

<html>
	<head>
		<meta charset="utf-8">
		
		<meta http-equiv="Cache-Control" content="no-cache"/>
		<meta http-equiv="Expires" content="0"/>
		<meta http-equiv="Pragma" content="no-cache"/>

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Musign</title>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/inc/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="/inc/js/printThis.js"></script>
		<script src="/inc/js/function.js"></script>
		<script src="/inc/js/main.js"></script>
		
		
		<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
		
		<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
		<link rel="stylesheet" type="text/css" href="/inc/css/main.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/general.css">
		<link rel="stylesheet" type="text/css" href="/inc/css/mu_layout.css">
		
		<!-- 유지보수 css -->
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_a.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_b.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/family_musign_c.css" />
		<!-- 유지보수 css -->

		<link rel="stylesheet" type="text/css" href="/inc/css/board_detail.css" />
		<link rel="stylesheet" type="text/css" href="/inc/css/new_registration.css">
		<link rel="stylesheet" type="text/css" href="/inc/css/responsive.css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		
		<script>
		$(document).ready(function(){
		
			$("#printhtis").click(function(){
				jQuery("#mySelector").printThis({
				     debug: false,               // show the iframe for debugging
				     importCSS: true,            // import page CSS
				     importStyle: true,         // import style tags
				     printContainer: true,       // grab outer container as well as the contents of the selector
				     loadCSS: "/inc/css/musign.css",  // path to additional css file - us an array [] for multiple
				     pageTitle: "",              // add title to print page
				     removeInline: false,        // remove all inline styles from print elements
				     printDelay: 333,            // variable print delay
				     header: null,               // prefix to html
				     footer: null,               // postfix to html
				     base: false,                // preserve the BASE tag, or accept a string for the URL
				     formValues: true,           // preserve input/form values
				     canvas: false,              // copy canvas elements (experimental)
				     doctypeString: '...',       // enter a different doctype for older markup
				     removeScripts: false        // remove script tags from print content
				 });
			});	
		})
	
		
		
		
		</script>
	</head>
<body>

<script>

$(function(){
	
	/* $("#header .logo, #header .fl-ri > span , #header .fl-ri .s-btn").clone().appendTo("#m_header .top"); */
	$("#inb").clone().appendTo("#m_header .menu .scr");
	$("#m_header #inb").addClass("m_menu");

	$("#header .m_btn").click(function(){
		$("#m_header").stop().animate({
			left:0
		},500);
		$(".header_dim").addClass("on");
	});
	$("#m_header .m_close").click(function(){
		$("#m_header").stop().animate({
			"left":"-100%"
		},500);
		$(".header_dim").removeClass("on");
	});

});


function dep(menu)
{
	if($(".menu_"+menu).css("display") == "none")
	{
    	$(".depth2").slideUp();
		$(".menu_"+menu).slideDown();
	}
	else
	{
		$(".depth2").slideUp();
	}	
}

function start_loading(){
	$('.loading').show();
}

function end_loading(){
	$('.loading').hide();
}
	
</script>

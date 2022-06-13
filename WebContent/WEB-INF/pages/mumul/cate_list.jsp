<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script type="text/javascript" src="/inc/js/musign.js"></script>
<script type="text/javascript" src="/inc/js/function.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<link rel="stylesheet" href="/inc/css/mumul.css" /> 
	<link rel="stylesheet" href="/inc/css/mumul_admin.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript" src="/inc/ckeditor/ckeditor.js"></script>
<script>
$(document).ready(function(){
	
	var result = JSON.parse('${list}');
	for(var i = 0; i < result.length; i++)
	{
		if(Number(result[i].idx) >= idx)
		{
			idx = Number(result[i].idx)+1;
		}
		if(result[i].dep == '1' && result[i].par == '0') //대분류
		{
			inner = '<div id="dep_1_'+result[i].idx+'" class="category_dep dep_1" is_show="'+result[i].is_show+'" onclick="selCate(\'dep_1\', \''+result[i].idx+'\')" style="padding-left:' + ( 3 * (result[i].dep - 1) + 18) + 'px; background-position-x:' + 3 * (result[i].dep - 1) + 'px;"><span class="category">'+result[i].cate_nm+'</span></div>';
			$("#depth_area").append(inner);
		}
		else
		{
			inner = '<div id="dep_'+result[i].dep+'_'+result[i].idx+'" class="category_dep dep_'+result[i].dep+' par_dep_'+(Number(result[i].dep)-1)+'_'+result[i].par+'" is_show="'+result[i].is_show+'" onclick="selCate(\'dep_'+result[i].dep+'\', \''+result[i].idx+'\')" style="padding-left:' + ( 3 * (result[i].dep - 1) + 18) + 'px; background-position-x:' + 3 * (result[i].dep - 1) + 'px;"><span class="category">'+result[i].cate_nm+'</span></div>';
			$("#depth_area").append(inner);
		}
	}
	cateCss();
});


function getThisCateProductCnt(idx)
{
	var ret = 0;
	$.ajax({
		type : "POST", 
		url : "/mumul/getThisCateProductCnt",
		dataType : "text",
		async : false,
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
			ret = data;
		}
	});	
	return ret;
}


function cateCss()
{
	for(var i = 1; i <= 100; i++)
	{
		$(".dep_"+i).css("margin-left", i*15+"px");
	}
}
var selDep = "";
var selIdx = "";
var idx = 1;
function addDepth()
{
	var inner = "";
	if(selDep == "")
	{
		inner = '<div id="dep_1_'+idx+'" class="category_dep dep_1" onclick="selCate(\'dep_1\', \''+idx+'\')">1차분류</div>';
		$("#depth_area").append(inner);
	}
	else
	{
		var tmp_dep = Number(selDep.split("_")[1])+1;
		inner = '<div id="dep_'+tmp_dep+'_'+idx+'" class="category_dep dep_'+tmp_dep+' par_'+selDep+'_'+selIdx+'" onclick="selCate(\'dep_'+tmp_dep+'\', \''+idx+'\')" style="padding-left:' + (3 * (tmp_dep - 1) + 18) +'px; background-position-x: ' + 3 * (tmp_dep - 1)  + 'px">'+tmp_dep+'차분류</div>';
		$("#"+selDep+"_"+selIdx).after(inner);
	}
	idx++;
	selDep = "";
	selIdx = "";
	cateCss();
}

function delDepth()
{
	if(selDep != "")
	{
		var tmp_class = $("#"+selDep+"_"+selIdx).attr("id");
		
		if($(".par_"+tmp_class).length > 0)
		{
			alert("하위카테고리가 있어서 삭제 불가");
		}
		else
		{
			$.ajax({
				type : "POST", 
				url : "/mumul/delCate",
				dataType : "text",
				async:false,
				data : 
				{
					idx : selIdx
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
		    			$("#"+selDep+"_"+selIdx).remove();
		    		}
				}
			});	
			
		}
		selDep = "";
		selIdx = "";
	}
}
function selCate(dep, idx)
{
	var con = true;
	var tmpCon = "";
	var getCon = "";
	
	if(selIdx != "")
	{
		$.ajax({
			type : "POST", 
			url : "/mumul/getContents",
			dataType : "text",
			async:false,
			data : 
			{
				idx : selIdx
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				var radioVal = $('input[name="view_type"]:checked').val();
				if(radioVal == "pop")
			    {
			    	CKEDITOR.instances.contents.updateElement(); 
			    }
				tmpCon = nullChk($("#contents").val());
				getCon = repWord(nullChk(result.contents));
			}
		});	
	}
	
	if(tmpCon != getCon)
	{
		con = confirm("저장안됨 그래도나감?");
	}
	if(con)
	{
		//$(".right_div").show();
		selDep = dep;
		selIdx = idx;
		var tmp = $("#"+selDep+"_"+selIdx).html().replace('<span class="category">', "");
		tmp = tmp.replace("</span>", "");
		$("#cate_nm").val(tmp);
		
		tmp = $("#"+selDep+"_"+selIdx).attr("is_show");
		if(nullChk(tmp) != '')
		{
			$("input:radio[name='is_show']:radio[value='"+tmp+"']").prop('checked', true);
		}
		else
		{
			$("input:radio[name='is_show']:radio[value='Y']").prop('checked', true);
		}
		
		
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
				var tmp = nullChk(result.view_type);
				
				if(tmp == '')
				{
					$("input:radio[name='view_type']:radio[value='none']").prop('checked', true);
				}
				$("input:radio[name='view_type']:radio[value='"+tmp+"']").prop('checked', true);
				typeClick(tmp);
				
				$("#contents").val(repWord(result.contents));
			}
		});	
	}
}
function cateTyping()
{
	var tmp = $("#cate_nm").val();
	$("#"+selDep+"_"+selIdx).html(tmp);
}
function cateClick(tmp)
{
	$("#"+selDep+"_"+selIdx).attr("is_show", tmp);
}
function typeClick(act)
{
	var inner = "";
	$("#type_target").html(inner);
	
	if(act == "link")
	{
		inner += '<input type="text" id="contents" name="contents"/>';
		$("#type_target").html(inner);
	}
	else if(act == "pop")
	{
		inner += '<textarea id="contents" name="contents"></textarea>';
		$("#type_target").html(inner);
		CKEDITOR.replace('contents'); 
// 		CKEDITOR.replace('contents', {
// 			filebrowserUploadUrl : '/mumul/ckeditor_upload'
// 		});
	}
	else if(act == "direct")
	{
		inner += '<textarea id="contents" name="contents"></textarea>';
		$("#type_target").html(inner);
	}
	
	
}

function fncSubmit()
{
	var sort = 0;
	var isSuc = true;
	$("#depth_area > div").each(function(){
		sort++;
		var fin_dep = $(this).attr("id").split("_")[1];
		var fin_idx = $(this).attr("id").split("_")[2];
		
		var fin_par = "0";
		if(!$(this).hasClass("dep_1"))
		{
			fin_par = ($(this).attr("class").split(" ")[2]).split("_")[3];
		}
		var fin_cate_nm = $(this).html().replace('<span class="category">', "");
		fin_cate_nm = fin_cate_nm.replace("</span>", "");
		var fin_is_show = $(this).attr("is_show");
		
		$.ajax({
			type : "POST", 
			url : "/mumul/saveCate",
			dataType : "text",
			async : false,
			data : 
			{
				dep : fin_dep,
				idx : fin_idx,
				par : fin_par,
				cate_nm : fin_cate_nm,
				is_show : fin_is_show,
				sort : sort
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc != "success")
	    		{
	    			isSuc = false;
	    		}
			}
		});	
	});
	
	if(isSuc)
	{
		var radioVal = $('input[name="view_type"]:checked').val();
		if(radioVal == "pop")
	    {
	    	CKEDITOR.instances.contents.updateElement(); 
	    }
		$.ajax({
			type : "POST", 
			url : "/mumul/saveContents",
			dataType : "text",
			async:false,
			data : 
			{
				idx : selIdx,
				view_type : radioVal,
				contents : $("#contents").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc != "success")
	    		{
	    			isSuc = false;
	    		}
			}
		});	
	}
	
	if(isSuc)
	{
		alert("저장되었습니다.");
	}
	else
	{
		alert("오류가 발생하였습니다.");
	}
}

</script>

<div id="wrap" class="mumul_admin">
	<div id="header">
		<header class="header_wrap">
			<div class="logo"><a href="../cate_list"><img src="/img/mumul/logo.png" alt="뮤자인 로고"></a></div>
			<nav>
				<ul class="gnb">
					<li><a href="#">대시보드</a></li>
					<li class="on"><a href="#">키워드 관리</a></li>
					<li><a href="#">운영자 관리</a></li>
				</ul>
			</nav>
		</header>
	</div>
	<div id="container">
		<main class="container_wrap">
			<div class="container_top">
				<div class="breadcrumb">
					<ul>
						<li>홈</li>
						<li>키워드 관리</li>
					</ul>
				</div>
				<h1 class="page_title">키워드 관리</h1>
				<div class="member_menu">
					<button type="button">admin</button>
					<i><img src="" alt="멤버 아이콘"></i>
				</div>
			</div>
			<div id="content" class="mumul_admin_content">
				<section class="section category_tree_section">
					<div class="category_wrapper content_box">
						<h3>카테고리</h3>
						<div class="category_tree">
							<div id="depth_area"></div>
						</div>
						<div class="category_btn_box">
							<button type="button" class="category_btn category_add_btn" onclick="javascript:addDepth();">키워드 추가</button>
							<button type="button" class="category_btn category_delete_btn" onclick="javascript:delDepth();"><img src="/img/mumul/category_close_btn.svg" alt="키워드">선택 삭제</button>
						</div>
					</div>
				</section>
				<section class="section category_detail_section">
					<div class="category_detail content_box">
						<dl>
							<dt>카테고리명</dt>
							<dd><input type="text" id="cate_nm" name="cate_nm" placeholder="카테고리명을 입력해주세요 " onkeyup="cateTyping()"/></dd>
						</dl>
						<dl>
							<dt>노출 여부</dt>
							<dd>
								<div class="input_radio_wrap">
									<span class="input_radio">
										<input type="radio" id="is_show1" name="is_show" value="Y" onclick="javascript:cateClick('Y');" checked /> 
										<label for="is_show1"><span>노출</span></label>
									</span>
									<span class="input_radio">
										<input type="radio" id="is_show2" name="is_show" value="N" onclick="javascript:cateClick('N');" /> 
										<label for="is_show2"><span>비노출</span></label>
									</span>
								</div>
							</dd>
						</dl>
						<dl>
							<dt>타입</dt>
							<dd>
								<div class="input_radio_wrap">
									<span class="input_radio">
										<input type="radio" id="view_type1" name="view_type" value="none" onclick="javascript:typeClick('none');" checked/> 
										<label for="view_type1"><span>내용없음</span></label>
									</span>
									<span class="input_radio">
										<input type="radio" id="view_type2" name="view_type" value="link" onclick="javascript:typeClick('link');" /> 
										<label for="view_type2"><span>링크</span></label>
									</span>
									<span class="input_radio">
										<input type="radio" id="view_type3" name="view_type" value="pop" onclick="javascript:typeClick('pop');" /> 
										<label for="view_type3"><span>팝업</span></label>
									</span>
									<span class="input_radio">
										<input type="radio" id="view_type4" name="view_type" value="direct" onclick="javascript:typeClick('direct');" /> 
										<label for="view_type4"><span>바로답변</span></label>
									</span>
								</div>
							</dd>
						</dl>
						<dl>
							<dt>내용</dt>
							<dd id="type_target">
								<!-- 위에 라디오버튼 클릭에 따라 내용 달라쥠 -->
							</dd>
						</dl>
					</div>
				</section>
				<div class="save_btn_wrap">
					<button type="button" class="float_btn save_btn btn_type_v1" onclick="javascript:fncSubmit();">저장</button>
				</div>
		
			</div>
			<!-- //content -->
		</main>
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->

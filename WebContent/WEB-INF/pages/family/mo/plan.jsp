<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

$(document).ready(function(){
	getList();
});


var grade_idx_arr = new Array();
function getList(){
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getMoPlanList",
		dataType : "text",
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.list.length > 0)
			{
				grade_idx_arr = new Array();
				for (var i = 0; i < result.list.length; i++) {
					grade_idx_arr.push(result.list[i].idx);
					inner +='<div class="plan_inner">';
					
					inner +='	<div class="mu_right_content n1">';
					inner +='		<div class="mu_right_box1">';
					inner +='			<h3>계약 등급</h3>';
					inner +='			<div class="mu_drop plan_level">';
					inner +='				<input type="text" id="grade_nm_'+result.list[i].idx+'" value="'+nullChk(result.list[i].grade_nm)+'" placeholder="등급입력" class="gr_type">';
					inner +='			</div>';
					inner +='		</div>';
					inner +='	</div>';
					
					inner +='	<div class="mu_right_content n3 ">';
					
					inner +='		<div class="mu_right_box1 pd_r">';
					inner +='			<h3>월 사용료(기본)</h3>';
					inner +='			<div class="mu_drop gr_line_w left_line plan">';
					inner +='				<input type="text" id="mon_amount_'+result.list[i].idx+'" value="'+nullChk(result.list[i].mon_amount)+'" placeholder="금액입력" class="gr_type">';
					inner +='			</div>';
					inner +='		</div>';
					
					inner +='		<div class="mu_right_box1 final_amount">';
					
					inner +='			<h3>월 사용료(최종금액)</h3>';
					inner +='			<div class="mu_drop gr_line_w plan_mid">';
					inner +='				<input type="text" id="t_mon_amount_'+result.list[i].idx+'" value="'+nullChk(result.list[i].t_mon_amount)+'" placeholder="금액입력" class="gr_type mid_left">';
					inner +='				<div class="percent_box"><input type="text" id="per_amount_'+result.list[i].idx+'" value="'+nullChk(result.list[i].per_amount)+'" placeholder="" class="gr_type plan_per"><span class="per_red">%</span></div>';
					inner +='			</div>';
					
					inner +='		</div>';
					inner +='		<div class="mu_right_box1 pd_L">'; 
					
					inner +='			<h3>연 사용료</h3>';
					inner +='			<div class="mu_drop gr_line_w right_line plan">';
					inner +='				<input type="text" id="year_amount_'+result.list[i].idx+'" value="'+nullChk(result.list[i].year_amount)+'" placeholder="금액입력" class="gr_type">';
					inner +='			</div>';
					
					inner +='		</div>';
					inner +='	</div>';
					inner +='	<button type="button" class="add_grade" onclick="del_grade(\''+result.list[i].idx+'\');">삭제</button>';
					inner +='</div>';
				}
				$('#grade_area').html(inner);
			}
			end_loading();
		}
	});
}


function del_grade(idx){
	if(!confirm("정말 삭제하시겠습니까?"))
	{
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./delMoPlan",
		dataType : "text",
		data : 
		{
			idx : idx,
		},
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			getList();
		}
	});
}

function add_grade(){
	$.ajax({
		type : "POST", 
		url : "./addMoPlan",
		dataType : "text",
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			getList();
		}
	});
}

function save_grade(){
	var grade_idx    = "";
	var grade_nm     = "";
	var mon_amount   = "";
	var t_mon_amount = "";
	var per_amount   = "";
	var year_amount  = "";
	
	for (var i = 0; i < grade_idx_arr.length; i++) {
		grade_idx	 += grade_idx_arr[i]+"|";
		
		////////////////////////////////////////////////////////////
		//등급명 체크
		if ($('#grade_nm_'+grade_idx_arr[i]).val()=="") 
		{
			alert("등급 입력해주세요.");
			$('#grade_nm_'+grade_idx_arr[i]).focus();
			return;
		}
		else
		{
			grade_nm	 += $('#grade_nm_'+grade_idx_arr[i]).val()+"|";
		}
		///////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////
		//월 사용료(기본) 체크
		if ($('#mon_amount_'+grade_idx_arr[i]).val()=="") 
		{
			alert("월 사용료(기본)을 입력해주세요.");
			$('#mon_amount_'+grade_idx_arr[i]).focus();
			return;
		}
		else
		{
			mon_amount	 += $('#mon_amount_'+grade_idx_arr[i]).val()+"|";
		}
		///////////////////////////////////////////////////////////

		///////////////////////////////////////////////////////////
		//월 사용료(최종금액) 체크
		if ($('#t_mon_amount_'+grade_idx_arr[i]).val()=="") 
		{
			alert("월 사용료(최종금액)을 입력해주세요.");
			$('#t_mon_amount_'+grade_idx_arr[i]).focus();
			return;
		}
		else
		{
			t_mon_amount	 += $('#t_mon_amount_'+grade_idx_arr[i]).val()+"|";
		}
		///////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////
		//월 사용료(최종금액)비율 체크
		if ($('#per_amount_'+grade_idx_arr[i]).val()=="") 
		{
			alert("월 사용료(최종금액)비율을 입력해주세요.");
			$('#per_amount_'+grade_idx_arr[i]).focus();
			return;
		}
		else
		{
			per_amount	 += $('#per_amount_'+grade_idx_arr[i]).val()+"|";
		}
		///////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////
		//연 사용료 체크
		if ($('#year_amount_'+grade_idx_arr[i]).val()=="") 
		{
			alert("월 사용료(최종금액)비율을 입력해주세요.");
			$('#year_amount_'+grade_idx_arr[i]).focus();
			return;
		}
		else
		{
			year_amount	 += $('#year_amount_'+grade_idx_arr[i]).val()+"|";
		}
		///////////////////////////////////////////////////////////
	}
	
	console.log("grade_idx : "+grade_idx);
	console.log("grade_nm : "+grade_nm);
	console.log("mon_amount : "+mon_amount);
	console.log("t_mon_amount : "+t_mon_amount);
	console.log("per_amount : "+per_amount);
	console.log("year_amount : "+year_amount);
	
	$.ajax({
		type : "POST", 
		url : "./uptMoPlan",
		dataType : "text",
		data : 
		{
			grade_idx : grade_idx,
			grade_nm : grade_nm,
			mon_amount : mon_amount,
			t_mon_amount : t_mon_amount,
			per_amount : per_amount,
			year_amount : year_amount
		},
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if (result.isSuc=="success") 
			{
				
			}
			alert(result.msg);
		}
	});
	
}
</script>

<!-- 플랜 등록 -->
<div id="wrap">		
	<div class="mu_content write wage plan">
		<div class="mu_inner">
			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">플랜 등록</h3>
<!-- 					<div class="mu_mypage"> -->
<!-- 						<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 						<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 					</div> -->
					<button type="button" class="add_grade plan_grade" onclick="add_grade();">+ 등급 추가</button>
				</div>
			</div>
			<div class="mu_bottom">
				<div class="mu_bottom_02">
					<div class="mu_contentsBox">
						<div class="mu_contents_right contr">
							<div id="grade_area" class="mu_right_inner"></div>
							<div class="mu_bttom_btn">
								<input type="submit" value="저장하기" class="mu_save" onclick="save_grade();">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>
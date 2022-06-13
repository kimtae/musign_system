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

var cate_idx_arr = new Array();
function getList(){
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./getMoCateList",
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
				var mr_type_arr="";
				var mr_type2_arr="";
				var mr_cost_arr="";
				cate_idx_arr = new Array();
				for (var i = 0; i < result.list.length; i++) {
					cate_idx_arr.push(result.list[i].idx);
					mr_type_arr = result.list[i].mr_type.split('|');
					mr_type2_arr = result.list[i].mr_type2.split('|');
					mr_cost_arr = result.list[i].mr_cost.split('|');
					
					inner +='<div class="mu_contentsBox n1 half_cont">';
					inner +='	<div class="cont_wrap left">';
					inner +='		<button type="button" class="del_item dis_no" onclick="del_cate(\''+result.list[i].idx+'\')">- 삭제</button>';
					inner +='		<div class="cont_top_wrap half_cont">';
					inner +='			<div class="mu_right_box1">';
					inner +='				<div class="mu_txt cont-top">';
					inner +='					<input type="text" id="mr_nm_'+result.list[i].idx+'" value="'+nullChk(result.list[i].mr_nm)+'" class="gr_type" placeholder="등급입력">';
					inner +='				</div>';
					inner +='			</div>';
					inner +='			<button type="button" class="plus_item bg_blue" onclick="add_cate_sub(\''+result.list[i].idx+'\');">+ 추가</button>';
					inner +='		</div>';
					
					
					inner +='		<div id="cate_sub_area_'+result.list[i].idx+'" class="cont_btm_wrap">';
					for (var j = 0; j < mr_type_arr.length-1; j++) {
						inner +='			<div id="sub_cont_'+(j+1)+'" class="sub_cont cont_btm n1 half_cont">';
						inner +='				<div class="mu_right_box1 n1">';
						inner +='					<div class="mu_txt">';
						inner +='						<input type="text" value="'+mr_type_arr[j]+'" class="gr_type mr_type_'+result.list[i].idx+'" placeholder="구분">';
						inner +='					</div>';
						inner +='				</div>';
						inner +='				<div class="mu_right_box1 n2">';
						inner +='					<div class="mu_txt">';
						inner +='						<input type="text" value="'+mr_type2_arr[j]+'" class="gr_type mr_type2_'+result.list[i].idx+'" placeholder="세부항목">';
						inner +='					</div>';
						inner +='				</div>';
						inner +='				<div class="mu_right_box1 n3">';
						inner +='					<div class="mu_txt">';
						inner +='						<input type="text" value="'+mr_cost_arr[j]+'" class="gr_type mr_cost_'+result.list[i].idx+'" placeholder="금액입력">';
						inner +='					</div>';
						inner +='				</div>';
						inner +='				<button type="button" class="del_item" onclick="del_cate_sub(\''+(j+1)+'\')">- 삭제</button>';
						inner +='			</div>';
					}
					inner +='		</div>';
					inner +='	</div>';
					inner +='</div>';
				}
				$('#cate_area').html(inner);
			}
			end_loading();
		}
	});
}

function add_cate(){
	$.ajax({
		type : "POST", 
		url : "./addMoCate",
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

function del_cate(idx){
	if(!confirm("정말 삭제하시겠습니까?"))
	{
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./delMoCate",
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

function add_cate_sub(idx){
	var len = ($('.sub_cont').length)+1;
	var inner="";
	inner +='<div id="sub_cont_'+len+'" class="sub_cont cont_btm n1 half_cont">';
	inner +='	<div class="mu_right_box1 n1">';
	inner +='		<div class="mu_txt">';
	inner +='			<input type="text" value="" class="gr_type mr_type_'+idx+'">';
	inner +='		</div>';
	inner +='	</div>';
	inner +='	<div class="mu_right_box1 n2">';
	inner +='		<div class="mu_txt">';
	inner +='			<input type="text" value="" class="gr_type mr_type2_'+idx+'">';
	inner +='		</div>';
	inner +='	</div>';
	inner +='	<div class="mu_right_box1 n3">';
	inner +='		<div class="mu_txt">';
	inner +='			<input type="text" value="" class="gr_type mr_cost_'+idx+'">';
	inner +='		</div>';
	inner +='	</div>';
	inner +='	<button type="button" class="del_item" onclick="del_cate_sub(\''+len+'\')">- 삭제</button>';
	inner +='</div>';
	$('#cate_sub_area_'+idx).append(inner);
}

function del_cate_sub(idx){
	if(!confirm("정말 삭제하시겠습니까?"))
	{
		return;
	}
	$('#sub_cont_'+idx).remove();
}

function save_cate(){
	
	var mr_nm="";
	var mr_type_arr="";
	var mr_typr2_arr="";
	var mr_cost_arr="";
	
	for (var i = 0; i < cate_idx_arr.length; i++) {
		mr_nm = $('#mr_nm_'+cate_idx_arr[i]).val();
// 		if (condition) 
// 		{
			
// 		}
		
		
		for (var j = 0; j < $('.mr_type_'+cate_idx_arr[i]).length; j++) {
			
		}
		mr_type_arr =""; 
		
		$.ajax({
			type : "POST",  
			url : "./uptMoCate",
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
}

</script>

<div id="wrap">		
	<div class="mu_content write wage cate_add">
		<div class="mu_inner">
			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">유지보수 항목 등록</h3>
<!-- 					<div class="mu_mypage"> -->
<!-- 						<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 						<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 					</div> -->
						<button type="button" class="add_grade mo_btn" onclick="add_cate();">+ 등급 추가</button>
						<button type="button" class="add_grade pc_btn" onclick="add_cate();">+ 등급 추가</button>
				</div>
			</div>
			
<!-- 			<div class="cont_wrap right wage_btn"> -->
<!-- 				<button type="button" class="add_grade" onclick="add_cate();">+ 등급 추가</button> -->
<!-- 			</div> -->
			
			<div id="cate_area" class="mu_bottom">
			
				<div class="mu_contentsBox n1 half_cont">
					<div class="cont_wrap left">
						<button type="button" class="del_item">- 삭제</button>
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1">
								<div class="mu_txt cont-top">
									<input type="text" placeholder="디자인" class="gr_type">
								</div>
							</div>
							<button type="button" class="plus_item bg_blue">+ 추가</button>
						</div>
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="리사이징" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="이미지 리사이징" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n3">
									<div class="mu_txt">
										<input type="text" placeholder="50,000" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
						</div>
					</div>
				</div>
				
			</div><!-- end of .mu_contents-->
			<input type="submit" value="저장하기" class="mu_save" onclick="save_cate();">
<!-- 			<div class="mu_bttom_btn"> -->
<!-- 				<input type="submit" value="저장하기" class="mu_save" onclick="save_cate();"> -->
<!-- 			</div> -->
		</div>
	</div>
</div>









<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



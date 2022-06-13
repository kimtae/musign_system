<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>


<script>
var project_idx='';
var grade_idx='';
var left_amt=0;

$( document ).ready(function() {
	getMoCateList();
});

function getMoCateList()
{
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
				
				var mr_type="";
				var mr_type2="";
				var mr_cost="";
				for (var i = 0; i < result.list.length; i++) {
					inner = "";
					if (nullChk(result.list[i].mr_nm)!="") 
					{
						
						mr_type = result.list[i].mr_type;
						mr_type2 = result.list[i].mr_type2;
						mr_cost = result.list[i].mr_cost;
						
						inner+='<div id="mr_div_'+result.list[i].idx+'" class="mu_right_box1">';
						inner+='	<h3>'+result.list[i].mr_nm+'</h3>';
						inner+='	<div class="mu_money popup_wrap">';
						inner+='	<button type="button" class="add_item wide_btn show" onclick="show_pop(this);">+ 항목 추가</button>';
						inner+='	<div class="background">';
						inner+='		<div class="window">';
						inner+='			<div class="popup">';
						inner+='				<div class="pop_cont_wrap design_plus">';
						inner+='					<h5>'+result.list[i].mr_nm+' 항목 추가</h5>';
						inner+='					<span>'+result.list[i].mr_nm+' 항목</span>';
						
						inner+='					<div id="mr_type_area_'+result.list[i].idx+'">';
						inner+='					</div>';
						
						inner+='					<div class="pop_cont n2">';
						inner+='						<button type="button" class="" onclick="add_mr_type(\''+result.list[i].idx+'\',\''+mr_type+'\',\''+mr_type2+'\',\''+mr_cost+'\');">+ 항목추가</button>';
						inner+='					</div>';
						inner+='					<div class="pop_cont n2-2 half_cont">';
						inner+='						<div class="balance half_cont">';
						inner+='							<span>잔여 금액</span>';
						inner+='							<span class="left_amt red_font"></span>';
						inner+='						</div>';
						inner+='					</div>';
						inner+='					<div class="pop_cont n3 half_cont">';
						inner+='						<div class="popup_btn n1">';
						inner+='							<button type="button" class="close_btn">취소</button>';
						inner+='						</div>';
						inner+='						<div class="popup_btn n2">';
						inner+='							<button type="button" class="mu_add">생성</button>';
						inner+='						</div>';
						inner+='					</div>';
						inner+='				</div>';
						inner+='			</div>';
						inner+='		</div>';
						inner+='	</div>';
						inner+='</div>';
						$('#mr_area').append(inner);
					}
				}
			}
		}
	});
}

function del_pop(idx){
	var target_amt = $('.target_amt_'+idx).val();
	left_amt = left_amt+(target_amt*1);
	$('.left_amt').text(left_amt);
	$('.target_pop'+idx).remove();
}

function add_mr_type(idx,mr_type,mr_type2,mr_cost){
	
	var mr_type_arr = mr_type.split('|');
	var mr_type2_arr = mr_type2.split('|');
	var mr_cost_arr = mr_cost.split('|');
	
	var inner='';
	var len = $('.pop_cont').length;
	
	inner+='<div class="target_pop'+len+' pop_cont n1 half_cont">';
	inner+='	<div class="pop_left">';
	inner+='		<div class="mu_drop">';
	inner+='			<button type="button" class="mu_dropBtn drop_btn_h"></button>';
	inner+='			<ul>';
	
	for (var i = 0; i < mr_type2_arr.length; i++) {
		if (mr_type2_arr[i]!='') {
			//inner+='		<li onclick="document.getElementsByClassName(\'target_amt_'+len+'\')[0].value=\''+mr_cost_arr[i]+'\' " >'+mr_type2_arr[i]+'('+comma(mr_cost_arr[i])+')</li>';
			inner+='		<li onclick="choose_target('+mr_cost_arr[i]+','+len+',\''+mr_type2_arr[i]+'\')" >'+mr_type2_arr[i]+'('+comma(mr_cost_arr[i])+')</li>';
		}
	}
	
	inner+='			</ul>';
	inner+='		</div>';
	inner+='	</div>';
	inner+='	<div class="pop_right">';
	inner+='		<div class="mu_drop">';
	inner+='			<input type="text" class="target_mr_type2_'+len+' target_amt gr_type">';
	inner+='			<input type="text" class="target_amt_'+len+' target_amt gr_type">';
	inner+='		</div>';
	inner+='	</div>';
	inner+='	<button type="button" class="del_item" onclick="del_pop('+len+');">- 삭제</button>';
	inner+='</div>';
	/*
	inner+='<div class="target_pop'+len+' pop_cont n1-2 half_cont cost_pdt">';
	inner+='	<span>사용금액</span>';
	inner+='	<span>- 50,000</span>';
	inner+='</div>';
	*/
	$('#mr_type_area_'+idx).append(inner);
	
}


function choose_project(idx){
	project_idx=idx;
}

function choose_grade(idx){
	grade_idx=idx;
}

function show_pop(val){
	if ($('#contract_amt').val()=='' || $('#contract_amt').val()=='0') 
	{
		alert('계약금을 입력해주세요.');
		$('#contract_amt').focus();
		return;
	}
	var target_amt=0;
	$('.target_amt').each(function(){ 
		target_amt+=($(this).val()*1);
	})
	
	left_amt = $('#contract_amt').val() - target_amt;
	if (left_amt < 0) 
	{
		alert('계약 금액이 0원보다 작습니다. 계약 금액을 확인해주세요.');
		return;
	}
	
	$('.left_amt').text(left_amt);

	$(".background.show").removeClass('show');
	$(val).siblings('div').toggleClass('show');
}

function choose_target(cost,len,mr_type2){
	
	if (left_amt < cost) 
	{
		alert('금액 초과');
		return;
	}
	
	var target_amt = $('.target_amt_'+len).val();
	if (target_amt == '') 
	{
		left_amt=left_amt- (cost*1);
	}
	else
	{
		left_amt=(left_amt+($('.target_amt_'+len).val()*1))- (cost*1);
	}
	
	$('.target_amt_'+len).val(cost);		
	$('.target_mr_type2_'+len).val(mr_type2);
	//left_amt=left_amt- (cost*1);
	$('.left_amt').text(left_amt);
}


function add_project(){
	
	var idx					=nullChk('${idx}');
	var project_type		=document.querySelector('input[name="regular"]:checked').value;;
	var sale_idx			=project_idx; 						 var grade				=project_type==1?grade_idx:'';
	var edit_cnt			=nullChk($('#edit_cnt').val()); 	 var manager_nm			=nullChk($('#manager_nm').val());
	var manager_level		=nullChk($('#manager_level').val()); var phone_no1			=nullChk($('#phone_no1').val());
	var phone_no2			=nullChk($('#phone_no2').val());     var phone_no3			=nullChk($('#phone_no3').val());
	var email				=nullChk($('#email').val());		 var business_no		=nullChk($('#business_no').val());
	var contract_amt		=nullChk($('#contract_amt').val());	 var start_ymd			=nullChk($('#start_ymd').val());
	var end_ymd				=nullChk($('#end_ymd').val());		 var month_amt			=nullChk($('#month_amt').val());
	var month_cal_day		=nullChk($('#month_cal_day').val()); var tax_date			=nullChk($('#tax_date').val());
	var user_id				=nullChk($('#user_id').val());		 var user_pw			=nullChk($('#user_pw').val());
	var ftp_id				=nullChk($('#ftp_id').val());		 var ftp_pw				=nullChk($('#ftp_pw').val());
	var db_id				=nullChk($('#db_id').val());		 var db_pw				=nullChk($('#db_pw').val());
	var mr_idx				='';								 var mr_sub_idx			='';
	
	/*
	if (sale_idx=='') { alert('프로젝트를 선택해주세요'); return }
	if (grade=='') { alert('계약등급을 선택해주세요'); return }
	if (edit_cnt=='') { alert('요청사항별 수정 횟수를 적어주세요.'); return }
	if (manager_nm=='') { alert('담당자명을 입력해주세요.'); return }
	if (manager_nm=='') { alert('담당자명을 입력해주세요.'); return }
	*/
	
	
	
	/*
	$.ajax({
		type : "POST", 
		url : "./add_project",
		dataType : "text",
		data : 
		{
			idx 			: 	idx,
			project_type	: 	project_type,
			sale_idx		: 	sale_idx,
			grade			: 	grade,
			edit_cnt		: 	edit_cnt,
			manager_nm		:	manager_nm,
			manager_level	:	manager_level,
			phone_no1		: 	phone_no1,
			phone_no2		: 	phone_no2,
			phone_no3		:	phone_no3,
			email			:	email,
			business_no		:	business_no,
			contract_amt	:	contract_amt,
			start_ymd		:	start_ymd,
			end_ymd			:	end_ymd,
			month_amt		:	month_amt,
			month_cal_day	:	month_cal_day,
			tax_date		:	tax_date,
			mr_idx			:	mr_idx,
			mr_sub_idx		:	mr_sub_idx,
			user_id			:	user_id,
			user_pw			:	user_pw,
			ftp_id			:	ftp_id,
			ftp_pw			:	ftp_pw,
			db_id			:	db_id,
			db_pw			:	db_pw
		},
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
				
			}
		}
	});
	*/
}


</script>

<!-- 관리자 - 프로젝트등록 -->

<div id="wrap">		
	<div class="mu_content write enrollment">
		<div class="mu_inner">
			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">프로젝트 등록</h3>
					<!-- 
					<div class="mu_mypage">
						<a href="#" class="mu_myIcon">마이페이지</a>
						<a href="#" class="mu_myIcon2">로그아웃</a>
					</div>
					 -->
				</div>
				<div class="mu_top3">
					<div class="mu_radio n1">
						<input type="radio" id="project_type_a" name="regular" value='1' class="top_radio n1" checked="checked"><label for="radio">정기</label>
					</div>
					<div class="mu_radio n2">
						<input type="radio" id="project_type_b" name="regular" value='2' class="top_radio n2"><label for="radio">비정기</label>
					</div>
				</div>
			</div>
			<div class="mu_bottom">
				<div class="mu_bottom_02">
					<div class="mu_contentsBox">
						<div class="mu_contents_lr">
							<div class="mu_contents_right contr">
								<div class="mu_right_inner">
									<div class="mu_right_content n1">
										<div class="mu_right_box1">
											<h3>프로젝트 명</h3>
											<div class="mu_drop">
												<button type="button" class="mu_dropBtn">프로젝트를 선택해주세요.</button>
												<ul id="project_nm">
													<c:forEach var="j" items="${getProjectList}" varStatus="loop">
														<li onclick="choose_project('${j.idx}')">${j.user_company}</li>
													</c:forEach>
												</ul>
											</div>
										</div>
										<div class="mu_right_box1 con_regular">
											<h3>계약등급</h3>
											<div class="mu_drop">
												<button type="button" id="grade" class="mu_dropBtn">등급을 선택해주세요.</button>
												<ul id="memberGrade">
													<c:forEach var="j" items="${getGradeList}" varStatus="loop">
														<li onclick="choose_grade('${j.idx}')">${j.grade_nm}</li>
													</c:forEach>
												</ul>
												
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>요청사항별 수정 횟수</h3>
											<div class="mu_drop">
												<input type="number" id="edit_cnt" class="gr_type" >
											</div>
										</div>
									</div>
									<div class="mu_right_content n2">
										<div class="mu_right_box1 n1">
											<h3>담당자명</h3>
											<div class="mu_drop">
												<input type="text" id="manager_nm"  class="gr_type">
											</div>
										</div>
										<div class="mu_right_box1 n2">
											<h3>직급</h3>
											<div class="mu_drop">
												<input type="text" id="manager_level" class="gr_type">
											</div>
										</div>
										<div class="mu_right_box1 n3">
											<h3>연락처</h3>
											<div class="half_cont gr_line">
												<div class="mu_text_no">
													<input type="number" id="phone_no1" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="number" id="phone_no2" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="number" id="phone_no3" class="gr_type">
												</div>
											</div>
										</div>
										<div class="mu_right_box1 n4">
											<h3>이메일</h3>
											<div class="mu_drop">
												<input type="text" id="email" class="gr_type wide_input">
											</div>
										</div>
										<div class="mu_right_box1 n5">
											<h3>사업자등록번호</h3>
											<div class="mu_drop">
												<input type="text" id="business_no" class="gr_type wide_input">
											</div>
										</div>
									</div>
									<div class="mu_right_content n3">
										<div class="mu_right_box1">
											<h3>계약금액(연간)</h3>
											<div class="mu_drop gr_line_w">
												<input type="number" id="contract_amt" class="gr_type wide_btn">
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>계약 시작일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" id="start_ymd" class="wide_btn date-i">
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>계약 종료일</h3>
											<div class="mu_calender">
												<input type="text" id="end_ymd" class="wide_btn date-i">
											</div>
										</div>
									</div>
									<div class="mu_right_content n4">
										<div class="mu_right_box1">
											<h3>월 정산금액</h3>
											<div class="mu_drop gr_line_w">
												<input type="number" id="month_amt" class="gr_type wide_btn">
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>월 정산일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" id="month_cal_day" class="wide_btn date-i">
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>세금계산서 발행일</h3>
											<div class="mu_calender">
												<input type="text" id="tax_date" class="wide_btn date-i">
											</div>
										</div>
									</div>
									
									<div id="mr_area" class=" mu_right_content n5 con_regular">
									
									</div>
									
									<div class="mu_right_content n7">
										<div class="mu_right_box1 box2">
											<h3>아이디</h3>
											<div class="mu_money gr_line">
												<input type="text" id="user_id" class="gr_type wide_btn">
											</div>
										</div>
										<div class="mu_right_box1 box2">
											<h3>비밀번호</h3>
											<div class="mu_text_no">
												<input type="text" id='user_pw' class="gr_type wide_btn">
											</div>
										</div>
									</div>
									<div class="mu_right_content n8">
										<div class="mu_right_box1 box2">
											<h3>FTP접속정보</h3>
											<div class="half_cont gr_line">
												<div class="mu_text_no">
													<input type="text" id="ftp_id" placeholder="ID" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="text" id="ftp_pw" placeholder="PW" class="gr_type">
												</div>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>DB접속정보</h3>
											<div class="half_cont">
												<div class="mu_text_no">
													<input type="text" id="db_id" placeholder="ID" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="text" id="db_pw" placeholder="PW" class="gr_type">
												</div>
											</div>
										</div>
									</div><!-- end of .mu_contents-->
									<div class="mu_bttom_btn">
										<input type="submit" value="등록하기" class="mu_save" onclick='add_project()'>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>





<script>


</script>

<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



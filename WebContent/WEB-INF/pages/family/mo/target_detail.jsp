<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<!-- <script>

$(document).ready(function(){		
	
	function show_area(target){
		$('.sub_area').hide();
		$('#'+target+"_area").show();
		
		$('.sub_head').removeClass('on');
		$('#'+target+'_head').addClass('on');
	}
	
	
	var dropDiv2 = $('.mu_drop');
	var dropBt2 = $(".mu_drop button");
	$.each(dropDiv2, function(idex, item){		
		var dropUl2 = $(this).find("ul");
		$(this).find('button').on("click",function(){
			dropUl2.toggle();
		});
		dropUl2.click(function(){
			$(this).hide();
		});
	});	
	
	
	var dropDiv = $('.mu_drop');
	$.each(dropDiv, function(index, item){
		var _this = $(this);
		$(this).find('ul li').click(function(){
			var dropTxt = $(this).text();
			_this.find('button').text(dropTxt);
		});		
	});
	
	//진행바
	
		var dropLis = $('.mu_drop.drop_line ul li');
		var muLine = $('.mu_line .circle'); 
// 		var muCir = $('.mu_line ul li .circle'); 

		$.each(dropLis, function(index, item){
		
			$(this).click(function(){
				var idx = $(this).index();
				//$('body').append('<style>.mu_line ul:after {width: ' +  idx*7.5 + 22 + '%;}</style>');
				$('.mu_line .bg_b').css('width', (idx + 1)*12.5 + '%');
				muLine.removeClass('on');
				muLine.eq(index).addClass('on');
			});		
		});
		
	$('.sub_area').hide();
	$('#sub_offer_area').show();
});



</script>  -->

<div class="mu_content calculate_margin sy_wrap">
	<div class="mu_inner">
		<div class="mu_top">
			<div class="mu_top2">
				<h3 class="mu_title">유지보수 상세현황</h3>
<!-- 				<div class="mu_mypage"> -->
<!-- 					<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 					<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 				</div> -->
			</div>
			<a href="http://sale.musign.net/family/mo/list" class="mu_back">리스트로 돌아가기</a>
		</div>
		<div class="mu_bottom">
			<div class="mu_bottom_01">
				<h3 class="mu_title2">10월 유지보수 처리현황</h3>
				<div class="mu_line">
					<div class="bg_g"></div>					
					<div class="bg_b" style="width: 12.5%"></div>
					<ul>
                            <li>
                                <div class="circle on">
                                    <span>접수완료</span>    
                                </div>
                            </li>

                            <li>
                                <div class="circle">
                                    <span>요구사항 분석</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>요구사항 확정</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>작업중</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>검수요청</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>검수완료</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>정산</span>    
                                </div>
                            </li>
                            <li>
                                <div class="circle">
                                    <span>완료</span>    
                                </div>
                            </li>
                        </ul>						
				</div>
				<div class="mu_progress">
					<div class="mu_progress2">
						<h2 class="mu_title3 progress03_tit">진행 상태</h2>
							<div class="mu_drop drop_line pro_drop progress_drop">
								<button type="button" class="progress_btn">접수완료</button>
									<ul>
										<li>접수완료</li>
										<li>요구사항 분석</li>
										<li>요구사항 확정</li>
										<li>작업중</li>
										<li>검수요청</li>
										<li>검수완료</li>										
										<li>정산</li>
										<li>완료</li>
									</ul>
							</div>
				    </div>
				</div>
			</div>
			<div class="mu_bottom_02 tab_mgt">
				<div class="mu_contentsBox">
	                   <div class="mu_tabContainer">
	                       <ul class="mu_tabs">
	                           <li id="sub_offer_head" class="sub_head on"><a href="javascript:show_area('sub_offer')">유지보수 요청서</a></li>
	                           <li id="sub_work_status_head" class="sub_head"><a href="javascript:show_area('sub_work_status')">상세 업무 현황</a></li>
	                           <li id="sub_calender_head" class="sub_head"><a href="javascript:show_area('sub_calender')">캘린더</a></li>
	                           <li id="sub_memo_head" class="sub_head"><a href="javascript:show_area('sub_memo')">관리자 메모</a></li>
	                           <li id="sub_set_head" class="sub_head"><a href="javascript:show_area('sub_set')">정산설정</a></li>
	                       </ul> 
					</div>
				</div>
			</div>
		</div>
	

	<!-- 유지보수 요청서 영역 -->
	<div id="sub_offer_area" class="sub_area">
		<jsp:include page="/WEB-INF/pages/family/mo/sub_offer.jsp"/> <br>
	</div>
	
	<!-- 상세 업무 현황 영역 -->
	<div id="sub_work_status_area" class="sub_area">
		<jsp:include page="/WEB-INF/pages/family/mo/sub_work_status.jsp"/><br>
	</div>
	
	<!-- 캘린더 영역 -->
	<div id="sub_calender_area" class="sub_area">
		<jsp:include page="/WEB-INF/pages/family/mo/sub_calender.jsp"/><br>
	</div>
	
	<!-- 관리자 메모 영역 -->
	<div id="sub_memo_area" class="sub_area memo_area">
		<jsp:include page="/WEB-INF/pages/family/mo/sub_memo.jsp"/><br>
	</div>
	
	<!-- 정산 설정 영역 -->
	<div id="sub_set_area" class="sub_area set_area">
		<jsp:include page="/WEB-INF/pages/family/mo/sub_set.jsp"/><br>
	</div>
</div>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
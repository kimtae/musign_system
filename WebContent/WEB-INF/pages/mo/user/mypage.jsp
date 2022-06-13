<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/inc/js/domain_chk_mo.js"></script>

<%-- <jsp:include page="/WEB-INF/pages/family/common/header.jsp"/> --%>
<jsp:include page="/WEB-INF/pages/mo/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/mo/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<%-- <jsp:include page="/WEB-INF/pages/family/mo/progress_staus_2.jsp"/> --%>

<div class="front_wrap mypage_wrap">
	<div class="front_mypage_container">
		<div class="mypage_title">
			<h2><span class="my_icon"></span>마이 페이지</h2>
		</div>
		<div class="my_info_level">
			<h2>뮤자인님, 연간계약 PLAN은 GOLD RATE PLAN입니다.</h2>
			<div class="lank_img"></div>
		</div>
		<div class="mu_contents_lr on contract">
							<div class="mu_contents_right contr">
								<div class="mu_right_inner">
									<div class="mu_right_content n3">
										<div class="mu_right_box1">
											<h3>계약금액(연간)</h3>
											<div class="mu_drop gr_line_w">
												<button type="button" class="wide_btn">₩7,200,000</button>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>계약 시작일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" class="wide_btn date-i">
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>계약 종료일</h3>
											<div class="mu_calender">
												<input type="text" class="wide_btn date-i">
											</div>
										</div>
									</div>
									<div class="mu_right_content n4">
										<div class="mu_right_box1">
											<h3>월 정산금액</h3>
											<div class="mu_drop gr_line_w">
												<button type="button" class="wide_btn">₩600,000</button>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>월 정산일</h3>
											<div class="mu_calender gr_line_w">
												<input type="text" class="wide_btn date-i">
											</div>
										</div>
									</div>
									
									<h3 class="conbox_tit">1월 유지보수 잔여 횟수</h3>
									
									<div class="mu_right_content2 n5">
										<div class="cont_left">
											<div class="mu_right_box1 half_cont">
												<h3>디자인</h3>
												<div class="mu_money popup_wrap">
													<div class="background">
													  <div class="window">
													    <div class="popup">
													    	<div class="pop_cont_wrap">
													    		<h5>디자인 항목 추가</h5>
														  		<div class="pop_cont n1 half_cont">
														  			<div class="pop_left">
														  				<span>디자인 항목</span>
															  			<div class="mu_drop">
																			<button type="button">이미지 교체</button>
																			<ul>
																				<li>이미지 교체</li>
																				<li>팝업 디자인 교체</li>
																			</ul>
																		</div>
																	</div>
																	<div class="pop_right">
																		<span>횟수 입력</span>
															  			<div class="mu_drop">
																			<input type="text" placeholder="1" class="gr_type">
																		</div>
																	</div>
														  		</div>
														  		<div class="pop_cont n2">
														  			<button type="button" class="add_item">+ 항목추가</button>
														  		</div>
														  		<div class="pop_cont n3 half_cont">
														  			<div class="popup_btn n1">
																      <button type="button" class="close_btn">취소</button>
																    </div>
																    <div class="popup_btn n2">
																      <button type="submit" class="mu_add">생성</button>
																    </div>
													  			</div>
													    	</div>
													  	</div>
													  </div>
												    </div>
												</div>
											</div>
											<div class="mu_right_box1 half_cont">
												<div class="mu_money gr_line">
													<input type="text" placeholder="이미지 리사이징" class="mid_input">
													<button type="button" class="mu_add">0회/3회</button>
												</div>
												<div class="mu_money half_cont">
													<input type="text" placeholder="팝업 디자인, 배너 디자인" class="mid_input">
													<button type="button" class="mu_add">0회/3회</button>
												</div>
											</div>
										</div>
									</div>
									<div class="mu_right_content2 n6">
										<div class="cont_left">
											<div class="mu_right_box1 half_cont">
												<h3>퍼블리싱</h3>
												<div class="mu_money popup_wrap">
													<div class="background">
													  <div class="window">
													    <div class="popup">
													    	<div class="pop_cont_wrap">
													    		<h5>디자인 항목 추가</h5>
														  		<div class="pop_cont n1 half_cont">
														  			<div class="pop_left">
														  				<span>디자인 항목</span>
															  			<div class="mu_drop">
																			<button type="button">이미지 교체</button>
																			<ul>
																				<li>이미지 교체</li>
																				<li>팝업 디자인 교체</li>
																			</ul>
																		</div>
																	</div>
																	<div class="pop_right">
																		<span>횟수 입력</span>
															  			<div class="mu_drop">
																			<input type="text" placeholder="1" class="gr_type">
																		</div>
																	</div>
														  		</div>
														  		<div class="pop_cont n2">
														  			<button type="button" class="add_item">+ 항목추가</button>
														  		</div>
														  		<div class="pop_cont n3 half_cont">
														  			<div class="popup_btn n1">
																      <button type="button" class="close_btn">취소</button>
																    </div>
																    <div class="popup_btn n2">
																      <button type="submit" class="mu_add">생성</button>
																    </div>
													  			</div>
													    	</div>
													  	</div>
													  </div>
												    </div>
												</div>
											</div>
											<div class="mu_money bg_gray">
												<button type="button" class="mu_add top">상세페이지 링크 삽입</button>
												<button type="button" class="mu_add top">콘텐츠 영상 또는 이미지 교체</button>
												<button type="button" class="mu_add top">메인 메뉴 추가 또는 수정</button>
												<button type="button" class="mu_add top">간편로그인 버튼 추가</button>
												<button type="button" class="mu_add top">게시글 추가</button>
												<button type="button" class="mu_add top">팝업창 노출 처리</button>
												<button type="button" class="mu_add">HTML 텍스트 수정 (1회 5개)</button>
											</div>
											<div class="mu_right_box1">
												<div class="mu_money">
													<button type="button" class="mu_add">0회/7회</button>
												</div>
											</div>
										</div>
									</div>
									<div class="mu_right_content n8">
										<div class="mu_right_box1 box2">
											<h3>FTP접속정보</h3>
											<div class="half_cont gr_line">
												<div class="mu_text_no">
													<input type="text" placeholder="ID" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="text" placeholder="PW" class="gr_type">
												</div>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>DB접속정보</h3>
											<div class="half_cont">
												<div class="mu_text_no">
													<input type="text" placeholder="ID" class="gr_type">
												</div>
												<div class="mu_text_no">
													<input type="text" placeholder="PW" class="gr_type">
												</div>
											</div>
										</div>
									</div><!-- end of .mu_contents-->
									<div class="mypage_notification">
										<p>※ 연간 플랜은 최대 15% D/C가 적용된 플랜입니다. (제공 범위 외 커스텀 필요시 5p 참조)</p>
										<p>※ 유지 보수 계약 시 결제 조건은 12개월 선납 기준이며, 입금 후부터 계약의 효력이 발생합니다. (*프리미엄의 경우 1년 선납 시 1개월 비용 할인)</p>
										<p>※ 일반 기업 홈페이지 / 대기업, 쇼핑몰, 커뮤니티 등은 단가 표와 별도로 업무량에 따라 협의 후 조정할 수 있습니다.</p>
										<p>※ 서비스 항목은 이월 불가합니다.</p>
										<p>※ 동일한 금액 내 항목 변경이 가능합니다.</p>
										<p>※ 공휴일, 국경일을 제외한 영업일 기준 작업이 진행되며, 기타 유지 보수 조정사항이 필요하신 경우 요청해 주시면 맞춤형 견적서를 발송해 드립니다.</p>
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
	</div>
</div>

<script>

	/* 드롭다운 */
	$(document).ready(function(){
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
		
		/* 선택한 드롭다운 확인 */
		var dropDiv = $('.mu_drop');
		$.each(dropDiv, function(index, item){
			var _this = $(this);
			$(this).find('ul li').click(function(){
				var dropTxt = $(this).text();
				_this.find('button').text(dropTxt);
			});		
		});
		
		/* 팝업창 */
		
		var popup = $('.popup_wrap');
		var addBtn = popup.find($('.add_item'));
		var closeBtn = popup.find($('.close_btn'));
		
		addBtn.click(function(){
			$(this).siblings('div').toggleClass('show');
		})
		
		closeBtn.click(function(){
			$(this).parents('.background.show').removeClass('show');
		})
		
		/* 상단_탭메뉴 */
		
		var mu_Tab = $('.mu_tabs > li');
		var mu_Con = $('.mu_contents_lr')
		
		$.each(mu_Tab, function(index, item){
			$(this).click(function(){
				mu_Tab.removeClass('on');
				$(this).addClass('on');
								
				mu_Con.removeClass('on');
				mu_Con.eq(index).addClass('on');
					
			});
		});
		
	}); //document_end
		
</script>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>

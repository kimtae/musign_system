<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<%-- <jsp:include page="/WEB-INF/pages/family/mo/progress_staus_2.jsp"/> --%>


<!-- 상세리스트_계약정보 -->



<!-- <div id="wrap">		
	<div class="mu_content" id="contract">
		<div class="mu_inner"> -->
<!-- 			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">프로젝트명 : 빙그레</h3>
					<div class="mu_mypage">
						<a href="#" class="mu_myIcon">마이페이지</a>
						<a href="#" class="mu_myIcon2">로그아웃</a>
					</div>
				</div>
			</div> -->
			<!-- <div class="mu_bottom">
				<div class="mu_bottom_02">
					<div class="mu_contentsBox">
	                    <div class="mu_tabContainer">
	                        <ul class="mu_tabs">
	                            <li>유지보수 리스트</li>
	                            <li class="on">계약정보</li>
	                        </ul>
	                    </div> -->
<div id="wrap">		
	
<div class="mu_content calculate_margin info_wrap" id="sy_wrap_2">
	<div class="mu_inner">
		<div class="mu_top">
			<div class="mu_top2">
				<h3 class="mu_title">프로젝트명 : 빙그레</h3>
<!-- 				<div class="mu_mypage"> -->
<!-- 					<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 					<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="mu_bottom">
			<div class="mu_bottom_02">
				<div class="mu_contentsBox">
                    <div class="mu_tabContainer">
                        <ul class="mu_tabs">
                            <li><a href="/family/mo/target_list">유지보수 리스트</a></li>
                            <li class="on"><a href="/family/mo/contract_info">계약정보</a></li>
                        </ul>
                        
						<div class="mu_contents_lr on contract pop_re">
							<div class="mu_contents_right contr">
								<div class="mu_right_inner">
									<div class="mu_right_content n1">
										<div class="mu_right_box1">
											<h3>프로젝트 명</h3>
											<div class="mu_drop">
												<button type="button" class="wide_btn">(주)빙그레</button>
												<ul>
													<li>(주)빙그레</li>
													<li>빙그레</li>
												</ul>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>계약등급</h3>
											<div class="mu_drop">
												<button type="button">GOLD</button>
												<ul>
													<li>GOLD</li>
													<li>BRONZE</li>
												</ul>
											</div>
										</div>
										<div class="mu_right_box1">
											<h3>요청사항별 수정 횟수</h3>
											<div class="mu_drop">
												<input type="text" placeholder="10" class="gr_type">
											</div>
										</div>
									</div>
									<div class="mu_right_content n2">
										<div class="mu_right_box1 sec01">
											<h3>담당자명</h3>
											<div class="mu_drop">
												<input type="text" placeholder="김진오 팀장" class="gr_type">
											</div>
										</div>
										<div class="mu_right_box1 sec02">
											<h3>연락처</h3>
											<div class="mu_drop">
												<input type="tel" placeholder="010-1234-4567" class="gr_type">
											</div>
										</div>
										<div class="mu_right_box1 sec03">
											<h3>이메일</h3>
											<div class="mu_drop">
												<input type="email" placeholder="abcde@musign.net" class="gr_type wide_input">
											</div>
										</div>
										<div class="mu_right_box1 sec04">
											<h3>사업자등록번호</h3>
											<div class="mu_drop">
												<input type="text" placeholder="80888009508" class="gr_type wide_input">
											</div>
										</div>
									</div>
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
										<div class="mu_right_box1">
											<h3>세금계산서 발행일</h3>
											<div class="mu_calender">
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
													<button type="button" class="add_item show">+ 디자인 항목추가</button>
													<div class="background">
													  <div class="window">
													    <div class="popup">
													    	<div class="pop_cont_wrap design_pop ">
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
													<button type="button" class="add_item show">+ 퍼블리싱 항목추가</button>
													<div class="background">
													  <div class="window">
													    <div class="popup">
													    	<div class="pop_cont_wrap publ_pop">
													    		<h5>퍼블리싱 항목 추가</h5>
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
									<div class="mu_right_content n7">
										<div class="mu_right_box1 box2">
											<h3>아이디</h3>
											<div class="mu_text gr_line">
												<input type="text" placeholder="musign" class="gr_type wide_btn">
											</div>
										</div>
										<div class="mu_right_box1 box2">
											<h3>비밀번호</h3>
											<div class="mu_text_no">
												<input type="text" placeholder="**********" class="gr_type wide_btn">
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
									<div class="mu_bttom_btn">
										<input type="submit" value="저장하기" class="mu_save">
									</div>
								</div>
							</div>
						</div>
						<!-- <div class="mu_contents_lr">3</div>
						<div class="mu_contents_lr">4</div>
						<div class="mu_contents_lr">5</div> -->
						
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
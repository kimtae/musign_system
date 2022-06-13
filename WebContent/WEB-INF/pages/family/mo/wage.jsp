<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>


<!-- 관리자 - 노임단가 등록 -->

<div id="wrap">		
	<div class="mu_content wage wage_re">
		<div class="mu_inner">
			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">노임단가 등록</h3>
<!-- 					<div class="mu_mypage"> -->
<!-- 						<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 						<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 					</div> -->
						<button type="button" class="add_grade mo_btn" onclick="add_cate();">+ 등급 추가</button>
						<button type="button" class="add_grade pc_btn" onclick="add_cate();">+ 등급 추가</button>
				</div>
			</div>
			<div class="mu_bottom">
			
				<div class="mu_contentsBox n1 half_cont">
					<div class="cont_wrap left">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="PM" class="gr_type">
								</div>
							</div>
							<button type="button" class="del_item bg_blue">+ 추가</button>
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1 ">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>
				
					
					<div class="cont_wrap mid">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="기획" class="gr_type">
								</div>
							</div>
							<!-- <button type="button" class="del_item bg_blue">+ 추가</button> -->
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>

					<!-- <div class="cont_wrap right">
						<button type="button" class="add_grade">+ 등급 추가</button>
					</div> -->
				</div>
				
				
				
				
				
				<div class="mu_contentsBox n2 half_cont">
					<div class="cont_wrap left">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box" >
								<div class="mu_txt">
									<input type="text" placeholder="디자인" class="gr_type">
								</div>
							</div>
							<button type="button" class="del_item bg_blue">+ 추가</button>
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>
					
					
					<div class="cont_wrap mid">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="퍼블리싱" class="gr_type">
								</div>
							</div>
							<!-- <button type="button" class="del_item bg_blue">+ 추가</button> -->
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>

					
				</div>
				
				
				
				<div class="mu_contentsBox n3 half_cont">
					<div class="cont_wrap left">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="개발" class="gr_type">
								</div>
							</div>
							<button type="button" class="del_item bg_blue">+ 추가</button>
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>
					
					
					<div class="cont_wrap mid">
					
						<div class="cont_top_wrap half_cont">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="IT테스트" class="gr_type">
								</div>
							</div>
							<!-- <button type="button" class="del_item bg_blue">+ 추가</button> -->
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(특급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n2 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(고급)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n3 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PL)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<div class="cont_btm n4 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="PM(PA)" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="13,285,210" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>

					
					
				</div>
				
				
				
				
				
				<div class="mu_contentsBox n4">
					<div class="cont_wrap left n4_cont">
					
						<div class="cont_top_wrap half_cont write_add">
							<div class="mu_right_box1 name_box">
								<div class="mu_txt">
									<input type="text" placeholder="항목입력" class="gr_type">
								</div>
							</div>
							<button type="button" class="del_item bg_blue ">+ 추가</button>
						</div>
						
						<div class="cont_btm_wrap">
							<div class="cont_btm n1 half_cont">
								<div class="mu_right_box1 n1">
									<div class="mu_txt">
										<input type="text" placeholder="등급선택" class="gr_type">
									</div>
								</div>
								<div class="mu_right_box1 n2">
									<div class="mu_txt">
										<input type="text" placeholder="금액입력" class="gr_type">
									</div>
								</div>
								<button type="button" class="del_item con_hide">- 삭제</button>
							</div>
							<p class="small_word">*월 평균임금기준</p>
							
						</div>
					</div>
					<!-- <div class="cont_wrap mid">
					
						
					</div> -->

					
					
				</div>
				</div>
				
			
			</div><!-- end of .mu_contents-->
			<div class="mu_bttom_btn">
				<input type="submit" value="저장하기" class="mu_save">
			</div>
		</div>
	</div>
</div>









<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



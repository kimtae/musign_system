<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  유지보수 상세 페이지 - 상세 업무 현황 요청 없을 시-->
<div class="no_staus dis-no">
	<span class="no_txt">유지보수 요청항목이 없습니다.</span>
</div>

<!--  유지보수 상세 페이지 - 상세 업무 현황-->
<div class="mu_contents_lr on front_status ">
	<div class="mu_contents_left">
		<div class="content">
			<div class="mu_box1 on">
				<div class="box_inner">
					<span class="mu_num num_blue">B-211027-01 <span class="txt_orange">진행중</span></span>
					<div><b>업무담당 : 디자인</b></div>
					<div class="mu_margin"><b>완료 희망일*</b> <span class="mu_date">2021. 10. 19</span></div>
				</div>
			</div>
			<div class="mu_box1">
				<div class="box_inner">
					<span class="mu_num num_blue">B-211027-02 <span class="txt_blue">검수요청</span></span>
					<div><b>업무담당 : 디자인</b></div>
					<div class="mu_margin"><b>완료 희망일*</b> <span class="mu_date">2021. 10. 19</span></div>
				</div>
			</div>
			<div class="mu_box1">
				<div class="box_inner">
					<span class="mu_num num_gray">B-211027-03<span class="txt_gray">진행불가</span></span>
					<div><b>업무담당 : 디자인</b></div>
					<div class="mu_margin"><b>완료 희망일*</b> <span class="mu_date">2021. 10. 19</span></div>
				</div>
			</div>
<!-- 								<button type="button" class="mu_exDown"> -->
<!-- 									엑셀 다운로드 -->
<!-- 								</button> -->
		</div>
	
	</div> <!-- end of .mu_contents_left-->
	
	<!-- 상세업무현황 버튼 비활성화 클래스 non_click 추가-->
	<div class="mu_contents_right on non_click front_target_detail processing">
		<div class="mu_right_inner">
			<div class="mu_right_title">
				B-211027-01
			</div>
			<h3 class="mu_ing mu_right_down">진행중</h3>
<!-- 			<h3 class="re_quest mu_right_down">검수요청</h3> -->
<!-- 			<h3 class="not_poceed mu_right_down">진행불가</h3> -->
			<div class="mu_right_content">
				<div class="mu_right_box1">
					<h3>분류</h3>
						<div class="menu_n1">
							<input type="text" placeholder="오류" disabled>
						</div>
				</div>
				<div class="mu_right_box1">
					<h3>우선순위</h3>
						<div class="menu_n1">
							<input type="text" placeholder="Major" disabled>
						</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1">
					<h3>환경</h3>
						<div class="menu_n1">
							<input type="text" placeholder="PC" disabled>
						</div>
				</div>
				<div class="mu_right_box1">
					<h3>1차 메뉴</h3>
					<div class="menu_n1">
						<input type="text" placeholder="Major" disabled>
					</div>
				</div>
				<div class="mu_right_box1">
					<h3>2차 메뉴</h3>
					<div class="menu_n1">
						<input type="text" placeholder="Major" disabled>
					</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1">
					<h3>요청업무*</h3>
						<div class="menu_n1">
							<input type="text" placeholder="디자인" disabled>
						</div>
				</div>
				<div class="mu_right_box1">
					<h3></h3>
						<div class="menu_n1">
							<input type="text" placeholder="이미지 교체" disabled>
						</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1">
					<h3>완료 희망일*</h3>
					<div class="mu_calender">
						<input type="text" class="date-i" disabled>
					</div>
				</div>
			</div>
			<div class="mu_right_content2">
				<div class="mu_right_box1">
					<h3>요청업무 상세*</h3>
					<div class="mu_detail">
						<textarea placeholder="내용을 입력해주세요." disabled></textarea>
					</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1 box2">
					<h3>진행여부</h3>
					<div class="progress_box right-after">
						<div class="menu_n1">
							<input type="text" placeholder="진행 가능" disabled>
						</div>
						<div class="menu_n1 n2">
							<input type="text" placeholder="내용" disabled>
						</div>
					</div>
				</div>
				<div class="mu_right_box1 box2">
					<h3>차감 횟수</h3>
					<div class="mu_text">
						<input type="text" placeholder="1" disabled>
					</div>
				</div>
				<div class="mu_right_box1">
					<h3>작업 완료일</h3>
					<div class="mu_calender">
						<input type="text" placeholder="2021.10.19" class="date-i" disabled>
					</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1 box2 per">
					<h3>투입인력</h3>
					<div class="menu_n1">
						<input type="text" placeholder="기획(PL)" disabled>
					</div>
				</div>
				<div class="mu_right_box1 box2">
					<h3>M/M 입력</h3>
					<div class="mu_text m_money">
						<input type="text" placeholder="0.5" disabled>
					</div>
				</div>
				<div class="mu_right_box1">
					<h3>M/M 금액</h3>
					<div class="mu_money m_money">
						<input type="text" placeholder="₩7,200,000" disabled>
					</div>
				</div>
			</div>
			<div class="mu_right_content">
				<div class="mu_right_box1 box2 name">
					<h3>담당자</h3>
					<div class="mu_dam">
						<div class="mu_drop pro_drop">
							<div class="manager">김명주 팀장</div>
<!-- 							<ul> -->
<!-- 								<li>김명주 팀장</li> -->
<!-- 								<li>홍자영 팀장</li> -->
<!-- 								<li>김명주 팀장</li> -->
<!-- 								<li>김명주 팀장</li> -->
<!-- 								<li>김명주 팀장</li> -->
<!-- 							</ul> -->
						</div>
					</div>
				</div>
			</div>
			<div class="mu_bttom_btn front_target_btn"> 
				<a href="#" class="mu_cancle gum_ask re_">수정 요청하기(0/2)</a>
				<a href="#" class="mu_cancle gum_ask re_full">수정 요청하기(2/2)</a>
				<a href="#" class="mu_cancle gum_ask re_check">검수 완료</a>
			</div>
		</div>
	</div> <!-- end of .mu_contents_right-->
</div>


<!-- 수정 요청 팝업 -->
<div class="mu_modal modal2">
	<div class="modal-content save_as">
		<div class="modal-close">
			<img src="/img/mu_close.png">
		</div>
		<div class="modal_title">상태 저장 완료</div>
	</div>
</div>
<!-- ///수정 팝업 -->

<!-- 수정 팝업 -->
<div class="mu_modal modal3">
	<div class="modal-content save_as">
		<div class="modal-close">
			<img src="/img/mu_close.png">
		</div>
		<div class="modal_title">검수 요청 완료</div>
	</div>
</div>

<!-- 수정 요청 팝업 -->
<div class="re_modal">
	<div class="re_modal_box">
	<span class="re_modal_close"></span>
		<div class="re_modal_con">
			<h2 class="re_modal_title">수정 요청</h2>
			<button class="attachment_btn" type="button">+ 첨부파일</button>
			<div class="re_modal_text_box">
				<div class="re_modal_tit">
					요청업무 상세*
				</div>
				<div class="re_modal_text">
					<textarea name="" id="" cols="30" rows="10" placeholder="내용을 입력해주세요"></textarea>
				</div>
			</div>
			<button class="re_modal_btn" type="button">요청하기</button>
		</div>
	</div>
</div>

<!-- 수정 요청 완료 팝업 -->

<div class="mu_modal modal3 front_pop">
	<div class="modal-content save_as">
		<div class="modal-close">
			<img src="/img/mu_close.png">
		</div>
		<div class="modal_title">수정 요청 완료</div>
		<div class="modal_text">
			<span>접수가 완료 되었습니다. <br>
				담당자가 확인하여 연락을 드리도록 하겠습니다.
			</span>
		</div>
	</div>
</div>

<!-- 검수 완료 -->
<div class="mu_modal modal3 front_chk">
	<div class="modal-content save_as">
		<div class="modal-close">
			<img src="/img/mu_close.png">
		</div>
		<div class="modal_title">검수 완료</div>
		<div class="modal_text">
			<span>최종 검수가 완료되었습니다. <br>
				감사합니다.
			</span>
		</div>
	</div>
</div>



<script>
	
	$(document).ready(function(){
	
	 	var mu_box = $('.mu_box1');
		var mu_Con2 = $('.mu_contents_right');
		
		$.each(mu_box, function(index, item){
			$(this).click(function(){
				mu_box.removeClass('on');
				$(this).addClass('on');
				
				mu_Con2.removeClass('on');
				mu_Con2.eq(index).addClass('on');
			});
		}); 
		
		
		var mu_Pro_none = $('.progress_none');
		var mu_Pro_pos = $('.progress_pos');
		var mu_Pro_cont = $('.progress_none_cont input');
		
		$(mu_Pro_none).click(function(){
			mu_Pro_cont.addClass('on');
		});
		
		$(mu_Pro_pos).click(function(){
			mu_Pro_cont.removeClass('on');
		});
		
		
		var mu_Add = $('.btn_add');
		var mu_Name = $('.mu_drop10');
		
		$(mu_Add).click(function(){
			mu_Name.addClass('on');
		});
		
		
		//확인하기
		$(".modal-open1").on("click",function(e){
			e.preventDefault();
			$(".mu_modal.modal1").show();
		});
		
		$(".modal-close").on("click",function(e){
			e.preventDefault();
			$(".mu_modal.modal1").hide();
		});
		
		
		// 상태저장
		$(".modal-open2").on("click",function(e){
			e.preventDefault();
			$(".mu_modal.modal2").show();
		});
		
		$(".modal-close").on("click",function(e){
			e.preventDefault();
			$(".mu_modal.modal2").hide();
		});
		
		// 수정요청
		$(".re_").on("click",function(e){
			e.preventDefault();
			$(".re_modal").show();
		});
		$(".re_modal_close").on("click",function(e){
			e.preventDefault();
			$(".re_modal").hide();
		});
		
		$(".re_modal_btn").on("click",function(e){
			e.preventDefault();
			$(".re_modal").hide();
		});
		
		$(".re_modal_btn").on("click",function(e){
			e.preventDefault();
			$(".front_pop").show();
		});
		
		$(".modal-close").on("click",function(e){
			e.preventDefault();
			$(".front_pop").hide();
		});
		
		// 검수 완료
		$(".re_check").on("click",function(e){
			e.preventDefault();
			$(".front_chk").show();
		});
		$(".modal-close").on("click",function(e){
			e.preventDefault();
			$(".front_chk").hide();
		});
		
	

	

	});

		
	
</script>

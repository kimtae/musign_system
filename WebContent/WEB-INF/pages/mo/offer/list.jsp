<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>




<!-- 유지보수 요청 / 유지보수 등록 -->
<jsp:include page="/WEB-INF/pages/mo/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/mo/common/lnb.jsp"/>

<div class="wrap mu_content list_wrap fr_list offer_wrap fr_offer_list">
        <div class="mu_inner">
            <div class="project_list_title">
            	<img src="/img/front_list_icon.png" alt="calendar">
                <h2>유지보수 요청</h2>
            </div>
            <div class="project_list_content">
            	<div class="list_btn_wrap">
                	<div class="list_btn_l">
                		<span class="fr_list_tit">제목</span>
               			<input type="text" placeholder="10월 유지보수 요청" class="fr_list_input gr_type">
                	</div>
                	<div class="list_btn_r">
                		<button class="add_item att_file">+ 첨부파일</button>
                	</div>
                </div>
                <!-- <div class="search_box">
                    <input type="submit" id="" class="search_btn">
                    <input type="text" placeholder="검색어를 입력해주세요" class="search_box_input">
                </div> -->
                <div class="project_list_table_box project_list_detail_table_box">
                	<div class="sub_list_inner">
	                    <table class="project_list_table project_list_detail_table" >
	                        <thead>
	                            <tr>
	                                <th>
	                                    <input type="checkbox" class="check_list" id="num">
	                                    <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num">
	                                          <span>번호</span>
	                                    </label>
	                                </th>
	                                <th>
	                                    <span>접수ID</span>
	                                </th>
	                                <th>
	                                    <span>분류</span>
	                                </th>
	                                <th>
	                                    <span>우선순위</span>
	                                </th>
	                                <th>
	                                    <span>환경</span>
	                                </th>
	                                <th>
	                                    <span>요청업무</span>
	                                </th>
	                                <th>
	                                    <span>1차 메뉴</span>
	                                </th>
	                                <th>
	                                    <span>2차 메뉴</span>
	                                </th>
	                                <th>
	                                    <span>요구사항(상세)</span>
	                                </th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num1">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num1">
	                                        <span>1</span>
	                                    </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
	                                		<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button> -->
											<!-- <ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
	                                		<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num2">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num2">
	                                        <span>2</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num3">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num3">
	                                        <span>3</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.<br>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num4">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num4">
	                                        <span>4</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num5">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num5">
	                                        <span>5</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num6">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num6">
	                                        <span>6</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <input type="checkbox" class="check_list" id="num7">
	                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
	                                    <label for="num7">
	                                        <span>7</span>
	                                  </label>
	                                </td>
	                                <td>
	                                    <a href="/family/mo/target_detail">B-211027-01</a>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">수정</button>
											<ul>
												<li>수정</li>
												<li>오류</li>
												<li>추가</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">PC</button>
											<ul>
												<li>PC</li>
												<li>MO</li>
											</ul>
										</div>
	                                </td>
	                                <td class="wide_btn_wrap">
	                                	<div class="mu_drop">
											<button type="button" class="wide_btn">디자인</button>
											<ul>
												<li>디자인</li>
												<li>퍼블리싱</li>
												<li>개발</li>
											</ul>
										</div>
										<div class="mu_drop">
											<button type="button" class="wide_btn">이미지 교체</button>
											<ul>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
												<li>이미지 교체</li>
											</ul>
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td>
	                                	<div class="mu_drop">
											<span>Major</span>
											<!-- <button type="button" class="wide_btn">Major</button>
											<ul>
												<li>Major</li>
												<li>Major</li>
												<li>Major</li>
											</ul> -->
										</div>
	                                </td>
	                                <td class="state_btn_box">
	                                	<p>회원 등록이 오류사항에 대하여 확인 부탁드립니다.</p>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	            	</div>      
                </div>
                <div class="page_num">
                    <ul class="page_num_ul">
                        <li class="page_num_li">
                            <a href="">1</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">2</a>
                        </li>
                        <li class="page_num_li page_num_add_class">
                            <a href="">3</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">4</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">5</a>
                        </li>
                    </ul>
                </div>
                <div class="list_btn_box">
                	<div class="list_btn_btm">
                		<button class="add_item att_file">+ 추가하기</button>
                	</div>
                	<div class="list_btn_btm mu_bttom_btn front_target_btn">
                		<button type="button" class="mu_right_down mu_cancle gum_ask re_check">접수하기</button>
                	</div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="mu_modal modal3 front_chk" style="display: none;">
		<div class="modal-content save_as">
			<div class="modal-close">
				<img src="/img/mu_close.png">
			</div>
			<div class="modal_title">접수 완료</div>
			<div class="modal_text">
				<span>
					접수가 완료되었습니다.
					<br>
					담당자가 확인하여 연락을 드리도록 하겠습니다.
				</span>
			</div>
		</div>
	</div>






<script>
$(document).ready(function(){
	/* 드롭다운 */
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
});
	
	
	
	/* 팝업창 */
		
		$(document).ready(function(){
			var popup = $('.popup_wrap');
			var addBtn = popup.find($('.add_item'));
			var closeBtn = popup.find($('.close_btn'));
			addBtn.click(function(){
				$(".background.show").removeClass('show');
				$(this).siblings('div').toggleClass('show');
			})
			closeBtn.click(function(){
				$(this).parents('.background.show').removeClass('show');
			})
		})

		
		
	/* 상단_탭메뉴 */
		$(document).ready(function(){
		
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

		
	/* 정기, 비정기 radio */
		
		$(document).ready(function(){
			var regBtn = $('.top_radio.n1');
			var regBtn2 = $('.top_radio.n2');
			var conReg = $('.con_regular');
			regBtn2.click(function(){
				conReg.addClass('con_hide');
			});
			regBtn.click(function(){
				conReg.removeClass('con_hide');
			});
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
<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>
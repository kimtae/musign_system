<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/mo/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/mo/common/lnb.jsp"/>

<%-- <jsp:include page="/WEB-INF/pages/family/common/header.jsp"/> --%>
<jsp:include page="/WEB-INF/pages/mo/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<%-- <jsp:include page="/WEB-INF/pages/family/mo/progress_staus_2.jsp"/> --%>

<div class="mu_content front_wrap">
<div class="mypage_title f_list_title">
			<h2><span class="my_icon"></span>실시간 현황</h2>
	</div>
	<div class="mu_graph front_graph">
					<h4>유지보수 월별 정산 현황</h4>
					<div class="main_button">
						<button type="button">2021</button>
						<ul>
						    <li><a href="#">2021</a></li>
						    <li><a href="#">2020</a></li>
						</ul>
					</div>
				</div>
				<div class="mu_graph_box">					
					<div class="grap_bg">
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">10,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">5,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">1,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">500,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">0</div>
						</div>
					</div>
					<div class="grap_line">
						<div class="mu_month">					
							<div class="month_graph">
								<span>6월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>7월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>8월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>9월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>10월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>200,000</span>원</div>
								</div>
								
							</div>
							<div class="month_graph">
								<span>11월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>300,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>12월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>400,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>1월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>2월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>3월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>4월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>5월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>6월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>7월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>8월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>9월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>50,000</span>원</div>
								</div>
							</div>
						</div>					
					</div>				
					<div class="graph_txt">*2021~2022년 통계 합계입니다.</div>
				</div>
				<div class="project_list_content maintenance_list">
                <div class="search_box">
                    <input type="submit" id="" class="search_btn">
                    <input type="text" placeholder="검색어를 입력해주세요" class="search_box_input">
                </div>
                <div class="project_list_table_box project_list_detail_table_box"> 
                    <table class="project_list_table project_list_detail_table">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" class="check_list" id="num">
                                    <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
                                    <label for="num">
                                          <span>번호</span>
                                    </label>
                                    <div class="up_down_btn_box up_down_btn_pos">
                                        <button></button>
                                        <button></button>
                                    </div>
                                </th>
                                <th></th>
                                <th>
                                    <span>요청업무</span>
                                    <div class="up_down_btn_box">
                                        <button></button>
                                        <button></button>
                                    </div>
                                </th>
                                <th></th>
                                <th>
                                    <span>진척율 (%)</span>
                                    <div class="up_down_btn_box">
                                        <button></button>
                                        <button></button>
                                    </div>
                                </th>
                                <th>
                                    <span>계약일</span>
                                    <div class="up_down_btn_box">
                                        <button></button>
                                        <button></button>
                                    </div>
                                </th>
                                <th>
                                    <span>종료일</span>
                                    <div class="up_down_btn_box">
                                        <button></button>
                                        <button></button>
                                    </div>
                                </th>
                                <th>
                                    <span>상태</span>
                                    <div class="up_down_btn_box">
                                        <button></button>
                                        <button></button>
                                    </div>
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">11월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                <!-- 접수중 class accepting 입니다 -->
                                	<button type="button" class="accepting">접수중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">12월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                	<button type="button" class="accepting">접수중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">10월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                 <button type="button" class="accepting">접수중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">1월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                 <button type="button" class="accepting">접수중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">2월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                  <!-- 진행중 class proceeding 입니다 -->
                                <button type="button" class="proceeding">진행중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">3월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                  <button type="button" class="proceeding">진행중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
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
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">4월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                  <button type="button" class="proceeding">진행중</button>
<!-- 			                         <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" class="check_list" id="num8">
                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
                                    <label for="num8">
                                        <span>8</span>
                                  </label>
                                </td>
                                <td></td>
                                <td>
                                    <a href="/family/mo/target_detail">5월 유지보수</a>
                                </td>
                                <td></td>
                                <td>70%</td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td class="state_btn_box">
                                <button type="button" class="completion">완료</button>
                                 <!-- 완료 class completion 입니다 -->
<!--                                   <ul class="state_btn"> -->
<!-- 			                            <li>접수완료</li> -->
<!-- 			                            <li>요구사항 분석</li> -->
<!-- 			                            <li>요구사항 확정</li> -->
<!-- 			                            <li>작업중</li> -->
<!-- 			                            <li>검수요청</li> -->
<!-- 			                            <li>정산</li> -->
<!-- 			                            <li>완료</li> -->
<!-- 			                        </ul> -->
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
                </div>
			</div>
			
		</div>
		
		
		<script>
$(document).ready(function(){
		var dropDiv2 = $('.main_button');
		var dropBt2 = $(".main_button button");
		$.each(dropDiv2, function(idex, item){		
			var dropUl2 = $(this).find("ul");
			$(this).find('button').on("click",function(){
				dropUl2.toggle();
			});
			dropUl2.click(function(){
				$(this).hide();
			});
		});	
		
		
		var dropDiv = $('.main_button');
		$.each(dropDiv, function(index, item){
			var _this = $(this);
			$(this).find('ul li').click(function(){
				var dropTxt = $(this).text();
				_this.find('button').text(dropTxt);
			});		
		});
		
		
		var muBar = $('.mu_bar');
		var muMoney = $('.mu_bar_money');
		$.each(muBar, function(index, item){
			$(this).click(function(){
				muBar.removeClass('on');
				$(this).addClass('on');
				muMoney.removeClass('on');
				muMoney.eq(index).addClass('on');
			});
		});
		
		
		
		//정산현황
		var barM = $('.mu_bar');
		
		$.each(barM, function(index, item){
			var barM2 = $(this).find('.mu_bar_money > span').text(); 
			var barHeight = parseInt(barM2) / 10 ;
			$(this).height(barHeight + '%');
		});
		
		
		//알림창 클릭시
        $('.notice_icon_btn').click(function(){
            $('.notice_box').toggleClass('notice_tog')
        })
        
        // 알림창 닫기(이외의 부분 클릭시)
		
        $('.mu_graph, .mu_graph_box, .mu_bottom, .graph_txt').click(function(e){
		    if( !$('.notice_box').has(e.target).length == 1 ) $('.notice_box').removeClass('notice_tog')
		    
		});
		
        // 알림창 탭버튼 효과
        $('.tab_label').click(function(){
            $('.tab_label').removeClass('tab_add')
            $(this).addClass('tab_add')
        })
		

});
</script>

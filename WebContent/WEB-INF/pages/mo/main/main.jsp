<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/pages/mo/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/mo/common/lnb.jsp"/>

<!----- 프론트_메인 ----->
<div id="wrap" class="front_main">		
	<div class="mu_content calculate_margin" id="sy_wrap">
		<div class="mu_top2">
			<div class="mu_mypage">
				<img alt="calendar" src="/img/Calendar.png">
				<div class="txt_box">
					<span>계약 시작일</span>
					<p>2021.10.19</p>
				</div>
			</div>
			<div class="mu_mypage">
				<img alt="calendar" src="/img/Calendar.png">
				<div class="txt_box">
					<span>계약 종료일</span>
					<p>2021.10.19</p>
				</div>
			</div>
		</div>
		<div class="mu_inner">
			<div class="mu_top">
				<!-- <div class="mu_top2">
					<div class="mu_mypage">
						<img alt="calendar" src="/img/Calendar.png">
						<div class="txt_box">
							<span>계약 시작일</span>
							<p>2021.10.19</p>
						</div>
					</div>
					<div class="mu_mypage">
						<img alt="calendar" src="/img/Calendar.png">
						<div class="txt_box">
							<span>계약 종료일</span>
							<p>2021.10.19</p>
						</div>
					</div>
				</div> -->
				<div class="mu_graph">
					<h4>월별 정산 현황</h4>
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
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>11월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>12월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>				
							<div class="month_graph">
								<span>1월</span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>2월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>200,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>3월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>300,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>4월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>400,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>5월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>6월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>7월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>	
							</div>
							<div class="month_graph">
								<span>8월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>
							</div>
							<div class="month_graph">
								<span>9월</span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span>원</div>
								</div>
							</div>
						</div>					
					</div>				
					<div class="graph_txt">*2021~2022년 통계 합계입니다.</div>
				</div>
			</div>
			<div class="mu_btn_wrap">
				<button class="appl">유지보수 신청하기</button>
				<button class="list">리스트 바로가기</button>
			</div>
		</div> <!-- end of .mu_inner -->
	</div>
</div>
			

<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



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

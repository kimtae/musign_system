<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<!-- 유지보수 상세 페이지  정산설정 -->

		<!-- 정산설정 부분 시작 -->
		<div class="calculate_container">
	        <div class="calculate_inner tax_bill_box">
	            <h3>세금계산서</h3>
	            <div class="mu_drop">
	                <button type="button">미발행</button>
	                <ul>
	                    <li>미발행</li>
	                    <li>발행 완료</li>
	                </ul>
	            </div>
	        </div>
	        <div class="calculate_inner deposit_box">
	            <h3>입금여부</h3>
	            <div class="mu_drop">
	                <button type="button">미입금</button>
	                <ul>
	                    <li>미입금</li>
	                    <li>입금 완료</li>
	                </ul>
	            </div>
	        </div>
	        <div class="calculate_inner deposit_date_box">
	            <h3>입금 날짜</h3>
	           	<div class="mu_calender" >
					<input type="text" class="date-i calender_pas">
			   	</div>
	        </div>
	        <button type="button" class="save_state">상태 저장</button>
	    </div>

<script>
	$(document).ready(function(){
		
		var dropDiv2 = $('.mu_drop');
		
		$.each(dropDiv2, function(idex, item){		
			var dropUl2 = $(this).find($("ul"));
			var _this = $(this);
			var dropBt2 = $(this).find($("button"));
	 		var dropLi = dropUl2.find($('li'));
			
			$(this).find('button').on("click",function(){
				dropUl2.toggle();
			});
			
			dropLi.click(function(){
				var dropTxt = $(this).text();
				dropBt2.text(dropTxt);
				dropUl2.hide();
			});	
		});		
		
// 		//진행바
		
// 		var dropLis = $('.mu_drop.drop_line ul li');
// 		var muLine = $('.mu_line .circle'); 
// // 		var muCir = $('.mu_line ul li .circle'); 
	
// 		$.each(dropLis, function(index, item){
// 			$(this).click(function(){
	
// 				var idx = $(this).index();
// 				//$('body').append('<style>.mu_line ul:after {width: ' +  idx*7.5 + 22 + '%;}</style>');
// 				$('.mu_line .bg_b').css('width', (idx + 1)*12.5 + '%');
// 				muLine.removeClass('on');
// 				muLine.eq(index).addClass('on');
// 			});		
// 		});	
	});
	
	
	
	$(document).ready(function(){
		
// 		var mu_Tab = $('.mu_tabs > li');
// 		var mu_Con = $('.mu_contents_lr')
		
// 		$.each(mu_Tab, function(index, item){
// 			$(this).click(function(){
// 				mu_Tab.removeClass('on');
// 				$(this).addClass('on');
								
// 				mu_Con.removeClass('on');
// 				mu_Con.eq(index).addClass('on');
					
// 			});
// 		});


	});

		
	
</script>
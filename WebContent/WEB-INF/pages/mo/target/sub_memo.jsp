<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 유지보수 상세 페이지 - 관리자 메모 -->
<!-- 관리자 메모 작업 시작 -->
  <div class="sub_memo_container">
       <div class="sub_memo_box">
           <div class="admin_note">
               <h3>김진오 책임</h3>
               <p>관리자 메모를 남깁니다. 히스토리 참고 부탁드립니다.</p>
               <p class="note_time">2021/09/26 09:05</p>
           </div>
           <div class="admin_note">
               <h3>김진오 책임</h3>
               <p>관리자 메모를 남깁니다. 히스토리 참고 부탁드립니다.</p>
               <p class="note_time">2021/09/26 09:05</p>
           </div>
           <div class="admin_note">
               <h3>김진오 책임</h3>
               <p>관리자 메모를 남깁니다. 히스토리 참고 부탁드립니다.</p>
               <p class="note_time">2021/09/26 09:05</p>
           </div>
           <div class="admin_note">
               <h3>김진오 책임</h3>
               <p>관리자 메모를 남깁니다. 히스토리 참고 부탁드립니다.</p>
               <p class="note_time">2021/09/26 09:05</p>
           </div>
       </div>
       <form class="sub_memo_write">
           <p><textarea cols="50" rows="10"></textarea></p>
           <p><input type="submit" value="전송"></p>
       </form>
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
		
		//진행바
		
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
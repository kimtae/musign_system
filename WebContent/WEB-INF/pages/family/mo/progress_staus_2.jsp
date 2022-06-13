<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>	

$(document).ready(function(){		
	//진행바
	
	var dropLis = $('.mu_drop.drop_line ul li');
	var muLine = $('.mu_line .circle'); 

	$.each(dropLis, function(index, item){
		$(this).click(function(){

			var idx = $(this).index();
			$('.mu_line .bg_b').css('width', (idx + 1)*12.5 + '%');
			muLine.removeClass('on');
			muLine.eq(index).addClass('on');
		});		
	});
	
	
	var muTab = $('.mu_tabs li');
	var Ahref = location.pathname;
	
	$.each(muTab, function(){
		var tabHref = $(this).find('a').attr('href');
		
		if ( Ahref == tabHref ){
			 muTab.removeClass('on');
			$(this).addClass('on');
		} else {
			
		}
		
	})
	
});

</script>

<div id="wrap">		
	
<div class="mu_content calculate_margin" id="sy_wrap_2">
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
                            <li class="on"><a href="/family/mo/target_list">유지보수 리스트</a></li>
                            <li><a href="/family/mo/contract_info">계약정보</a></li>
                        </ul>
                        
                        
                        
                        
                        
                        
                        
                        
                        
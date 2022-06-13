

$(document).ready(function(){
	//드롭다운 리스트 컨텐츠 클릭 시 동작 수정 220103 강은영
	$(document).on('click', '.mu_drop ul li', function(){
		var dropWrap = $(this).closest('.mu_drop'),
			dropBt2 = dropWrap.find('button'),
			dropTxt = $(this).text(),
			dropList = $(this).parent();
		
			dropBt2.text(dropTxt);
			dropWrap.removeClass('active');
			dropList.hide();
	})
	
	
	//드롭다운
	$(document).on('click', '.mu_dropBtn', function(){
		$('.mu_drop').removeClass('active').find('ul').hide(); 
		
		var dropWrap = $(this).closest('.mu_drop'),
			dropBt2 = $(this),
			dropList = $(this).next('ul');

		if(dropWrap.hasClass('active')){
			dropWrap.removeClass('active');
			dropList.hide();		
	
		}else{
			dropWrap.addClass('active');
			dropList.show();			
		}
	})
	
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
	/*
	$(document).on('click', '.popup_wrap .add_item', function(){
		$(".background.show").removeClass('show');
		$(this).siblings('div').toggleClass('show');
	});
	*/
	$(document).on('click', '.popup_wrap .close_btn', function(){
		$(this).parents('.background.show').removeClass('show');
	});
	
	
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
	
	
	/* 정기, 비정기 radio */
	var regBtn = $('.top_radio.n1');
	var regBtn2 = $('.top_radio.n2');
	var conReg = $('.con_regular');
	regBtn2.click(function(){
		conReg.addClass('con_hide');
	});
	regBtn.click(function(){
		conReg.removeClass('con_hide');
	});
	$('#memberGrade li').click(function(){
		var _thisGrade = $(this).attr('data-val');
	});
	
	
	/* 메인 */
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
    })
    
    $('input[name="notice_tab"]').eq(0).prop('checked', true);
    $('input[name="notice_tab"]').change(function(){
    	var linkedTab = $(this);
    	$('.tab_label').each(function(){
    		if($(this).index() === linkedTab.index()){
    			$(this).addClass('tab_add');
    		}else{
    			$(this).removeClass('tab_add');
    		}
    	})
    	$('.notice_tab_content').removeClass('notice_on');
    	if($(this).is(':checked')){
    		$('.notice_tab_content_' + ($(this).index() + 1)).addClass('notice_on');
    	}
    })
    
    
    
    /* 관리자 메모 */
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
    
    
	
	
	/* 유지보수 요청서 sub_offer */
	var mu_box = $('.mu_box1');
	var mu_Con2 = $('.sy_wrap .mu_contents_right');
	
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
	
	
	var dropDiv = $('.mu_drop');
	$.each(dropDiv, function(index, item){
		var _this = $(this);
		$(this).find('ul li').click(function(){
			var dropTxt = $(this).text();
			_this.find('button').text(dropTxt);
		});		
	});
	
	
	$(".modal-open").on("click",function(e){
		e.preventDefault();
		$(".mu_modal").show();
	});
	$(".modal-close").on("click",function(e){
		e.preventDefault();
		$(".mu_modal").hide();
	});
    
    
    
    
    
    
	/* sub_work_status */
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
	
	// 검수요청
	$(".modal-open3").on("click",function(e){
		e.preventDefault();
		$(".mu_modal.modal3").show();
	});
	$(".modal-close").on("click",function(e){
		e.preventDefault();
		$(".mu_modal.modal3").hide();
	});
    	
	
	/* target_detail */
	var dropDiv2 = $('.mu_drop');
	var dropBt2 = $(".mu_drop button");
	$.each(dropDiv2, function(idex, item){		
		var dropUl2 = $(this).find("ul");
		$(this).find('button').on("click",function(){
			dropUl2.toggle();
			
//			console.log(눌림)
		});
		
		dropUl2.click(function(){
			$(this).hide();
		});
		
	});
	
	
	var dropDiv = $('.mu_drop');
	$.each(dropDiv, function(index, item){
		var _this = $(this);
		$(this).find('ul li').click(function(){
			var dropTxt = $(this).text();
			_this.find('button').text(dropTxt);
		});		
	});
	
	//진행바
	
		var dropLis = $('.mu_drop.drop_line ul li');
		var muLine = $('.mu_line .circle'); 
// 		var muCir = $('.mu_line ul li .circle'); 

		$.each(dropLis, function(index, item){
		
			$(this).click(function(){
				var idx = $(this).index();
				//$('body').append('<style>.mu_line ul:after {width: ' +  idx*7.5 + 22 + '%;}</style>');
				$('.mu_line .bg_b').css('width', (idx + 1)*12.5 + '%');
				muLine.removeClass('on');
				muLine.eq(index).addClass('on');
			});		
			
		});
		
	$('.sub_area').hide();
	$('#sub_offer_area').show();

	
	
    
	
	/* target_list */
//	var dropDiv2 = $('.mu_drop');
//	var dropDiv3 = $('.mu_drop.drop_line');
//	var mu_Tab = $('.mu_tabs > li');
//	var mu_Con = $('.mu_contents_lr')
//	
//	$.each(dropDiv2, function(idex, item){		
//		var dropUl2 = $(this).find($("ul"));
//		var _this = $(this);
//		var dropBt2 = $(this).find($("button"));
// 		var dropLi = dropUl2.find($('li'));
//		
//		$(this).find('button').on("click",function(){
//			dropUl2.toggle();
//		});
//		
//		dropLi.click(function(){
//			var dropTxt = $(this).text();
//			dropBt2.text(dropTxt);
//			dropUl2.hide();
//		});	
//	});
//
//	$.each(mu_Tab, function(index, item){
//		$(this).click(function(){
//			mu_Tab.removeClass('on');
//			$(this).addClass('on');
//							
//			mu_Con.removeClass('on');
//			mu_Con.eq(index).addClass('on');
//				
//		});
//	});

// 리스트의 상태 부분에서 접수중, 진행중, 완료 클릭시 드롭다운

	var dropbox1 = $('.state_btn_box');

	$.each(dropbox1, function(idex, item){
		var dropboxUl = $(this).find($("ul"));
		var d_this = $(this);
		var dropboxbtn = $(this).find($("button"));
 		var dropboxLi = dropboxUl.find($('li'));
		
		$(this).find('button').on("click",function(){
			dropboxUl.toggle();
		});
		
		dropboxLi.click(function(){
			dropboxUl.hide();
		});	
		
		// 드롭다운 이외의 부분 클릭시 드롭다운 닫힘
		
		$('.mu_inner').click(function(e){
		    if( !$('.state_btn_box').has(e.target).length ) $('.state_btn').hide();
		});
		
		//드롭다운 중복 클릭시 나머지 닫힘
		
	  	$('.state_btn_box button').click(function(){
	         
	  		$('.state_btn').hide();
	  		$(this).next('.state_btn').show();
	 	});
		

		
	//상세리스트 상태 부분에서 접수중, 진행중, 완료 부분 클릭시 드롭다운될 때, 드롭다운에서 상태 클릭시 문구 변경되는 부분입니다
		
		dropboxLi.click(function(){
			var dropTxt1 = $(this).text();
			dropboxbtn.text(dropTxt1);
			dropboxUl.hide();
		});	
		
	});

});

function show_area(target){
	$('.sub_area').hide();
	$('#'+target+"_area").show();
	
	$('.sub_head').removeClass('on');
	$('#'+target+'_head').addClass('on');
	
}
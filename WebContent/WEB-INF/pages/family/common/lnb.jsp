<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	var alarm_cnt = "";

	$(document).ready(function() {
		var link = location.href;
		if (link.indexOf("/family/user/") > -1) {
			dep('user');
		}
		$('.alarm_div').hide();

		if (("${login_chmod}" * 1) < 4) {
			getSignCnt();
			if (("${login_team}" * 1) <= 3) {
				getSaleCnt();
			}
		}

	});

	function dep(menu) {
		if ($(".menu_" + menu).css("display") == "none") {
			$(".depth2").slideUp();
			$(".menu_" + menu).slideDown();
		} else {
			$(".depth2").slideUp();
		}
	}

	$(window).ready(function() {
		$("#inb div a").each(function() {
			var path = location.pathname;
			var link = $(this).attr("href");
			if (path == link) {
				$(this).addClass("active");
				$(this).parents(".depth1").addClass("active");
				$(this).parents(".depth2").addClass("active");
				$(this).parents(".depth3").addClass("active");
			}
		})
	});

	$(document).ready(function() {

		var depth1 = $(".depth1");
		depth1.each(function() {
			var _this = $(this);
			_this.children("a").click(function() {
				var depth2 = _this.find(".depth2");
				if (depth2.css("display") == "none") {
					depth2.stop().slideDown();

					_this.addClass('on');

				} else {

					depth1.removeClass('on');

					depth2.stop().slideUp();
				}
			});

		});

		/* $(".depth2").click(function(){
			var depth3 = $(this).find(".depth3");
			if (depth3.css("display") == "none")
			{
				depth3.stop().slideDown();
			}else{
				depth3.stop().slideUp();
			}
		});
		 */
		var lnbLis = $('.dep3_menu');
		$.each(lnbLis, function(index, item) {
			$(this).click(function() {
				var depth3 = $(this).siblings(".depth3");
				if (depth3.css("display") == "none") {
					depth3.stop().slideDown();
				} else {
					depth3.stop().slideUp();
				}
			})
		});

		var gnb_dep1 = $('.depth1');
		$.each(gnb_dep1, function(index, item) {
			$(this).click(function() {

			});
		});

	});

	$(document).ready(function() {
		$(".slide").click(function() {
			var target = $(this).parent().children(".deps");
			$(target).slideToggle();

			if ($(this).parent().hasClass("active")) {
				$(this).parent().removeClass("active");
			} else {
				$(this).parent().addClass("active");
			}
		});

		//메뉴 고정
		$(window).scroll(function() {
			var pageTop = $(window).scrollTop();

			//console.log(pageTop);

			if (pageTop > 150) {
				$("#inb").addClass("fixed");
				console.log(1);
			} else {
				console.log("위");
				$("#inb").removeClass("fixed");
			}

		});

	});

	$(function() {
		var sTop = $(window).scrollTop();
	});

	function passAll() {

		var sign_idx = "";
		var msg = "";
		$('.sign_idx').each(function() {
			sign_idx = $(this).text().split('-');
			$.ajax({
				type : "POST",
				url : "/family/dosign/chkApprovalLine",
				dataType : "text",
				async : false,
				data : {
					idx : sign_idx[2],
					content : "일괄처리"
				},
				error : function() {
					console.log("AJAX ERROR");
				},
				success : function(data) {
					console.log(data);
					var result = JSON.parse(data);
					msg = result.msg;
					//				getList();
					//				show_comment();
					//				location.reload();
				}
			});

			if (msg != '저장 되었습니다.') {
				alert("관리자에게 문의해주세요.");
				return false;
			}

		})
		alert("저장 되었습니다.");
		getSignCnt();
		getSignList();
	}

	function getSignCnt() {
		$.ajax({
			type : "POST",
			url : "/family/getSignCnt",
			dataType : "text",
			error : function() {
				console.log("AJAX ERROR");
			},
			success : function(data) {
				console.log(data);
				var result = JSON.parse(data);
				if (result.getSignCnt == "0") {
					$('.sign_number').text('');
				} else {
					$('.sign_number').text(result.getSignCnt);
				}
			}
		});
	}

	function getSaleCnt() {
		$.ajax({
			type : "POST",
			url : "/family/getSaleCnt",
			dataType : "text",
			error : function() {
				console.log("AJAX ERROR");
			},
			success : function(data) {
				var result = JSON.parse(data);
				if (result.getSaleCnt == "0") {
					$('.sale_number').text('');
				} else {
					$('.sale_number').text(result.getSaleCnt);
				}
			}
		});
	}

	function getSignList() {
		$(".alarm_div").toggleClass("click");/*click이란클래스붙임*/
		$('.alarm_div').show();

		$.ajax({
			type : "POST",
			url : "/family/getSignList",
			dataType : "text",
			error : function() {
				console.log("AJAX ERROR");
			},
			success : function(data) {
				console.log(data);
				var result = JSON.parse(data);
				var inner = "";
				$('#sign_list_area').empty();
				if (result.getSignList.length > 0) {
					for (var i = 0; i < result.getSignList.length; i++) {
						inner += '<tr onclick="javascript:location.href=\'/family/dosign/detail?idx='
								+ result.getSignList[i].idx
								+ '&doc_type='
								+ result.getSignList[i].doc_type
								+ '\' ">';
						inner += '	<td class="sign_idx number">'
								+ result.getSignList[i].doc_type + '-'
								+ result.getSignList[i].doc_idx + '-'
								+ result.getSignList[i].idx + '</td>'
						inner += '	<td class="name">'
								+ result.getSignList[i].kor_nm
								+ '</td>'
						inner += '	<td class="team">'
								+ result.getSignList[i].team_kr
								+ '</td>'
						inner += '	<td class="level">'
								+ result.getSignList[i].level_nm
								+ '</td>'
						inner += '	<td class="content">'
								+ result.getSignList[i].doc_name
								+ '</td>'
						inner += '</tr>';
	
					}
					$('#sign_list_area').html(inner);
				}
	
			}
		});
	}

	function getSaleList() {
		$(".alarm_div").toggleClass("click");/*click이란클래스붙임*/
		$('.alarm_div').show();

		$.ajax({
			type : "POST",
			url : "/family/getSaleList",
			dataType : "text",
			error : function() {
				console.log("AJAX ERROR");
			},
			success : function(data) {
				console.log(data);
				var result = JSON.parse(data);
				var inner = "";
				$('#sign_list_area').empty();
				if (result.getSaleList.length > 0) {
					for (var i = 0; i < result.getSaleList.length; i++) {
						inner += '<tr onclick="javascript:location.href=\'/family/sales/write?idx='
								+result.getSaleList[i].idx+ '\' ">';
						inner += '	<td class="submit_date">'
								+ result.getSaleList[i].submit_date + '</td>'
						inner += '	<td class="user_company">'
								+ result.getSaleList[i].user_company + '</td>'
						inner += '	<td class="user_type">'
								+ result.getSaleList[i].user_type + '</td>'
						inner += '	<td class="user_manager">'
								+ result.getSaleList[i].user_manager + '</td>'
						inner += '</tr>';

					}
					$('#sign_list_area').html(inner);
				}

			}
		});
	}

	function close_alarm() {
		$('.alarm_div').hide();
	}
</script>

<div id="inb">

	<div class="depth1">
		<a href="/family/main" class="dep1_menu">HOME</a>
	</div>


	<div class="depth1">
		<a class="dep1_menu">인사관리</a>
		<ul class="depth2 lnb-menu" style="display: none">
			<li><a href="/family/user/group"><div>
						<p>TEAM 뮤자인</p>
					</div></a></li>
			<li><a href="/family/guntae/list"><div>
						<p>근무시간 관리</p>
					</div></a></li>
			<li><a href="/family/leave/list"><div>
						<p>연차관리</p>
					</div></a></li>

			<c:if test="${login_team < 3 || login_chmod le 3 || login_team le 2}">
				<li><a href="/family/team/list"><div>
							<p>DB 관리</p>
						</div></a></li>
			</c:if>
			<li><a href="/family/recruit/list"><div>
						<p>채용관리</p>
					</div></a></li>
			<li><a href="/family/kpi/insKpi"><div>
						<p>KPI 작성</p>
					</div></a></li>
			<li><a href="/family/kpi/list"><div>
				<p>KPI 게시판</p>
			</div></a></li>
		</ul>
	</div>


	<div class="depth1">
		<a class="dep1_menu">전자결재 <span class="sign_number"
			onclick="getSignList();"></span></a>
		<ul class="depth2 lnb-menu" style="display: none">
			<c:if test="${login_chmod ne '1'}">
				<li><a href="/family/allow/write"><div>
							<p>결재신청</p>
						</div></a></li>
			</c:if>
			<li>

				<div class="dosign_num">
					<a href="/family/dosign/list" style="width: 100%;">
						<p>결재열람</p>
					</a> <span class="sign_number" onclick="getSignList();"></span>
				</div>
			</li>
		</ul>
	</div>


	<!-- <div class="depth1">
   		<a href="/family/guntae/list" class="dep1_menu">근태관리</a>
   	</div> -->

	<%-- <c:if test="${login_team < 3 || login_chmod le 3 || login_team le 2}">
    	<div class="depth1">
    		<a href="/family/team/list" class="dep1_menu">DB 관리</a>
    	</div>
	</c:if> --%>

	<!-- <div class="depth1">
   		<a href="/family/leave/list" class="dep1_menu">연차관리</a>
   	</div> -->

	<c:if test="${isManager eq 'Y'}">
		<div class="depth1">
			<a href="/family/oper/card" class="dep1_menu">카드관리</a>
		</div>

		<div class="depth1">
			<a href="/family/board/list" class="dep1_menu">게시판</a>
		</div>

	</c:if>

	<%-- <div class="depth1 access">
    		<a href="/family/dosign/list" class="dep1_menu" >결재열람</a>
			<c:if test="${login_chmod eq '1' || login_chmod eq '2' || login_chmod eq '3'}">
				<div class="area">
					<span class="sign_number" onclick="getSignList();"></span>
				</div>
			</c:if>
    	</div>
    	<c:if test="${login_chmod ne '1'}">
	        <div class="depth1">
				<a href="/family/allow/write" class="dep1_menu">결재신청</a>
			</div>
		</c:if> --%>

	<!-- <div class="depth1">
    	<a href="/family/user/group" class="dep1_menu" >TEAM 뮤자인</a>
 	 </div> -->

	<!-- 
 	  <div class="depth1">
    	<a href="/family/musign_lib/list" class="dep1_menu" >뮤키백과</a>
 	 </div>
 	  -->


	<div class="depth1">
		<a class="dep1_menu">프로젝트 <span class="sale_number"
			onclick="getSaleList();"></span>
		</a>
		<ul class="depth2 lnb-menu" style="display: none">
			<div>
				<c:if test="${sale_auth ne 'N'}">
					<a class="dep3_menu n1 dep3_name"> 영업</a>
					<ul class="depth3 lnb-menu gnb" style="display: none">
						<li><a href="/family/sales/list"><div class="depth_pad">
									<p>· 관리차트</p>
								</div></a></li>
						<li class="first"><a href="/family/sales/write"><div
									class="depth_pad">
									<p class="enrollment">· 신규등록 / 수정</p>
								</div></a></li>
					</ul>
				</c:if>
			</div>

			<div>
				<a class="dep3_menu dep3_name"> 운영 관리</a>
				<ul class="depth3 lnb-menu" style="display: none">
					<li><a href="/family/mo/main"><div class="depth_pad">
								<p>· 대시보드</p>
							</div></a></li>
					<li><a href="/family/mo/list"><div class="depth_pad">
								<p>· 관리차트</p>
							</div></a></li>
					<li><a class="dep3_menu n1 n2"><div class="depth_pad">
								<p>· 프로젝트 등록</p>
							</div></a>

						<ul class="depth3 depth4 lnb-menu gnb" style="display: none">
							<li><a href="/family/mo/write"><div>
										<p class="depth4_wrap">- 프로젝트 작성</p>
									</div></a>
							<li><a href="/family/mo/plan"><div>
										<p class="depth4_wrap">- 플랜등록</p>
									</div></a></li>
							<li><a href="/family/mo/cate_add"><div>
										<p class="depth4_wrap">- 유지보수 항목 등록</p>
									</div></a></li>
							<li><a href="/family/mo/wage"><div>
										<p class="depth4_wrap">- 노임단가 등록</p>
									</div></a></li>
						</ul></li>
				</ul>
			</div>
		</ul>
	</div>

	<!-- <div class="depth1">
   		<a href="/family/recruit/list" class="dep1_menu">채용관리</a>
   	</div>
	<div class="depth1">
   		<a href="/family/kpi/insKpi" class="dep1_menu">KPI 관리</a>
   	</div> -->
	<div class="depth1">
		<a href="/family/room/insRoom" class="dep1_menu">회의실예약</a>
	</div>


	<%-- <c:if test="${sale_auth ne 'N'}">
	 	 <div class="depth1">
	    	<a class="dep1_menu" >영업관리</a>
	    	<ul class="depth2 lnb-menu" style="display: none">
				<li class="first"><a href="/family/sales/write"><div><p class="enrollment">신규등록 / 수정</p></div></a></li>
				<li><a href="/family/sales/list"><div><p>관리차트</p></div></a></li>
			</ul>
	 	 </div>
 	 </c:if> --%>
</div>
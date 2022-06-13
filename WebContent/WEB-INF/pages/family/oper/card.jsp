<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/inc/css/card.css" />
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<script>

var search_cont = $('#search_cont').val()

// 검색이 빈칸일때
$(document).ready(function() {
    if(search_cont != '')
    {
        $("#search_cont").val(search_cont);
    }
    getCardList();
   
    $("#insNum1").keyup(function(){ 	
    	var value = $(this).val()	
    	if (value.length == 4) {
    		$("#insNum2").focus();
    	}
    });
    
    $("#insNum2").keyup(function(){ 	
    	var value = $(this).val()	
    	if (value.length == 4) {
    		$("#insNum3").focus();
    	}
    });
    
    $("#insNum3").keyup(function(){ 	
    	var value = $(this).val()	
    	if (value.length == 4) {
    		$("#insNum4").focus();
    	}
    });    
});

// 글등록 버튼 클릭
function doWrite()
{
	$('.list-edit-wrap').fadeIn(200);
}

// 수정 취소 후 등록 버튼 클릭시 이전 내용 초기화
function closeAct() 
{
	$("#insBank").val("");
	$("#insNum1").val("");
	$("#insNum2").val("");
	$("#insNum3").val("");
	$("#insNum4").val("");
	$("#insOwner").val("");
	$("#insPre_pay_yn").val("");
	$("#submit_btn").attr("value","등록");	
}

// 닫기버튼 esc로 닫기
$(document).on('keydown', function(e) {
    if (e.keyCode == 27)
    	$('.list-edit-wrap').fadeOut(200);
});

//카드 등록 기능
function card_write_proc()
{
	var f = document.formRegex;
	
	// 빈칸 없게 예외처리
	if (isEmpty(f.insNum1))
	{
		alert("빈칸을 채워주세요.");
		f.insNum1.value = "";
		f.insNum1.focus();
		return false;
	}
	
	// 숫자만 가능하게 예외처리
	if(isNotNumber(f.insNum1))
	{
		alert("숫자를 채워주세요.");
		f.insNum1.value = "";
		f.insNum1.focus();
		return false;
	}
	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./card_write_proc",
		dataType : "text",
		data : 
		{
			insBank : $("#insBank").val(),
			insNum1 : $("#insNum1").val(),
			insNum2 : $("#insNum2").val(),
			insNum3 : $("#insNum3").val(),
			insNum4 : $("#insNum4").val(),
			insOwner : $("#insOwner").val(),
			insPre_pay_yn :	$("#insPre_pay_yn").val()
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
    		if(result.isSuc == "success")
    		{
    			alert("저장되었습니다.");
    			location.reload();
    		}
    		else
    		{
    			alert(result.msg);
    		}
    		end_loading();
		}
	});
}

//카드 목록 조회
function getCardList()
{
	var f = document.fncForm;
	start_loading();
	$.ajax({
		type : "POST", 			
		url : "./getCard",	
		dataType : "text",
		data:
		{
			search_cont : f.search_cont.value
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			console.log(result);
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += 	'<td>'+[i+1]+'</td>';
					inner += 	'<td>'+result.list[i].bank+'</td>';
					inner += 	'<td>'+result.list[i].account_num+'</a></td>';
					inner += 	'<td>'+result.list[i].owner+'</td>';
					inner += 	'<td>'+cutDate(result.list[i].submit_date)+'</td>';
					inner += 	'<td>'+result.list[i].pre_pay_yn+'</td>';
					inner += 	'<td><input type="button" value="수정" onclick="doEdit('+result.list[i].idx+')" class="btn btn_black01"></td>';
					inner += 	'<td><input type="button" value="삭제" onclick="doDelete('+result.list[i].idx+')" class="btn btn_black01"></td>'; 
					inner += 	'<input type="hidden" name="idx" value="${data.idx}" class="detail">';
					inner += '</tr>';
				}
			}
			$("#list_target").html(inner);
			end_loading();
		}
	});	
}

//수정버튼 클릭시 기능
function doEdit(idx)
{	
	$('.list-edit-wrap').fadeIn(200);
	start_loading();
	$.ajax({
		type : "POST", 			
		url : "./detail_card",	
		dataType : "text",
		data: {'idx' : idx},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			console.log(result);
				
			// 카드번호 split 으로 짤라서 배열로 만듬
			var an_arr = result.data.account_num.split("-");
	
			$("#insBank").val(result.data.bank);
			$("#insNum1").val(an_arr[0]);
			$("#insNum2").val(an_arr[1]);
			$("#insNum3").val(an_arr[2]);
			$("#insNum4").val(an_arr[3]);
			$("#insOwner").val(result.data.owner);
			$("#insPre_pay_yn").val(result.data.pre_pay_yn);
			
			// 등록버튼이었던 것을 card_edit_proc() 버튼 기능을 하도록 수정
			$("#submit_btn").attr("onclick","card_edit_proc('"+idx+"')");
			
			// 버튼이름 등록 에서 수정 으로 변경
			$("#submit_btn").attr("value","수정");
			end_loading();
		}
	});	
	
}

//카드 수정 기능 
function card_edit_proc(idx)
{
	start_loading();
	$.ajax({
			type : "POST", 
			url : "./card_edit_proc",
			dataType : "text",
			data : 
		{
			'idx' : idx,
			insBank : $("#insBank").val(),
			insNum1 : $("#insNum1").val(),
			insNum2 : $("#insNum2").val(),
			insNum3 : $("#insNum3").val(),
			insNum4 : $("#insNum4").val(),
			insOwner : $("#insOwner").val(),
			insPre_pay_yn :	$("#insPre_pay_yn").val()
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.isSuc == "success")
			{
				alert("저장되었습니다.");
				location.reload();
			}
			else
			{
				alert(result.msg);
			}
			end_loading();
		}
	});
}

// 카드 삭제
function doDelete(idx) 
{
	start_loading();
	$.ajax({
		type : "GET",
		url : "./delCard",
		dataType : "text",
		data:  {'idx' : idx},
		error : function() 
		{
			swal("통신 중 오류가 발생하였습니다.", "", "error");
		},
		success : function(data) 
		{
			alert('삭제 되었습니다.');
			location.href="/oper/card";
			
		}
	});		
}			
</script>

<div id="container" class="manager_edit">
	<div class="musign-grid">			 
        <div class="btn-wrap ali-right">
        	<form id="fncForm" name="fncForm" class="card_form" method="GET" onsubmit="return false">
	            <input type="text" name="search_cont" id="search_cont" class="card_sch" placeholder="검색어를 입력해 주세요." onkeydown="excuteEnter(getCardList)">
	            <input type="button" value="검색" onclick="getCardList()" class="btn btn_black01">
	            <td><input type="button" value="카드 등록" onclick="doWrite()"  class="btn btn_black01"></td>
	        </form>
        	
        </div>	
        <table class="board-lay card_responsive">
            <tr align="center">
           	 	<td>No</td> <td>은행</td>  <td style="width:400px;">카드번호</td> <td>사용팀</td> <td>등록날짜</td> <td>선지급여부</td>	<td></td> 	<td></td>
            </tr>
            <!-- 카드 목록 조회 -->
            <tbody id="list_target">
            </tbody>
        </table>
        <!-- 검색창 -->
        <div class="search-wrap">
	        
        </div>
	</div>
</div>

<!-- 카드 등록 버튼 클릭 시 -->
<div class="list-edit-wrap">
	<div class="le-cell2">
		<div class="le-inner">
        	<div class="list-edit">
        		<div class="le-txt">
        			<p class="t-tit">카드 등록</p>
					<table class="board-lay">
                        <tr align="center">
                         <td>은행</td>  <td>카드번호</td> <td>사용팀</td> <td>선지급여부</td>	<td></td>
                        </tr>  
                        <tr>
                             <td>
                            	 <select id="insBank" name="insBank">
                            	 <option value="bank_name">은행명</option>
	                            	 <option value="신한">신한</option>
	                             	 <option value="국민">국민</option>
                             	</select>	
                            </td>
                             <td>
	                             <form id="formRegex" name="formRegex">
	                                <input type='text' id="insNum1" name="insNum1" style="width:60px;" maxlength='4' > - 
	                                <input type='text' id="insNum2" name="insNum2" style="width:60px;" maxlength='4'> - 
	                                <input type='text' id="insNum3" name="insNum3" style="width:60px;" maxlength='4'> - 
	                                <input type='text' id="insNum4" name="insNum4" style="width:60px;" maxlength='4'>
	                             </form>
                             </td>
                             <td>
                             	<select id="insOwner" name="insOwner">
									<option value="musign">사용팀명</option>
									<c:forEach var="j" items="${teamList}" varStatus="loop">
										<option value="${j.team_kr}">${j.team_kr}</option>
									</c:forEach>
								</select>
                             </td>
                             <td>
                             	<select id="insPre_pay_yn" name="pre_pay_yn">
                             		<option value="pay_yn">지급여부</option>
                             		<option value="Y">Y</option>
                             		<option value="N">N</option>
                             	</select>
                             </td>   
	                             <td><input type="button" id="submit_btn" value="등록" onclick="card_write_proc()" class="btn btn_black01"></td>
                        </tr>
                    </table> 
            	</div>
        		<div class="close" onclick="javascript:$('.list-edit-wrap').fadeOut(200); closeAct();">X</div>
        	</div>
        </div>
    </div>	
</div>
<!-- footer  -->
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
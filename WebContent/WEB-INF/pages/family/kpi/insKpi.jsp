<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
	

$(document).ready(function(){

	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	
	var tmp = 1;
	if(month >= 1 && month <= 3){tmp = 1;}
	else if(month >= 4 && month <= 6){tmp = 2;}
	else if(month >= 7 && month <= 9){tmp = 3;}
	else if(month >= 10 && month <= 12){tmp = 4;}
	
	$("#year").val(year);
	$("#period").val(tmp);

	getKpi();
	
	$("th").mouseover(function() {
		$(this).children(".info").css("display", "block");
	});
	$("th").mouseout(function() {
		$(this).children(".info").css("display", "none");
	});
})

function init()
{
	$("input[type=file]").removeAttr("disabled");
	$("input[type=text]").removeAttr("disabled");
	$("select").removeAttr("disabled");
	$("textarea").removeAttr("disabled");
	
	
	var inner = '';
	inner += '<input type="button" value="저장" onclick="fncSubmit()" class="btn btn_black01" id="saveBtn">';
	inner += '<input type="button" value="" onclick="" class="btn btn_black01" id="kpiBtn">';
	inner += '<div><span id="작성중">작성중</span> > ';
	inner += '<span id="제출">제출</span> > ';
	inner += '<span id="팀장승인">팀장승인</span> > ';
	inner += '<span id="본부장승인">본부장승인</span></div>';
	
	
	$("#kpiBtn_div").html(inner);
	
	for(var i = det_cnt1; i > 1; i--)
	{
		delDetail(1, i);
	}
	for(var i = det_cnt2; i > 1; i--)
	{
		delDetail(2, i);
	}
	for(var i = det_cnt3; i > 1; i--)
	{
		delDetail(3, i);
	}
	for(var i = det_cnt4; i > 1; i--)
	{
		delDetail(4, i);
	}
	for(var i = det_cnt5; i > 1; i--)
	{
		delDetail(5, i);
	}
	
	cnt_arr1 = new Array();
	cnt_arr2 = new Array();
	cnt_arr3 = new Array();
	cnt_arr4 = new Array();
	cnt_arr5 = new Array();
	cnt_arr1.push(1);
	cnt_arr2.push(1);
	cnt_arr3.push(1);
	cnt_arr4.push(1);
	cnt_arr5.push(1);
	det_cnt1 = 2;
	det_cnt2 = 2;
	det_cnt3 = 2;
	det_cnt4 = 2;
	det_cnt5 = 2;
	
	$("#target_t").val('');
	$("#detail_t").val('');
	
	$("#target1_t").val('');
	$("#target2_t").val('');
	$("#target3_t").val('');
	$("#target4_t").val('');
	$("#target5_t").val('');
	
	$("#detail1_1").val('');
	$("#detail2_1").val('');
	$("#detail3_1").val('');
	$("#detail4_1").val('');
	$("#detail5_1").val('');
	$("#detail_date1_1").val('');
	$("#detail_date2_1").val('');
	$("#detail_date3_1").val('');
	$("#detail_date4_1").val('');
	$("#detail_date5_1").val('');
	$("#detail_step1_1").val('미진행');
	$("#detail_step2_1").val('미진행');
	$("#detail_step3_1").val('미진행');
	$("#detail_step4_1").val('미진행');
	$("#detail_step5_1").val('미진행');
	
	$(".add_span").remove();
}

function getKpi()
{
	//초기화
	init();
	//초기화
	
	var period = $("#period").val();
	$(".period").html(period);
	var year = $("#year").val();
	$(".year").html(year+" ");
	$.ajax({
		type : "POST", 
		url : "./getKpi",
		dataType : "text",
		async : false,
		data : 
		{
			user_idx : '${user_idx}',
			year : year
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			if(data != "")
			{
				var result = JSON.parse(data);
				
				$("#target_t").val(repWord(result.target));
				$("#detail_t").val(repWord(result.detail));
				
				var tmp_file = '<img src="/img/download_icon_128877.png">';
				if(nullChk(result.output_file) == "") {tmp_file = '&nbsp;';}
				var inner = '<span class="add_span">';
				inner += '<input type="hidden" id="output_file_ori" name="output_file_ori" value="'+result.output_file+'"/>';
				inner += '<a target="_blank" href="/upload/kpi/'+result.output_file+'" download>'+tmp_file+'</a>';
				inner += '</span>';
				$("#output_file").parent().append(inner);
			}
			else
			{
				
			}
		}
	});	
	$.ajax({
		type : "POST", 
		url : "./getOkr",
		dataType : "text",
		async : false,
		data : 
		{
			user_idx : '${user_idx}',
			year : year,
			period : period
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			if(data != "")
			{
				var result = JSON.parse(data);
				
				$("#target1_t").val(repWord(result.target1));
				$("#target2_t").val(repWord(result.target2));
				$("#target3_t").val(repWord(result.target3));
				$("#target4_t").val(repWord(result.target4));
				$("#target5_t").val(repWord(result.target5));
				var detail1_arr = nullChk(result.detail1).split("|");
				for(var i = 0; i < detail1_arr.length-1; i++)
				{
					if(i != 0){addDetail(1);}
					$("#detail1_"+(i+1)).val(repWord(detail1_arr[i]));
				}
				var detail2_arr = nullChk(result.detail2).split("|");
				for(var i = 0; i < detail2_arr.length-1; i++)
				{
					if(i != 0){addDetail(2);}
					$("#detail2_"+(i+1)).val(repWord(detail2_arr[i]));
				}
				var detail3_arr = nullChk(result.detail3).split("|");
				for(var i = 0; i < detail3_arr.length-1; i++)
				{
					if(i != 0){addDetail(3);}
					$("#detail3_"+(i+1)).val(repWord(detail3_arr[i]));
				}
				var detail4_arr = nullChk(result.detail4).split("|");
				for(var i = 0; i < detail4_arr.length-1; i++)
				{
					if(i != 0){addDetail(4);}
					$("#detail4_"+(i+1)).val(repWord(detail4_arr[i]));
				}
				var detail5_arr = nullChk(result.detail5).split("|");
				for(var i = 0; i < detail5_arr.length-1; i++)
				{
					if(i != 0){addDetail(5);}
					$("#detail5_"+(i+1)).val(repWord(detail5_arr[i]));
				}
				
				var detail_date1_arr = nullChk(result.detail_date1).split("|");
				for(var i = 0; i < detail_date1_arr.length-1; i++)
				{
					$("#detail_date1_"+(i+1)).val(repWord(detail_date1_arr[i]));
				}
				var detail_date2_arr = nullChk(result.detail_date2).split("|");
				for(var i = 0; i < detail_date2_arr.length-1; i++)
				{
					$("#detail_date2_"+(i+1)).val(repWord(detail_date2_arr[i]));
				}
				var detail_date3_arr = nullChk(result.detail_date3).split("|");
				for(var i = 0; i < detail_date3_arr.length-1; i++)
				{
					$("#detail_date3_"+(i+1)).val(repWord(detail_date3_arr[i]));
				}
				var detail_date4_arr = nullChk(result.detail_date4).split("|");
				for(var i = 0; i < detail_date4_arr.length-1; i++)
				{
					$("#detail_date4_"+(i+1)).val(repWord(detail_date4_arr[i]));
				}
				var detail_date5_arr = nullChk(result.detail_date5).split("|");
				for(var i = 0; i < detail_date5_arr.length-1; i++)
				{
					$("#detail_date5_"+(i+1)).val(repWord(detail_date5_arr[i]));
				}
				
				var detail_step1_arr = nullChk(result.detail_step1).split("|");
				for(var i = 0; i < detail_step1_arr.length-1; i++)
				{
					$("#detail_step1_"+(i+1)).val(repWord(detail_step1_arr[i]));
				}
				var detail_step2_arr = nullChk(result.detail_step2).split("|");
				for(var i = 0; i < detail_step2_arr.length-1; i++)
				{
					$("#detail_step2_"+(i+1)).val(repWord(detail_step2_arr[i]));
				}
				var detail_step3_arr = nullChk(result.detail_step3).split("|");
				for(var i = 0; i < detail_step3_arr.length-1; i++)
				{
					$("#detail_step3_"+(i+1)).val(repWord(detail_step3_arr[i]));
				}
				var detail_step4_arr = nullChk(result.detail_step4).split("|");
				for(var i = 0; i < detail_step4_arr.length-1; i++)
				{
					$("#detail_step4_"+(i+1)).val(repWord(detail_step4_arr[i]));
				}
				var detail_step5_arr = nullChk(result.detail_step5).split("|");
				for(var i = 0; i < detail_step5_arr.length-1; i++)
				{
					$("#detail_step5_"+(i+1)).val(repWord(detail_step5_arr[i]));
				}
				
				var output_file1_arr = nullChk(result.output_file1).split("|");
				for(var i = 0; i < output_file1_arr.length-1; i++)
				{
					var tmp_file = '<img src="/img/download_icon_128877.png">';
					if(nullChk(output_file1_arr[i]) == "") {tmp_file = '&nbsp;';}
					var inner = '<span class="add_span">';
					inner += '<input type="hidden" id="output_file_ori1_'+(i+1)+'" name="output_file_ori1_'+(i+1)+'" value="'+output_file1_arr[i]+'"/>';
					inner += '<a target="_blank" href="/upload/kpi/'+output_file1_arr[i]+'" download>'+tmp_file+'</a>';
					inner += '</span>';
					$("#output_file1_"+(i+1)).parent().append(inner);
				}
				var output_file2_arr = nullChk(result.output_file2).split("|");
				for(var i = 0; i < output_file2_arr.length-1; i++)
				{
					var tmp_file = '<img src="/img/download_icon_128877.png">';
					if(nullChk(output_file2_arr[i]) == "") {tmp_file = '&nbsp;';}
					var inner = '<span class="add_span">';
					inner += '<input type="hidden" id="output_file_ori2_'+(i+1)+'" name="output_file_ori2_'+(i+1)+'" value="'+output_file2_arr[i]+'"/>';
					inner += '<a target="_blank" href="/upload/kpi/'+output_file2_arr[i]+'" download>'+tmp_file+'</a>';
					inner += '</span>';
					$("#output_file2_"+(i+1)).parent().append(inner);
				}
				var output_file3_arr = nullChk(result.output_file3).split("|");
				for(var i = 0; i < output_file3_arr.length-1; i++)
				{
					var tmp_file = '<img src="/img/download_icon_128877.png">';
					if(nullChk(output_file3_arr[i]) == "") {tmp_file = '&nbsp;';}
					var inner = '<span class="add_span">';
					inner += '<input type="hidden" id="output_file_ori3_'+(i+1)+'" name="output_file_ori3_'+(i+1)+'" value="'+output_file3_arr[i]+'"/>';
					inner += '<a target="_blank" href="/upload/kpi/'+output_file3_arr[i]+'" download>'+tmp_file+'</a>';
					inner += '</span>';
					$("#output_file3_"+(i+1)).parent().append(inner);
				}
				var output_file4_arr = nullChk(result.output_file4).split("|");
				for(var i = 0; i < output_file4_arr.length-1; i++)
				{
					var tmp_file = '<img src="/img/download_icon_128877.png">';
					if(nullChk(output_file4_arr[i]) == "") {tmp_file = '&nbsp;';}
					var inner = '<span class="add_span">';
					inner += '<input type="hidden" id="output_file_ori4_'+(i+1)+'" name="output_file_ori4_'+(i+1)+'" value="'+output_file4_arr[i]+'"/>';
					inner += '<a target="_blank" href="/upload/kpi/'+output_file4_arr[i]+'" download>'+tmp_file+'</a>';
					inner += '</span>';
					$("#output_file4_"+(i+1)).parent().append(inner);
				}
				var output_file5_arr = nullChk(result.output_file5).split("|");
				for(var i = 0; i < output_file5_arr.length-1; i++)
				{
					var tmp_file = '<img src="/img/download_icon_128877.png">';
					if(nullChk(output_file5_arr[i]) == "") {tmp_file = '&nbsp;';}
					var inner = '<span class="add_span">';
					inner += '<input type="hidden" id="output_file_ori5_'+(i+1)+'" name="output_file_ori5_'+(i+1)+'" value="'+output_file5_arr[i]+'"/>';
					inner += '<a target="_blank" href="/upload/kpi/'+output_file5_arr[i]+'" download>'+tmp_file+'</a>';
					inner += '</span>';
					$("#output_file5_"+(i+1)).parent().append(inner);
				}
				
				
				var is_end1_arr = nullChk(result.is_end1).split("|");
				for(var i = 0; i < is_end1_arr.length-1; i++)
				{
					if(is_end1_arr[i] == "Y")
					{
						$("#detail_date1_"+(i+1)).attr("disabled", "disabled");
						$("#detail_step1_"+(i+1)).attr("disabled", "disabled");
						$("#output_file1_"+(i+1)).attr("disabled", "disabled");
					}
				}
				var is_end2_arr = nullChk(result.is_end2).split("|");
				for(var i = 0; i < is_end2_arr.length-1; i++)
				{
					if(is_end2_arr[i] == "Y")
					{
						$("#detail_date2_"+(i+1)).attr("disabled", "disabled");
						$("#detail_step2_"+(i+1)).attr("disabled", "disabled");
						$("#output_file2_"+(i+1)).attr("disabled", "disabled");
					}
				}
				var is_end3_arr = nullChk(result.is_end3).split("|");
				for(var i = 0; i < is_end3_arr.length-1; i++)
				{
					if(is_end3_arr[i] == "Y")
					{
						$("#detail_date3_"+(i+1)).attr("disabled", "disabled");
						$("#detail_step3_"+(i+1)).attr("disabled", "disabled");
						$("#output_file3_"+(i+1)).attr("disabled", "disabled");
					}
				}
				var is_end4_arr = nullChk(result.is_end4).split("|");
				for(var i = 0; i < is_end4_arr.length-1; i++)
				{
					if(is_end4_arr[i] == "Y")
					{
						$("#detail_date4_"+(i+1)).attr("disabled", "disabled");
						$("#detail_step4_"+(i+1)).attr("disabled", "disabled");
						$("#output_file4_"+(i+1)).attr("disabled", "disabled");
					}
				}
				var is_end5_arr = nullChk(result.is_end5).split("|");
				for(var i = 0; i < is_end5_arr.length-1; i++)
				{
					if(is_end5_arr[i] == "Y")
					{
						$("#detail_date5_"+(i+1)).attr("disabled", "disabled");
						$("#detail_step5_"+(i+1)).attr("disabled", "disabled");
						$("#output_file5_"+(i+1)).attr("disabled", "disabled");
					}
				}
			}
			else
			{
				
			}
			
			$(".play_status").css("color", "black");
			//STEP 제어
			if(nullChk(result) != '')
			{
				var step = nullChk(result.step);
				if(step == "")
				{
					if('${login_chmod}' == '3') //팀장인경우 바로 팀장승인
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('팀장승인')");
						$("#kpiBtn").attr("value", "제출하기");
					}
					else
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('제출')");
						$("#kpiBtn").attr("value", "제출하기");
					}
					saveEnable();
				}
				else if(step == "제출")
				{
					$("#kpiBtn").attr("onclick", "okrSubmit('')");
					$("#kpiBtn").attr("value", "제출취소");
					saveDisable();
				}
				else if(step == "팀장승인" && '${login_chmod}' == '3') //팀장이 자기자신꺼
				{
					$("#kpiBtn").attr("onclick", "okrSubmit('')");
					$("#kpiBtn").attr("value", "제출취소");
					saveDisable();
				}
				else
				{
					$("#kpiBtn").remove();
					saveDisable();
				}
				var tmp = step;
				if(tmp == "")
				{
					tmp = "작성중";
				}
				$("#"+tmp).css("color", "red");
// 				$("#kpiBtn_div").append("<div>현재상태 : "+tmp+"</div>");
			}
			else
			{
				$("#kpiBtn").remove();
				$("#작성중").css("color", "red");
				saveEnable();
// 				$("#kpiBtn_div").append("<div>현재상태 : 작성중</div>");
			}
			//STEP 제어

			
			
		}
	});	
}
function saveDisable()
{
	$("#target_t").attr("disabled", "disabled");
	$("#detail_t").attr("disabled", "disabled");
	$("textarea[name=target1_t]").attr("disabled", "disabled");
	$("textarea[name=target2_t]").attr("disabled", "disabled");
	$("textarea[name=target3_t]").attr("disabled", "disabled");
	$("textarea[name=target4_t]").attr("disabled", "disabled");
	$("textarea[name=target5_t]").attr("disabled", "disabled");
	$("textarea[name=detail1]").attr("disabled", "disabled");
	$("textarea[name=detail2]").attr("disabled", "disabled");
	$("textarea[name=detail3]").attr("disabled", "disabled");
	$("textarea[name=detail4]").attr("disabled", "disabled");
	$("textarea[name=detail5]").attr("disabled", "disabled");
	$(".add_btn1 > div").hide();
	$(".add_btn2 > div").hide();
	$(".add_btn3 > div").hide();
	$(".add_btn4 > div").hide();
	$(".add_btn5 > div").hide();
}
function saveEnable()
{
	$(".add_btn1 > div").show();
	$(".add_btn2 > div").show();
	$(".add_btn3 > div").show();
	$(".add_btn4 > div").show();
	$(".add_btn5 > div").show();
	// var tmp = '<div><a onclick="addDetail(1)">추가</a></div>';
	// $(".add_btn1").html(tmp);
	// var tmp = '<div><a onclick="addDetail(2)">추가</a></div>';
	// $(".add_btn2").html(tmp);
	// var tmp = '<div><a onclick="addDetail(3)">추가</a></div>';
	// $(".add_btn3").html(tmp);
	// var tmp = '<div><a onclick="addDetail(4)">추가</a></div>';
	// $(".add_btn4").html(tmp);
	// var tmp = '<div><a onclick="addDetail(5)">추가</a></div>';
	// $(".add_btn5").html(tmp);
}
function okrSubmit(step)
{
	$.ajax({
		type : "POST", 
		url : "./okrSubmit",
		dataType : "text",
		async : false,
		data : 
		{
			user_idx : '${user_idx}',
			year : $("#year").val(),
			period : $("#period").val(),
			step : step
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
    			location.reload();
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});	
}



var cnt_arr1 = new Array();
var cnt_arr2 = new Array();
var cnt_arr3 = new Array();
var cnt_arr4 = new Array();
var cnt_arr5 = new Array();
cnt_arr1.push(1);
cnt_arr2.push(1);
cnt_arr3.push(1);
cnt_arr4.push(1);
cnt_arr5.push(1);
var det_cnt1 = 2;
var det_cnt2 = 2;
var det_cnt3 = 2;
var det_cnt4 = 2;
var det_cnt5 = 2;
function addDetail(val)
{
	var det_cnt = 0;
	if(val == 1)
	{
		det_cnt = det_cnt1;
	}
	if(val == 2)
	{
		det_cnt = det_cnt2;
	}
	if(val == 3)
	{
		det_cnt = det_cnt3;
	}
	if(val == 4)
	{
		det_cnt = det_cnt4;
	}
	if(val == 5)
	{
		det_cnt = det_cnt5;
	}
	var innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><textarea id="detail'+val+'_'+det_cnt+'" name="detail'+val+'"></textarea></div>';
	$(".detail"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><input type="text" id="detail_date'+val+'_'+det_cnt+'" name="detail_date'+val+'" class="date-i"/></div>';
	$(".detail_date"+val).append(innerHTML);
	
	innerHTML = '';
	innerHTML += '<div class="add_div'+val+'_'+det_cnt+'"><select id="detail_step'+val+'_'+det_cnt+'" name="detail_step'+val+'">';
	innerHTML += '	<option value="미진행">미진행</option>';
	innerHTML += '	<option value="진행중">진행중</option>';
	innerHTML += '	<option value="진행완료">진행완료</option>';
	innerHTML += '</select></div>';
	$(".detail_step"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><input type="file" id="output_file'+val+'_'+det_cnt+'"  name="output_file'+val+'_'+det_cnt+'"/></div>';
	$(".output_file"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><a onclick="delDetail('+val+', '+det_cnt+')">삭제</a></div>';
	$(".add_btn"+val).append(innerHTML);
	
	dateInit();
	if(val == 1)
	{
		cnt_arr1.push(det_cnt);
		det_cnt1 ++;
	}
	if(val == 2)
	{
		cnt_arr2.push(det_cnt);
		det_cnt2 ++;
	}
	if(val == 3)
	{
		cnt_arr3.push(det_cnt);
		det_cnt3 ++;
	}
	if(val == 4)
	{
		cnt_arr4.push(det_cnt);
		det_cnt4 ++;
	}
	if(val == 5)
	{
		cnt_arr5.push(det_cnt);
		det_cnt5 ++;
	}
}
function delDetail(val, det_cnt)
{
	$(".add_div"+val+"_"+det_cnt).remove();
	if(val == 1)
	{
		for(var i = 0; i < cnt_arr1.length; i++)
		{
			if(cnt_arr1[i] == det_cnt)
			{
				cnt_arr1.splice(i,1);
			}
		}
	}
	if(val == 2)
	{
		for(var i = 0; i < cnt_arr2.length; i++)
		{
			if(cnt_arr2[i] == det_cnt)
			{
				cnt_arr2.splice(i,1);
			}
		}
	}
	if(val == 3)
	{
		for(var i = 0; i < cnt_arr3.length; i++)
		{
			if(cnt_arr3[i] == det_cnt)
			{
				cnt_arr3.splice(i,1);
			}
		}
	}
	if(val == 4)
	{
		for(var i = 0; i < cnt_arr4.length; i++)
		{
			if(cnt_arr4[i] == det_cnt)
			{
				cnt_arr4.splice(i,1);
			}
		}
	}
	if(val == 5)
	{
		for(var i = 0; i < cnt_arr5.length; i++)
		{
			if(cnt_arr5[i] == det_cnt)
			{
				cnt_arr5.splice(i,1);
			}
		}
	}
}

function fncSubmit(){


	//마감시간
	var isEnd = false;
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 

	var dateString = year + month  + day + hours + minutes + seconds;

	var year = $("#year").val();
	var period = $("#period").val();

	//나중에 분기 추가되면 이부분을 늘리면된다.
	if(year == '2022' && period == '1')
	{
		var end_date = "20220330160000";
		if(dateString >= end_date)
		{
			isEnd = true;
		}
	}
	//나중에 분기 추가되면 이부분을 늘리면된다.

	if(isEnd)
	{
		alert(year+"년 "+period+"분기는 마감되었습니다.");
		return;	
	}
	//마감시간
	
	
	start_loading();
	
	
	var tmp = $("#target_t").val()
	$("#target").val(tmp);
	var tmp = $("#detail_t").val()
	$("#detail").val(tmp);
	var tmp = $("#target1_t").val()
	$("#target1").val(tmp);
	var tmp = $("#target2_t").val()
	$("#target2").val(tmp);
	var tmp = $("#target3_t").val()
	$("#target3").val(tmp);
	var tmp = $("#target4_t").val()
	$("#target4").val(tmp);
	var tmp = $("#target5_t").val()
	$("#target5").val(tmp);
	var cnt_list1 = "";
	for(var i = 0; i < cnt_arr1.length; i++)
	{
		cnt_list1 += cnt_arr1[i]+"|";
	}
	$("#cnt_list1").val(cnt_list1);
	
	var cnt_list2 = "";
	for(var i = 0; i < cnt_arr2.length; i++)
	{
		cnt_list2 += cnt_arr2[i]+"|";
	}
	$("#cnt_list2").val(cnt_list2);
	
	var cnt_list3 = "";
	for(var i = 0; i < cnt_arr3.length; i++)
	{
		cnt_list3 += cnt_arr3[i]+"|";
	}
	$("#cnt_list3").val(cnt_list3);
	
	var cnt_list4 = "";
	for(var i = 0; i < cnt_arr4.length; i++)
	{
		cnt_list4 += cnt_arr4[i]+"|";
	}
	$("#cnt_list4").val(cnt_list4);
	
	var cnt_list5 = "";
	for(var i = 0; i < cnt_arr5.length; i++)
	{
		cnt_list5 += cnt_arr5[i]+"|";
	}
	$("#cnt_list5").val(cnt_list5);
	
	var detail_list1 = "";
	$("[name='detail1']").each(function() 
	{
		detail_list1 += $(this).val()+"|";
	});
	$("#detail_list1").val(detail_list1);
	
	var detail_list2 = "";
	$("[name='detail2']").each(function() 
	{
		detail_list2 += $(this).val()+"|";
	});
	$("#detail_list2").val(detail_list2);
	
	var detail_list3 = "";
	$("[name='detail3']").each(function() 
	{
		detail_list3 += $(this).val()+"|";
	});
	$("#detail_list3").val(detail_list3);
	
	var detail_list4 = "";
	$("[name='detail4']").each(function() 
	{
		detail_list4 += $(this).val()+"|";
	});
	$("#detail_list4").val(detail_list4);
	
	var detail_list5 = "";
	$("[name='detail5']").each(function() 
	{
		detail_list5 += $(this).val()+"|";
	});
	$("#detail_list5").val(detail_list5);
	
	var detail_date_list1 = "";
	$("[name='detail_date1']").each(function() 
	{
		detail_date_list1 += $(this).val()+"|";
	});
	$("#detail_date_list1").val(detail_date_list1);
	
	var detail_date_list2 = "";
	$("[name='detail_date2']").each(function() 
	{
		detail_date_list2 += $(this).val()+"|";
	});
	$("#detail_date_list2").val(detail_date_list2);
	
	var detail_date_list3 = "";
	$("[name='detail_date3']").each(function() 
	{
		detail_date_list3 += $(this).val()+"|";
	});
	$("#detail_date_list3").val(detail_date_list3);
	
	var detail_date_list4 = "";
	$("[name='detail_date4']").each(function() 
	{
		detail_date_list4 += $(this).val()+"|";
	});
	$("#detail_date_list4").val(detail_date_list4);
	
	var detail_date_list5 = "";
	$("[name='detail_date5']").each(function() 
	{
		detail_date_list5 += $(this).val()+"|";
	});
	$("#detail_date_list5").val(detail_date_list5);
	
	var detail_step_list1 = "";
	$("[name='detail_step1']").each(function() 
	{
		detail_step_list1 += $(this).val()+"|";
	});
	$("#detail_step_list1").val(detail_step_list1);
	
	var detail_step_list2 = "";
	$("[name='detail_step2']").each(function() 
	{
		detail_step_list2 += $(this).val()+"|";
	});
	$("#detail_step_list2").val(detail_step_list2);
	
	var detail_step_list3 = "";
	$("[name='detail_step3']").each(function() 
	{
		detail_step_list3 += $(this).val()+"|";
	});
	$("#detail_step_list3").val(detail_step_list3);
	
	var detail_step_list4 = "";
	$("[name='detail_step4']").each(function() 
	{
		detail_step_list4 += $(this).val()+"|";
	});
	$("#detail_step_list4").val(detail_step_list4);
	
	var detail_step_list5 = "";
	$("[name='detail_step5']").each(function() 
	{
		detail_step_list5 += $(this).val()+"|";
	});
	$("#detail_step_list5").val(detail_step_list5);
	
	
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
    		if(data.isSuc == "success")
    		{
    			alert("저장되었습니다.");
    			location.reload();
    		}
    		else
    		{
    			alert(data.msg);
    		}
		}
	});
}

</script>
<div id="container" class="user_edit kpi-page kpi-edit">
	<div class="musign-grid">
		
    	<form id="fncForm" name="fncForm" method="POST" action="insKpi_proc" enctype="multipart/form-data">
    		<input type="hidden" id="target" name="target" value=""/>
    		<input type="hidden" id="detail" name="detail" value=""/>
    		<input type="hidden" id="target1" name="target1" value=""/>
    		<input type="hidden" id="target2" name="target2" value=""/>
    		<input type="hidden" id="target3" name="target3" value=""/>
    		<input type="hidden" id="target4" name="target4" value=""/>
    		<input type="hidden" id="target5" name="target5" value=""/>
    		<input type="hidden" id="cnt_list1" name="cnt_list1" value=""/>
    		<input type="hidden" id="cnt_list2" name="cnt_list2" value=""/>
    		<input type="hidden" id="cnt_list3" name="cnt_list3" value=""/>
    		<input type="hidden" id="cnt_list4" name="cnt_list4" value=""/>
    		<input type="hidden" id="cnt_list5" name="cnt_list5" value=""/>
    		<input type="hidden" id="detail_list1" name="detail_list1" value=""/>
    		<input type="hidden" id="detail_list2" name="detail_list2" value=""/>
    		<input type="hidden" id="detail_list3" name="detail_list3" value=""/>
    		<input type="hidden" id="detail_list4" name="detail_list4" value=""/>
    		<input type="hidden" id="detail_list5" name="detail_list5" value=""/>
    		<input type="hidden" id="detail_date_list1" name="detail_date_list1" value=""/>
    		<input type="hidden" id="detail_date_list2" name="detail_date_list2" value=""/>
    		<input type="hidden" id="detail_date_list3" name="detail_date_list3" value=""/>
    		<input type="hidden" id="detail_date_list4" name="detail_date_list4" value=""/>
    		<input type="hidden" id="detail_date_list5" name="detail_date_list5" value=""/>
    		<input type="hidden" id="detail_step_list1" name="detail_step_list1" value=""/>
    		<input type="hidden" id="detail_step_list2" name="detail_step_list2" value=""/>
    		<input type="hidden" id="detail_step_list3" name="detail_step_list3" value=""/>
    		<input type="hidden" id="detail_step_list4" name="detail_step_list4" value=""/>
    		<input type="hidden" id="detail_step_list5" name="detail_step_list5" value=""/>
    		
    		
    		<div class="btn_wrap ali-right" id="kpiBtn_div">
    			<input type="button" value="저장" onclick="fncSubmit()" class="btn btn_black01" id="saveBtn">
    			<input type="button" value="" onclick="" class="btn btn_black01" id="kpiBtn">
    			<div>
	    			<span id="작성중" class="play_status">작성중</span> > 
	    			<span id="제출" class="play_status">제출</span> > 
	    			<span id="팀장승인" class="play_status">팀장승인</span> > 
	    			<span id="본부장승인" class="play_status">본부장승인</span>
    			</div>
    		</div>
    		<div>
    			<select id="year" name="year" onchange="getKpi()">
    				<option value="2022">2022</option>
    				<option value="2021">2021</option>
    			</select>
    			<select id="period" name="period" onchange="getKpi()">
    				<option value="1">1분기</option>
    				<option value="2">2분기</option>
    				<option value="3">3분기</option>
    				<option value="4">4분기</option>
    			</select>
    			
    		</div>
        	<table class="board-lay">
        		<colgroup>
					<col width="10%"/>
					<col width=""/>
					<col width=""/>
					<col width="10%"/>
				</colgroup>
				<tr>
					<th>구분</th>
					<th>목표<div class="info">1년 치 기준으로 작성<br>예시) 기획/PM 업무</div></th>
					<th>목표달성 상세계획<div class="info">수치화가 가능한 범위로 상세 계획 작성<br>예시) 메인 프로젝트 1건, 제안 프로젝트 참여 2건 등</div></th>
					<th>산출물</th>
				</tr>
				<tr>
					<th><span class="year"></span>KPI</th>
					<td>
						<textarea id="target_t" name="target_t" style="height:100px;"></textarea>
					</td>
					<td>
						<textarea id="detail_t" name="detail_t" style="height:100px;"></textarea>
					</td>
					<td>
						<input type="file" id="output_file" name="output_file"/>
					</td>
				</tr>
			</table>
			<table class="board-lay periodClass">
				<colgroup>
					<col width="7%"/>
					<col width=""/>
					<col width=""/>
					<col width="8%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="60px"/>
				</colgroup>
				<tr>
					<th>분기 구분</th>
					<th>목표 설정<div class="info">분기마다 목표 설정 방식(본인설정)<br>회사 업무 관련 및 본인 성장이 가능해야함<br>- 본인이 수행 가능한 범위로 목표 설정<br>- 타팀과의 협업으로 진행 가능<br>- 개수 제한 없음</div></th>
					<th>To do list<div class="info">월 단위로 To Do List 기입<br>- 목표 설정에 따른 세분화된 목표를 설정하고 완료 가능한 일자로 날짜를 기입</div></th>
					<th>날짜</th>
					<th>상세 활동 내역<div class="info">완료 날짜에 맞춰 진행 상태 값 변경<br>- 각 분기가 완료되는 시점에는 진행 상태 값이 [진행완료]가 되어있어야 함<br>- 진행 완료와 동시에 산출물 등록 필수<br>- 산출물 형식은 pdf or 여러 개의 파일일 경우에는 zip 파일로 등록<br><br>상세 활동 내역은 월별 관리자가 짧은 면담을 통해 진행 내역 확인을 할 예정,<br>본인 판단하에 완료가 되었음에도 관리자 판단하에 미흡하다면 미완료 처리</div></th>
					<th>산출물 등록</th>
					<th></th>
				</tr>
				<tr>
					<th rowspan="5"><div class="year"></div><div>OKR</div><span class="period"></span>분기</th>
					<td><textarea id="target1_t" name="target1_t"></textarea></td>
					<td class="detail1">
						<div><textarea id="detail1_1" name="detail1"></textarea></div>
					</td>
					<td class="detail_date1">
						<div><input type="text" id="detail_date1_1" name="detail_date1" class="date-i"/></div>
					</td>
					<td class="detail_step1">
						<div><select id="detail_step1_1" name="detail_step1">
							<option value="미진행">미진행</option>
							<option value="진행중">진행중</option>
							<option value="진행완료">진행완료</option>
						</select></div>
					</td>
					<td class="output_file1">
						<div><input type="file" id="output_file1_1"  name="output_file1_1"/></div>
					</td>
					<td class="add_btn1">
						<div><a onclick="addDetail(1)">추가</a></div>
					</td>
				</tr>
				<tr>
					<td><textarea id="target2_t" name="target2_t"></textarea></td>
					<td class="detail2">
						<div><textarea id="detail2_1" name="detail2"></textarea></div>
					</td>
					<td class="detail_date2">
						<div><input type="text" id="detail_date2_1" name="detail_date2" class="date-i"/></div>
					</td>
					<td class="detail_step2">
						<div><select id="detail_step2_1" name="detail_step2">
							<option value="미진행">미진행</option>
							<option value="진행중">진행중</option>
							<option value="진행완료">진행완료</option>
						</select></div>
					</td>
					<td class="output_file2">
						<div><input type="file" id="output_file2_1"  name="output_file2_1"/></div>
					</td>
					<td class="add_btn2">
						<div><a onclick="addDetail(2)">추가</a></div>
					</td>
				</tr>
				<tr>
					<td><textarea id="target3_t" name="target3_t"></textarea></td>
					<td class="detail3">
						<div><textarea id="detail3_1" name="detail3"></textarea></div>
					</td>
					<td class="detail_date3">
						<div><input type="text" id="detail_date3_1" name="detail_date3" class="date-i"/></div>
					</td>
					<td class="detail_step3">
						<div><select id="detail_step3_1" name="detail_step3">
							<option value="미진행">미진행</option>
							<option value="진행중">진행중</option>
							<option value="진행완료">진행완료</option>
						</select></div>
					</td>
					<td class="output_file3">
						<div><input type="file" id="output_file3_1"  name="output_file3_1"/></div>
					</td>
					<td class="add_btn3">
						<div><a onclick="addDetail(3)">추가</a></div>
					</td>
				</tr>
				<tr>
					<td><textarea id="target4_t" name="target4_t"></textarea></td>
					<td class="detail4">
						<div><textarea id="detail4_1" name="detail4"></textarea></div>
					</td>
					<td class="detail_date4">
						<div><input type="text" id="detail_date4_1" name="detail_date4" class="date-i"/></div>
					</td>
					<td class="detail_step4">
						<div><select id="detail_step4_1" name="detail_step4">
							<option value="미진행">미진행</option>
							<option value="진행중">진행중</option>
							<option value="진행완료">진행완료</option>
						</select></div>
					</td>
					<td class="output_file4">
						<div><input type="file" id="output_file4_1"  name="output_file4_1"/></div>
					</td>
					<td class="add_btn4">
						<div><a onclick="addDetail(4)">추가</a></div>
					</td>
				</tr>
				<tr>
					<td><textarea id="target5_t" name="target5_t"></textarea></td>
					<td class="detail5">
						<div><textarea id="detail5_1" name="detail5"></textarea></div>
					</td>
					<td class="detail_date5">
						<div><input type="text" id="detail_date5_1" name="detail_date5" class="date-i"/></div>
					</td>
					<td class="detail_step5">
						<div><select id="detail_step5_1" name="detail_step5">
							<option value="미진행">미진행</option>
							<option value="진행중">진행중</option>
							<option value="진행완료">진행완료</option>
						</select></div>
					</td>
					<td class="output_file5">
						<div><input type="file" id="output_file5_1"  name="output_file5_1"/></div>
					</td>
					<td class="add_btn5">
						<div><a onclick="addDetail(5)">추가</a></div>
					</td>
				</tr>
			</table>
    	</form>
    </div>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
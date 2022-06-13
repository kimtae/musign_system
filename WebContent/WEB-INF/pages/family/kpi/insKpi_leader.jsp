<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<style>
td > div {
	text-align:center;
}
.musign-grid {
	max-width:none !important;
}
th {
	position:relative;
}
</style>
<script>
	

$(document).ready(function(){
	$("#team_idx").val('${user_idx}');

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
	getUser();
	
	$("th").mouseover(function() {
		$(this).children(".info").css("display", "block");
	});
	$("th").mouseout(function() {
		$(this).children(".info").css("display", "none");
	});
})
function otherTeamView()
{
	var tmp = $("#team_idx").val();
	
	location.href="/family/kpi/insKpi_leader?idx="+tmp;
}
function getUser()
{
	$.ajax({
		type : "POST", 
		url : "./getUser",
		dataType : "text",
		async : false,
		data : 
		{
			user_idx : $("#team_idx").val()
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
				
				$("#user_name").html(nullChk(result.name));
				$("#user_level").html(nullChk(result.level_nm));
				$("#user_date").html(nullChk(result.regi_date));
				
				var user_long = Number(result.user_long);
				var year = 0;
				var month = 0;
				var day = 0;
				
				if(user_long >= 365)
				{
					while(true)
					{
						year ++;
						user_long = user_long - 365
						if(user_long < 365)
						{
							break;
						}
					}
				}
				if(user_long >= 30)
				{
					while(true)
					{
						month ++;
						user_long = user_long - 30
						if(user_long < 30)
						{
							break;
						}
					}
				}
				day = user_long;
				
				var tmp = "";
				if(year > 0)
				{
					tmp += year+"년 ";
				}
				if(month > 0)
				{
					tmp += month+"개월 ";
				}
				tmp += day+"일";
				
				$("#user_long").html(tmp);
				
			}
			else
			{
				
			}
		}
	});	
}
function getKpi()
{
	//초기화
	$("#target").html('');
	$("#detail").html('');
	$("#interv_date").val('');
	$("#interv_comment").val('');
				
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
	
	$("#target1").html('');
	$("#target2").html('');
	$("#target3").html('');
	$("#target4").html('');
	$("#target5").html('');
	
	$("#detail1_1").html('');
	$("#detail2_1").html('');
	$("#detail3_1").html('');
	$("#detail4_1").html('');
	$("#detail5_1").html('');
	$("#detail_date1_1").html('');
	$("#detail_date2_1").html('');
	$("#detail_date3_1").html('');
	$("#detail_date4_1").html('');
	$("#detail_date5_1").html('');
	$("#detail_step1_1").html('미진행');
	$("#detail_step2_1").html('미진행');
	$("#detail_step3_1").html('미진행');
	$("#detail_step4_1").html('미진행');
	$("#detail_step5_1").html('미진행');
	
	$("#is_end1_1").prop("checked", false);  
	$("#is_end2_1").prop("checked", false);  
	$("#is_end3_1").prop("checked", false);  
	$("#is_end4_1").prop("checked", false);  
	$("#is_end5_1").prop("checked", false);  
	
	$("#comment_date1_1").val('');
	$("#comment_date2_1").val('');
	$("#comment_date3_1").val('');
	$("#comment_date4_1").val('');
	$("#comment_date5_1").val('');
	
	$("#comment1_1").val('');
	$("#comment2_1").val('');
	$("#comment3_1").val('');
	$("#comment4_1").val('');
	$("#comment5_1").val('');
	
	$("#succ_avg1").html('');
	$("#succ_avg2").html('');
	$("#succ_avg3").html('');
	$("#succ_avg4").html('');
	$("#succ_avg5").html('');

	$(".add_span").remove();
	//초기화
	
	
	var back = $("#table_back").html();
	$("#table_ori").html(back);
	console.log($("#table_back").html());
	console.log($("#table_ori").html());
	
	
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
			user_idx : $("#team_idx").val(),
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
				
				$("#target").html(repWordNoLine(result.target));
				$("#detail").html(repWordNoLine(result.detail));
				
				var tmp_file = '<img src="/img/download_icon_128877.png">';
				if(nullChk(result.output_file) == "") {tmp_file = '&nbsp;';}
				var inner = '<span class="add_span">';
				inner += '<input type="hidden" id="output_file_ori1" name="output_file_ori1" value="'+result.output_file+'"/>';
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
			user_idx : $("#team_idx").val(),
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
				
				$("#interv_date").val(repWord(result.interv_date));
				$("#interv_comment").val(repWord(result.interv_comment));
				
				$("#target1").html(repWordNoLine(result.target1));
				$("#target2").html(repWordNoLine(result.target2));
				$("#target3").html(repWordNoLine(result.target3));
				$("#target4").html(repWordNoLine(result.target4));
				$("#target5").html(repWordNoLine(result.target5));
				var detail1_arr = nullChk(result.detail1).split("|");
				for(var i = 0; i < detail1_arr.length-1; i++)
				{
					if(i != 0){addDetail(1);}
					$("#detail1_"+(i+1)).html(repWordNoLine(detail1_arr[i]));
					if($("#detail1_"+(i+1)).html() == ''){$("#detail1_"+(i+1)).html('&nbsp;');}
				}
				var detail2_arr = nullChk(result.detail2).split("|");
				for(var i = 0; i < detail2_arr.length-1; i++)
				{
					if(i != 0){addDetail(2);}
					$("#detail2_"+(i+1)).html(repWordNoLine(detail2_arr[i]));
					if($("#detail2_"+(i+1)).html() == ''){$("#detail2_"+(i+1)).html('&nbsp;');}
				}
				var detail3_arr = nullChk(result.detail3).split("|");
				for(var i = 0; i < detail3_arr.length-1; i++)
				{
					if(i != 0){addDetail(3);}
					$("#detail3_"+(i+1)).html(repWordNoLine(detail3_arr[i]));
					if($("#detail3_"+(i+1)).html() == ''){$("#detail3_"+(i+1)).html('&nbsp;');}
				}
				var detail4_arr = nullChk(result.detail4).split("|");
				for(var i = 0; i < detail4_arr.length-1; i++)
				{
					if(i != 0){addDetail(4);}
					$("#detail4_"+(i+1)).html(repWordNoLine(detail4_arr[i]));
					if($("#detail4_"+(i+1)).html() == ''){$("#detail4_"+(i+1)).html('&nbsp;');}
				}
				var detail5_arr = nullChk(result.detail5).split("|");
				for(var i = 0; i < detail5_arr.length-1; i++)
				{
					if(i != 0){addDetail(5);}
					$("#detail5_"+(i+1)).html(repWordNoLine(detail5_arr[i]));
					if($("#detail5_"+(i+1)).html() == ''){$("#detail5_"+(i+1)).html('&nbsp;');}
				}
				
				var detail_date1_arr = nullChk(result.detail_date1).split("|");
				for(var i = 0; i < detail_date1_arr.length-1; i++)
				{
					$("#detail_date1_"+(i+1)).html(repWord(detail_date1_arr[i]));
					if($("#detail_date1_"+(i+1)).html() == ''){$("#detail_date1_"+(i+1)).html('&nbsp;');}
				}
				var detail_date2_arr = nullChk(result.detail_date2).split("|");
				for(var i = 0; i < detail_date2_arr.length-1; i++)
				{
					$("#detail_date2_"+(i+1)).html(repWord(detail_date2_arr[i]));
					if($("#detail_date2_"+(i+1)).html() == ''){$("#detail_date2_"+(i+1)).html('&nbsp;');}
				}
				var detail_date3_arr = nullChk(result.detail_date3).split("|");
				for(var i = 0; i < detail_date3_arr.length-1; i++)
				{
					$("#detail_date3_"+(i+1)).html(repWord(detail_date3_arr[i]));
					if($("#detail_date3_"+(i+1)).html() == ''){$("#detail_date3_"+(i+1)).html('&nbsp;');}
				}
				var detail_date4_arr = nullChk(result.detail_date4).split("|");
				for(var i = 0; i < detail_date4_arr.length-1; i++)
				{
					$("#detail_date4_"+(i+1)).html(repWord(detail_date4_arr[i]));
					if($("#detail_date4_"+(i+1)).html() == ''){$("#detail_date4_"+(i+1)).html('&nbsp;');}
				}
				var detail_date5_arr = nullChk(result.detail_date5).split("|");
				for(var i = 0; i < detail_date5_arr.length-1; i++)
				{
					$("#detail_date5_"+(i+1)).html(repWord(detail_date5_arr[i]));
					if($("#detail_date5_"+(i+1)).html() == ''){$("#detail_date5_"+(i+1)).html('&nbsp;');}
				}
				
				var detail_step1_arr = nullChk(result.detail_step1).split("|");
				for(var i = 0; i < detail_step1_arr.length-1; i++)
				{
					$("#detail_step1_"+(i+1)).html(repWord(detail_step1_arr[i]));
				}
				
				var detail_step2_arr = nullChk(result.detail_step2).split("|");
				for(var i = 0; i < detail_step2_arr.length-1; i++)
				{
					$("#detail_step2_"+(i+1)).html(repWord(detail_step2_arr[i]));
				}
				
				var detail_step3_arr = nullChk(result.detail_step3).split("|");
				for(var i = 0; i < detail_step3_arr.length-1; i++)
				{
					$("#detail_step3_"+(i+1)).html(repWord(detail_step3_arr[i]));
				}
				
				var detail_step4_arr = nullChk(result.detail_step4).split("|");
				for(var i = 0; i < detail_step4_arr.length-1; i++)
				{
					$("#detail_step4_"+(i+1)).html(repWord(detail_step4_arr[i]));
				}
				
				var detail_step5_arr = nullChk(result.detail_step5).split("|");
				for(var i = 0; i < detail_step5_arr.length-1; i++)
				{
					$("#detail_step5_"+(i+1)).html(repWord(detail_step5_arr[i]));
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
				var is_end_avg1_cnt = 0;
				for(var i = 0; i < is_end1_arr.length-1; i++)
				{
					if(is_end1_arr[i] == "Y")
					{
						is_end_avg1_cnt ++;
						$("#is_end1_"+(i+1)).prop("checked", true);
					}
				}
				var is_end_avg1 = is_end_avg1_cnt / (is_end1_arr.length-1) * 100
				is_end_avg1 = is_end_avg1.toFixed(2);
				if(is_end1_arr.length-1 > 0) { $(".succ_avg1").html(is_end_avg1+"%"); } else { $(".succ_avg1").html("0%"); }
				var is_end2_arr = nullChk(result.is_end2).split("|");
				var is_end_avg2_cnt = 0;
				for(var i = 0; i < is_end2_arr.length-1; i++)
				{
					if(is_end2_arr[i] == "Y")
					{
						is_end_avg2_cnt ++;
						$("#is_end2_"+(i+1)).prop("checked", true);
					}
				}
				var is_end_avg2 = is_end_avg2_cnt / (is_end2_arr.length-1) * 100
				is_end_avg2 = is_end_avg2.toFixed(2);
				if(is_end2_arr.length-1 > 0) { $(".succ_avg2").html(is_end_avg2+"%"); } else { $(".succ_avg2").html("0%"); }
				var is_end3_arr = nullChk(result.is_end3).split("|");
				var is_end_avg3_cnt = 0;
				for(var i = 0; i < is_end3_arr.length-1; i++)
				{
					if(is_end3_arr[i] == "Y")
					{
						is_end_avg3_cnt ++;
						$("#is_end3_"+(i+1)).prop("checked", true);
					}
				}
				var is_end_avg3 = is_end_avg3_cnt / (is_end3_arr.length-1) * 100
				is_end_avg3 = is_end_avg3.toFixed(2);
				if(is_end3_arr.length-1 > 0) { $(".succ_avg3").html(is_end_avg3+"%"); } else { $(".succ_avg3").html("0%"); }
				var is_end4_arr = nullChk(result.is_end4).split("|");
				var is_end_avg4_cnt = 0;
				for(var i = 0; i < is_end4_arr.length-1; i++)
				{
					if(is_end4_arr[i] == "Y")
					{
						is_end_avg4_cnt ++;
						$("#is_end4_"+(i+1)).prop("checked", true);
					}
				}
				var is_end_avg4 = is_end_avg4_cnt / (is_end4_arr.length-1) * 100
				is_end_avg4 = is_end_avg4.toFixed(2);
				if(is_end4_arr.length-1 > 0) { $(".succ_avg4").html(is_end_avg4+"%"); } else { $(".succ_avg4").html("0%"); }
				var is_end5_arr = nullChk(result.is_end5).split("|");
				var is_end_avg5_cnt = 0;
				for(var i = 0; i < is_end5_arr.length-1; i++)
				{
					if(is_end5_arr[i] == "Y")
					{
						is_end_avg5_cnt ++;
						$("#is_end5_"+(i+1)).prop("checked", true);
					}
				}
				var is_end_avg5 = is_end_avg5_cnt / (is_end5_arr.length-1) * 100
				is_end_avg5 = is_end_avg5.toFixed(2);
				if(is_end5_arr.length-1 > 0) { $(".succ_avg5").html(is_end_avg5+"%"); } else { $(".succ_avg5").html("0%"); }
				
				
				var comment_date1_arr = nullChk(result.comment_date1).split("|");
				for(var i = 0; i < comment_date1_arr.length-1; i++)
				{
					$("#comment_date1_"+(i+1)).val(repWord(comment_date1_arr[i]));
				}
				var comment_date2_arr = nullChk(result.comment_date2).split("|");
				for(var i = 0; i < comment_date2_arr.length-1; i++)
				{
					$("#comment_date2_"+(i+1)).val(repWord(comment_date2_arr[i]));
				}
				var comment_date3_arr = nullChk(result.comment_date3).split("|");
				for(var i = 0; i < comment_date3_arr.length-1; i++)
				{
					$("#comment_date3_"+(i+1)).val(repWord(comment_date3_arr[i]));
				}
				var comment_date4_arr = nullChk(result.comment_date4).split("|");
				for(var i = 0; i < comment_date4_arr.length-1; i++)
				{
					$("#comment_date4_"+(i+1)).val(repWord(comment_date4_arr[i]));
				}
				var comment_date5_arr = nullChk(result.comment_date5).split("|");
				for(var i = 0; i < comment_date5_arr.length-1; i++)
				{
					$("#comment_date5_"+(i+1)).val(repWord(comment_date5_arr[i]));
				}
				
				var comment1_arr = nullChk(result.comment1).split("|");
				for(var i = 0; i < comment1_arr.length-1; i++)
				{
					$("#comment1_"+(i+1)).val(repWord(comment1_arr[i]));
				}
				var comment2_arr = nullChk(result.comment2).split("|");
				for(var i = 0; i < comment2_arr.length-1; i++)
				{
					$("#comment2_"+(i+1)).val(repWord(comment2_arr[i]));
				}
				var comment3_arr = nullChk(result.comment3).split("|");
				for(var i = 0; i < comment3_arr.length-1; i++)
				{
					$("#comment3_"+(i+1)).val(repWord(comment3_arr[i]));
				}
				var comment4_arr = nullChk(result.comment4).split("|");
				for(var i = 0; i < comment4_arr.length-1; i++)
				{
					$("#comment4_"+(i+1)).val(repWord(comment4_arr[i]));
				}
				var comment5_arr = nullChk(result.comment5).split("|");
				for(var i = 0; i < comment5_arr.length-1; i++)
				{
					$("#comment5_"+(i+1)).val(repWord(comment5_arr[i]));
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
				if('${login_chmod}' == '3') //팀장
				{
					if(step == "제출")
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('팀장승인')");
						$("#kpiBtn").attr("value", "승인하기");
						$("#kpiBtn").show();
					}
					else if(step == "팀장승인")
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('제출')");
						$("#kpiBtn").attr("value", "승인취소");
						$("#kpiBtn").show();
					}
					else
					{
						$("#kpiBtn").hide();
					}
					var tmp = nullChk(step);
					if(tmp == "")
					{
						tmp = "작성중";
					}
					$("#"+tmp).css("color", "red");
				}
				else if('${login_chmod}' == '2') //본부장님
				{
					if(step == "팀장승인")
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('본부장승인')");
						$("#kpiBtn").attr("value", "승인하기");
						$("#kpiBtn").show();
					}
					else if(step == "본부장승인")
					{
						$("#kpiBtn").attr("onclick", "okrSubmit('팀장승인')");
						$("#kpiBtn").attr("value", "승인취소");
						$("#kpiBtn").show();
					}
					else
					{
						$("#kpiBtn").hide();
					}
					var tmp = nullChk(step);
					if(tmp == "")
					{
						tmp = "작성중";
					}
					$("#"+tmp).css("color", "red");
				}
			}
			else
			{
				$("#kpiBtn").hide();
				$("#작성중").css("color", "red");
			}
			//STEP 제어
		}
	});	
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
			user_idx : $("#team_idx").val(),
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
	var innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><div id="detail'+val+'_'+det_cnt+'"></div></div>';
	$(".detail"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><div id="detail_date'+val+'_'+det_cnt+'"></div></div>';
	$(".detail_date"+val).append(innerHTML);
	
	innerHTML = '';
	innerHTML += '<div class="add_div'+val+'_'+det_cnt+'"><div id="detail_step'+val+'_'+det_cnt+'"></div></div>';
	$(".detail_step"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><div id="output_file'+val+'_'+det_cnt+'"></div></div>';
	$(".output_file"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><input type="checkbox" id="is_end'+val+'_'+det_cnt+'" name="is_end'+val+'"/></div>';
	$(".is_end"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><input type="text" id="comment_date'+val+'_'+det_cnt+'" name="comment_date'+val+'" class="date-i"/></div>';
	$(".comment_date"+val).append(innerHTML);
	
	innerHTML = '<div class="add_div'+val+'_'+det_cnt+'"><textarea id="comment'+val+'_'+det_cnt+'" name="comment'+val+'"></textarea></div>';
	$(".comment"+val).append(innerHTML);
	
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
	
	start_loading();
	
	var is_end_list1 = "";
	$("[name='is_end1']").each(function() 
	{
		var tmp = "N";
		if($(this).is(":checked")) {tmp = "Y";}
		is_end_list1 += tmp+"|";
	});
	$("#is_end_list1").val(is_end_list1);
	var is_end_list2 = "";
	$("[name='is_end2']").each(function() 
	{
		var tmp = "N";
		if($(this).is(":checked")) {tmp = "Y";}
		is_end_list2 += tmp+"|";
	});
	$("#is_end_list2").val(is_end_list2);
	var is_end_list3 = "";
	$("[name='is_end3']").each(function() 
	{
		var tmp = "N";
		if($(this).is(":checked")) {tmp = "Y";}
		is_end_list3 += tmp+"|";
	});
	$("#is_end_list3").val(is_end_list3);
	var is_end_list4 = "";
	$("[name='is_end4']").each(function() 
	{
		var tmp = "N";
		if($(this).is(":checked")) {tmp = "Y";}
		is_end_list4 += tmp+"|";
	});
	$("#is_end_list4").val(is_end_list4);
	var is_end_list5 = "";
	$("[name='is_end5']").each(function() 
	{
		var tmp = "N";
		if($(this).is(":checked")) {tmp = "Y";}
		is_end_list5 += tmp+"|";
	});
	$("#is_end_list5").val(is_end_list5);
	
	
	var comment_date_list1 = "";
	$("[name='comment_date1']").each(function() 
	{
		comment_date_list1 += $(this).val()+"|";
	});
	$("#comment_date_list1").val(comment_date_list1);
	var comment_date_list2 = "";
	$("[name='comment_date2']").each(function() 
	{
		comment_date_list2 += $(this).val()+"|";
	});
	$("#comment_date_list2").val(comment_date_list2);
	var comment_date_list3 = "";
	$("[name='comment_date3']").each(function() 
	{
		comment_date_list3 += $(this).val()+"|";
	});
	$("#comment_date_list3").val(comment_date_list3);
	var comment_date_list4 = "";
	$("[name='comment_date4']").each(function() 
	{
		comment_date_list4 += $(this).val()+"|";
	});
	$("#comment_date_list4").val(comment_date_list4);
	var comment_date_list5 = "";
	$("[name='comment_date5']").each(function() 
	{
		comment_date_list5 += $(this).val()+"|";
	});
	$("#comment_date_list5").val(comment_date_list5);
	
	var comment_list1 = "";
	$("[name='comment1']").each(function() 
	{
		comment_list1 += $(this).val()+"|";
	});
	$("#comment_list1").val(comment_list1);
	var comment_list2 = "";
	$("[name='comment2']").each(function() 
	{
		comment_list2 += $(this).val()+"|";
	});
	$("#comment_list2").val(comment_list2);
	var comment_list3 = "";
	$("[name='comment3']").each(function() 
	{
		comment_list3 += $(this).val()+"|";
	});
	$("#comment_list3").val(comment_list3);
	var comment_list4 = "";
	$("[name='comment4']").each(function() 
	{
		comment_list4 += $(this).val()+"|";
	});
	$("#comment_list4").val(comment_list4);
	var comment_list5 = "";
	$("[name='comment5']").each(function() 
	{
		comment_list5 += $(this).val()+"|";
	});
	$("#comment_list5").val(comment_list5);
	
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
<div id="container" class="user_edit kpi-page kpi-view">
	<div class="musign-grid">
		
    	<form id="fncForm" name="fncForm" method="POST" action="insKpi_leader_proc">
    		
    		<input type="hidden" id="comment_date_list1" name="comment_date_list1" value=""/>
    		<input type="hidden" id="comment_date_list2" name="comment_date_list2" value=""/>
    		<input type="hidden" id="comment_date_list3" name="comment_date_list3" value=""/>
    		<input type="hidden" id="comment_date_list4" name="comment_date_list4" value=""/>
    		<input type="hidden" id="comment_date_list5" name="comment_date_list5" value=""/>
    		<input type="hidden" id="comment_list1" name="comment_list1" value=""/>
    		<input type="hidden" id="comment_list2" name="comment_list2" value=""/>
    		<input type="hidden" id="comment_list3" name="comment_list3" value=""/>
    		<input type="hidden" id="comment_list4" name="comment_list4" value=""/>
    		<input type="hidden" id="comment_list5" name="comment_list5" value=""/>
    		<input type="hidden" id="is_end_list1" name="is_end_list1" value=""/>
    		<input type="hidden" id="is_end_list2" name="is_end_list2" value=""/>
    		<input type="hidden" id="is_end_list3" name="is_end_list3" value=""/>
    		<input type="hidden" id="is_end_list4" name="is_end_list4" value=""/>
    		<input type="hidden" id="is_end_list5" name="is_end_list5" value=""/>
    		
    		
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
    			<select id="team_idx" name="team_idx" onchange="otherTeamView()">
		   			<c:if test="${login_chmod <= 3 || login_team < 3}">
   						<c:forEach var="i" items="${team_list}" varStatus="loop">
							<option value="${i.idx}">${i.NAME}</option>
	   						</c:forEach>
		   			</c:if>
    			</select>
    			
    		</div>
    		<table class="board-lay board-level">
    			<tr>
    				<th>이름</th>
    				<th>직급</th>
    				<th>입사일</th>
    				<th>근속년수</th>
    			</tr>
    			<tr>
    				<td id="user_name"></td>
    				<td id="user_level"></td>
    				<td id="user_date"></td>
    				<td id="user_long"></td>
    			</tr>
    		</table>
        	<table class="board-lay">
				<colgroup>
					<col width="10%"/>
					<col width=""/>
					<col width=""/>
					<col width="10%"/>
				</colgroup>
				<tr>
					<th>구분</th>
					<th>목표</th>
					<th>목표달성 상세계획</th>
					<th>산출물</th>
				</tr>
				<tr>
					<th><span class="year"></span>KPI</th>
					<td>
						<div id="target"></div>
					</td>
					<td>
						<div id="detail"></div>
					</td>
					<td>
						<div id="output_file"></div>
					</td>
				</tr>
			</table>
			<table class="board-lay periodClass">
				<colgroup>
					<col width="5%"/>
					<col width=""/>
					<col width=""/>
					<col width="8%"/>
					<col width="5%"/>
					<col width="80px"/>
					<col width="5%"/>
					<col width="5%"/>
					<col width="10%"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>분기 구분</th>
					<th>목표 설정</th>
					<th>To do list</th>
					<th>날짜</th>
					<th>진행상황</th>
					<th>산출물</th>
					<th>완료여부<div class="info">상세 목표 설정/산출물이 미흡하지 않게 완료 되었는지 판단하에 Check</div></th>
					<th>달성률<div class="info">자동계산</div></th>
					<th>코멘트날짜</th>
					<th>코멘트<div class="info">진행 상황에 대하여 기입 필요</div></th>
				</tr>
				<tr>
					<th rowspan="5"><div class="year"></div><div>OKR</div><span class="period"></span>분기</th>
					<td class="object"><div id="target1"></div></td>
					<td class="detail1 object_de">
						<div><div id="detail1_1"></div></div>
					</td>
					<td class="detail_date1">
						<div><div id="detail_date1_1"></div></div>
					</td>
					<td class="detail_step1">
						<div><div id="detail_step1_1"></div></div>
					</td>
					<td class="output_file1">
						<div><div id="output_file1_1"></div></div>
					</td>
					<td class="is_end1">
						<div><input type="checkbox" id="is_end1_1"  name="is_end1" value="Y"/></div>
					</td>
					<td class="succ_avg1">
						
					</td>
					<td class="comment_date1">
						<div><input type="text" id="comment_date1_1" name="comment_date1" class="date-i"/></div>
					</td>
					<td class="comment1">
						<div><textarea id="comment1_1" name="comment1"></textarea></div>
					</td>
				</tr>
				<tr>
					<td class="object"><div id="target2"></div></td>
					<td class="detail2 object_de">
						<div><div id="detail2_1"></div></div>
					</td>
					<td class="detail_date2">
						<div><div id="detail_date2_1"></div></div>
					</td>
					<td class="detail_step2">
						<div><div id="detail_step2_1"></div></div>
					</td>
					<td class="output_file2">
						<div><div id="output_file2_1"></div></div>
					</td>
					<td class="is_end2">
						<div><input type="checkbox" id="is_end2_1"  name="is_end2" value="Y"/></div>
					</td>
					<td class="succ_avg2">
						
					</td>
					<td class="comment_date2">
						<div><input type="text" id="comment_date2_1" name="comment_date2" class="date-i"/></div>
					</td>
					<td class="comment2">
						<div><textarea id="comment2_1" name="comment2"></textarea></div>
					</td>
				</tr>
				<tr>
					<td class="object"><div id="target3"></div></td>
					<td class="detail3 object_de">
						<div><div id="detail3_1"></div></div>
					</td>
					<td class="detail_date3">
						<div><div id="detail_date3_1"></div></div>
					</td>
					<td class="detail_step3">
						<div><div id="detail_step3_1"></div></div>
					</td>
					<td class="output_file3">
						<div><div id="output_file3_1"></div></div>
					</td>
					<td class="is_end3">
						<div><input type="checkbox" id="is_end3_1"  name="is_end3" value="Y"/></div>
					</td>
					<td class="succ_avg3">
						
					</td>
					<td class="comment_date3">
						<div><input type="text" id="comment_date3_1" name="comment_date3" class="date-i"/></div>
					</td>
					<td class="comment3">
						<div><textarea id="comment3_1" name="comment3"></textarea></div>
					</td>
				</tr>
				<tr>
					<td class="object"><div id="target4"></div></td>
					<td class="detail4 object_de">
						<div><div id="detail4_1"></div></div>
					</td>
					<td class="detail_date4">
						<div><div id="detail_date4_1"></div></div>
					</td>
					<td class="detail_step4">
						<div><div id="detail_step4_1"></div></div>
					</td>
					<td class="output_file4">
						<div><div id="output_file4_1"></div></div>
					</td>
					<td class="is_end4">
						<div><input type="checkbox" id="is_end4_1"  name="is_end4" value="Y"/></div>
					</td>
					<td class="succ_avg4">
						
					</td>
					<td class="comment_date4">
						<div><input type="text" id="comment_date4_1" name="comment_date4" class="date-i"/></div>
					</td>
					<td class="comment4">
						<div><textarea id="comment4_1" name="comment4"></textarea></div>
					</td>
				</tr>
				<tr>
					<td class="object"><div id="target5"></div></td>
					<td class="detail5 object_de">
						<div><div id="detail5_1"></div></div>
					</td>
					<td class="detail_date5">
						<div><div id="detail_date5_1"></div></div>
					</td>
					<td class="detail_step5">
						<div><div id="detail_step5_1"></div></div>
					</td>
					<td class="output_file5">
						<div><div id="output_file5_1"></div></div>
					</td>
					<td class="is_end5">
						<div><input type="checkbox" id="is_end5_1"  name="is_end5" value="Y"/></div>
					</td>
					<td class="succ_avg5">
						
					</td>
					<td class="comment_date5">
						<div><input type="text" id="comment_date5_1" name="comment_date5" class="date-i"/></div>
					</td>
					<td class="comment5">
						<div><textarea id="comment5_1" name="comment5"></textarea></div>
					</td>
				</tr>
			</table>
			<table class="board-lay board-interview">
				<tr>
					<th style="width:200px;">면담일자</th>
					<th>면담내용</th>
				</tr>
				<tr> 
					<td class="detail_date">
						<div><input type="text" id="interv_date" name="interv_date" class="date-i"/></div>
					</td>
					<td>
						<div><textarea id="interv_comment" name="interv_comment"></textarea></div>
					</td>
				</tr>
			</table>
    	</form>
    </div>
</div>
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
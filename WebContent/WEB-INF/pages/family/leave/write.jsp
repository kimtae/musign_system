<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="musign.classes.*" %>
<script>

$(document).ready(function(){	
	
})

function close_div(){
	$('.attach_div').hide();
}

function addLeave(){
	
	if ( $('#leave_title').val()=="" ) 
	{
		alert('제목을 채워주세요.');
		$('#leave_title').focus();
		return;
	}
	
	/*
	if ( $('#leave_start_ymd').val()=="" ) 
	{
		alert('시작 시간을 채워주세요.');
		$('#leave_start_ymd').focus();
		return;
	}
	
	if ( $('#leave_end_ymd').val()=="" ) 
	{
		alert('종료 시간을 채워주세요.');
		$('#leave_end_ymd').focus();
		return;
	}
	*/
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./addLeave",
		dataType : "text",
		async : false,
		data : 
		{
			title : $('#leave_title').val(),
			target_year : $('#selYear').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			if (result.isSuc=="success") 
			{
				getList();
				$('.attach_div').hide();
			}
			end_loading();
		}
	});
}

function uptLeave(){
	
	if ( $('#leave_title').val()=="" ) 
	{
		alert('제목을 채워주세요.');
		$('#leave_title').focus();
		return;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./uptLeave",
		dataType : "text",
		async : false,
		data : 
		{
			idx : edit_idx,
			title : $('#leave_title').val(),
			target_year : $('#selYear').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			if (result.isSuc=="success") 
			{
				getList();
				$('.attach_div').hide();
			}
			end_loading();
		}
	});
}

function delLeave(){
	if(!confirm("정말 삭제하시겠습니까?"))
	{
		return;
	}
	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./delLeave",
		dataType : "text",
		async : false,
		data : 
		{
			idx : edit_idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			if (result.isSuc=="success") 
			{
				getList();
				$('.attach_div').hide();
			}
			end_loading();
		}
	});
}

function addHoliday(){
	var year =  $('#selYear').val();
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./addHoliday",
		dataType : "text",
		async : false,
		data : 
		{
			target_year : $('#selYear').val(),
			idx : edit_idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (result.isSuc=="success") 
			{
				alert(result.msg);
			}
			end_loading();
		}
	});
}
</script>

<div class="attach_div" style="display: none;">
	<div class="closeBtn">
		<input type="button" onclick="close_div();" value="닫기" class="attachClose">
	</div>
	<div class="root_tableWrap">
		<div class="tableWrap">
			<div class="tableBox write_table">
				<span class="write_responsive">제목 &nbsp; &nbsp;: &nbsp; &nbsp; <input id="leave_title" class="leave_write" name="leave_title" type="text"></span>
					<span class="write_responsive2">해당연도 &nbsp; &nbsp; :  &nbsp; &nbsp;<select de-data="${year}" id="selYear" name="selYear">
						<%
						int year = Utils.checkNullInt(request.getAttribute("year"));
						for(int i = year+5; i > 2016; i--)
						{
							if(i == year)
							{
								%>			
								<option value="<%=i%>" selected><%=i%></option>
								<%
							}
							else
							{
								%>
								<option value="<%=i%>"><%=i%></option>
								<%
							}
						}
						%>
					</select>
				</span>
				<!-- list.jsp 페이지에서  등록/수정/석제 노출 조절 -->
				<input type="button" value="등록" class="add_leave" onclick="addLeave();">
				<input type="button" value="휴일 등록" class="add_holiday" onclick="addHoliday();">
				<input type="button" value="수정" class="edit_leave" onclick="uptLeave();">
				<input type="button" value="삭제" class="edit_leave" onclick="delLeave();">
				
			</div><!-- class="tableBox" -->
		</div><!-- class="tableWrap" -->
	</div>
</div>





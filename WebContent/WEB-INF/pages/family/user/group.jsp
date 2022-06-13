<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp" />
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp" />
<link rel="stylesheet" type="text/css" href="/css/group.css" />

<jsp:include page="/inc/date_picker/date_picker.html" />

<script>
	// 클리시 사진보이는 기능
	$(document).ready(function() {
		$('.alarm_div').hide();
		getList();
	});
	function viewPhoto(name) {
		console.log(1);
		$('.list-edit-wrap').fadeIn(200);
		//$("#photo").attr("src","/group/"+name+".PNG");
		$.get("/upload/group/" + name + ".png").done(function() {
			$("#photo").attr("src", "/upload/group/" + name + ".png");
		}).fail(function() {
			$("#photo").attr("src", "/upload/group/sample.png");
// 			$("#photo").attr("width", "300px");
// 			$("#photo").attr("height", "400px");

		})
		
	}
	//가족구성원 전체 조회
	function getList()
	{
		$.ajax({
			type : "POST", 			
			url : "./getGroupTeamList",	
			dataType : "text",
	
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
				var list = result.List;
				var teamPeople = result.TeamPeople;
				console.log(list);
				console.log(teamPeople);
				
				if(list.length > 0)
				{
					// 부서 반복
					for(var i=0; i < list.length; i++)
					{
						inner += 	'<div class="depth3">';
						inner += 			'<li class="team">'+list[i].team+'</li>';
						inner += 	'<ul>';
						
						// 팀원 반복
						for(var j=0; j< teamPeople.length; j++){
							if(list[i].team == teamPeople[j].team){
								inner += 	'<li class="member"><a href="javascript:viewPhoto(\''+teamPeople[j].NAME+'\')">'+teamPeople[j].NAME+' '+teamPeople[j].level+'</a></li>';							
							}
						}
						inner += 		'</ul>';
						inner += 	'</div>';
					}
				}
				// 뿌리기
				$(".Employee").html(inner);
				
			}
		});	
	}
	
	function fncSubmit(){
		
		var f = document.fncForm;
		
		//파일 첨부가 되지 않았을 때
		if(isEmpty(f.chart_file))
		{
			alert("업로드할 파일이 없습니다.");
			f.chart_file.value ="";
			f.chart_file.focus();
			return false;
		}
		start_loading();
		$("#fncForm").ajaxSubmit({
			success : function(data)
			{
				var result = JSON.parse(data);
				if(result.isSuc == "success")
				{
					alert(result.msg);
					location.href="/family/user/group";
				}
				else
				{
					alert(result.msg);
				}
				end_loading();
			}
			
		});
	}
	
</script>

<!-- 가족구성원 -->
<div class="company_wrap">

<c:if test="${isManager eq 'Y'}">
	<form id="fncForm" name="fncForm" method="post" action="teamChartUpload" enctype="multipart/form-data">
		<div style="margin-top: 80px">
			<input type="file" id="chart_file" class="write_file" name="chart_file" onchange="checkSize(this)">
	    	<input type="button" value="조직도 업로드" onclick="fncSubmit();">
		</div>
	</form>
</c:if>

	<div class="boss">
		<div class="ceo_01">
			
			<strong><a href="${imageDir}${chart_file}" download >조직 배치도 다운로드</a></strong>
			
			<ul>
				<li onclick="javascript:viewPhoto('이호걸')"><i class="material-icons">perm_identity</i>
				<!-- material icon -->
				CEO 이호걸 대표
				</li>
			</ul>
		</div>
		<div class="ceo_02">
			<ul>
				<li onclick="javascript:viewPhoto('지한규')">
				<i class="material-icons">perm_identity</i>
				COO 지한규 본부장
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 가족구성원 각 팀 별 조회 -->
	<div class="Employee">
	</div>
</div>

<div class="list-edit-wrap">
	<div class="le-cell">
		
		<div class="le-inner">
		
		<div class="list-edit">
			<img src="/group/sample.jpg" id="photo">
		</div>
		<div class="close" onclick="javascript:$('.list-edit-wrap').fadeOut(200);" ></div>
		
		
		
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp" />
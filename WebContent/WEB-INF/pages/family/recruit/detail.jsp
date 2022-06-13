<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<style>
.detail_receipt{display: none;}
.Information_wrap .edit,
.check_wrap .edit {position:relative;}
.Information_wrap .edit:before,
.check_wrap .edit:before {
	content:'';
	display:inline-block;
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:transparent;
	z-index:11111;
}

</style>

<script>
$(window).scroll(function(){

    try {
        var winST = $(window).scrollTop();
        var winH = $(window).height();
        var gnbT = 0;
        var oft = $(".bottom_hide").offset().top;
        console.log(oft);
        if(winST > gnbT )
        {
            $(".side_info_box").addClass("fixed");
            if (winST >= oft - winH)
            {
                $(".side_info_box").addClass("fixed-bottom");
            }
            else
            {
                $(".side_info_box").removeClass("fixed-bottom");
            }
        }
        else
        {
            $(".side_info_box").removeClass("fixed");
        }
    }
    catch(e) {

    }
});

$(document).ready(function(){
	var want_area_type_arr =  "${want_area}".split("|");
	var want_area_line = document.getElementsByName("want_area_type");
	for (var i = 0; i < want_area_type_arr.length-1; i++) 
	{
		for (var j = 0; j < want_area_line.length; j++) 
		{
			if (want_area_line[j].value==want_area_type_arr[i]) 
			{
				want_area_line[j].checked=true;
			}
		}
	}
	
	if ("${user_address}"!="") 
	{
		$('#user_address').val("${user_address}");
	}
	
	if ("${story_cont}"!="") 
	{
		$('#story_cont').val(repWord("${story_cont}"));
	}
	
	
    if ("${user_name}"!="")
    {
            $('#user_name').val("${user_name}");
             $('#rec_target').text("${user_name}");
    }

    if ("${user_phone}"!="")
    {
            $('#user_phone').val("${user_phone}");
    }

    if ("${user_email}"!="")
    {
            $('#user_email').val("${user_email}");
    }

    if ("${file}" !="")
    {
            var file_ori_arr = "${file_ori}".split('|');
            var file_arr =  "${file}".split('|');
            for (var i = 0; i < file_ori_arr.length; i++) {
                    if(nullChk(file_ori_arr[i])!='')
                    {
                      $('#file_area').append("<a href='https://musign.net"+file_arr[i]+"'>"+file_ori_arr[i]+"</a> <br>");
                    }
            }
    }
    
    if("${submit_date}" != "")
    {
       var year = "${submit_date}".substring(0,4);
       var mon = "${submit_date}".substring(4,6);
       var day = "${submit_date}".substring(6,8);
       $('#rec_ymd').text(year+'.'+mon+'.'+day);
    }

	
	
})


</script>


<div id="container">
	<form id="fncForm" name="fncForm" method="post" enctype="multipart/form-data">
		<div class="top">
			<div class="back_button">
				<a href="/family/recruit/list"><img src="/img/back_arrow.png"></a>
			</div>
		</div>
		<div class="re_title">
			<div class="re_name">지원자 <span id="rec_target" class="volun">홍길동</span> </div>
			<div class="re_date"> <span id="rec_ymd">채용일자 2022.01.03</span> </div>
		</div>
		<div class="cellbox recruit_wrap">
			<div class="qna_wrap cell cell1">
				<table class="qna">
					<tr class="tr_title">
						<th colspan="12">지원 내용</th>
					</tr>
					
					<tr class="check_wrap check_wrap1 recruit">		
						<th>지원분야</th>
						<td>
							<input type="checkbox" name="want_area_type" value="01">
							<label>운영지원</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="02">
							<label>기획</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="03">
							<label>디자인</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="04">
							<label>패키지디자인</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="05">
							<label>프론트엔드</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="06">
							<label>백엔드</label>
						</td>
						<td>
							<input type="checkbox" name="want_area_type" value="07">
							<label>마케팅</label>
						</td>
					</tr>
					
			
					
					<tr>
						<th>
							지원내용
						</th>
						<td colspan="7"><textarea id="story_cont" name="story_cont"></textarea></td>
					</tr>
					
					<tr>
						<th>
							첨부파일
						</th>
						<td id="file_area" colspan="7" >
						
						</td>
					</tr>
					
					
					
				</table>
			</div>	
			
			
				<div class="Information_wrap cell cell2">
					<div class="side_info_box">
					<table class="Information">
						<tr class="tr_title">
							<th colspan="14">지원자 정보</th>
							<!-- <th colspan="7" id="manager_nm"></th>-->
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="user_name" value="" readonly="readonly"></td>	
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" id="user_phone" value="" readonly="readonly"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" id="user_email" value="" readonly="readonly"></td>	
						</tr>
						<tr>
							<th>참고 사이트</th>
							<td><input type="text" id="user_address" value="" readonly="readonly"></td>	
						</tr>
					</table>
				</div>	
			</div>	
			
		</div>
	</form>
</div>
<div class="bottom_hide"></div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
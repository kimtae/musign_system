<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(document).ready(function(){
	document.getElementById('now_date').valueAsDate = new Date();
})
</script>





<div id="container">
	<h1 id="name">관리차트 - (수출바우처)</h1>
	<div class="calendar">
		<h6>기간설정 :</h6>
		<div class="calendar1"><input type="date" class="cal_date"></div>
		<div class="calendar2">~</div>
		<div class="calendar3"><input type="date" class="cal_date"></div>
		<div class="calendar4">적용</div>
	</div>	
	<div class="table_wrap">
		<table class="board">
			<tr>
				<th colspan="3">구분</th>
				<th colspan="8">고객정보</th>
				<th colspan="14">질의 응답</th>
				<th colspan="10">진행 상황</th>
			</tr>
			<tr>
				<th>문의 일자</th>
				<th>상태</th>
				<th>담당자</th>
				<th>회사명</th>
				<th>사업자등록번호</th>
				<th>업종 업태</th>
				<th>담당자</th>
				<th>이메일</th>
				<th>연락처</th>
				<th>개인정보 동의</th>
				<th>마케팅 수신 동의</th>
				<th>유형</th>
				<th>서비스</th>
				<th>기존 URL</th>
				<th>제작 목적</th>
				<th>웹사이트 이용대상</th>
				<th>동종업계 경쟁사 사이트 URL</th>
				<th>선호 기능 및 디자인 URL</th>
				<th>대응 디바이스</th>
				<th>브라우저 호환성</th>
				<th>웹사이트 제작예산</th>
				<th>희망 오픈일</th>
				<th>미팅 가능일정</th>
				<th>유입경로</th>
				<th>기타요청사항</th>
				<th>견적금액 1차</th>
				<th>견적회신일</th>
				<th>견적금액 2차</th>
				<th>견적회신일</th>
				<th>견적금액 3차</th>
				<th>견적회신일</th>
				<th>견적서</th>
				<th>코멘트</th>
				<th>미팅내용</th>
				<th>계약교부</th>
			</tr>
			<tr>
				<td><input type="date" id="now_date"></td>
				<td>계약</td>
				<td>지한규</td>
				<td>㈜뮤자인</td>
				<td>808-50-5555</td>
				<td>도소매</td>
				<td>홍길동</td>
				<td>/</td>
				<td>/</td>
				<td>X</td>
				<td>X</td>
				<td>문의</td>
				<td>기업사이트</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>/</td>
				<td>15,000,000</td>
				<td>2020-07-05</td>
				<td>18,000,000</td>
				<td>2020-07-10</td>
				<td>25,000,000</td>
				<td>2020-08-10</td>
				<td>확인</td>
				<td>/</td>
				<td>/</td>
				<td>O</td>
			</tr>		
		</table>
	</div>
	<div class="down_bt">엑셀 다운로드</div>
</div>


<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
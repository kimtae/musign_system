<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<!-- 유지보수 상세 페이지  정산설정 -->

		<!-- 정산설정 부분 시작 -->
		<div class="calculate_container">
	        <div class="calculate_inner tax_bill_box">
	            <h3>세금계산서</h3>
	            <div class="mu_drop">
	                <button type="button">미발행</button>
	                <ul>
	                    <li>미발행</li>
	                    <li>발행 완료</li>
	                </ul>
	            </div>
	        </div>
	        <div class="calculate_inner deposit_box">
	            <h3>입금여부</h3>
	            <div class="mu_drop">
	                <button type="button">미입금</button>
	                <ul>
	                    <li>미입금</li>
	                    <li>입금 완료</li>
	                </ul>
	            </div>
	        </div>
	        <div class="calculate_inner deposit_date_box">
	            <h3>입금 날짜</h3>
	           	<div class="mu_calender" >
					<input type="text" class="date-i calender_pas">
			   	</div>
	        </div>
	        <button type="button" class="save_state">상태 저장</button>
	    </div>


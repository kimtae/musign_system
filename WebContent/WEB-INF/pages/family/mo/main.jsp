<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<div id="wrap">		
	<div class="mu_content calculate_margin" id="sy_wrap">
		<div class="mu_inner">
			<div class="mu_top">
				<div class="mu_top2">
					<h3 class="mu_title">대시보드</h3>
					<!-- <div class="mu_mypage">
						<a href="#" class="mu_myIcon">마이페이지</a>
						<a href="#" class="mu_myIcon2">로그아웃</a>
						<div class="mu_mypage notice_icon">
        					<img src="/img/notice_btn.png" alt="알림버튼" class="notice_icon_btn">
        					<span class="notice_num">2</span>
    					</div>
    					<div class="notice_box">
					        <div class="notice_title">
					            <div class="bell_box">
					                <div class="bell_num">
					                    <span>2</span>
					                </div>
					            </div>
					            <h3>알림</h3>
					        </div>
					        <div class="notice_tab_btn_box">
					            <label for="notice_tab_1" class="tab_label tab_add">전자결재
					                <span>1</span>
					            </label>
					            <label for="notice_tab_2" class="tab_label">영업관리
					                <span>1</span>
					            </label>
					            <label for="notice_tab_3" class="tab_label">유지보수</label>
					        </div>
					        <div class="notice_tab_page_box">
					            <input id="notice_tab_1"type="radio" class="notice_tab" name="notice_tab" checked>
					            <input id="notice_tab_2"type="radio" class="notice_tab" name="notice_tab">
					            <input id="notice_tab_3"type="radio" class="notice_tab" name="notice_tab">
					            <div class="notice_tab_content notice_tab_content_1">
					                <div class="notice_inner_content notice_inner_content_1">
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 26(목)</p>
					                        </div> 
					                        <div class="message_con">	
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 25(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 24(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <div class="notice_tab_content notice_tab_content_2">
					                <div class="notice_inner_content notice_inner_content_1">
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 26(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인에서 영업 신청서를 작성했습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 26 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 25(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>(주)뮤자인의 담당자로 배정 되었습니다.</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 25 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="message_day_contain">
					                        <div class="day_num">
					                            <p>2021. 11. 24(목)</p>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                        <div class="message_con">
					                            <div class="message_box">
					                                <div class="message_text">
					                                    <span>문동현님의 근태신청서 서류를 확인해주세요</span>
					                                </div>
					                                <div class="message_time">
					                                    <span>21. 11. 24 11:39</span>
					                                </div>
					                                <div class="check_message">
					                                    <a href="#" class="check_message_a">바로가기</a>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <div class="notice_tab_content notice_tab_content_3"></div>
					        </div>
					    </div>
					</div> -->
				</div>
				<div class="mu_graph">
					<h4>유지보수 월별 정산 현황</h4>
					<div class="main_button">
						<button type="button">2021</button>
						<ul>
						    <li><a href="#">2021</a></li>
						    <li><a href="#">2020</a></li>
						</ul>
					</div>
				</div>
				<div class="mu_graph_box">					
					<div class="grap_bg">
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">10,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">5,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">1,000,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">500,000</div>
							<div class="mu_graph_line"></div>
						</div>
						<div class="mu_graph_box_in">
							<div class="mu_graph_money">0</div>
						</div>
					</div>
					<div class="grap_line">
						<div class="mu_month">					
							<div class="month_graph">
								<span>1<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">								
									<div class="mu_bar_money"><span>112,500</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>2<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>200,000</span><span class="mo_dis_no">원</span></div>
								</div>
								
							</div>
							<div class="month_graph">
								<span>3<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>300,000</span><span class="mo_dis_no">원</span></div>
								</div>	
							</div>
							<div class="month_graph">
								<span>4<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>400,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>5<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>6<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>	
							</div>
							<div class="month_graph">
								<span>7<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>	
							</div>
							<div class="month_graph">
								<span>8<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>9<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>10<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>11<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
							<div class="month_graph">
								<span>12<span class="mo_dis_no">월</span></span>
								<div class="mu_bar">
									<div class="mu_bar_money"><span>700,000</span><span class="mo_dis_no">원</span></div>
								</div>
							</div>
						</div>					
					</div>				
					<div class="graph_txt">*2021~2022년 통계 합계입니다.</div>
				</div>
			</div>
			<div class="mu_bottom">
				<h4>전체 유지보수 리스트</h4>
				<div class="project_list_content main_table_box">
                <div class="project_list_table_box  main_table"> 
                    <table class="project_list_table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="project_name_w">프로젝트명</th>
                                <th>계약일</th>
                                <th>종료일</th>
                                <th>계약금</th>
                                <th>월 정산금</th>
                                <th>월 정산일</th>
                                <th>업무요청</th>
                                <th>완료업무</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>5</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>6</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>7</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                            <tr>
                                <td>8</td>
                                 <td>
                                    <a href="/family/mo/target_list">빙그레</a>
                                </td>
                                <td>2021. 10. 19</td>
                                <td>2021. 10. 19</td>
                                <td>￦7,200,000</td>
                                <td>￦600,000</td>
                                <td>2021. 10. 19</td>
                                <td>
                                    <span class="request_span">1</span>
                                </td>
                                <td>
                                    <span class="completion_span">10</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="page_num">
                    <ul class="page_num_ul">
                        <li class="page_num_li">
                            <a href="">1</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">2</a>
                        </li>
                        <li class="page_num_li page_num_add_class">
                            <a href="">3</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">4</a>
                        </li>
                        <li class="page_num_li">
                            <a href="">5</a>
                        </li>
                    </ul>
                </div>
            </div>
			</div>
		</div> <!-- end of .mu_inner -->
	</div>
</div>
			

<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



<script>
</script>
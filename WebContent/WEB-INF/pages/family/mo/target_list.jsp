<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 유지보수 상세 리스트 -->

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

<%-- <jsp:include page="/WEB-INF/pages/family/mo/progress_staus_2.jsp"/>  --%>

<%-- <jsp:include page="/WEB-INF/pages/family/mo/progress_staus_2.jsp"/> --%>


<div id="wrap">		
	
<div class="mu_content calculate_margin list_detail" id="sy_wrap_2">
	<div class="mu_inner">
		<div class="mu_top">
			<div class="mu_top2">
				<h3 class="mu_title">프로젝트명 : 빙그레</h3>
<!-- 				<div class="mu_mypage"> -->
<!-- 					<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 					<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="mu_bottom">
			<div class="mu_bottom_02">
				<div class="mu_contentsBox">
                    <div class="mu_tabContainer">
                        <ul class="mu_tabs">
                            <li class="on"><a href="/family/mo/target_list">유지보수 리스트</a></li>
                            <li><a href="/family/mo/contract_info">계약정보</a></li>
                        </ul>
					   <div class="wrap"> <!-- mu_content삭제함-수지 -->
					        <div class="project_list_detail_contain">
					            <!-- <div class="project_list_title">
					                <h2>프로젝트명: 빙그레</h2>
					                 <div class="mu_mypage">
										<a href="#" class="mu_myIcon">마이페이지</a>
										<a href="#" class="mu_myIcon2">로그아웃</a>
									</div>
					            </div>
					            <div class="project_list_detail_btn_box ">
					                탭 활성화 class teb_add_class 입니다
					                <div class="detail_btn maintenance_btn teb_add_class">
					                    <a href="/family/mo/target_list">유지보수 리스트</a>
					                </div>
					                <div class="detail_btn contract_info_btn">
					                    <a href="/family/mo/contract_info">계약정보</a>
					                </div>
					            </div> -->
					            <div class="project_list_content maintenance_list">
					                <div class="search_box">
					                    <input type="submit" id="" class="search_btn">
					                    <input type="text" placeholder="검색어를 입력해주세요" class="search_box_input">
					                </div>
					                <div class="project_list_table_box project_list_detail_table_box"> 
					                    <table class="project_list_table project_list_detail_table">
					                        <thead>
					                            <tr>
					                                <th>
					                                    <input type="checkbox" class="check_list" id="num">
					                                    <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num">
					                                          <span>번호</span>
					                                    </label>
					                                    <div class="up_down_btn_box up_down_btn_pos">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                                <th></th>
					                                <th>
					                                    <span>요청업무</span>
					                                    <div class="up_down_btn_box">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                                <th></th>
					                                <th>
					                                    <span>진척율 (%)</span>
					                                    <div class="up_down_btn_box">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                                <th>
					                                    <span>계약일</span>
					                                    <div class="up_down_btn_box">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                                <th>
					                                    <span>종료일</span>
					                                    <div class="up_down_btn_box">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                                <th>
					                                    <span>상태</span>
					                                    <div class="up_down_btn_box">
					                                        <button></button>
					                                        <button></button>
					                                    </div>
					                                </th>
					                            </tr>
					                        </thead>
					                        <tbody>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num1">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num1">
					                                        <span>1</span>
					                                    </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">11월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                <!-- 접수중 class accepting 입니다 -->
					                                	<button type="button" class="accepting">접수중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num2">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num2">
					                                        <span>2</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">12월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                	<button type="button" class="accepting">접수중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num3">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num3">
					                                        <span>3</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">10월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                 <button type="button" class="accepting">접수중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num4">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num4">
					                                        <span>4</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">1월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                 <button type="button" class="accepting">접수중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num5">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num5">
					                                        <span>5</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">2월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                  <!-- 진행중 class proceeding 입니다 -->
					                                <button type="button" class="proceeding">진행중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num6">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num6">
					                                        <span>6</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">3월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                  <button type="button" class="proceeding">진행중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num7">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num7">
					                                        <span>7</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">4월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                  <button type="button" class="proceeding">진행중</button>
								                         <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td>
					                                    <input type="checkbox" class="check_list" id="num8">
					                                     <!-- id 값 변경 가능합니다 label 맞추려고 넣었습니다 -->
					                                    <label for="num8">
					                                        <span>8</span>
					                                  </label>
					                                </td>
					                                <td></td>
					                                <td>
					                                    <a href="/family/mo/target_detail">5월 유지보수</a>
					                                </td>
					                                <td></td>
					                                <td>70%</td>
					                                <td>2021. 10. 19</td>
					                                <td>2021. 10. 19</td>
					                                <td class="state_btn_box">
					                                <button type="button" class="completion">완료</button>
					                                 <!-- 완료 class completion 입니다 -->
					                                  <ul class="state_btn">
								                            <li>접수완료</li>
								                            <li>요구사항 분석</li>
								                            <li>요구사항 확정</li>
								                            <li>작업중</li>
								                            <li>검수요청</li>
								                            <li>정산</li>
								                            <li>완료</li>
								                        </ul>
					                                </td>
					                            </tr>
					                        </tbody>
					                    </table>
					                </div>
					                <div class="select_contain">
					                    <div class="select_remove_box">
					                        <button type="button">선택 삭제</button>
					                    </div>
					                    <div class="mu_drop drop_line pro_drop state_change_box">
					                        <span>일괄 상태 변경</span>
					                        <button type="button">접수완료</button>
					                        <ul>
					                            <li>접수완료</li>
					                            <li>요구사항 분석</li>
					                            <li>요구사항 확정</li>
					                            <li>작업중</li>
					                            <li>검수요청</li>
					                            <li>정산</li>
					                            <li>완료</li>
					                        </ul>
					                    </div>
					                </div>
					                <div class="page_num">
					                    <ul class="page_num_ul">
					                        <!-- 활성화 class  page_num_add_class 입니다 -->
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
					   </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</div>  
<!-- 계약정보 영역  -->
<div>
<%-- 	<jsp:include page="/WEB-INF/pages/family/mo/contract_info.jsp"/> --%>
</div>

<%-- <jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/> --%>



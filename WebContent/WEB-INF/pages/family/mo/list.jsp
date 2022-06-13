<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 유지보수 리스트 기본 -->

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>

  <div class="wrap mu_content list_wrap">
        <div class="mu_inner">
            <div class="project_list_title">
                <h2>프로젝트 리스트</h2>
<!--                 <div class="mu_mypage"> -->
<!-- 					<a href="#" class="mu_myIcon">마이페이지</a> -->
<!-- 					<a href="#" class="mu_myIcon2">로그아웃</a> -->
<!-- 				</div> -->
            </div>
            <div class="project_list_content">
                <div class="search_box">
                    <input type="submit" id="" class="search_btn">
                    <input type="text" placeholder="검색어를 입력해주세요" class="search_box_input">
                </div>
                <div class="project_list_table_box"> 
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
    </div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="alarm_div" >
	
		<div class="closeBtn">
			<input type="button" onclick="close_alarm();" value="닫기" class="attachClose">
		</div>
		<div class="root_tableWrap">

		<div class="tableWrap">
			<div class="tableBox" style="overflow: auto;">
				<table>
					<tbody id="sign_list_area">
						
    				</tbody>
				</table> 
				<br>
				<c:if test="${login_chmod eq '1'}">
					<input type="button" value="일괄처리" onclick="passAll();">
				</c:if>
				
			</div>
		</div>
	</div>
</div>

<div id="footer">
	Powered by musign
</div>

</body>
</html>
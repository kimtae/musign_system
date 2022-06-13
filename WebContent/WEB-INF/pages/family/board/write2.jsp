<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<script>

	var wsUri = "ws://localhost:8080/family/board/list/";
	var output;
	
	function init(){
		output = document.getElementById("output");
		testWebSocket();
	}
	
	function testWebSocket(){
		websocket = new WebSocket(wsUri);
		websocket.onopen 	= function(evt) { onOpen(evt); };
		websocket.onclose	= function(evt) { onClose(evt); };
		websocket.onmessage	= function(evt) { onMessage(evt); };
		websocket.onerror	= function(evt) { onError(evt); };
	}
	
	function onOpen(evt){
		writeToScreen("연결완료");
		doSend("테스트 메세지");
	}
	
	function onClose(evt){
		writeToScreen("연결해제");
	}
	
	function onMessage(evt){
		writeToScreen('<span style="color:blue;">수신: '+ evt.data +'</span>');
		websocket.close();
	}
	
	function onError(evt){
		writeToScreen('<span style="color:red;">에러: '+ evt.data +'</span>');
	}
	
	function doSend(message){
		writeToScreen("발신 : "+message);
		websocket.send(message);
	}

	function writeToScreen(message){
		var pre = document.createElement("p");
		pre.style.wordWrap = "break-word";
		pre.innerHTML = message;
		output.appendChild(pre);
	}
	
	window.addEventListener("load",init,false);

</script>

<div id="container" class="board_write">
	<h2>test</h2>
	<div id="output"></div>
</div>

<!-- footer  -->
<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>


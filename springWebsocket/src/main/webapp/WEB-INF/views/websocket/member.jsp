<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		var socket;
		
		function connect(){
			if(!socket){
				socket = new WebSocket("ws://localhost:8888/ws/member");
			}
			
			socket.onopen = function(){
				alert("서버와 연결되었습니다.");
			}
			
			socket.onclose = function(){
				alert("서버와 연결이 해제되었습니다.");
			}
			
			socket.onerror = function(){
				alert("서버와 연결도중 오류가 발생했습니다.");
			}
			
			socket.onmessage = function(e){
				console.log("메세지 도착");
				console.log(e.data);
				
				var div = document.createElement("div");
				//div.textContent = e.data;
				var obj = JSON.parse(e.data);
				console.log(obj);
				div.textContent = "["+obj.userId+"] : "+obj.message;
				document.querySelector("#message-area").appendChild(div);
			}
			
			
		}
		
		function disconnect(){
			socket.close();
			socket = "";
		}
		
		function send(){
			
			var message = document.querySelector("#chat").value;
			
			socket.send(message);
			
			document.querySelector("#chat").value = "";
		}
	</script>
	
	<h1>회원 전용 채팅방</h1>
	
	<h2>로그인 여부 : ${not empty loginUser }</h2>
	<h2>접속중인 아이디 : ${loginUser.userId }</h2>
	<button onclick="connect()">접속</button>
	<button onclick="disconnect()">종료</button>

	<hr>
	<input type="text" id="chat">
	<button onclick="send()">전송</button>
	
	<div id="message-area">
	</div>
</body>
</html>
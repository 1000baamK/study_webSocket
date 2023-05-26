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
			console.log(socket);
			
			//비어있지 않을때만 생성이 가능하게 만들어야 된다.
			if(!socket){		
				var url = "ws://localhost:8888/ws/group";
				socket = new WebSocket(url);
			}
			
			socket.onopen = function(){
				console.log("서버와 연결되었습니다.");
			}
			
			socket.onclose = function(){
				console.log("서버와 연결이 종료되었습니다.");
			}
			
			socket.onerror = function(){
				console.log("서버와 연결과정에서 오류가 발생했습니다.");
			}
			
			socket.onmessage = function(e){
				console.log("메세지가 도착했습니다.");
				
				console.log(e.data);
				var div = document.createElement("div");
				div.textContent = e.data;
				document.querySelector("#message-area").appendChild(div);
				
			}
			
		}
		
		function disconnect(){
			socket.close(); //소켓 종료
			socket ="";
		}
		
		function send(){
			var message = document.querySelector("#chat").value;
			
			socket.send(message);
			
			document.querySelector("#chat").value = "";
		}
	</script>
	<h1>그룹 채팅</h1>
	
	<button onclick="connect()">접속</button>
	<button onclick="disconnect()">종료</button>
	
	<br>
	<input type="text" id="chat">
	<button onclick="send()">전송</button>
	
	<!-- 전송된 메세지들이 출력될 공간 -->
	<div id="message-area">
		
	</div>
</body>
</html>
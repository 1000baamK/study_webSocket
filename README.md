# study_webSocket

서버와 클라이언트 간의 효율적인 양방향 통신을 실현하기 위해 기존에 사용하는 프로토콜(http)가 아닌 
웹소켓은 단순한 API로 구성되어있으며, 웹소켓을 이용하면 하나의 HTTP 접속으로 양방향 메시지를 자유롭게 주고받을 수 있습니다.






- websocketServer를 만들기 위해서는 특정 클래스/인터페이스 상속이 필요하다.<br>
  ->extends TextWebSocketHandler 상속<br>
  ->implements WebSocketHandler 구현<br>

- 웹소켓에서 사용되는 세션은 WebSocketSession으로 기존에 사용하던 HttpSession이랑 다르다.<br>

- 메세지 수신시 실행될 메소드<br>
@Override<br>
public void handleTextMessage(WebSocketSession session, TextMessage message){}<br>

- 접속시 실행되는 메소드<br>
@Override<br>
public void afterConnectionEstablished(WebSocketSession session){}<br>

- 접속 종료시 실행되는 메소드<br>
@Override<br>
public void afterConnectionClosed(WebSocketSession session, CloseStatus status){}<br>

	*session : 전송한 사용자의 웹소켓 정보(WebSocketSession)<br>
	*message : 사용자가 전송한 메세지 정보<br>
		-payload : 실제 보낸 내용<br>
		-byteCount : 보낸 메세지 크기(byte)<br>
		-last : 메세지 종료 여부<br>
	*status : 접속이 종료된 원인과 관련된 정보들<br>


소켓은 비어있지 않을때만 생성이 가능하게 조건을 걸어야한다.<br>
그렇지않으면 계속 새로운 소켓이 생성되면서 한 컴퓨터에서 여러 세션을 생성 할수가 있게 된다.<br>

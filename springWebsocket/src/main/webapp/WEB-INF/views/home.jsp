<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<h1> login : ${not empty loginUser } </h1>
<h3> userId : ${loginUser.userId }</h3>

<button onclick="location.href='websocket/member'">go</button>
</body>
</html>

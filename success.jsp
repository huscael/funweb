<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
	<title>success</title>
</head>
<body>
	<% 
		String type = request.getParameter("type");
		if (type.equals("update"))
		{
			String UserName = (String)session.getAttribute("UserName"); 
	%>
		<center>
			<h1>更新成功！</h1>
			<a href="individual.jsp?UserName=<%=UserName%>">点击返回</a>
		</center>
	<%
		} 
		else if (type.equals("signup"))
		{
	%>
		<center>
			<h1>注册成功！</h1>
			<a href="login.html">点击返回</a>
		</center>
	<%
		}
	%>
</body>
</html>
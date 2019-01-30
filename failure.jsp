<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
	<title>failure</title>
</head>
<body>
	<% 
		String UserName = (String)session.getAttribute("UserName"); 
		String type = request.getParameter("type");
		if (type.equals("login"))
		{
	%>
		<center>
			<h1>登录失败，请重试！</h1>
			<a href="login.html">点击返回</a>
		</center>
	<%
		}
		else if (type.equals("signup"))
		{
	%>
		<center>
			<h1>注册失败，用户已存在！</h1>
			<a href="login.html">点击返回</a>
		</center>
	<%
		} 
		else if (type.equals("update"))
		{
	%>
		<center>
			<h1>更新失败，请重试！</h1>
			<a href="individual.jsp?UserName=<%=UserName%>">点击返回</a>
		</center>
	<%
		}
	%>
</body>
</html>
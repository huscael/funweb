<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.vo.*" %>
<%@ page import="jb.dao.proxy.*" %>
<%@ page import="jb.dao.impl.*" %>
<html>
<head>
	<title>check</title>
</head>
<body>
	<% 
		try {
			AccountDAOProxy accountDAOProxy = new AccountDAOProxy();
			Account account = new Account();
			account.setUserName(request.getParameter("UserName"));
			account.setSNo(request.getParameter("SNo"));
			account.setPassword(request.getParameter("Password"));
			boolean success = accountDAOProxy.doCreate(account);
			if (success)
			{
	%>
				登录成功，跳转到成功页...
				<jsp:forward page= "success.jsp">
					<jsp:param name="type" value="signup"/>
				</jsp:forward>
	<%
			}
			else
			{
	%>
				登录失败，跳转到失败页...
				<jsp:forward page= "failure.jsp">
					<jsp:param name="type" value="signup"/>
				</jsp:forward>
	<%
			}
			} catch (Exception e) {
	%>
			<%= e.getMessage() %>
	<%
			}
	%>
</body>
</html>
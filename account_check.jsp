<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<html>
<head>
	<title>check</title>
</head>
<body>
	<% 
		DatabaseConnection dbc = null;
		Connection conn = null;
		Statement stat = null;
		String check_ID = request.getParameter("UserName");
		String check_Password = request.getParameter("Password");
		try {
			dbc = new DatabaseConnection();
			conn = dbc.getConnection();
			stat = conn.createStatement();
			} catch (Exception e) {
	%>
			<%= e.getMessage() %>
	<%
		}
		try{
			String sql = "select * from account where UserName='" + check_ID + "' and Password='" + check_Password + "'";
			ResultSet rs = stat.executeQuery(sql);
			if (rs.next())
			{ 
				conn.close();
				//使用seesion的属性保持用户状态
				session.setAttribute("UserName",check_ID);
				session.setAttribute("Password",check_Password);
				if (check_ID.equals("admin"))
				{
	%>
				登录成功，跳转到成功页...
				<jsp:forward page= "admin.jsp">
					<jsp:param name="UserName" value="<%=check_ID%>"/>
					<jsp:param name="Password" value="<%=check_Password%>"/>
				</jsp:forward>
	<%
				}
				else
				{
	%>
				登录成功，跳转到成功页...
				<jsp:forward page= "individual.jsp">
					<jsp:param name="UserName" value="<%=check_ID%>"/>
					<jsp:param name="Password" value="<%=check_Password%>"/>
				</jsp:forward>
	<%
				}
			}
			else
			{
				conn.close();
	%>
				登录失败，跳转到失败页...
				<jsp:forward page= "failure.jsp">
					<jsp:param name="type" value="login"/>
				</jsp:forward>
	<%
			}
			dbc.close();
		}catch(Exception e){
	%>
			<%= e.getMessage() %>
	<%
		}
	%>
</body>
</html>
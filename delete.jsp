<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<html>
<head>
	<title>delete</title>
</head>
<body>
	<% 
		DatabaseConnection dbc = null;
		Connection conn = null;
		Statement stat = null;
		String SNo = request.getParameter("SNo");
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
			String sql = "delete from choose where SNo='"+SNo+"';";
			stat.executeUpdate(sql);
			sql = "delete from account where SNo='"+SNo+"';";
			stat.executeUpdate(sql);
			sql = "delete from student where SNo='"+SNo+"';";
			stat.executeUpdate(sql);
			String UserName=(String)session.getAttribute("UserName");
			String Password=(String)session.getAttribute("Password");
	%>
				登录成功，跳转到成功页...
				<jsp:forward page= "admin.jsp">
					<jsp:param name="UserName" value="<%=UserName%>"/>
					<jsp:param name="Password" value="<%=Password%>"/>
				</jsp:forward>
	<%
			
		}catch(Exception e){
	%>
			<%= e.getMessage() %>
	<%
		}
	%>
</body>
</html>
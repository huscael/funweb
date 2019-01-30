<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<html>
<head>
	<title>
		check
	</title>
</head>
<body>
<% 
	DatabaseConnection dbc = null;
	Connection conn = null;
	Statement stat = null;
	String UserName = (String)session.getAttribute("UserName");
	String SNo = (String)session.getAttribute("SNo");
	request.setCharacterEncoding("utf-8");
	String SName = request.getParameter("SName");
	String SSex = request.getParameter("SSex");
	String SDormitory = request.getParameter("SDormitory");
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
	    int flag=1;
		String sql = "update student set SName='"+SName+"' where SNo='" + SNo +"';";
		stat.executeUpdate(sql);
		sql = "update student set SSex='"+SSex+"' where SNo='" + SNo +"';";
		stat.executeUpdate(sql);
		sql = "update student set SDormitory='"+SDormitory+"' where SNo='" + SNo +"';";
		stat.executeUpdate(sql);
%>
		更新成功，跳转到成功页...
		<jsp:forward page= "success.jsp">
			<jsp:param name="type" value="update"/>
		</jsp:forward>
<%
			dbc.close();
		}catch(Exception e){
%>
			<%= e.getMessage() %>
<%
		}
%>
</body>
</html>
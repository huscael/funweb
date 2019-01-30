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
	String CNo = request.getParameter("CNo");
	String Score = request.getParameter("Score");
	String SNo = (String)session.getAttribute("SNo");
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
		String sql = "select * from choose where CNo='" + CNo +"' and SNO='"+SNo+"'";
		ResultSet rs = stat.executeQuery(sql);
		if (rs.next()) flag=0;
		sql = "select * from course where CNo='" + CNo +"'";
		rs = stat.executeQuery(sql);
		if (!rs.next()) flag=0;
		if (flag==0)
			{ 
%>
				更新失败，跳转到失败页...
				<jsp:forward page= "failure.jsp">
					<jsp:param name="type" value="update"/>
				</jsp:forward>
<%
			}
			else
			{
				sql = "insert into choose values('"+SNo+"','"+CNo+"',"+Score+")";
				stat.executeUpdate(sql);
%>
				更新成功，跳转到成功页...
				<jsp:forward page= "success.jsp">
					<jsp:param name="type" value="update"/>
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
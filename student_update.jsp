<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<%@ page import="jb.vo.*" %>
<html>
<head>
	<title>完善信息</title>
	<link href="bootstrap-3.3.7-dist\css\bootstrap.css" rel="stylesheet">
	<link href="bootstrap-3.3.7-dist\css\bootstrap-theme.css" rel="stylesheet">
	<script src="jquery.js"></script>
	<script src="bootstrap-3.3.7-dist\js\bootstrap.js"></script>
</head>
<body>
	<%
		DatabaseConnection dbc = null;
		Connection conn = null;
		Statement stat = null;
		try {
			dbc = new DatabaseConnection();
			conn = dbc.getConnection();
			stat = conn.createStatement();
			} catch (Exception e) {
	%>
			<%= e.getMessage() %>
	<%
		}
	%>
	<%
		String UserName = request.getParameter("UserName");
		String SNo = request.getParameter("SNo");
		String SName = null;
		String SSex = request.getParameter("SSex");
		String SDormitory = request.getParameter("SDormitory");
	%>
	<%
	try{
		String sql = "select * from student where UserName='" + UserName+"'";
		ResultSet rs = stat.executeQuery(sql);
		if(rs.next())
			SNo = rs.getString("SNo");
		else
		{
			sql = "select * from student where SNo='" + UserName+"'";
			rs = stat.executeQuery(sql);
			rs.next();
			SNo = rs.getString("SNo");
		}
		SName=rs.getString("SName");
		//rs.close();
		//dbc.close();
	}catch(Exception e){
%>
		<%= e.getMessage() %>
<%
	}
%>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h3>
				信息完善
			</h3>
			<form role="form" method="post">
				<div class="form-group">
					 <label for="exampleInput2">用户名</label><text class="form-control" name="UserName" ><%=UserName%></text>
				</div>
				<div class="form-group">
					 <label for="exampleInput3">学号</label></label><text class="form-control" name="UserName" ><%=SNo%></text>
				</div>
				<div class="form-group">
					 <label for="exampleInput3">姓名</label><input type="text" class="form-control" name="SName" value="<%=session.getAttribute("SName")%>"/>
				</div>
				<div class="form-group">
					 <label for="exampleInput3">性别</label><input type="text" class="form-control" name="SSex" value="<%=SSex%>"/>
				</div>
				<div class="form-group">
					 <label for="exampleInput3">寝室</label><input type="text" class="form-control" name="SDormitory" value="<%=SDormitory%>"/>
				</div>
				<button type="submit" class="btn btn-default" formaction="student_update_check.jsp">Submit</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>
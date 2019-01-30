<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>更新信息</title>
	<link href="bootstrap-3.3.7-dist\css\bootstrap.css" rel="stylesheet">
	<link href="bootstrap-3.3.7-dist\css\bootstrap-theme.css" rel="stylesheet">
	<script src="jquery.js"></script>
	<script src="bootstrap-3.3.7-dist\js\bootstrap.js"></script>
</head>
<body>
	<%String UserName = request.getParameter("UserName");%>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h3>
				信息更新
			</h3>
			<form role="form" method="post">
				<div class="form-group">
					 <label for="exampleInput2">课程编号</label><input type="text" class="form-control" name="CNo" />
				</div>
				<div class="form-group">
					 <label for="exampleInput3">课程分数</label><input type="text" class="form-control" name="Score" />
				</div>
				<button type="submit" class="btn btn-default" formaction="update_check.jsp">Submit</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>
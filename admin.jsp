<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<%@ page import="jb.vo.*" %>
<html>
<head>
	<title>管理员</title>
	<link href="bootstrap-3.3.7-dist\css\bootstrap.css" rel="stylesheet">
	<link href="bootstrap-3.3.7-dist\css\bootstrap-theme.css" rel="stylesheet">
	<script src="jquery.js"></script>
	<script src="bootstrap-3.3.7-dist\js\bootstrap.js"></script>
</head>
<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="page-header">
					<h1>
						管理员界面 <small>为学生服务</small>
					</h1>
				</div>
			</div>
		</div>
		<div class="row clearfix">
			<div class="col-md-8 column">
				<div style="padding: 20px 0px 10px;">
    				<form class="bs-example bs-example-form" role="form" action="individual.jsp" method="POST">
    					<div class="row">
				            <div class="col-lg-6">
				                <div class="input-group">
				                    <input type="text" class="form-control" placeholder="输入学号" name="UserName" id="UserName">
				                    <span class="input-group-btn">
				                        <button class="btn btn-default" type="submit">搜索</button>
				                    </span>
				                </div><!-- /input-group -->
				            </div><!-- /.col-lg-6 -->
			        	</div>
    				</form>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th>
								学号
							</th>
							<th>
								用户名
							</th>
							<th>
								真实姓名
							</th>
						</tr>
					</thead>
					<tbody>
						<%
							DatabaseConnection dbc = null;
							Connection conn = null;
							Statement stat = null;
							String UserName=null;
							String SNo=null;
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
								String sql = "select * from account,student where account.UserName!='admin' and account.SNo=student.SNo;";
								ResultSet rs = stat.executeQuery(sql);
								int n=5;
								while(rs.next() && n-->0)
								{
						%>
									<tr>
										<td><%= rs.getString("SNo") %></td>
										<td><%= rs.getString("UserName") %></td>
										<td><%= rs.getString("SName") %></td>
									</tr>
						<%
								}
								//rs.close();
								//dbc.close();
							}catch(Exception e){
						%>
								<%= e.getMessage() %>
						<%
							}
						%>
					</tbody>
				</table>
				<div style="padding: 20px 0px 10px;">
    				<form class="bs-example bs-example-form" role="form" action="delete.jsp" method="POST">
    					<div class="row">
				            <div class="col-lg-6">
				                <div class="input-group">
				                    <input type="text" class="form-control" placeholder="输入学号" name="SNo" id="SNo">
				                    <span class="input-group-btn">
				                        <button class="btn btn-default" type="submit">删除成员信息</button>
				                    </span>
				                </div><!-- /input-group -->
				            </div><!-- /.col-lg-6 -->
			        	</div>
    				</form>
				</div>
			</div>
			<div class="col-md-4 column">
				<div class="dropdown">
				    <button type="button" class="btn dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">科目
				        <span class="caret"></span>
				    </button>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				    	<%
				    	try{
								String sql = "select * from course;";
								ResultSet rs = stat.executeQuery(sql);
								while(rs.next())
								{
						%>
									<li role="presentation">
										<a role="menuitem" tabindex="-1" href="subject_stat.jsp?CNo=<%= rs.getString("CNo") %>">
											<%= rs.getString("CName") %>
										</a>
				        			</li>
						<%
								}
								//rs.close();
								//dbc.close();
							}catch(Exception e){
						%>
								<%= e.getMessage() %>
						<%
							}
						%>
				    </ul>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th>
								类别
							</th>
							<th>
								统计
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								及格率
							</td>
							<td>
								请选择科目
							</td>
							<tr>
							<td>
								平均成绩
							</td>
							<td>
								请选择科目
							</td>
						</tr>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="col-md-12 column">
			 <a href="login.html">
				<button type="button" class="btn btn-default btn-block">返回首页</button>
			</a>
		</div>
	</div>
</body>
</html>
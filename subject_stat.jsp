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
							String CNo=request.getParameter("CNo");
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
						<%
						String CName=null;
				    	try{
								String sql = "select * from course where CNo='"+CNo+"';";
								ResultSet rs = stat.executeQuery(sql);
								rs.next();
								CName=rs.getString("CName");
								//rs.close();
								//dbc.close();
							}catch(Exception e){
						%>
								<%= e.getMessage() %>
						<%
							}
						%>
						<tr>
							<td>
								<%= CName %>及格率
							</td>
							<%
					    	try{
									String sql = "select * from choose where CNo='"+CNo+"';";
									ResultSet rs = stat.executeQuery(sql);
									int pass=0,all=0;
									while(rs.next())
									{
										if (Double.valueOf(rs.getString("score"))-60.0>1e-3)
										{
											pass++;
											all++;
										}
										else
											all++;
									}
									String rate=String.valueOf((float)pass/all*100)+"%";
								%>
									<td>
										<%= rate %>
									</td>
								<%
									//rs.close();
									//dbc.close();
								}catch(Exception e){
							%>
									<%= e.getMessage() %>
							<%
								}
							%>
							
						</tr>
						<tr>
							<td>
								<%= CName %>平均成绩
							</td>
							<%
					    	try{
									String sql = "select * from choose where CNo='"+CNo+"';";
									ResultSet rs = stat.executeQuery(sql);
									double sum=0,avg;
									int cnt=0;
									while(rs.next())
									{
										sum+=Double.valueOf(rs.getString("score"));
										cnt++;
									}
									avg=sum/cnt;
								%>
									<td>
										<%= avg %>
									</td>
								<%
									//rs.close();
									//dbc.close();
								}catch(Exception e){
							%>
									<%= e.getMessage() %>
							<%
								}
							%>
						
						</tr>
					</tbody>
				</table>
				<%
				 	int a=0,b=0,c=0,d=0,ee=0;
					try{
						String sql = "select * from choose where CNo='"+CNo+"';";
						ResultSet rs = stat.executeQuery(sql);
						while(rs.next())
						{
							if (Double.valueOf(rs.getString("score"))-90>1e-3)
								a++;
							else if (Double.valueOf(rs.getString("score"))-80>1e-3)
								b++;
							else if (Double.valueOf(rs.getString("score"))-70>1e-3)
								c++;
							else if (Double.valueOf(rs.getString("score"))-60>1e-3)
								d++;
							else
								ee++;
						}
						//rs.close();
						//dbc.close();
					}catch(Exception e){
				%>
						<%= e.getMessage() %>
				<%
					}
				%>
				<a href="bar.jsp?a=<%=a%>&b=<%=b%>&c=<%=c%>&d=<%=d%>&ee=<%=ee%>" class="pull-right">详细图表</a>
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
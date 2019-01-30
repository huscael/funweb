<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jb.dbc.*" %>
<%@ page import="jb.vo.*" %>
<html>
<head>
	<title>个人主页</title>
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
	String UserName = request.getParameter("UserName");
	//String Password = request.getParameter("Password");
	String SNo = null;
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
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h3>
				<em><%= UserName %></em>的个人主页
			</h3>
		</div>
	</div>
	<div class="row clearfix">
		<div class="col-md-2 column">
			<img alt="140x140" src="img/spears.jpg" class="img-rounded" width="140" height="140" />
			<br>
			<p>
				<br>
				 <em><%= UserName %></em> 是一个优秀的学生，就读于重庆邮电大学 <strong> CQUPT </strong> 
			</p>
		</div>
		<div class="col-md-10 column">
			<div class="tabbable" id="tabs-295567">
				<ul class="nav nav-tabs">
					<li class="active">
						 <a href="#panel-1" data-toggle="tab">基本信息</a>
					</li>
					<li>
						 <a href="#panel-2" data-toggle="tab">课程信息</a>
					</li>
					<li>
						 <a href="#panel-3" data-toggle="tab">统计信息</a>
					</li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="panel-1">
						<p>
							<%
								String SName=null;
								String SSex=null;
								String SDormitory=null;
								//request.setCharacterEncoding("UTF-8");
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
									session.setAttribute("SNo",SNo);
									SName=rs.getString("SName");
									session.setAttribute("SName",SName);
									SSex=rs.getString("SSex");
									SDormitory=rs.getString("SDormitory");
									//rs.close();
									//dbc.close();
								}catch(Exception e){
							%>
									<%= e.getMessage() %>
							<%
								}
							%>
							<ul>
								<li>
									用户名：<%=UserName%>
								</li>
								<li>
									学号：<%=SNo%>
								</li>
								<li>
									姓名：<%=SName%>
								</li>
								<li>
									性别：<%=SSex%>
								</li>
								<li>
									寝室：<%=SDormitory%>
								</li>
							</ul> 
							<a href="student_update.jsp?UserName=<%=UserName%>&SNo=<%=SNo%>&SName=<%=SName%>&SSex=<%=SSex%>&SDormitory=<%=SDormitory%>">
								<button type="button" class="btn btn-default">信息完善</button>
							</a>
						</p>
					</div>
					<div class="tab-pane" id="panel-2">
						<table class="table">
							<thead>
								<tr>
									<th>课程编号</th>
									<th>课程名</th>
									<th>考试成绩</th>
									<th>学分</th>
								</tr>
							</thead>
							<tbody>
								<%
									try{
										String sql = "select SNo from account where UserName='" + UserName+"'";
										ResultSet rs = stat.executeQuery(sql);
										if(rs.next())
											SNo = rs.getString("SNo");
										else
										{
											sql = "select SNo from account where SNo='" + UserName+"'";
											rs = stat.executeQuery(sql);
											rs.next();
											SNo = rs.getString("SNo");
										}
										sql = "select choose.CNo,Score,CName,CCredit from choose,course where choose.SNo='"+SNo+"' and choose.CNo=course.CNo";
										rs = stat.executeQuery(sql);
										while(rs.next())
										{
								%>
											<tr>
												<td><%= rs.getString("CNo") %></td>
												<td><%= rs.getString("CName") %></td>
												<td><%= rs.getString("Score") %></td>
												<td><%= rs.getString("CCredit") %></td>
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
						<a href="score_update.jsp">
							<button type="button" class="btn btn-sm btn-primary btn-block">更新信息</button>
						</a>
					</div>
					<div class="tab-pane" id="panel-3">
						<p>
							<div class="row clearfix">
								<div class="col-md-12 column">
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
											<tr class="success">
												<td>
													平均成绩
												</td>
												<td>
													<%
													try{
														String sql = "select score from choose where SNo='"+SNo+"';";
														ResultSet rs = stat.executeQuery(sql);
														double sum_score=0;
														int cnt=0;
														while(rs.next())
														{
															sum_score+=Double.valueOf(rs.getString("score"));
															cnt++;
														}
														sum_score/=cnt;
												%>
														<%= sum_score %>
												<%
														//rs.close();
														//dbc.close();
													}catch(Exception e){
												%>
														<%= e.getMessage() %>
												<%
													}
												%>
												</td>
											</tr>
											<tr class="success">
												<td>
													绩点
												</td>
												<td>
												<%
													try{
														String sql = "select CCredit,score from choose,course where choose.SNo='"+SNo+"' and choose.CNo=course.CNo;";
														ResultSet rs = stat.executeQuery(sql);
														float sum_gpa=0,sum_credit=0;
														while(rs.next())
														{
															double tmp=Double.valueOf(rs.getString("score"));
															double c=Double.valueOf(rs.getString("CCredit"));
															if (tmp>=90)
																tmp=4.0*c;
															else if (tmp>=85)
																tmp=3.7*c;
															else if (tmp>=82)
																tmp=3.3*c;
															else if (tmp>=78)
																tmp=3.0*c;
															else if (tmp>=75)
																tmp=2.7*c;
															else if (tmp>=72)
																tmp=2.3*c;
															else if (tmp>=68)
																tmp=2.0*c;
															else if (tmp>=64)
																tmp=1.5*c;
															else if (tmp>=60)
																tmp=1.0*c;
															sum_gpa+=tmp;
															sum_credit+=c;
														}
														sum_gpa/=sum_credit;
												%>
														<%= sum_gpa %>
												<%
														//rs.close();
														//dbc.close();
													}catch(Exception e){
												%>
														<%= e.getMessage() %>
												<%
													}
												%>
												</td>
											</tr>
											<tr class="success">
												<td>
													总学分
												</td>
												<td>
												<%
													try{
														String sql = "select CCredit from choose,course where choose.SNo='"+SNo+"' and choose.CNo=course.CNo;";
														ResultSet rs = stat.executeQuery(sql);
														double sum_credit=0;
														while(rs.next())
														{
															sum_credit+=Double.valueOf(rs.getString("CCredit"));
														}
												%>
														<%= sum_credit %>
												<%
														rs.close();
														dbc.close();
													}catch(Exception e){
												%>
														<%= e.getMessage() %>
												<%
													}
												%>
												</td>
											</tr>
				
										</tbody>
									</table>
								</div>
							</div>
						</p>
					</div>
				</div>
			</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎</title>
</head>
<body>
<h2><%=session.getAttribute("username") %>，您好！</h2>
<p>欢迎使用实践课教学管理系统！为了使您更快地掌握本系统，提高工作效率，请仔细阅读以下使用指南：</p>
<%
if(Integer.parseInt(session.getAttribute("type").toString())==2)
	{
%>
<p><strong>请注意：您的身份是陪审组长<br>
（1）打分前，您需要对本组的陪审员安排工作。请在【组员成绩】中的“成绩管理”，找到并进入本次考核，点击“组员管理”，指定每位陪审员指责，并及时提交数据。<br>
（2）打分后，您可以反复点击“组员管理”中的“刷新”按钮，以观察陪审员们的打分结果，分数无误即可勾选“确认”，并及时提交数据。<br>
（3）如果某位陪审员在“确认”后又修改了成绩，他负责的所有学生成绩记录都将自动变成未确认状态，请留意。</strong></p>
<%
	}
%>
<p>请在<strong>【组员成绩】</strong>中的"成绩管理"，找到并进入本次考核，对所有列出的学生进行打分，打分需仔细阅读评分要求，并留意分数上限，即每个考查点的最高分值。</p>
<p>&nbsp;</p>
</body>
</html>

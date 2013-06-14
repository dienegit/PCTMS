<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="oMD5" scope="session" class="com.course.encoder.MD5"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加学生</title>
</head>
<body>
<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<3)		
	{
%>
	没有权限！<br>请重新<a href="../login.jsp">登录</a>.
<%
}
else
{
%>

<%
	String sno = new String(request.getParameter("sno").getBytes("ISO-8859-1"),"UTF-8");
	String sname = new String(request.getParameter("sname").getBytes("ISO-8859-1"),"UTF-8");
	String classno = new String(request.getParameter("classno").getBytes("ISO-8859-1"),"UTF-8");
	String password = oMD5.getMD5ofStr(sno);
%>

您刚才输入了下列信息：<br>
	学号：<%=sno %><br>
	姓名：<%=sname%><br>
	班号：<%=classno%><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("insert into student(sno,sname,classno,spassword) values(?,?,?,?)");
			sta.setString(1,sno);
			sta.setString(2,sname);
			sta.setString(3,classno);
			sta.setString(4,password);
			sta.execute();
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>
	<br>
	<a href="index.jsp">返回查看</a>
<%
}
%>
</body>
</html>

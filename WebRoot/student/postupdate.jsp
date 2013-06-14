<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改学生</title>
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
	String sno = new String(request.getParameter("sno_new").getBytes("ISO-8859-1"),"UTF-8");
	String sname = new String(request.getParameter("sname_new").getBytes("ISO-8859-1"),"UTF-8");
	String classno = new String(request.getParameter("classno_new").getBytes("ISO-8859-1"),"UTF-8");
%>

您刚才更新了下列信息：<br>
	学号：<%=sno %><br>
	姓名：<%=sname%><br>
	班号：<%=classno%><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("update student set sname=?,classno=? where sno='"+sno+"'");
			sta.setString(1,sname);
			sta.setString(2,classno);
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改教师</title>
</head>
<body>
<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())!=9)		
	{
%>
	没有权限！<br>先进行超级管理员<a href="../admin.jsp">验证</a>.<br>
	然后再重新进行操作！
<%
}
else
{
%>

<%
	String tno = new String(request.getParameter("tno_new").getBytes("ISO-8859-1"),"UTF-8");
	String tname = new String(request.getParameter("tname_new").getBytes("ISO-8859-1"),"UTF-8");
%>

您刚才更新了下列信息：<br>
	教师号：<%=tno %><br>
	教师名：<%=tname%><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("update teacher set tname=? where tno='"+tno+"'");
			sta.setString(1,tname);
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

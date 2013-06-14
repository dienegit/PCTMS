<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="oMD5" scope="session" class="com.course.encoder.MD5"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>
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
	String tno = new String(request.getParameter("tno").getBytes("ISO-8859-1"),"UTF-8");
	String password = oMD5.getMD5ofStr(tno);
	
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("update teacher set tpassword=? where tno='"+tno+"'");
			sta.setString(1,password);
			sta.execute();
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

成功将该教师的登录密码重置为教师号“<%=tno%>”！<br>
	<br>
	<a href="index.jsp">返回查看</a>
<%
}
%>
</body>
</html>

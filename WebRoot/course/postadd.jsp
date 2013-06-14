<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加班级</title>
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
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String cdescribe = new String(request.getParameter("cdescribe").getBytes("ISO-8859-1"),"UTF-8");
	String tno = new String(request.getParameter("tno").getBytes("ISO-8859-1"),"UTF-8");
%>

您刚才输入了下列信息：<br>
	课程号：<%=cno %><br>
	课程名：<%=cname%><br>
	教学任务：<%=cdescribe%><br>
	授课教师：<%=tno%><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("insert into course(cno,tno,cname,cdescribe) values(?,?,?,?)");
			sta.setString(1,cno);
			sta.setString(2,tno);
			sta.setString(3,cname);
			sta.setString(4,cdescribe);
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

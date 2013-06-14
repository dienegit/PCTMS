<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改课程</title>
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
	String cno = new String(request.getParameter("cno_new").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname_new").getBytes("ISO-8859-1"),"UTF-8");
	String cdescribe = new String(request.getParameter("cdescribe_new").getBytes("ISO-8859-1"),"UTF-8");
	String tno = new String(request.getParameter("tno_new").getBytes("ISO-8859-1"),"UTF-8");
%>

您刚才更新了下列信息：<br>
	学号：<%=cno %><br>
	姓名：<%=cname%><br>
	班号：<%=cdescribe%><br>
	权限：<%=tno%><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("update course set cname=?,cdescribe=?,tno=? where cno='"+cno+"'");
			sta.setString(1,cname);
			sta.setString(2,cdescribe);
			sta.setString(3,tno);
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

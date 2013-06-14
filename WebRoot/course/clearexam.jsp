<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="log" scope="page" class="com.course.data.WriteLog"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>清理记录</title>
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
	
	成功清理了课程信息失效的考核记录！
	<%
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("delete from exam where cno not in (select cno from course)");
			sta.execute();
			sta.close();
			dbc.close();
			log.setPath(application.getRealPath("/logs"));	//写日志
			log.setLog("> "+ session.getAttribute("userno") + "; type: " + session.getAttribute("type") + "; delete from exam where cno not in (select cno from course)");
			log.writeFile();
		}
		catch(Exception e)
		{}
	%>
	
	<br>
	<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

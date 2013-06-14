<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除课程</title>
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
	
	您删除了下列课程：
	<%
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("delete from course where cno=?");
			
			String[] delIdSet = request.getParameterValues("delId");	
			
			for(int i=0;i<delIdSet.length;i++)
			{
			%>
				<%=delIdSet[i]%>&nbsp;&nbsp;
			<%
			sta.setString(1,delIdSet[i]);
			sta.execute();
			}
			
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

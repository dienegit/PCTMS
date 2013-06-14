<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改班级</title>
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
	String classno = new String(request.getParameter("classno").getBytes("ISO-8859-1"),"UTF-8");
	String classname=null;
	int stype=0;
	try
		{
			
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from class where classno='"+classno+"'");
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				classname = rs.getString("classname");
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

【修改班级】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postupdate.jsp">
	班号：<input name="classno_new" type="text" onfocus=this.blur() value="<%=classno %>"/><br>
	班级名：<input name="classname_new" type="text" value="<%=classname %>"/><br>
	<input type="submit" value="提交数据"/>
</form>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

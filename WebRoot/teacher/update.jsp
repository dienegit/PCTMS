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
	String tno = new String(request.getParameter("tno").getBytes("ISO-8859-1"),"UTF-8");
	String tname=null;
	try
		{
			
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from teacher where tno='"+tno+"'");
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				tname = rs.getString("tname");
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

【修改教师】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postupdate.jsp">
	教师号：<input name="tno_new" type="text" onfocus=this.blur() value="<%=tno %>"/><br>
	教师名：<input name="tname_new" type="text" value="<%=tname %>"/><br>
	<input type="submit" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

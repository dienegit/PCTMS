<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师管理</title>
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

【教师管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="delete.jsp">
	<table border=1 >
	<tr>
		<td>教师号</td>
		<td>教师名</td>
		<td>修改</td>
		<td>删除</td>
		
	</tr>
	
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from teacher");
		ResultSet rs = sta.executeQuery();
	
		while(rs.next())
		{
			String tno =  rs.getString("tno");
%>

	<tr>
		<td><%=tno%></td>
		<td><%=rs.getString("tname")%></td>
		<td><a href="update.jsp?tno=<%=tno%>">修改信息</a>&nbsp;|&nbsp;<a href="reset.jsp?tno=<%=tno%>">重置密码</a></td>
		<td><input type=checkbox name="delId" value="<%=tno%>" ></td>
		
	</tr>
	
	

<%	
		}
		sta.close();
		dbc.close();
	}
	catch(Exception e)
	{}
%>

</table>
<input type="submit" value="删除选定"/>
</form>

<br>
<br>
<a href="add.jsp">添加数据</a>

<%
}
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生管理</title>
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

【学生管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="delete.jsp">
	<table border=1 >
	<tr>
		<td>班号</td>
		<td>学号</td>
		<td>姓名</td>
		<td>修改</td>
		<td>删除</td>
		
	</tr>
	
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from student order by classno, sno");
		ResultSet rs = sta.executeQuery();
	
		while(rs.next())
		{
			String sno =  rs.getString("sno");
%>

	<tr>
		<td><%=rs.getString("classno")%></td>
		<td><%=sno%></td>
		<td><%=rs.getString("sname")%></td>
		<td><a href="update.jsp?sno=<%=sno%>">修改信息</a>&nbsp;|&nbsp;<a href="reset.jsp?sno=<%=sno%>">重置密码</a></td>
		<td><input type=checkbox name="delId" value="<%=sno%>" ></td>
		
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
<br>
<br>
<br>
<a href="clearstu.jsp"><font color="#FF0000">*清理班级号失效的学生记录</font></a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分组管理</title>
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

【分组管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>

<table border=1 >
	<tr>
		<td>课程号</td>
		<td>课程名</td>
		<td>查看分组/修改分组</td>
		<td>分组</td>
	</tr>
	
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from course");
		ResultSet rs = sta.executeQuery();
	
		while(rs.next())
		{
			String cno =  rs.getString("cno");
			String cname =  rs.getString("cname");
%>

	<tr>
		<td><%=cno%></td>
		<td><%=cname%></td>
<%
			String exam = "";
			PreparedStatement sta1 = dbc.getConnection().prepareStatement("select * from exam where cno='"+cno+"'");
			ResultSet rs1 = sta1.executeQuery();
			while(rs1.next())
			{
				String eid = rs1.getString("eid");
				String eno =  rs1.getString("eno");
				String ename =  rs1.getString("ename");
				exam+= "<a href=\"view.jsp?eid="+eid+"&cno="+cno+"&cname="+cname+"&eno="+eno+"&ename="+ename+"&teamno=1\">第"+eno+"次考核："+ename+"</a><br>";
			}
			sta1.close();
%>
		<td><%=exam%></td>
		<td><a href="auto.jsp?cno=<%=cno %>&cname=<%=cname %>">自动分组</a></td>
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
<br>
<br>
<a href="../course/index.jsp">课程管理/考核管理</a>
<br>
<br>
<a href="../grade/index.jsp">成绩管理</a>
<%
}
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程管理</title>
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

【课程管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="delete.jsp">
	<table border=1 >
	<tr>
		<td width="60">课程号</td>
		<td width="80">课程名</td>
		<td width="250">教学任务</td>
		<td width="80">授课教师</td>
		<td width="80">修改</td>
		<td width="50">删除</td>
		
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
		<td><%=rs.getString("cdescribe")%></td>
		<td><%=rs.getString("tno")%></td>
		<td><a href="update.jsp?cno=<%=cno%>">修改信息</a><br><br><a href="exam/index.jsp?cno=<%=cno%>&cname=<%=cname%>">考核设置</a><br><br><a href="stucourse/index.jsp?cno=<%=cno%>&cname=<%=cname%>">选课学生</a></td>
		<td><input type=checkbox name="delId" value="<%=cno%>" ></td>
		
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
<a href="clearteacher.jsp"><font color="#FF0000">*清理教师号失效的课程记录</font></a>
<br>
<br>
<a href="clearexam.jsp"><font color="#FF0000">*清理课程信息失效的考核记录</font></a>
<br>
<br>
<a href="clearsc.jsp"><font color="#FF0000">*清理课程信息失效的选课记录</font></a>
<br>
<br>
<a href="clearstu.jsp"><font color="#FF0000">*清理学生信息失效的选课记录</font></a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

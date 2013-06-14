<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成绩管理</title>
</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<1)		
	{
%>
	没有权限！<br>请重新<a href="../login.jsp">登录</a>.
<%
}
else
{
	String entry = new String(request.getParameter("entry").getBytes("ISO-8859-1"),"UTF-8");
	String sql = null;
%>

【成绩管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>

<table border=1 >
	<tr>
		<td>课程号</td>
		<td>课程名</td>
		<td>录入考核成绩</td>
		<td>查看总成绩</td>
	</tr>
	
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		if(Integer.parseInt(session.getAttribute("type").toString())>2) sql = "select * from course";
		else sql = "select course.* from course,stucourse where course.cno=stucourse.cno and sno='"+session.getAttribute("userno").toString()+"' and type>0";
		PreparedStatement sta = dbc.getConnection().prepareStatement(sql);
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
			PreparedStatement sta1 = dbc.getConnection().prepareStatement("select * from exam where cno='"+cno+"' and available=1");
			ResultSet rs1 = sta1.executeQuery();
			while(rs1.next())
			{
				String eid = rs1.getString("eid");
				String eno =  rs1.getString("eno");
				String ename =  rs1.getString("ename");
				exam+= "<a href=\"add.jsp?entry="+entry+"&eid="+eid+"&cno="+cno+"&cname="+cname+"&eno="+eno+"\">第"+eno+"次考核："+ename+"</a><br>";
			}
			sta1.close();
%>
		<td><%=exam%></td>
		<td><a href="view.jsp?cno=<%=cno %>&cname=<%=cname %>&sort=class">点击查看</a></td>
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
<br>
<a href="cleargrade.jsp"><font color="#FF0000">*清理学生或考核失效的成绩记录</font></a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

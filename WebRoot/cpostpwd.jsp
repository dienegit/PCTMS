<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="oMD5" scope="session" class="com.course.encoder.MD5"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
</head>
<body>
<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<1)		
	{
%>
	没有权限！<br>请重新<a href="login.jsp">登录</a>.
<%
}
else
{
%>

<%
	String old = oMD5.getMD5ofStr(request.getParameter("old"));
	String password = oMD5.getMD5ofStr(request.getParameter("new2"));
	String sno = (String)session.getAttribute("userno");
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from student where sno=? and spassword=?");
		sta.setString(1,sno);
		sta.setString(2,old);
		ResultSet rs = sta.executeQuery();
		if(!rs.next())
		{
%>
	原密码输入错误！<br>请<a href="cpwd.jsp">返回</a>.
<%
		}
		else
		{
			PreparedStatement sta1 = dbc.getConnection().prepareStatement("update student set spassword=? where sno=?");
			sta1.setString(1,password);
			sta1.setString(2,sno);
			sta1.execute();
			sta1.close();
			dbc.close();
%>
	密码修改成功！<br>
	<a href="logout.jsp">用新密码登录</a>
<%
		}
	}
	catch(Exception e)
	{}
}
%>
</body>
</html>

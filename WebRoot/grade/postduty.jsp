<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组员管理</title>
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
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String entry = new String(request.getParameter("entry").getBytes("ISO-8859-1"),"UTF-8");

	try
	{
		String[] checkerSet = request.getParameterValues("checker");
		String[] gnoSet = request.getParameterValues("gno");
		String[] checkSet = request.getParameterValues("checkId");
		int checked = 0;
		DataBaseConnection dbc = new DataBaseConnection();
		for(int i=0;i<gnoSet.length;i++)
		{
			PreparedStatement sta = dbc.getConnection().prepareStatement("update grade set duty=?,checked=? where gno=?");
			sta.setString(1,checkerSet[i]);
			checked = 0;
			if(checkSet!=null)
			for(int j=0;j<checkSet.length;j++)
			{
					if(gnoSet[i].equals(checkSet[j])) checked = 1;
			}
			sta.setInt(2,checked);
			sta.setString(3,gnoSet[i]);
			sta.execute();
			sta.close();
		}
		dbc.close();
	}
	catch(Exception e)
	{}
%>
	
	负责人和确认信息成功提交！
	<br>
	<a href="index.jsp?entry=<%=entry %>">返回查看</a>
<%
}
%>
</body>
</html>

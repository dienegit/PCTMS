<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选课学生</title>
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

	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
%>
	
	您将下列学生添加到了<%=cno %>《<%=cname %>》：
	<%
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("insert into stucourse(sno,cno) values(?,'"+cno+"')");
			
			String[] addstuIdSet = request.getParameterValues("addstuId");	
			
			for(int i=0;i<addstuIdSet.length;i++)
			{
			%>
				<%=addstuIdSet[i]%>&nbsp;&nbsp;
			<%
			sta.setString(1,addstuIdSet[i]);
			sta.execute();
			}
			
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
	%>
	
	<br>
	<a href="index.jsp?cno=<%=cno%>&cname=<%=cname %>">返回查看</a>
<%
}
%>
</body>
</html>

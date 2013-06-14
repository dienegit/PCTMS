<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加本组学生</title>
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
	String eid = new String(request.getParameter("eid").getBytes("ISO-8859-1"),"UTF-8");
	String eno = new String(request.getParameter("eno").getBytes("ISO-8859-1"),"UTF-8");
	String ename = new String(request.getParameter("ename").getBytes("ISO-8859-1"),"UTF-8");
	String teamno = new String(request.getParameter("teamno").getBytes("ISO-8859-1"),"UTF-8");
	int sum = 0;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("update stucourse set type=? where scid=?");
		String[] addstuIdSet = request.getParameterValues("addstuId");	

		for(int i=0;i<addstuIdSet.length;i++)
		{
			sta.setString(1,request.getParameter(addstuIdSet[i]));
			sta.setString(2,addstuIdSet[i]);
			sta.execute();
			sum++;
		}
		sta.close();
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("update grade set teamno="+teamno+" where scid=? and eid="+eid);
		for(int i=0;i<addstuIdSet.length;i++)
		{
			sta1.setString(1,addstuIdSet[i]);
			sta1.execute();
		}
		sta1.close();
		
		dbc.close();
	}
	catch(Exception e)
	{}
	%>
	
	您添加了本组<%=sum %>名学生！
	<br>
	<a href="view.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>&ename=<%=ename %>&teamno=<%=teamno %>">返回查看</a>
<%
}
%>
</body>
</html>

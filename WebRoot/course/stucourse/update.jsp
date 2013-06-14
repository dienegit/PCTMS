<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更新选课学生</title>
</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<3)		
	{
%>
	没有权限！<br>请重新<a href="../../login.jsp">登录</a>.
<%
}
else
{
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	int sum = 0;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("update stucourse set type=? where scid=?");
		String[] allIdSet = request.getParameterValues("allId");
		String[] typeSet = request.getParameterValues("type");
		String[] delIdSet = request.getParameterValues("delId");
		for(int i=0;i<allIdSet.length;i++)
		{
			sta.setString(1,typeSet[i]);
			sta.setString(2,allIdSet[i]);
			sta.execute();
		}
		sta.close();
		
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("delete from stucourse where scid=?");
		if(request.getParameterValues("delId")!=null)
		for(int i=0;i<delIdSet.length;i++)
		{
			sta1.setString(1,delIdSet[i]);
			sta1.execute();
			sum++;
		}
		sta1.close();
		
		dbc.close();
%>
	
	成功保存了选课学生身份信息，并删除了<%=sum %>名选<%=cno%>《<%=cname %>》课的学生！
	<br>
	<a href="index.jsp?cno=<%=cno%>&cname=<%=cname %>">返回查看</a>
<%
	}
	catch(Exception e)
	{}

}
%>
</body>
</html>

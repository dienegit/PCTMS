<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="log" scope="page" class="com.course.data.WriteLog"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>录入成绩</title>
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
	int checked = 0;
	if(Integer.parseInt(session.getAttribute("type").toString())>2) checked = 1;
	int exam = Integer.parseInt(request.getParameter("exam"));

	try
	{
		String[] gradeSet = request.getParameterValues("grade");
		String[] gnoSet = request.getParameterValues("gno");
		DataBaseConnection dbc = new DataBaseConnection();
		int m = 0;
		for(int i=0;i<gnoSet.length;i++)
		{
			for(int j=1;j<=exam;j++)
			{
				PreparedStatement sta = dbc.getConnection().prepareStatement("update grade set eg"+j+"=?,checked="+checked+" where gno=?");
				sta.setString(1,gradeSet[m]);
				sta.setString(2,gnoSet[i]);
				log.setPath(application.getRealPath("/logs"));
				log.setLog("> "+ session.getAttribute("userno") + "; type: " + session.getAttribute("type") + "; update grade set eg"+j+"="+gradeSet[m]+",checked="+checked+" where gno="+gnoSet[i]);
				log.writeFile();
				m++;
				sta.execute();
				sta.close();
			}
		}
		dbc.close();
	}
	catch(Exception e)
	{}
	%>
	
	成绩成功录入！
	<br>
	<a href="index.jsp?entry=<%=entry %>">返回查看</a>
<%
}
%>
</body>
</html>

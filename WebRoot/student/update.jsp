<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改学生</title>
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

<%
	String sno = new String(request.getParameter("sno").getBytes("ISO-8859-1"),"UTF-8");
	String sname=null;
	String classno=null;
	try
		{
			
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from student where sno='"+sno+"'");
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				sname = rs.getString("sname");
				classno = rs.getString("classno");
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

【修改学生】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postupdate.jsp">
	学号：<input name="sno_new" type="text" onfocus=this.blur() value="<%=sno %>"/><br>
	姓名：<input name="sname_new" type="text" value="<%=sname %>"/><br>
	班级：<select name="classno_new" id="classno_new">
<%
	String classno_old=null;
	String classname=null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from class");
		ResultSet rs = sta.executeQuery();

    	while(rs.next())
    	{
    		classno_old=rs.getString("classno");
			classname=rs.getString("classname");
%>
    <option value="<%=classno_old %>" <%if(classno.equals(classno_old)) out.println("selected=\"selected\""); %>><%=classname %></option>
<%
		}
		sta.close();
		dbc.close();
	}
	catch(Exception e)
	{}
%>
  	</select><br>
	<input type="submit" value="提交数据"/>
</form>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

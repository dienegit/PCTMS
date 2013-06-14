<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改课程</title>
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
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname=null;
	String cdescribe=null;
	String tno=null;
	try
		{
			
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from course where cno='"+cno+"'");
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				cname = rs.getString("cname");
				cdescribe = rs.getString("cdescribe");
				tno = rs.getString("tno");
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

【修改课程】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postupdate.jsp">
	课程号：<input name="cno_new" type="text" onfocus=this.blur() value="<%=cno %>"/><br>
	课程名：<input name="cname_new" type="text" value="<%=cname %>"/><br>
	教学任务：<textarea name="cdescribe_new" id="cdescribe_new"><%=cdescribe %></textarea><br>
	授课教师：<select name="tno_new" id="tno_new">
<%
	String tno_old=null;
	String tname=null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from teacher");
		ResultSet rs = sta.executeQuery();

    	while(rs.next())
    	{
    		tno_old=rs.getString("tno");
			tname=rs.getString("tname");
%>
    <option value="<%=tno_old %>" <%if(tno.equals(tno_old)) out.println("selected=\"selected\""); %>><%=tname %><%=tno_old %></option>
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

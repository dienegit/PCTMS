<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加课程</title>

<script language="javascript">
<!--
	function check(){
		if(form1.cno.value==""){
			alert("请输入课程号");
			form1.cno.focus();
			return false;
		}
		if(form1.cname.value==""){
			alert("请输入课程名");
			form1.cname.focus();
			return false;
		}
	}
-->
</script>

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

【添加课程】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="postadd.jsp" onSubmit="return check();">
	课程号：<input name="cno" type="text"/><br>
	课程名：<input name="cname" type="text"/><br>
	教学任务：<textarea name="cdescribe" id="cdescribe"></textarea><br>
	授课教师：<select name="tno" id="tno">
<%
	String tno=null;
	String tname=null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from teacher");
		ResultSet rs = sta.executeQuery();

    	while(rs.next())
    	{
    		tno=rs.getString("tno");
			tname=rs.getString("tname");
%>
    <option value="<%=tno %>"><%=tname %><%=tno %></option>
<%
		}
%>
  </select><br>
	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<%
		sta.close();
		dbc.close();
	}
	catch(Exception e)
	{}
}
%>
</body>
</html>

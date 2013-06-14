<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加学生</title>

<script language="javascript">
<!--
	function check(){
		if(form1.sno.value==""){
			alert("请输入学号");
			form1.sno.focus();
			return false;
		}
		if(form1.sname.value==""){
			alert("请输入姓名");
			form1.sname.focus();
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

【添加学生】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="postadd.jsp" onSubmit="return check();">
	学号：<input name="sno" type="text"/><br>
	姓名：<input name="sname" type="text"/><br>
	班级：<select name="classno" id="classno">
<%
	String classno=null;
	String classname=null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from class");
		ResultSet rs = sta.executeQuery();

    	while(rs.next())
    	{
    		classno=rs.getString("classno");
			classname=rs.getString("classname");
%>
    <option value="<%=classno %>"><%=classname %></option>
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

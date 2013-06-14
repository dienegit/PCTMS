<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加班级</title>

<script language="javascript">
<!--
	function check(){
		if(form1.classno.value==""){
			alert("请输入班号");
			form1.classno.focus();
			return false;
		}
		if(form1.classname.value==""){
			alert("请输入班级名");
			form1.classname.focus();
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

【添加班级】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="postadd.jsp" onSubmit="return check();">
	班号：<input name="classno" type="text"/><br>
	班级名：<input name="classname" type="text"/><br>
	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

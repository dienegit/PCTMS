<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加教师</title>

<script language="javascript">
<!--
	function check(){
		if(form1.tno.value==""){
			alert("请输入教师号");
			form1.tno.focus();
			return false;
		}
		if(form1.tname.value==""){
			alert("请输入教师名");
			form1.tname.focus();
			return false;
		}
	}
-->
</script>

</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())!=9)		
	{
%>
	没有权限！<br>先进行超级管理员<a href="../admin.jsp">验证</a>.<br>
	然后再重新进行操作！
<%
}
else
{
%>

【添加教师】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="postadd.jsp" onSubmit="return check();">
	教师号：<input name="tno" type="text"/><br>
	教师名：<input name="tname" type="text"/><br>
	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

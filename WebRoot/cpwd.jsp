<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>

<script language="javascript">
<!--
	function check(){
		if(form1.old.value==""){
			alert("请输入原密码");
			form1.old.focus();
			return false;
		}
			if(form1.new1.value==""){
			alert("请输入新密码");
			form1.new1.focus();
			return false;
		}
		if(form1.new1.value!=form1.new2.value){
			alert("两次新密码输入不匹配");
			form1.new1.focus();
			return false;
		}
	}
-->
</script>

</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<1)		
	{
%>
	没有权限！<br>请重新<a href="login.jsp">登录</a>.
<%
}
else
{
%>

【修改密码】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="cpostpwd.jsp" onSubmit="return check();">
	原密码：<input name="old" type="password"/><br>
	新密码：<input name="new1" type="password"/><br>
	确认输入：<input name="new2" type="password"/><br>
	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

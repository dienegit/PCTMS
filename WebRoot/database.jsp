<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据维护</title>

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
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())!=9)		
	{
%>
	没有权限！<br>先进行超级管理员<a href="admin.jsp">验证</a>.<br>
	然后再重新进行操作！
<%
}
else
{
%>

【修改超级管理员密码】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="apostpwd.jsp" onSubmit="return check();">
	原密码：<input name="old" type="password"/><br>
	新密码：<input name="new1" type="password"/><br>
	确认输入：<input name="new2" type="password"/><br>
	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<br>
<br>
<a href="student/clearstu.jsp"><font color="#FF0000">*清理班级号失效的学生记录</font></a>
<br>
<br>
<a href="course/clearteacher.jsp"><font color="#FF0000">*清理教师号失效的课程记录</font></a>
<br>
<br>
<a href="course/clearexam.jsp"><font color="#FF0000">*清理课程信息失效的考核记录</font></a>
<br>
<br>
<a href="course/clearsc.jsp"><font color="#FF0000">*清理课程信息失效的选课记录</font></a>
<br>
<br>
<a href="course/clearstu.jsp"><font color="#FF0000">*清理学生信息失效的选课记录</font></a>
<br>
<br>
<a href="grade/cleargrade.jsp"><font color="#FF0000">*清理学生或考核失效的成绩记录</font></a>

<%
}
%>
</body>
</html>

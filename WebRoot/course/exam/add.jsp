<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加考核</title>

<script language="javascript">
<!--
	function check(){
		if(form1.eno.value==""){
			alert("请输入考核次数");
			form1.eno.focus();
			return false;
		}
		if(form1.ename.value==""){
			alert("请输入考核名称");
			form1.ename.focus();
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
	没有权限！<br>请重新<a href="../../login.jsp">登录</a>.
<%
}
else
{
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
%>

【添加考核】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form name="form1" method="post" action="postadd.jsp" onSubmit="return check();">
	<input name="cno" type="hidden" value="<%=cno %>"/>
	<input name="cname" type="hidden" value="<%=cname %>"/>
	第<input name="eno" type="text" value="<%=Integer.parseInt(request.getParameter("eno")) %>"/>次考核<br>
	考核名称：<input name="ename" type="text"/><br>
	评分要求：<textarea name="edescribe" id="edescribe"></textarea><br>
	分数上限：<input name="emax" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点1：<input name="exam1" type="text"/>&nbsp;&nbsp;比例：<input name="exam1_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点2：<input name="exam2" type="text"/>&nbsp;&nbsp;比例：<input name="exam2_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点3：<input name="exam3" type="text"/>&nbsp;&nbsp;比例：<input name="exam3_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点4：<input name="exam4" type="text"/>&nbsp;&nbsp;比例：<input name="exam4_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点5：<input name="exam5" type="text"/>&nbsp;&nbsp;比例：<input name="exam5_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点6：<input name="exam6" type="text"/>&nbsp;&nbsp;比例：<input name="exam6_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点7：<input name="exam7" type="text"/>&nbsp;&nbsp;比例：<input name="exam7_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点8：<input name="exam8" type="text"/>&nbsp;&nbsp;比例：<input name="exam8_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点9：<input name="exam9" type="text"/>&nbsp;&nbsp;比例：<input name="exam9_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点10：<input name="exam10" type="text"/>&nbsp;&nbsp;比例：<input name="exam10_perc" type="text" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>

	<input type="submit" onClick="return check();" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

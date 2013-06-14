<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加本组学生</title>
<script type="text/javascript"> 
window.onload = function ()
{
	var oA = document.getElementsByTagName("a")[0];	
	var oInput = document.getElementsByTagName("input");
	var isCheckAll = function ()
	{
		for (var i = 1, n = 0; i < oInput.length; i++)
		{
			oInput[i].checked && n++	
		}
		oInput[0].checked = n == oInput.length - 1;
	};
	//全选/全不选
	oInput[0].onclick = function ()
	{
		for (var i = 1; i < oInput.length; i++)
		{
			oInput[i].checked = this.checked			
		}
		isCheckAll()
	};
	//反选
	oA.onclick = function ()
	{
		for (var i = 1; i < oInput.length; i++)
		{
			oInput[i].checked = !oInput[i].checked
		}
		isCheckAll()
	};
	//根据复选个数更新全选框状态
	for (var i = 1; i < oInput.length; i++)
	{
		oInput[i].onclick = function ()
		{
			isCheckAll()
		}	
	}	
}
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
	String eid = new String(request.getParameter("eid").getBytes("ISO-8859-1"),"UTF-8");
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String eno = new String(request.getParameter("eno").getBytes("ISO-8859-1"),"UTF-8");
	String ename = new String(request.getParameter("ename").getBytes("ISO-8859-1"),"UTF-8");
	String teamno = new String(request.getParameter("teamno").getBytes("ISO-8859-1"),"UTF-8");
%>

【添加本组学生】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postadd.jsp" method="post">
	<table border=1 >
	<tr>
		<td>班号</td>
		<td>学号</td>
		<td>姓名</td>
		<td>权限</td>
		<td>选择<br><input type="checkbox" id="checkAll" />全选/<a href="javascript:;">反选</a></td>
		
	</tr>
	
<%
	String type = null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select stucourse.scid,classno,student.sno,student.sname,type from stucourse,student,course,exam,grade where student.sno=stucourse.sno and course.cno=stucourse.cno and exam.cno=stucourse.cno and stucourse.scid=grade.scid and exam.eid=grade.eid and exam.cno='"+cno+"' and exam.eno="+eno+" and (teamno=0 or teamno is null) order by classno,student.sno");
		ResultSet rs = sta.executeQuery();
	
		while(rs.next())
		{
			if(rs.getInt("type")==2)
			{
				type = "陪审组长";
			}
			else if(rs.getInt("type")==1)
			{
				type = "陪审员";
			}
			else
			{
				type = "普通学生";
			}
			String scid =  rs.getString("scid");
%>

	<tr>
		<td><%=rs.getString("classno")%></td>
		<td><%=rs.getString("sno")%></td>
		<td><%=rs.getString("sname")%></td>
		<td><%=type %></td>
		<td><input type=checkbox name="addstuId" value="<%=scid %>" ></td>
		
	</tr>

<%	
		}
		sta.close();
		dbc.close();
	}
	catch(Exception e)
	{}
%>

	</table>
	<input name="cno" type="hidden" value="<%=cno %>"/>
	<input name="cname" type="hidden" value="<%=cname %>"/>
	<input name="eid" type="hidden" value="<%=eid %>"/>
	<input name="eno" type="hidden" value="<%=eno %>"/>
	<input name="ename" type="hidden" value="<%=ename %>"/>
	<input name="teamno" type="hidden" value="<%=teamno %>"/>
	<input type="submit" value="添加到本组"/>
</form>
<br>
<br>
<a href="../course/stucourse/index.jsp?cno=<%=cno%>&cname=<%=cname%>">选课学生</a>
<br>
<br>
<a href="../student/index.jsp">学生管理</a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>

<%
}
%>
</body>
</html>

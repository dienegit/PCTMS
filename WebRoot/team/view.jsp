<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看分组</title>
<script type="text/javascript"> 
window.onload = function ()
{
	var oA = document.getElementsByTagName("a")[1];	
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
	int maxteamno = 0;
	int next = Integer.parseInt(teamno)+1;
	int previous = Integer.parseInt(teamno)-1;
	int nexteno = 0;
	int previouseno = 0;
	int nexteid = 0;
	int previouseid = 0;
	String nextename = null;
	String previousename = null;
%>

【查看分组】（当前用户：<%=session.getAttribute("username") %>）<br><br>
课程<%=cno %>《<%=cname %>》<br>
第<%=eno %>次考核“<%=ename %>”（查看<a href="seat.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>&ename=<%=ename %>&teamno=<%=teamno %>">座位表</a>）<br>
第<%=teamno %>组的学生有：<br><br>
<form action="delete.jsp">
<table border=1 >
	<tr>
		<td>班号</td>
		<td>学号</td>
		<td>姓名</td>
		<td>身份</td>
		<td>删除<br><input type="checkbox" id="checkAll" />全选/<a href="javascript:;">反选</a></td>
	</tr>
	
<%
	String type = null;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select stucourse.scid,classno,student.sno,student.sname,stucourse.type from stucourse,student,course,exam,grade where student.sno=stucourse.sno and course.cno=stucourse.cno and exam.cno=stucourse.cno and stucourse.scid=grade.scid and exam.eid=grade.eid and exam.cno='"+cno+"' and exam.eno="+eno+" and teamno="+teamno+" order by stucourse.type desc,student.sno");
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
%>

	<tr>
		<td><%=rs.getString("classno")%></td>
		<td><%=rs.getString("sno")%></td>
		<td><%=rs.getString("sname")%></td>
		<td><%=type %></td>
		<td><input type=checkbox name="delId" value="<%=rs.getString("scid")%>" ></td>
	</tr>
	
<%	
		}
		sta.close();
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("select max(teamno) as maxteamno from grade,stucourse where grade.scid=stucourse.scid and cno='"+cno+"' and teamno is not null");
		ResultSet rs1 = sta1.executeQuery();
		rs1.next();
		maxteamno = rs1.getInt("maxteamno");
		sta1.close();
		
		PreparedStatement sta2 = dbc.getConnection().prepareStatement("select eid,eno,ename from exam where cno='"+cno+"'");
		ResultSet rs2 = sta2.executeQuery();
		while(rs2.next())
		{
			if(rs2.getInt("eid")==Integer.parseInt(eid)) break;
			previouseid = rs2.getInt("eid");
			previouseno = rs2.getInt("eno");
			previousename = rs2.getString("ename");
		}
		rs2.next();
		nexteid = rs2.getInt("eid");
		nexteno = rs2.getInt("eno");
		nextename = rs2.getString("ename");
		sta2.close();
		
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
<input type="submit" value="删除选定"/>
</form>

<br>
<br>
<table width="200" border="0" cellspacing="0">
  <tr>
    <td width="100">
<%
	if(Integer.parseInt(teamno)>1) out.println("<a href=\"view.jsp?eid="+eid+"&cno="+cno+"&cname="+cname+"&eno="+eno+"&ename="+ename+"&teamno="+previous+"\">上一组</a>");
%>
	</td>
    <td width="100">
<%
	if(Integer.parseInt(teamno)<maxteamno) out.println("<a href=\"view.jsp?eid="+eid+"&cno="+cno+"&cname="+cname+"&eno="+eno+"&ename="+ename+"&teamno="+next+"\">下一组</a>");
%>
	</td>
  </tr>
  <tr>
    <td width="100">&nbsp;</td>
    <td width="100">&nbsp;</td>
  </tr>
  <tr>
    <td width="100">
<%
	if(previouseid!=0) out.println("<a href=\"view.jsp?eid="+previouseid+"&cno="+cno+"&cname="+cname+"&eno="+previouseno+"&ename="+previousename+"&teamno="+teamno+"\">上一考核</a>");
%>
	</td>
    <td width="100">
<%
	if(nexteid!=0) out.println("<a href=\"view.jsp?eid="+nexteid+"&cno="+cno+"&cname="+cname+"&eno="+nexteno+"&ename="+nextename+"&teamno="+teamno+"\">下一考核</a>");
%>
	</td>
  </tr>
</table>

<br>
<br>
<a href="add.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>&ename=<%=ename %>&teamno=<%=teamno %>">添加本组学生</a>
<br>
<br>
<a href="view.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>&ename=<%=ename %>&teamno=<%=maxteamno+1 %>">创建新组</a>
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

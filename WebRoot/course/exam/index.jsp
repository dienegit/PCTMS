<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考核设置</title>
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
	int eid = 0;
	int eno = 0;
%>
【考核设置】（当前用户：<%=session.getAttribute("username") %>）<br><br>

<table border=1 >
	<tr>
	  <td colspan="3"><p align="center"><%=cno %>《<%=cname %>》</p></td>
	</tr>
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select * from exam where cno='"+cno+"'");
		ResultSet rs = sta.executeQuery();
	
		while(rs.next())
		{
			eno =  rs.getInt("eno");
			eid = rs.getInt("eid");
%>

	<tr>
      <td rowspan="5" width="250"><p>第<%=eno%>次考核：<%=rs.getString("ename")%><br>
      <%if(rs.getInt("available")==-1) out.println("（已禁用）");%></p>
      <p>
      <%if(rs.getString("edescribe")!=null) out.println("评分要求："+rs.getString("edescribe")+"<br>");%>
      <%if(rs.getFloat("emax")!=0) out.println("分数上限为"+rs.getString("emax")+"分");%>
      </p>
      <p>
      <a href="available.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&available=<%=rs.getInt("available") %>"><%if(rs.getInt("available")==-1) out.print("启用"); else out.print("禁用");%></a>&nbsp;&nbsp;
      <a href="update.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>">修改</a>&nbsp;&nbsp;
      <a href="delete.jsp?eid=<%=eid %>&cno=<%=cno %>&cname=<%=cname %>&eno=<%=eno %>">删除</a></p></td>
      <td>考查点1：<%if(rs.getFloat("exam1_perc")!=0) out.println(rs.getString("exam1")+"*"+rs.getString("exam1_perc"));%></td>
      <td>考查点2：<%if(rs.getFloat("exam2_perc")!=0) out.println(rs.getString("exam2")+"*"+rs.getString("exam2_perc"));%></td>
    </tr>
    <tr>
      <td>考查点3：<%if(rs.getFloat("exam3_perc")!=0) out.println(rs.getString("exam3")+"*"+rs.getString("exam3_perc"));%></td>
      <td>考查点4：<%if(rs.getFloat("exam4_perc")!=0) out.println(rs.getString("exam4")+"*"+rs.getString("exam4_perc"));%></td>
    </tr>
    <tr>
      <td>考查点5：<%if(rs.getFloat("exam5_perc")!=0) out.println(rs.getString("exam5")+"*"+rs.getString("exam5_perc"));%></td>
      <td>考查点6：<%if(rs.getFloat("exam6_perc")!=0) out.println(rs.getString("exam6")+"*"+rs.getString("exam6_perc"));%></td>
    </tr>
    <tr>
      <td>考查点7：<%if(rs.getFloat("exam7_perc")!=0) out.println(rs.getString("exam7")+"*"+rs.getString("exam7_perc"));%></td>
      <td>考查点8：<%if(rs.getFloat("exam8_perc")!=0) out.println(rs.getString("exam8")+"*"+rs.getString("exam8_perc"));%></td>
    </tr>
    <tr>
      <td>考查点9：<%if(rs.getFloat("exam9_perc")!=0) out.println(rs.getString("exam9")+"*"+rs.getString("exam9_perc"));%></td>
      <td>考查点10：<%if(rs.getFloat("exam10_perc")!=0) out.println(rs.getString("exam10")+"*"+rs.getString("exam10_perc"));%></td>
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

<br>
<br>
<a href="add.jsp?cno=<%=cno %>&cname=<%=cname %>&eno=<%=++eno %>">添加数据</a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

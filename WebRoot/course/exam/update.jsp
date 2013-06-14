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
%>

<%
	int eid = Integer.parseInt(request.getParameter("eid"));
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String edescribe = null;
	float emax = 0;
	String ename = null;
	String exam1 = null;
	float exam1_perc =0; 
	String exam2 = null;
	float exam2_perc =0; 
	String exam3 = null;
	float exam3_perc =0; 
	String exam4 = null;
	float exam4_perc =0; 
	String exam5 = null;
	float exam5_perc =0; 
	String exam6 = null;
	float exam6_perc =0; 
	String exam7 = null;
	float exam7_perc =0; 
	String exam8 = null;
	float exam8_perc =0; 
	String exam9 = null;
	float exam9_perc =0; 
	String exam10 = null;
	float exam10_perc =0; 

	try
		{
			
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from exam where eid="+eid);
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				edescribe = rs.getString("edescribe");
				emax = rs.getFloat("emax");
				ename = rs.getString("ename");
				exam1 = rs.getString("exam1");
				exam1_perc = rs.getFloat("exam1_perc");
				exam2 = rs.getString("exam2");
				exam2_perc = rs.getFloat("exam2_perc");
				exam3 = rs.getString("exam3");
				exam3_perc = rs.getFloat("exam3_perc");
				exam4 = rs.getString("exam4");
				exam4_perc = rs.getFloat("exam4_perc");
				exam5 = rs.getString("exam5");
				exam5_perc = rs.getFloat("exam5_perc");
				exam6 = rs.getString("exam6");
				exam6_perc = rs.getFloat("exam6_perc");
				exam7 = rs.getString("exam7");
				exam7_perc = rs.getFloat("exam7_perc");
				exam8 = rs.getString("exam8");
				exam8_perc = rs.getFloat("exam8_perc");
				exam9 = rs.getString("exam9");
				exam9_perc = rs.getFloat("exam9_perc");
				exam10 = rs.getString("exam10");
				exam10_perc = rs.getFloat("exam10_perc");

			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>

【考核设置】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<form action="postupdate.jsp" method="post">
	<input name="eid" type="hidden" value="<%=eid %>"/>
	<input name="cno" type="hidden" value="<%=cno %>"/>
	<input name="cname" type="hidden" value="<%=cname %>"/>
	第<input name="eno" type="text" value="<%=Integer.parseInt(request.getParameter("eno")) %>"/>次考核<br>
	考核名称：<input name="ename" type="text" value="<%=ename %>"/><br>
	评分要求：<textarea name="edescribe" id="edescribe"><%=edescribe %></textarea><br>
	分数上限：<input name="emax" type="text" value="<%=emax %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点1：<input name="exam1" type="text" value="<%=exam1 %>"/>&nbsp;&nbsp;比例：<input name="exam1_perc" type="text" value="<%=exam1_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点2：<input name="exam2" type="text" value="<%=exam2 %>"/>&nbsp;&nbsp;比例：<input name="exam2_perc" type="text" value="<%=exam2_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点3：<input name="exam3" type="text" value="<%=exam3 %>"/>&nbsp;&nbsp;比例：<input name="exam3_perc" type="text" value="<%=exam3_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点4：<input name="exam4" type="text" value="<%=exam4 %>"/>&nbsp;&nbsp;比例：<input name="exam4_perc" type="text" value="<%=exam4_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点5：<input name="exam5" type="text" value="<%=exam5 %>"/>&nbsp;&nbsp;比例：<input name="exam5_perc" type="text" value="<%=exam5_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点6：<input name="exam6" type="text" value="<%=exam6 %>"/>&nbsp;&nbsp;比例：<input name="exam6_perc" type="text" value="<%=exam6_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点7：<input name="exam7" type="text" value="<%=exam7 %>"/>&nbsp;&nbsp;比例：<input name="exam7_perc" type="text" value="<%=exam7_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点8：<input name="exam8" type="text" value="<%=exam8 %>"/>&nbsp;&nbsp;比例：<input name="exam8_perc" type="text" value="<%=exam8_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点9：<input name="exam9" type="text" value="<%=exam9 %>"/>&nbsp;&nbsp;比例：<input name="exam9_perc" type="text" value="<%=exam9_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>
	考查点10：<input name="exam10" type="text" value="<%=exam10 %>"/>&nbsp;&nbsp;比例：<input name="exam10_perc" type="text" value="<%=exam10_perc %>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/><br>

	<input type="submit" value="提交数据"/>
</form>
<%
}
%>
</body>
</html>

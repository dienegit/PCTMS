<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改考核</title>
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

	String eid = new String(request.getParameter("eid").getBytes("ISO-8859-1"),"UTF-8");
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String eno = new String(request.getParameter("eno").getBytes("ISO-8859-1"),"UTF-8");
	String edescribe = new String(request.getParameter("edescribe").getBytes("ISO-8859-1"),"UTF-8");
	String emax = new String(request.getParameter("emax").getBytes("ISO-8859-1"),"UTF-8");
	String ename = new String(request.getParameter("ename").getBytes("ISO-8859-1"),"UTF-8");
	String exam1 = new String(request.getParameter("exam1").getBytes("ISO-8859-1"),"UTF-8");
	String exam1_perc = new String(request.getParameter("exam1_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam2 = new String(request.getParameter("exam2").getBytes("ISO-8859-1"),"UTF-8");
	String exam2_perc = new String(request.getParameter("exam2_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam3 = new String(request.getParameter("exam3").getBytes("ISO-8859-1"),"UTF-8");
	String exam3_perc = new String(request.getParameter("exam3_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam4 = new String(request.getParameter("exam4").getBytes("ISO-8859-1"),"UTF-8");
	String exam4_perc = new String(request.getParameter("exam4_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam5 = new String(request.getParameter("exam5").getBytes("ISO-8859-1"),"UTF-8");
	String exam5_perc = new String(request.getParameter("exam5_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam6 = new String(request.getParameter("exam6").getBytes("ISO-8859-1"),"UTF-8");
	String exam6_perc = new String(request.getParameter("exam6_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam7 = new String(request.getParameter("exam7").getBytes("ISO-8859-1"),"UTF-8");
	String exam7_perc = new String(request.getParameter("exam7_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam8 = new String(request.getParameter("exam8").getBytes("ISO-8859-1"),"UTF-8");
	String exam8_perc = new String(request.getParameter("exam8_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam9 = new String(request.getParameter("exam9").getBytes("ISO-8859-1"),"UTF-8");
	String exam9_perc = new String(request.getParameter("exam9_perc").getBytes("ISO-8859-1"),"UTF-8");
	String exam10 = new String(request.getParameter("exam10").getBytes("ISO-8859-1"),"UTF-8");
	String exam10_perc = new String(request.getParameter("exam10_perc").getBytes("ISO-8859-1"),"UTF-8");
	
%>

您刚才更新了下列信息：<br>
	第<%=eno %>次考核：<%=ename %><br>
	评分要求：<%=edescribe %><br>
	分数上限：<%=emax %><br>
	考查点1：<%=exam1 %>*<%if(exam1_perc!="0.0") out.println(exam1_perc); %><br>
	考查点2：<%=exam2 %>*<%if(exam2_perc!="0.0") out.println(exam2_perc); %><br>
	考查点3：<%=exam3 %>*<%if(exam3_perc!="0.0") out.println(exam3_perc); %><br>
	考查点4：<%=exam4 %>*<%if(exam4_perc!="0.0") out.println(exam4_perc); %><br>
	考查点5：<%=exam5 %>*<%if(exam5_perc!="0.0") out.println(exam5_perc); %><br>
	考查点6：<%=exam6 %>*<%if(exam6_perc!="0.0") out.println(exam6_perc); %><br>
	考查点7：<%=exam7 %>*<%if(exam7_perc!="0.0") out.println(exam7_perc); %><br>
	考查点8：<%=exam8 %>*<%if(exam8_perc!="0.0") out.println(exam8_perc); %><br>
	考查点9：<%=exam9 %>*<%if(exam9_perc!="0.0") out.println(exam9_perc); %><br>
	考查点10：<%=exam10 %>*<%if(exam10_perc!="0.0") out.println(exam10_perc); %><br>
	
<%
	try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("update exam set eno=?,edescribe=?,emax=?,ename=?,exam1=?,exam1_perc=?,exam2=?,exam2_perc=?,exam3=?,exam3_perc=?,exam4=?,exam4_perc=?,exam5=?,exam5_perc=?,exam6=?,exam6_perc=?,exam7=?,exam7_perc=?,exam8=?,exam8_perc=?,exam9=?,exam9_perc=?,exam10=?,exam10_perc=? where eid="+eid);
			sta.setString(1,eno);
			sta.setString(2,edescribe);
			sta.setString(3,emax);
			sta.setString(4,ename);
			sta.setString(5,exam1);
			sta.setString(6,exam1_perc);
			sta.setString(7,exam2);
			sta.setString(8,exam2_perc);
			sta.setString(9,exam3);
			sta.setString(10,exam3_perc);
			sta.setString(11,exam4);
			sta.setString(12,exam4_perc);
			sta.setString(13,exam5);
			sta.setString(14,exam5_perc);
			sta.setString(15,exam6);
			sta.setString(16,exam6_perc);
			sta.setString(17,exam7);
			sta.setString(18,exam7_perc);
			sta.setString(19,exam8);
			sta.setString(20,exam8_perc);
			sta.setString(21,exam9);
			sta.setString(22,exam9_perc);
			sta.setString(23,exam10);
			sta.setString(24,exam10_perc);
			sta.execute();
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
%>
	<br>
	<a href="index.jsp?cno=<%=cno %>&cname=<%=cname %>">返回查看</a>
<%
}
%>
</body>
</html>

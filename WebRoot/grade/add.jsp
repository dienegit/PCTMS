<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>录入成绩</title>
</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<1)		
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
	String entry = new String(request.getParameter("entry").getBytes("ISO-8859-1"),"UTF-8");
	String sql = null;
	String edescribe = null;
	String emax = null;
	String type = null;
	int teamno = 0;
%>

【录入成绩】（当前用户：<%=session.getAttribute("username") %>）<br><br>
课程<%=cno %>《<%=cname %>》的第<%=eno %>次考核成绩：
<form action="postadd.jsp" method="post">
	<table border=1 >
	
<%
	int title = 0;
	int exam = 0;
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta0 = dbc.getConnection().prepareStatement("insert into grade(scid, eid) select scid,eid from stucourse,exam where scid not in (select scid from grade) or eid not in (select eid from grade)");
		sta0.execute();
		sta0.close();
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("select teamno from stucourse,student,exam,grade where student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and student.sno='"+session.getAttribute("userno").toString()+"' and stucourse.cno='"+cno+"' and grade.eid="+eid);
		ResultSet rs1 = sta1.executeQuery();
		while(rs1.next())
		{
			teamno = rs1.getInt("teamno");
		}
		sta1.close();
		
		//全体成绩入口查询
		if(entry.equals("all")) sql = "select type,checked,student.sno,student.sname,classno,exam.*,grade.* from stucourse,student,exam,grade where student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid+" order by classno,student.sno";
		//陪审成绩入口查询
		else if(entry.equals("checker")) sql = "select type,checked,student.sno,student.sname,classno,exam.*,grade.* from stucourse,student,exam,grade where type>0 and student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid+" order by classno,student.sno";
		//学生成绩入口查询
		else sql = "select type,checked,student.sno,student.sname,classno,exam.*,grade.* from stucourse,student,exam,grade where type=0 and teamno="+teamno+" and duty is not null and duty="+session.getAttribute("userno").toString()+" and student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid+" order by classno,student.sno";
		PreparedStatement sta = dbc.getConnection().prepareStatement(sql);
		ResultSet rs = sta.executeQuery();
%>
	<tr>
		<td>班号</td>
		<td>学号</td>
		<td>姓名</td>
		<td>身份</td>
<%
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
			edescribe = rs.getString("edescribe");
			emax = rs.getString("emax");
			String sno =  rs.getString("sno");
			int scid = rs.getInt("scid");
			
			for(int i=1;i<=10&&title==0;i++) 	//打印表头中的考核列
				if(rs.getFloat("exam"+i+"_perc")!=0)
				{
					out.println("<td>"+rs.getString("exam"+i)+"</td>");
					exam++;
				}
			title = 1;
%>
	</tr>
	<tr>
		<td><%=rs.getString("classno")%></td>
		<td><%=sno%><input name="gno" type="hidden" value="<%=rs.getString("gno") %>"/></td>
		<td><%=rs.getString("sname")%></td>
		<td><%=type%></td>
<%
			String grade = null;
			for(int j=1;j<=exam;j++)	//打印成绩
			{
				grade = rs.getString("eg"+j);
				if(grade==null)
				{
					grade = "0.0";
				}
				out.println("<td><input name=\"grade\" type=\"text\" value=\""+grade+"\" onkeyup=\"value=value.replace(/[^\\d\\.]/g,'')\"/></td>");
			}
%>
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

<%if(!(edescribe==null||edescribe.equals("")))out.println("<br>评分要求："+edescribe);%>
<%if(!(emax==null||emax.equals("")))out.println("<br>分数上限为"+emax+"分");%>

<input name="cno" type="hidden" value="<%=cno %>"/>
<input name="cname" type="hidden" value="<%=cname %>"/>
<input name="exam" type="hidden" value="<%=exam %>"/>
<input name="entry" type="hidden" value="<%=entry %>"/>
<br><br><input type="submit" value="保存成绩"/>
<%if(Integer.parseInt(session.getAttribute("type").toString())>2)out.println("<font color=\"#FF0000\">*请注意：您的身份是教师，保存的成绩即为最终成绩，无需确认！</font><br>");%>
</form>
<%
	if(Integer.parseInt(session.getAttribute("type").toString())==2)
	{
		out.println("<br><br><a href=\"duty.jsp?entry="+entry+"&eid="+eid+"&cno="+cno+"&cname="+cname+"&eno="+eno+"\">组员管理</a>");
	}
%>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

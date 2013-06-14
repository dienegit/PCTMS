<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组员管理</title>
</head>
<body>

<%
	Boolean isLogin = (Boolean)session.getAttribute("login");
	if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())!=2)		
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
	String emax = null;
	int teamno = 0;
	int row = 0;
%>

【组员管理】（当前用户：<%=session.getAttribute("username") %>）<br><br>
课程<%=cno %>《<%=cname %>》的第<%=eno %>次考核：
<form action="postduty.jsp" method="post">
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
		
		PreparedStatement sta2 = dbc.getConnection().prepareStatement("select count(student.sno) as stu from stucourse,student,exam,grade where type>0 and teamno="+teamno+" and student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid);
		ResultSet rs2 = sta2.executeQuery();
		while(rs2.next())
		{
			row = rs2.getInt("stu");
		}
		sta2.close();
		
		String [][] checkers =new String[row][2];
		
		PreparedStatement sta3 = dbc.getConnection().prepareStatement("select student.sno,student.sname from stucourse,student,exam,grade where type>0 and teamno="+teamno+" and student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid+" order by classno,student.sno");
		ResultSet rs3 = sta3.executeQuery();
		int i = 0;
		while(rs3.next())
		{
			checkers[i][0] = rs3.getString("sno");
			checkers[i][1] = rs3.getString("sname");
			i++;
		}
		sta3.close();

		PreparedStatement sta = dbc.getConnection().prepareStatement("select gno,student.sno,student.sname,classno,duty,checked,exam.*,grade.* from stucourse,student,exam,grade where type=0 and teamno="+teamno+" and student.sno=stucourse.sno and grade.scid=stucourse.scid and grade.eid=exam.eid and stucourse.cno='"+cno+"' and grade.eid="+eid+" order by classno,student.sno");
		ResultSet rs = sta.executeQuery();
%>
	<tr>
		<td>班号</td>
		<td>学号</td>
		<td>姓名</td>
		<td>负责人</td>
		<td>确认</td>
<%
		while(rs.next())
		{
			String sno =  rs.getString("sno");
			emax = rs.getString("emax");
			for(i=1;i<=10;i++)
				if(rs.getFloat("exam"+i+"_perc")!=0&&title==0)
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
		<!--陪审员-->
		<td>
			<select name="checker" id="checker">
<%
			for(i=0;i<checkers.length;i++)
			{
%>
		    <option value="<%=checkers[i][0] %>" <%if(checkers[i][0].equals(rs.getString("duty"))) out.println("selected=\"selected\""); %>><%=checkers[i][1] %></option>
<%
			}
%>
		</select>
		</td>
		<!--确认-->
		<td><input type=checkbox name="checkId" <%if(rs.getInt("checked")==1) out.println("checked=\"checked\"");%> value="<%=rs.getString("gno")%>" ></td>
<%
			String grade = null;
			for(int j=1;j<=exam;j++)
			{
				grade = rs.getString("eg"+j);
				if(grade==null)
				{
					grade = "0.0";
				}
				out.println("<td>"+grade+"</td>");
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

<input name="cno" type="hidden" value="<%=cno %>"/>
<input name="cname" type="hidden" value="<%=cname %>"/>
<input name="entry" type="hidden" value="<%=entry %>"/>
<input type="submit" value="提交数据"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value=刷新 onclick="location.reload()"> 
</form>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

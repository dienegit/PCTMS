<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>座位安排</title>
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
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String eid = new String(request.getParameter("eid").getBytes("ISO-8859-1"),"UTF-8");
	String eno = new String(request.getParameter("eno").getBytes("ISO-8859-1"),"UTF-8");
	String ename = new String(request.getParameter("ename").getBytes("ISO-8859-1"),"UTF-8");
	int scsum = Integer.parseInt(request.getParameter("scsum"));
	int maxrow = Integer.parseInt(request.getParameter("row"));
	int maxcol = Integer.parseInt(request.getParameter("col"));
	int row = 0;
	int col = 0;
	int flag = 1;
	String [][] seatTable =new String[maxrow][maxcol];
%>

【座位安排】（当前用户：<%=session.getAttribute("username") %>）<br><br>
课程<%=cno %>《<%=cname %>》共有<%=scsum %>名选课学生。
第<%=eno %>次考核“<%=ename %>”座位表：<br>
<%

	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select student.sno,sname,teamno,type from stucourse,student,course,exam,grade where student.sno=stucourse.sno and course.cno=stucourse.cno and exam.cno=stucourse.cno and stucourse.scid=grade.scid and exam.eid=grade.eid and exam.cno='"+cno+"' and exam.eno="+eid+" order by grade.teamno,stucourse.type desc,student.sno");
		ResultSet rs = sta.executeQuery();
		while(rs.next())
		{
			seatTable[row][col] = rs.getString("sno")+"("+rs.getString("teamno")+"组)<br>"+rs.getString("sname");
			//判断方向
			if(flag==1) col++;
			else col--;
			//判断换行
			if(col==maxcol)
			{
				col = maxcol-1;
				row++;
				flag*=-1;
			}
			if(col<0)
			{
				col = 0;
				row++;
				flag*=-1;
			}
			//表满则输出
			if(row==maxrow)
			{
				out.println("<table border=\"1\" cellspacing=\"0\">");
				for(int i=0;i<maxrow;i++)
				{
					out.println("<tr>");
					for(int j=0;j<maxcol;j++)
					{
						out.println("<td>"+seatTable[i][j]+"</td>");
					}
					out.println("</tr>");
				}
				out.println("</table><br><br>");
				row = 0;
			}
		}
		//表不满时输出
		if(scsum%(maxrow*maxcol)!=0)
		{
			while(row<maxrow)
			{
				while(col<maxcol&&col>=0)
				{
					seatTable[row][col] = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br>";
					if(flag==1) col++;
					else col--;
				}
				flag = 1;
				row++;
				col = 0;
			}
			
			out.println("<table border=\"1\" cellspacing=\"0\">");
			for(int i=0;i<maxrow;i++)
			{
				out.println("<tr>");
				for(int j=0;j<maxcol;j++)
				{
					out.println("<td>"+seatTable[i][j]+"</td>");
				}
				out.println("</tr>");
			}
			out.println("</table><br><br>");
		}

	}
	catch(Exception e)
	{}

%>
	<br>
	<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

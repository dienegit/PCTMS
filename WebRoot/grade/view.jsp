<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="xls" scope="session" class="com.course.xls.ExportExcel"/>
<jsp:useBean id="gsort" scope="session" class="com.course.data.GradeSort"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看成绩</title>

<script type="text/javascript">
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
function MM_jumpMenuGo(objId,targ,restore){ //v9.0
  var selObj = null;  with (document) { 
  if (getElementById) selObj = getElementById(objId);
  if (selObj) eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0; }
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
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	String sort = new String(request.getParameter("sort").getBytes("ISO-8859-1"),"UTF-8");
%>

【查看成绩】（当前用户：<%=session.getAttribute("username") %>）<br><br>
课程<%=cno %>《<%=cname %>》成绩单：<br><br>
	
<%
	int title = 0;
	int col = 0;
	int row = 0;
	try
	{

		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta00 = dbc.getConnection().prepareStatement("insert into grade(scid, eid) select scid,eid from stucourse,exam where scid not in (select scid from grade) or eid not in (select eid from grade)");
		sta00.execute();	//增加新成绩条目
		sta00.close();
		
		PreparedStatement sta01 = dbc.getConnection().prepareStatement("update grade set total=isnull(eg1,0)*exam1_perc+isnull(eg2,0)*exam2_perc+isnull(eg3,0)*exam3_perc+isnull(eg4,0)*exam4_perc+isnull(eg5,0)*exam5_perc+isnull(eg6,0)*exam6_perc+isnull(eg7,0)*exam7_perc+isnull(eg8,0)*exam8_perc+isnull(eg9,0)*exam9_perc+isnull(eg10,0)*exam10_perc from grade,exam where grade.eid=exam.eid");
		sta01.execute();	//更新成绩总分
		sta01.close();
		
		PreparedStatement sta02 = dbc.getConnection().prepareStatement("update grade set total=round(total,1)");
		sta02.execute();	//总分保留一位小数
		sta02.close();
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("select count(eno) as exam from exam where cno='"+cno+"'");
		ResultSet rs1 = sta1.executeQuery();	//查询考核数，确定列数
		while(rs1.next())
		{
			col = rs1.getInt("exam")+4;
		}
		sta1.close();
		
		PreparedStatement sta2 = dbc.getConnection().prepareStatement("select count(sno) as stu from stucourse where cno='"+cno+"'");
		ResultSet rs2 = sta2.executeQuery();	//查询学生数，确定行数
		while(rs2.next())
		{
			row = rs2.getInt("stu")+2;
		}
		sta2.close();
		
		String [][] gradeTable =new String[row][col];	//建立成绩数组
		gradeTable[0][0]="班号";
		gradeTable[0][1]="学号";
		gradeTable[0][2]="姓名";
		String [][] colorTable =new String[row][col];	//建立高亮数组
		for(int i=0;i<row;i++)
		{
			for(int j=0;j<col;j++)
			{
				colorTable[i][j] = "";
			}
		}
		
		PreparedStatement sta3 = dbc.getConnection().prepareStatement("select eno from exam where cno='"+cno+"'");
		ResultSet rs3 = sta3.executeQuery();	//成绩数组表头
		title=3;
		while(rs3.next())
		{
			gradeTable[0][title] = "考核"+rs3.getString("eno");
			title++;
		}
		sta3.close();
		gradeTable[0][title] = "总分";
		
		PreparedStatement sta5 = dbc.getConnection().prepareStatement("select classno,student.sno,student.sname,exam.eno,grade.total,emax,checked from stucourse,student,course,exam,grade where student.sno=stucourse.sno and course.cno=stucourse.cno and exam.cno=stucourse.cno and stucourse.scid=grade.scid and exam.eid=grade.eid and exam.cno='"+cno+"' order by classno,student.sno,exam.eno");
		ResultSet rs5 = sta5.executeQuery();	//成绩内容
		int i = 1;	//行
		float emax = 0;
		int j = 3;	//列
		while(rs5.next())
		{
			emax = 999;	//分数上限
			if(rs5.getString("emax")!=null) emax = rs5.getFloat("emax");
			gradeTable[i][0] = rs5.getString("classno");
			gradeTable[i][1] = rs5.getString("sno");
			gradeTable[i][2] = rs5.getString("sname");
			gradeTable[i][j] = rs5.getString("total");	//成绩数组内容
			if(rs5.getFloat("total")==0||rs5.getFloat("total")>emax) colorTable[i][j]=" bgcolor=\"#FFFF00\"";	//超出上限高亮数组记录
			if(rs5.getInt("checked")!=1) colorTable[i][j]=" bgcolor=\"#CCCCCC\"";	//未确认高亮数组记录
			j++;
			if(j+1==col)
			{
				j = 3;
				i++;
			}
		}
		sta5.close();
		
		for(i=1;i<row-1;i++)	//计算每行成绩总分
		{
			float sum = 0;
			for(j=3;j<col-1;j++)
			{
				sum+= Float.parseFloat(gradeTable[i][j]); 
			}
			gradeTable[i][col-1] = String.valueOf(sum);
		}
		
		for(i=3;i<col;i++)	//计算每列成绩平均分
		{
			float sum = 0;
			for(j=1;j<row-1;j++)
			{
				sum+= Float.parseFloat(gradeTable[j][i]); 
			}
			gradeTable[row-1][0]="";
			gradeTable[row-1][1]="";
			gradeTable[row-1][2]="平均分：";
			gradeTable[row-1][i] = String.valueOf((Math.round(sum/(row-2)*10))/10.0);
		}
%>

<form name="form" id="form">
排序：
  <select name="jumpMenu" id="jumpMenu" onChange="MM_jumpMenu('self',this,0)">
    <option value="view.jsp?cno=<%=cno %>&cname=<%=cname %>&sort=class" <%if(sort.equals("class")) out.println("selected=\"selected\""); %>>默认</option>
<%
		for(i = 3;i<gradeTable[0].length-1;i++)
		{
%>
	<option value="view.jsp?cno=<%=cno %>&cname=<%=cname %>&sort=<%=i %>" <%if(sort.equals(String.valueOf(i))) out.println("selected=\"selected\""); %>><%=gradeTable[0][i] %></option>
<%
		}
%>
    <option value="view.jsp?cno=<%=cno %>&cname=<%=cname %>&sort=sum" <%if(sort.equals("sum")) out.println("selected=\"selected\""); %>>总分</option>
  </select>
</form>

<table border=1 >

<%
		//调用bean写入excel
		xls.setTable(gradeTable);
		xls.setRow(row);
		xls.setCol(col);
		
		//实现排序
		if(!sort.equals("class")) {
			int sortcol = 0;
			if(sort.equals("sum")) sortcol = gradeTable[0].length-1;
			else if(Integer.parseInt(sort)>0) sortcol = Integer.parseInt(sort); 
			
			gsort.setGradetable(gradeTable);
			gsort.setColortable(colorTable);
			gsort.setCol(sortcol);
			gradeTable = gsort.newGradetable();
			colorTable = gsort.newColortable();
		}
		
		//打印数组
		for(i=0;i<row;i++)
		{
			out.println("<tr>");
			for(j=0;j<col;j++)
			{
				out.println("<td"+colorTable[i][j]+">"+gradeTable[i][j]+"</td>");
			}
			out.println("</tr>");
		}

		dbc.close();
	}
	catch(Exception e)
	{}
%>

</table>
<br>
<br>
*注1：黄色单元格表示可能存在异常的成绩记录<br>
*注2：灰色单元格表示成绩记录未经确认<br>
<br>
<br>
<a href="scores.jsp">导出报表</a>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>
<%
}
%>
</body>
</html>

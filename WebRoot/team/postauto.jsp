<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自动分组</title>
</head>
<body>

<%
Boolean isLogin = (Boolean)session.getAttribute("login");
int teamsum = Integer.parseInt(request.getParameter("teamsum"));
int checkersum = Integer.parseInt(request.getParameter("checkersum"));
int scsum = Integer.parseInt(request.getParameter("scsum"));
int esum = Integer.parseInt(request.getParameter("esum"));
if(isLogin==null||!isLogin||Integer.parseInt(session.getAttribute("type").toString())<3)
{
%>
	没有权限！<br>请重新<a href="../login.jsp">登录</a>.
<%
}
else if(scsum<teamsum*(checkersum+1))
{
%>
	您输入的组数或陪审组成员数太多！<br>请重新<a href="javascript:history.back(-1)">输入</a>.
<%
}
else
{
	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	int [] leaderno = new int[teamsum];
	int [] checkerno = new int[teamsum*(checkersum-1)];
	int [] studentno = new int[scsum-teamsum*checkersum];
	int [] alleid = new int[esum];
	
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta0 = dbc.getConnection().prepareStatement("insert into grade(scid, eid) select scid,eid from stucourse,exam where scid not in (select scid from grade) or eid not in (select eid from grade)");
		sta0.execute();
		sta0.close();

		String [] eidSet = request.getParameterValues("eid");	//将表单勾选的考核号添加到考核号数组
		String sql = "eid="+eidSet[0];
		for(int i=1;i<eidSet.length;i++)
		{
			sql+=" or eid="+eidSet[i]; 
		}
		
		PreparedStatement sta = dbc.getConnection().prepareStatement("select stucourse.scid,sno,sum(total) as total from stucourse,grade where stucourse.scid=grade.scid and cno='"+cno+"' and ("+sql+") group by sno,stucourse.scid order by total desc");
		ResultSet rs = sta.executeQuery();	//查询考核总成绩
		rs.next();
		leaderno[0] = rs.getInt("scid");	//将总成绩最高的学号添加到陪审组长数组
		String sql1 = "update stucourse set type=2 where cno='"+cno+"' and (sno='"+rs.getString("sno")+"'";
		for(int i=1;i<teamsum;i++)
		{
			rs.next();
			leaderno[i] = rs.getInt("scid");
			sql1+=" or sno='"+rs.getString("sno")+"'";
		}
		sql1+=")";	//生成SQL语句：将陪审组长数组内学生的身份改为陪审组长（2）
		
		rs.next();
		checkerno[0] = rs.getInt("scid");	//将总成绩次高的学号添加到陪审员数组
		String sql2 = "update stucourse set type=1 where cno='"+cno+"' and (sno='"+rs.getString("sno")+"'";
		for(int i=1;i<teamsum*(checkersum-1);i++)
		{
			rs.next();
			checkerno[i] = rs.getInt("scid");
			sql2+=" or sno='"+rs.getString("sno")+"'";
		}
		sql2+=")";	//生成SQL语句：将陪审员数组内学生的身份改为陪审员（1）
		
		rs.next();
		studentno[0] = rs.getInt("scid");	//将剩余学生的学号添加到普通学生数组
		String sql3 = "update stucourse set type=0 where cno='"+cno+"' and (sno='"+rs.getString("sno")+"'";
		int i = 1;
		while(rs.next())
		{
			studentno[i] = rs.getInt("scid");
			i++;
			sql3+=" or sno='"+rs.getString("sno")+"'";
		}
		sql3+=")";	//生成SQL语句：将普通学生数组内学生的身份改为普通学生（0）
		sta.close();
		
		PreparedStatement sta1 = dbc.getConnection().prepareStatement(sql1);
		sta1.execute();
		sta1.close();
		
		PreparedStatement sta2 = dbc.getConnection().prepareStatement(sql2);
		sta2.execute();
		sta2.close();
		
		PreparedStatement sta3 = dbc.getConnection().prepareStatement(sql3);
		sta3.execute();
		sta3.close();
				
		PreparedStatement sta4 = dbc.getConnection().prepareStatement("select eid from exam where cno='"+cno+"'");
		ResultSet rs4 = sta4.executeQuery();	//查询所有考核号
		i = 0;
		while(rs4.next())
		{
			alleid[i] = rs4.getInt("eid");
			i++;
		}
		sta4.close();
		
		PreparedStatement sta5 = dbc.getConnection().prepareStatement("update grade set teamno=? where scid=? and eid=?");
		int leader = 0;
		int checker = 0;
		int team = 1;
		for(int exam=0;exam<esum;exam++)	//为各考核写入组号
		{
			for(team=1;team<=teamsum;team++)	//从第一组开始
			{
				sta5.setInt(1,team);
				sta5.setInt(2,leaderno[leader%teamsum]);	//每组一名陪审组长
				sta5.setInt(3,alleid[exam]);
				sta5.addBatch();
				leader++;
				for(int checkerperteam=0;checkerperteam<checkersum-1;checkerperteam++)	//每组数名陪审员
				{
					sta5.setInt(1,team);
					sta5.setInt(2,checkerno[checker%(teamsum*(checkersum-1))]);
					sta5.setInt(3,alleid[exam]);
					sta5.addBatch();
					checker++;
				}
			}
			leader++;
			checker+=checkersum-1;
			team = 1;
			for(int stu=0;stu<studentno.length;stu++)	//每组数名普通学生
			{
				sta5.setInt(1,team);
				sta5.setInt(2,studentno[stu]);
				sta5.setInt(3,alleid[exam]);
				sta5.addBatch();
				team++;
				if(team>teamsum) team = 1;
			}
		}
		sta5.executeBatch();	//批量执行分组语句，分组完成
		sta5.close();
		
		dbc.close();
	}
	catch(Exception e)
	{
		System.out.println("分组出现异常！");
		System.out.println(e);
	}
%>

分组完成！<br>
<br>
<a href="index.jsp">返回查看</a>

<%
}
%>
</body>
</html>

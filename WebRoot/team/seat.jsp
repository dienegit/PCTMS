<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>座位安排</title>

<script language="javascript">
<!--
	function check(){
		if(form1.row.value==""||form1.row.value<1){
			alert("教室排数应不小于1");
			form1.row.focus();
			return false;
		}
		if(form1.col.value==""||form1.col.value<1){
			alert("每排学生应不少于1名");
			form1.col.focus();
			return false;
		}
		
	}
-->
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
	
	int scsum = 0;
%>

【座位安排】（当前用户：<%=session.getAttribute("username") %>）<br><br>
<%
	try
	{
		DataBaseConnection dbc = new DataBaseConnection();
		PreparedStatement sta = dbc.getConnection().prepareStatement("select count(scid) as scno from stucourse where cno='"+cno+"'");
		ResultSet rs = sta.executeQuery();
		while(rs.next())
		{
			scsum = rs.getInt("scno");
		}
		sta.close();

%>

课程<%=cno %>《<%=cname %>》共有<%=scsum %>名选课学生。
第<%=eno %>次考核“<%=ename %>”的教室信息：<br>
<form name="form1" method="post" action="postseat.jsp" onSubmit="return check();">
	教室共有<input name="row" type="text" onkeyup="value=value.replace(/[^\d]/g,'')"/>排<br>
	每排能坐<input name="col" type="text" onkeyup="value=value.replace(/[^\d]/g,'')"/>名学生<br>
	<br>
	<input name="cno" type="hidden" value="<%=cno %>"/>
	<input name="cname" type="hidden" value="<%=cname %>"/>
	<input name="eid" type="hidden" value="<%=eid %>"/>
	<input name="eno" type="hidden" value="<%=eno %>"/>
	<input name="ename" type="hidden" value="<%=ename %>"/>
	<input name="scsum" type="hidden" value="<%=scsum %>"/>
	<input type="submit" onClick="return check();" value="生成座位图"/>
</form>
<br>
<br>
<a href="javascript:history.back(-1)">【返回】</a>

<%
		dbc.close();
	}
	catch(Exception e)
	{}

}
%>
</body>
</html>

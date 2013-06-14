<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自动分组</title>

<script language="javascript">
<!--
	function check(){
		if(form1.teamsum.value==""||form1.teamsum.value<2){
			alert("组数应不小于2");
			form1.teamsum.focus();
			return false;
		}
		if(form1.checkersum.value==""||form1.checkersum.value<1){
			alert("陪审组成员应不少于1名");
			form1.checkersum.focus();
			return false;
		}
		var count=form1.eid.length; 
		var j=0; 
		for(var i=0;i<count;i++){ 
			if (form1.eid[i].checked) ++j;
		} 
		if(j==0){
			alert("至少选择1个考核"); 
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

	String cno = new String(request.getParameter("cno").getBytes("ISO-8859-1"),"UTF-8");
	String cname = new String(request.getParameter("cname").getBytes("ISO-8859-1"),"UTF-8");
	int scsum = 0;
	int esum = 0;
%>

【自动分组】（当前用户：<%=session.getAttribute("username") %>）<br><br>
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

<font color="#FF0000">*警告：本操作将重置该课程的所有分组信息！</font>
<br>
<br>
课程<%=cno %>《<%=cname %>》共有<%=scsum %>名选课学生。
<form name="form1" method="post" action="postauto.jsp" onSubmit="return check();">
	将他们分成<input name="teamsum" type="text" onkeyup="value=value.replace(/[^\d]/g,'')"/>组<br>
	每组安排<input name="checkersum" type="text" onkeyup="value=value.replace(/[^\d]/g,'')"/>名陪审组成员<br>
	参考考核成绩：
<%
		PreparedStatement sta1 = dbc.getConnection().prepareStatement("select eid,ename from exam where cno='"+cno+"'");
		ResultSet rs1 = sta1.executeQuery();
		while(rs1.next())
		{
			esum++;
%>
    <br>
    <input type=checkbox name="eid" value="<%=rs1.getString("eid")%>" ><%=rs1.getString("ename") %>
<%
		}
%>
	<br>
	<br>
	<input name="scsum" type="hidden" value="<%=scsum %>"/>
	<input name="esum" type="hidden" value="<%=esum %>"/>
	<input name="cno" type="hidden" value="<%=cno %>"/>
	<input name="cname" type="hidden" value="<%=cname %>"/>
	<input type="submit" onClick="return check();" value="自动分组"/>
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

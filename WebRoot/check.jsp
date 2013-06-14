<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.course.db.*" %>
<jsp:useBean id="oMD5" scope="session" class="com.course.encoder.MD5"/>
<jsp:useBean id="log" scope="page" class="com.course.data.WriteLog"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录检查</title>
</head>
<body>
<%!public String getIpAddr(HttpServletRequest request) {
    String ip = request.getHeader("x-forwarded-for");
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getHeader("Proxy-Client-IP");
    }
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getRemoteAddr();
    }
    return ip;
}%>

<%
	String username = request.getParameter("username");
	String password = oMD5.getMD5ofStr(request.getParameter("password"));
	String strSelect = (String)request.getParameter("radio");
	String name = null;
	String ip=getIpAddr(request);
	int type = 0;

	//超级管理员
	if(strSelect.equals("admin"))
	{
		if(Integer.parseInt(session.getAttribute("type").toString())==3)
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select * from admin where apassword=?");
			sta.setString(1,password);
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				name=session.getAttribute("username")+"【超级管理员】";
				type=9;
				session.setAttribute("login",true);			//将登录状态写入session
				session.setAttribute("username",name);		//将用户名写入session
				session.setAttribute("userno",username);	//将用户编号写入session
				session.setAttribute("type",type);			//将用户权限写入session
				log.setPath(application.getRealPath("/logs"));	//写日志
				log.setLog("> "+ session.getAttribute("userno") + "; type: " + session.getAttribute("type") + "; " + ip + " login");
				log.writeFile();
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
	}
	
	//教师
	if(strSelect.equals("teacher"))
	{
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select tname from teacher where tno=? and tpassword=?");
			sta.setString(1,username);
			sta.setString(2,password);
			ResultSet rs = sta.executeQuery();
			if(rs.next())
			{
				name=rs.getString("tname");
				type=3;
				session.setMaxInactiveInterval(50*60);		//设定session（会话）超时时间
				session.setAttribute("login",true);			//将登录状态写入session
				session.setAttribute("username",name);		//将用户名写入session
				session.setAttribute("userno",username);	//将用户编号写入session
				session.setAttribute("type",type);			//将用户权限写入session
				log.setPath(application.getRealPath("/logs"));	//写日志
				log.setLog("> "+ session.getAttribute("userno") + "; type: " + session.getAttribute("type") + "; " + ip + " login");
				log.writeFile();
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
	}
	
	//陪审员
	if(strSelect.equals("checker"))
	{
		try
		{
			DataBaseConnection dbc = new DataBaseConnection();
			PreparedStatement sta = dbc.getConnection().prepareStatement("select sname,type from student,stucourse where student.sno=stucourse.sno and student.sno=? and spassword=?");
			sta.setString(1,username);
			sta.setString(2,password);
			ResultSet rs = sta.executeQuery();
			while(rs.next())
			{
				if(rs.getInt("type")>0)
				{
					name=rs.getString("sname");
					type=rs.getInt("type");
					session.setMaxInactiveInterval(50*60);
					session.setAttribute("login",true);
					session.setAttribute("username",name);
					session.setAttribute("userno",username);
					session.setAttribute("type",type);
					log.setPath(application.getRealPath("/logs"));
					log.setLog("> "+ session.getAttribute("userno") + "; type: " + session.getAttribute("type") + "; " + ip + " login");
					log.writeFile();
				}
			}
			sta.close();
			dbc.close();
		}
		catch(Exception e)
		{}
	}

	if(type>0&&type<3) response.sendRedirect("cpanel.html");
	if(type>2) response.sendRedirect("tpanel.html");

%>
	验证错误！<br>请重新<a href="javascript:history.back(-1)">登录</a>.

</body>
</html>

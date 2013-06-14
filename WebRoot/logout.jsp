<%
session.setAttribute("login",false);
session.setAttribute("username",null);
session.setAttribute("userno",null);
session.setAttribute("type",0);
response.sendRedirect("login.jsp");
%>
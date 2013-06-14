<%@page import="com.course.xls.ExportExcel"%>
<jsp:useBean id="xls" scope="session" class="com.course.xls.ExportExcel"/>
<%
	response.reset();
	response.setContentType("application/vnd.ms-excel");
	ExportExcel.writeExcel(response.getOutputStream());
%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>超级管理员验证</title>

<script language="javascript">
if (top.location !== self.location) {
 top.location=self.location;
}
</script>

<script language="javascript">
<!--
	function check(){
		if(form1.password.value==""){
			alert("请输入你的密码");
			form1.password.focus();
			return false;
		}
	}
-->
</script>
</head>

<body>
<p>&nbsp;</p>
<form id="form1" name="form1" method="post" action="check.jsp" onSubmit="return check();" >
  <h1 align="center">实践课教学管理系统</h1>
  <table width="280" border="0" align="center" cellspacing="0">
    <tr>
      <td colspan="2" align="center" bgcolor="#CCCCCC"><h3 align="center"><strong>超级管理员验证</strong></h3></td>
    </tr>
    <tr>
      <td bgcolor="#CCCCCC"><div align="right">密　码：</div></td>
      <td bgcolor="#CCCCCC">
      <input type="password" name="password" id="password" /></td>
    </tr>
        <tr>
      <td colspan="2" align="center" bgcolor="#CCCCCC">
      	<input name="username" type="hidden" value="admin"/>
        <input name="radio" type="hidden" value="admin"/>
        <input type="submit" name="submit" id="submit" onClick="return check();" value="提交" />
        <input type="reset" name="reset" id="reset" value="重置" /></td>
    </tr>
    <tr>
      <td colspan="2" align="center" bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
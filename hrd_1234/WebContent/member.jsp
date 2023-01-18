<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>

<%@ page import="DBPKG.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB 회원등록</title>
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;

request.setCharacterEncoding("UTF-8");

String custno = request.getParameter("custno");
String custname = request.getParameter("custname");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String joindate = request.getParameter("joindate");
String grade = request.getParameter("grade");
String city = request.getParameter("city");

joindate = joindate.replaceAll("-", "");

String sql = "insert into member_tbl_02 values (" +
					  custno + ", " + 
				"'" + custname + "', " +
				"'" + phone + "', " +
				"'" + address + "', " +
		"to_date('" + joindate + "', 'YYYYMMDD'), " +
				"'" + grade + "', " +
				"'" + city + "')";
int result = 0;

try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	
	result = stmt.executeUpdate(sql);
	
	if(conn.getAutoCommit() == false) conn.commit();
	
	stmt.close();
	conn.close();
}

catch(Exception e)
{
	System.out.println("[Error] " + e.getMessage());
	e.printStackTrace();
}

finally
{
	out.println("<h1>" + result + "</h1>");
}
%>

<script>
(function(){
	const h1Elem = document.querySelector("h1");
	
	if(h1Elem.textContent === "1")
	{
		alert("회원등록이 완료되었습니다.");	
	}
	else
	{
		alert("회원등록이 진행되지 않았습니다.");
	}
	
	parent.location.reload();
})();
</script>
</body>
</html>
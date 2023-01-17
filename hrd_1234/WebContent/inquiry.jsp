<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="java.util.Date" %>
<%@ page import="DBPKG.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록조회/수정</title>
<link rel="stylesheet" href="main.css">
</head>
<body>
	<header>
		<div>
			<h2>회원목록조회/수정</h2>
		</div>
	</header>
	
	<nav>
		<div>
			<a href="register.jsp">회원등록</a>
			<a href="inquiry.jsp">회원목록조회/수정</a>
			<a href="sale.jsp">회원매출조회</a>
			<a href="index.jsp">홈으로</a>
		</div>
	</nav>
	
	<section>
		<div>
			<h3>회원목록조회/수정</h3>
			<table border="1" style="width: 800px">
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입일자</th>
					<th>고객등급</th>
					<th>거주지역</th>
				</tr>
				
<% 
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;

String custno = "";
String custname = "";
String phone = "";
String address = "";
Date joindate = null;
String grade = "";
String city = "";

String sql = "select * from member_tbl_02 order by custno asc";

try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	
	while(rset.next())
	{
		custno = rset.getString("custno");
		custname = rset.getString("custname");
		phone = rset.getString("phone");
		address = rset.getString("address");
		joindate = rset.getDate("joindate");
		grade = rset.getString("grade");
		city = rset.getString("city");
		
		switch(grade)
		{
		case "A":
			grade = "VIP";
			break;
		case "B":
			grade = "일반";
			break;
		case "C":
			grade = "직원";
			break;
		default:
			grade = "미정";
			break;
		}
%>

				<tr>
					<td><a href="modify.jsp?custno=<%= custno %>"><%= custno %></a></td>
					<td><%= custname %></td>
					<td><%= phone %></td>
					<td><%= address %></td>
					<td><%= joindate %></td>
					<td><%= grade %></td>
					<td><%= city %></td>
				</tr>

<%
	}
}

catch(Exception e)
{
	System.out.println("[ERROR] " + e.getMessage());
	e.printStackTrace();
}
%>
				
			</table>
		</div>
	</section>
	
	<footer>
		<div>
			<h4>HRDKOREA Copyright@2016 All rights reserved. Human Resources Development Service of Korea</h4>
		</div>
	</footer>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="DBPKG.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원매출조회</title>
<link rel="stylesheet" href="main.css">
</head>
<body>
	<header>
		<div>
			<h2>쇼핑몰 회원관리 ver 1.0</h2>
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
			<h3>회원매출조회</h3>
			<table border="1" style="width: 500px">
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>고객등급</th>
					<th>매출</th>
				</tr>
				
<% 
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;

String custno = "";
String custname = "";
String grade = "";
String sale = "";

String sql = "select member.custno, member.custname, member.grade, sum(money.price) " + 
				"from member_tbl_02 member inner join money_tbl_02 money " + 
				"on member.custno = money.custno " + 
				"group by member.custno, member.custname, member.grade " + 	
				"order by sum(money.price) desc";

try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	
	while(rset.next())
	{
		custno = rset.getString(1);
		custname = rset.getString(2);
		grade = rset.getString(3);
		sale = rset.getString(4);
		
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
					<td><%= custno %></td>
					<td><%= custname %></td>
					<td><%= grade %></td>
					<td><%= sale %></td>
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
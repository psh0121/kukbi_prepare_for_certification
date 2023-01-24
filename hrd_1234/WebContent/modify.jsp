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
<title>홈쇼핑 회원 수정</title>
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
			<h3>홈쇼핑 회원 정보 수정</h3>
			
<%
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;

request.setCharacterEncoding("UTF-8");

String custno = request.getParameter("custno");
String custname = "";
String phone = "";
String address = "";
Date joindate = null;
String grade = "";
String city = "";

String sql = "select * from member_tbl_02 where custno=" + custno;

try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	
	while(rset.next())
	{
		custname = rset.getString("custname");
		phone = rset.getString("phone");
		address = rset.getString("address");
		joindate = rset.getDate("joindate");
		grade = rset.getString("grade");
		city = rset.getString("city");
	}
	
	rset.close();
	stmt.close();
	conn.close();
}

catch(Exception e)
{
	System.out.println("[Error] " + e.getMessage());
	e.printStackTrace();
}
%>
			
			<form method="post" id="frm_modify" name="frmModify">
				<table border="1" style="width: 550px">
					<tr>
						<th>회원번호</th>
						<td><input type="text" value=<%= custno %> readonly name="custno"></td>
					</tr>
					<tr>
						<th>회원성명</th>
						<td><input type="text" id="custname" name="custname" value=<%= custname %>></td>
					</tr>
					<tr>
						<th>회원전화</th>
						<td><input type="text" id="phone" name="phone" value=<%= phone %>></td>
					</tr>
					<tr>
						<th>회원주소</th>
						<td><input type="text" id="address" name="address" value="<%= address %>"></td>
					</tr>
					<tr>
						<th>가입일자</th>
						<td><input type="text" id="joindate" name="joindate" value=<%= joindate %>></td>
					</tr>
					<tr>
						<th>고객등급[A:VIP, B:일반, C:직원]</th>
						<td><input type="text" id="grade" name="grade" value=<%= grade %>></td>
					</tr>
					<tr>
						<th>도시코드</th>
						<td><input type="text" id="city" name="city" value=<%= city %>></td>
					</tr>
				</table>
			</form>
			
			<table border="1" style="width: 550px">
				<tr>
					<td>
						<input type="button" id="btn_modify" value="수정"> 
						<input type="button" id="btn_inquiry" value="조회">
					</td>
				</tr>
			</table>
		</div>
	</section>
	
	<footer>
		<div>
			<h4>HRDKOREA Copyright@2016 All rights reserved. Human Resources Development Service of Korea</h4>
		</div>
	</footer>
	
	<iframe name="hiddenframe" style="display: none"></iframe>
<script>
(function(){
	const btnModify = document.querySelector("#btn_modify");
	const btnInquiry = document.querySelector("#btn_inquiry");
	
	const frmModify = document.querySelector("#frm_modify");
	
	const objsArr = [
		{elem: document.querySelector("#custname"), size: 20, blankMsg: "회원성명이 입력되지 않았습니다.", validMsg: "회원성명이 올바르지 않습니다."},
		{elem: document.querySelector("#phone"), size: 13, blankMsg: "회원전화가 입력되지 않았습니다.", validMsg: "회원전화가 올바르지 않습니다."},
		{elem: document.querySelector("#address"), size: 60, blankMsg: "주소가 입력되지 않았습니다.", validMsg: "주소가 올바르지 않습니다."},
		{elem: document.querySelector("#joindate"), size: 10, blankMsg: "가입일자가 입력되지 않았습니다.", validMsg: "가입일자가 올바르지 않습니다."},
		{elem: document.querySelector("#grade"), size: 1, blankMsg: "고객등급이 입력되지 않았습니다.", validMsg: "고객등급이 올바르지 않습니다."},
		{elem: document.querySelector("#city"), size: 2, blankMsg: "거주도시가 입력되지 않았습니다.", validMsg: "거주도시가 올바르지 않습니다."}
	];
	
	const checkBlank = function()
	{
		let result = true;
		
		for(let i = 0; i < objsArr.length; i++)
		{
			if(objsArr[i].elem.value.length === 0) return i;
		}
		return result;
	}
	
	const checkValid = function()
	{
		let result = true;
		
		for(let i = 0; i < objsArr.length; i++)
		{
			if(objsArr[i].elem.value.length > objsArr[i].size) return i;
		}
		
		if(isNaN(objsArr[3].elem.value.replaceAll("-", "")) === true) return 3;
		
		if(isNaN(objsArr[4].elem.value) === false) return 4;
		
		if(isNaN(objsArr[5].elem.value) === true) return 5;
		
		return result;
	}
	
	btnModify.addEventListener("click", function()
	{
		let res = checkBlank();
		
		if(res !== true)
		{
			alert(objsArr[res].blankMsg);
			objsArr[res].elem.focus();
			return;
		}
		
		res = checkValid();
		
		if(res !== true)
		{
			alert(objsArr[res].validMsg);
			objsArr[res].elem.focus();
			return;
		}
		
		frmModify.action = "update.jsp";
		frmModify.target = "hiddenframe";
		frmModify.submit();
	});
	
	btnInquiry.addEventListener("click", function(){
		location.href = "./inquiry.jsp";
	});
})();
</script>
</body>
</html>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String hobby[] = request.getParameterValues("hobby");
	String hobbystr = "";
	for(int i=0; i<hobby.length; i++){
		hobbystr = hobbystr + hobby[i] + " ";	// 드라이브 등산
	}
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "";
	String url = "jdbc:mysql://localhost:3306/jcp";
	String uid = "root";
	String upw = "1234";
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		if(conn != null){
			sql += "update tb_member set mem_name= ?, ";
			sql += "mem_hp=?, mem_email=?, mem_hobby=?, mem_ssn1=?, mem_ssn2=?, mem_zipcode=?,";
			sql += "mem_address1=?, mem_address2=?, mem_address3=? where mem_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, hp);
			pstmt.setString(3, email);
			pstmt.setString(4, hobbystr);
			pstmt.setString(5, ssn1);
			pstmt.setString(6, ssn2);
			pstmt.setString(7, zipcode);
			pstmt.setString(8, address1);
			pstmt.setString(9, address2);
			pstmt.setString(10, address3);
			pstmt.setString(11,(String)session.getAttribute("userid"));
			pstmt.executeUpdate();
			

		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script>
	alert('정보수정이 완료되었습니다');
	location.href='info.jsp';
</script>
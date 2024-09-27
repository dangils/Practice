<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="com.koreait.board.ReplyDTO" %>
<%	
	request.setCharacterEncoding("UTF-8");
		
%>	

	<jsp:useBean id="boardDTO" class="com.koreait.board.BoardDTO"/>
	<jsp:useBean id="boardDAO" class="com.koreait.board.BoardDAO" />
	<jsp:useBean id="replyDTO" class="com.koreait.board.ReplyDTO"/>
	<jsp:useBean id="reDAO" class="com.koreait.board.ReplyDAO"/>
	
<% 	
	boardDTO.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
	                               //list의 <a href="./view.jsp?b_idx 에서 받아옴
	                                     
	String b_userid ="";	
	String b_title ="";	
	String b_content ="";	
	String b_regdate ="";	
	int b_like =0;	
	int b_hit =0;	
	String b_file ="";	
	int b_idx =boardDTO.getIdx();	
	
	if(boardDAO.view(boardDTO)!=null){
		b_userid=boardDTO.getUserid();
		b_title=boardDTO.getTitle();
		b_content=boardDTO.getContent();
		b_regdate=boardDTO.getRegdate();
		b_like=boardDTO.getLike();
		b_hit=boardDTO.getHit();
		b_file=boardDTO.getFile();
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script>
	function like(){
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}
		}
		xhr.open('GET', './like_ok.jsp?b_idx=<%=b_idx%>', true);
		xhr.send();
	}
</script>
</head>
<body>
	<h2>글보기</h2>
	<table border="1" width="800">
		<tr>
			<td>제목</td><td><%=b_title%></td>
		</tr>
		<tr>
			<td>날짜</td><td><%=b_regdate%></td>
		</tr>
		<tr>
			<td>작성자</td><td><%=b_userid%></td>
		</tr>
		<tr>
			<td>조회수</td><td><%=b_hit%></td>
		</tr>
		<tr>
			<td>좋아요</td><td><span id="like"><%=b_like%></span></td>
		</tr>
		<tr>
			<td>내용</td><td><%=b_content%></td>
		</tr>
		<tr>
			<td>파일</td>
			<td>
				<%
					if(b_file != null && !b_file.equals("")){
						out.println("첨부파일");
						out.println("<img src='../upload/"+b_file+"' alt='첨부파일' width='150'>");
					}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			
<%
	if(b_userid.equals((String)session.getAttribute("userid"))){
		//로긴ok에서 세션변수로 설정된 세션값과 DAO의 view 메소드 userid와 같으면(=같은 사용자 id이면) 아래 버튼 표시
%>
		<input type="button" value="수정" onclick="location.href='./edit.jsp?b_idx=<%=b_idx%>'"> 
		<input type="button" value="삭제" onclick="location.href='./delete.jsp?b_idx=<%=b_idx%>'">
<%
	}	
%>		
			<input type="button" value="좋아요" onclick="like()">
			<input type="button" value="리스트" onclick="location.href='./list.jsp'">
			</td>
		</tr>
	</table>
	<hr/>
	<form method="post" action="reply_ok.jsp">
		<input type="hidden" name="b_idx" value="<%=b_idx%>">
		<p><%=session.getAttribute("userid")%> : <input type="text" size="40" name="re_content"> <input type="submit" value="확인"></p>
		<!-- 로그인 했을 때의 userid -->
	</form>
	<hr/>
	

		
<%
			replyDTO.setDtolist(reDAO.view_reply(boardDTO.getIdx()));
			//board.getIdx()로 가져온 idx값을 매개변수로 받는 view_reply(입력된 댓글 출력) 메서드의 리턴값을 
			//replyDTO에 set
			
			if(replyDTO.getDtolist()!=null){ //replyDTO에서 reply의 list를 get		
				for(ReplyDTO arr : replyDTO.getDtolist()){
		
%>
		<p><%=arr.getUserid()%> : <%=arr.getContent()%> ( <%=arr.getRegdate()%> ) 	
<%
		if(b_userid.equals((String)session.getAttribute("userid"))){
		
%>
	
		<input type="button" value="삭제" onclick="location.href='reply_del.jsp?re_idx=<%=arr.getReidx()%>&b_idx=<%=b_idx%>'">
		
<%
	
	}
%>		

		</p>
		
<%
		}
	}
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kku.KkuDAO" %>   
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 

<jsp:useBean id="kku" class="kku.Kku" scope="page" />
<jsp:setProperty name="kku" property="kkuTitle" />
<jsp:setProperty name="kku" property="kkuContent" />



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KU 게시판</title>
</head>
<body>

	<%
		String userID=null;
	
		if(session.getAttribute("userID") != null ){
		userID = (String) session.getAttribute("userID");
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하셔야 글을 작성하실 수 있습니다')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else {
			if(kku.getKkuTitle() ==null || kku.getKkuContent() ==null){
				
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 내용이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
				
				}else{
					
					KkuDAO kkuDAO = new KkuDAO();
					int result = kkuDAO.write(kku.getKkuTitle(), userID , kku.getKkuContent());
					if(result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('작성이 완료되었습니다')");
						script.println("location.href = 'kku.jsp'"); 
						script.println("</script>");
					}
					
				}
			
		}
		
	%>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kku.KkuDAO" %>
<%@ page import="kku.Kku" %>   
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 


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
		
		int kkuID=0;
		if(request.getParameter("kkuID") != null){
			kkuID = Integer.parseInt(request.getParameter("kkuID"));
		}
		
		if(kkuID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='kku.jsp'");
			script.println("</script>");
		}
		
		Kku kku = new KkuDAO().getKku(kkuID);
		if(!userID.equals(kku.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='kku.jsp'");
			script.println("</script>");
		}

		else{
					KkuDAO kkuDAO = new KkuDAO();
					int result = kkuDAO.delete(kkuID);
					if(result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 삭제에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 삭제가 완료되었습니다.')");
						script.println("location.href = 'kku.jsp'"); 
						script.println("</script>");
					}
					
				}

		
	%>
	
</body>
</html>
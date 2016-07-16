<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!-- Metodo Post tiene los datos de base de datos -->
<!-- <form action="QueryTables" method="post"> -->
<!-- Metodo Get tiene los datos Dummy -->
	<form action="QueryTables" method="get">

	<input type="hidden" name="page" value="3">
	<table>
		<%
		List<String> stats = (List<String>) request.getAttribute("tableNames");
		Iterator<String> it = stats.iterator();
		
		while(it.hasNext())
		{
			String s = it.next();
			out.print("<tr>");
			out.println("<td>" + s + "</td>");
			out.print("<td><input type=\"radio\" name=\"table\" value=\"" +s +"\"");	
			out.print("</tr>");
		}
		%>	
 

	</table>
	<input type="submit" value="click here" />
</form>
</body>
</html>
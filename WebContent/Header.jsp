<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GlossyWindowShopping</title>
</head>
<body link=blue vlink=blue alink=blue>
<table width=100% style='height:500px;border:2px solid blue;'>    
<tr style='height:100px;background:lightblue;'>
	<td><h1>GlossyWindowShopping</h1></td>
	<td>
	<% if (session.getAttribute("uid") != null) { %>
	Sie sind eingeloggt! <a href='?a=login'>AUSLOGGEN</a><br>
	<a href='?pid=<%=session.getAttribute("uid")%>'>Meine Seite</a> (<a href='?rid=<%=session.getAttribute("uid")%>'>bearbeiten</a>)<br>
	<a href='?a=artikelneu'>Neuen Artikel erstellen</a>
	<% } else { %>
	Sie sind nicht eingeloggt! <a href='?a=login'>EINLOGGEN</a>
	<% } %>
	</td>
</tr>
				
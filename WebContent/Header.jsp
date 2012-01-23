<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GlossyWindowShopping</title>

<style>
body,td {
	font-family:Verdana;
	font-size:12px;
}
</style>
</head>
<body link=blue vlink=blue alink=blue>
<table width=100% style='height:500px;border:2px solid blue;'>    
<tr style='height:90px;background:#acff7f;'>
	<td width=61% style='border:2px solid black;' align="center" valign="middle"><img src="images/logo.png" width="400" />
	<a href='?'><font face="Cooper Black">HOME</a></font></td>
	

	<td style='border:2px solid black;'>
	<% if (session.getAttribute("uid") != null) { %>
	Sie sind eingeloggt! <a href='?a=login'>AUSLOGGEN</a><br>
	<a href='?pid=<%=session.getAttribute("uid")%>'>Meine Seite</a> (<a href='?rid=<%=session.getAttribute("uid")%>'>bearbeiten</a>)<br>
	<a href='?a=artikelneu'>Neuen Artikel erstellen</a><br>
	<a href='?a=statistik'>Statistik anzeigen</a>
	<% } else { %>
	Sie sind nicht eingeloggt! <a href='?a=login'>EINLOGGEN</a><br>
	<a href='?a=registrieren'>Registrieren</a><br>
	<% } %>
	</td>
</tr>
				
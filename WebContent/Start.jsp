<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="Header.jsp" %>
<tr>
	<td valign=top>
	<h2>Herzlich willkommen bei GlossyWindowShopping</h2>
	<h3>Ihre weiteren Schritte:</h3><br>
	<% if (session.getAttribute("uid") != null) { %>
		<a href='?a=login'>Ausloggen</a><br>
	<% } else { %>
		<a href='?a=login'>Einloggen</a><br>
	<% } %>
	<a href='?a=searchartikel'>Artikel durchsuchen</a><br>
	<a href='?a=searchpersonen'>Personen durchsuchen</a><br>
	
	</td>
</tr>
<%@ include file="Footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %>

<%
			Person p = new Person(Integer.valueOf(request.getParameter("rid")));
			
				%>
<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>

<tr style='height:40px;'>
	<td>Zum registrieren bitte einen Usernamen und ein Passwort wählen.</td>
</tr>

<tr>
	<td valign=top>
	<form method=get >
	<input type=hidden name=changepid value='<%=request.getParameter("rid") %>'>
	<b>Username:</b> <input type=text name=changeusername value='<%=p.getName() %>'><br> 
	<b>Passwort:</b> <input type=text name=changepasswort value='<%=p.getPasswort() %>'><br> 
	<input type=submit value='Speichern'><br> 
	</form>
	</td>
</tr>


<%@ include file="Footer.jsp" %>
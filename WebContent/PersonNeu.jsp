<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %>

<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>

<tr style='height:40px;'>
	<td>Zum registrieren bitte einen Usernamen und ein Passwort wählen.</td>
</tr>
 
<tr>
	<td valign=top>
	<form method=get >
	<b>Username:</b> <input type=text name=newusername><br>
	<b>Passwort:</b> <input type=text name=newpasswort><br> 
	<input type=submit value='Registrieren'><br>
	</form>
	</td>
</tr>


<%@ include file="Footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %>

<%
			Toolbox t = new Toolbox();
			t.connect();
			ResultSet rs = t.get("select * from person where pid='"+request.getParameter("rid")+"'");
			rs.next();
				%>
<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>

<tr>
	<td valign=top>
	<form method=get >
	<input type=hidden name=changepid value='<%=request.getParameter("rid") %>'>
	<b>Username:</b> <input type=text name=changeusername value='<%=rs.getString("name") %>'><br> 
	<b>Passwort:</b> <input type=text name=changepasswort value='<%=rs.getString("passwort") %>'><br> 
	<input type=submit value='Speichern'><br> 
	</form>
	</td>
</tr>


<%@ include file="Footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %>
<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>
<tr>
	<td valign=top>
		<%
			if (session.getAttribute("uid") != null) {
				session.invalidate();
				%><h2>Sie wurden ausgeloggt</h2><% 
			} else {
				%>
				
				<form method=get action="GlossyWindowShopping">
				<% if (request.getParameter("aid") != null) { %><input type=hidden name=aid value='<%=request.getParameter("aid")%>'><% } %>
				<% if (request.getParameter("pid") != null) { %><input type=hidden name=pid value='<%=request.getParameter("pid")%>'><% } %>
				<table>
				<tr>
					<td><b>Username:</b></td>
					<td><input type=text name=username value='Nico'></td>
				</tr>
				<tr>
					<td><b>Passwort:</b></td>
					<td><input type=password name=passwort value='dsfgdsf'></td>
				</tr>
				<tr>
					<td colspan=2 align=center><input type=submit value='Anmelden'></td>
				</tr>
				</table>
				</form>
				
				<% 
			}
		%>
	</td>
</tr>	
<%@ include file="Footer.jsp" %>
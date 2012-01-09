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
	<h2>Neuer Artikel</h2>
	<form method=get >
	<b>Artikelname:</b> <input type=text name=newartikelname value=''><br> 
	<b>Sofort-Kaufen-Preis:</b> <input type=text name=newartikelprice value=''><br> 
	<b>Deadline ist in 1 Woche</b><br> 
	<input type=submit value='Speichern'><br> 
	</form>
	</td>
</tr>


<%@ include file="Footer.jsp" %>
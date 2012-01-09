<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %> 

<%
			Person p = new Person(Integer.parseInt(request.getParameter("pid")));
			
				%>
<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>

<tr>
	<td valign=top>
	<h2>User: <%=p.getName() %></h2> 
	</td>
</tr>
<tr>
	<td>
		<h3>gekaufte Artikel:</h3>
		<%
			Artikel[] gekaufteArtikel = p.gekaufteArtikel();
			
			if (gekaufteArtikel.length < 1){
				%>Der User hat noch keine Artikel gekauft<%
			} else {
				for (int i = 0; i < gekaufteArtikel.length; i++){
					%><a href='?aid=<%=gekaufteArtikel[i].getAid() %>'><%=gekaufteArtikel[i].getName() %></a><br>    <%
				}
				
			}
		%>
		
		<h3>bebotene Artikel:</h3>
		<%
			Artikel[] beboteneArtikel = p.beboteneArtikel();
			
			if (beboteneArtikel.length < 1){
				%>Der User hat auf keine Artikel geboten<%
			} else {
				for (int i = 0; i < beboteneArtikel.length; i++){
					%><a href='?aid=<%=beboteneArtikel[i].getAid() %>'><%=beboteneArtikel[i].getName() %></a><br>    <%
				}
				
			}
			
		%>
		<h3>angebotene Artikel:</h3>
		<%
			Artikel[] angeboteneArtikel = p.beboteneArtikel();
			
			if (angeboteneArtikel.length < 1){
				%>Der User hat noch keine Artikel angeboten<%
			} else {
				for (int i = 0; i < angeboteneArtikel.length; i++){
					%><a href='?aid=<%=angeboteneArtikel[i].getAid() %>'><%=angeboteneArtikel[i].getName() %></a><br>    <%
				}
				
			}
		
			
		%>
	</td>
</tr>




<%@ include file="Footer.jsp" %>
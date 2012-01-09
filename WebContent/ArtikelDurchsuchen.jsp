<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>


<%@ include file="Header.jsp" %>
<tr>
	<td valign=top>
		<table cellpadding=10><tr><th>Name</th><th>Aktuelles&nbsp;Gebot</th><th>Deadline</th><th>Verk&auml;ufer</th></tr>
		<%
		
		Artikelliste al = new Artikelliste();
		
		Artikel[] alleA = al.suche("");
		
		String grey = "dddddd";
		
		for (int i = 0; i < alleA.length; i++) {
			if (grey.equals("dddddd")) grey = "ffffff";
			else grey = "dddddd";
			
			%>
			<tr style='background:#<%=grey %>'>
				<td><a href='?aid=<%=alleA[i].getAid() %>'><%=alleA[i].getName() %></a></td>
				<td><%
					// check if Gebote exists
					
					Gebote[] geb = alleA[i].getGebote();

					if (geb.length > 0){
						for (int a = 0; a < geb.length; a++){
							%>Gebot: <%=geb[a].getPreis() %><%
						}
						
					} else {
						%><b>Sofort Kaufen</b> <%=alleA[i].getPreis() %><%
					}
					%> &euro;</td>
				<td><%=alleA[i].getDeadline() %></td>
				<td><%
					Person verkaeufer = new Person(alleA[i].getVerkaeufer()); 
					%>
					<a href='?pid=<%=alleA[i].getVerkaeufer() %>'><%=verkaeufer.getName() %></a>
				</td>
			</tr>
			<%
		} %>
		</table>
	
	</td>
</tr>
<%@ include file="Footer.jsp" %>
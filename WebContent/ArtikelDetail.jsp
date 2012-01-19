<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>
<%@ include file="Header.jsp" %>
<tr>
	<td valign=top>
	
	<% if (request.getParameter("aid")!=null) {
		Artikel myArt = new Artikel(Integer.parseInt(request.getParameter("aid")));
		Float altpreis = myArt.getPreis();
		
		%>
		<table>
		<%
		
		Gebote[] geb = myArt.getGebote();
		
		
		// abfangen ob ein Gebot gesendet wurde -> wenn ja, dann in die gebote-tabelle schreiben
		if (request.getParameter("g") != null){
			// einen Euro höher bieten
			if (geb.length > 0)
				altpreis = geb[0].getPreis();
			myArt.doBit(Integer.valueOf(session.getAttribute("uid").toString()),Float.valueOf(request.getParameter("g")));
			myArt = new Artikel(Integer.parseInt(request.getParameter("aid")));
			geb = myArt.getGebote();
		}
		
			%>
				<tr><td><a href='?a=searchartikel'>zur&uuml;ck</a></td></tr>
				<tr>
					<td><h2><%=myArt.getName() %></h2></td>
				</tr>
				<tr>
					<td><h3>Kategorie: <%=myArt.getKategorie() %></h3></td>
				</tr>
				
				<tr>
					<td><%
						if (!myArt.abgelaufen){
							// check if Gebote exists
							
							if (geb.length > 0){
								%>Aktuelles Gebot: <%=geb[0].getPreis() %> &euro;
								<% if (session.getAttribute("uid") != null) {%>
									<a href='?aid=<%=request.getParameter("aid") %>&g=<%=(geb[0].getPreis()+1)%>'>Jetzt &uuml;berbieten</a>
								<% } else { %>
									<a href='?a=login&aid=<%=request.getParameter("aid") %>'>Jetzt einloggen um zu bieten</a>
								<% }
								
							} else {
								%><b>Sofort Kaufen</b> f&uuml;r <%=myArt.getPreis()  %> &euro;
								<br> oder 
								<% if (session.getAttribute("uid") != null) {%>
									<a href='?aid=<%=request.getParameter("aid") %>&g=<%=(myArt.getPreis()+1)%>'>Jetzt bieten</a>
								<% } else { %>
									<a href='?a=login&aid=<%=request.getParameter("aid") %>'>Jetzt einloggen um zu bieten</a>
								<% }
							}
						}
						%> 
					</td>
				</tr>
				<tr>
				<td>
				<h4>Diese Gebote wurden f&uuml;r diesen Artikel abgegeben</h4>
				<%
				
				if (geb.length > 0){
					for (int i = 0; i < geb.length; i++){
						%><a href='?pid=<%=geb[i].getKaeufer().getPid() %>'><%=geb[i].getKaeufer().getName() %></a> ( <%=geb[i].getPreis()  %>&euro;) <br>    <%
					}
				} else {
					%>Der Artikel wurde noch nicht beboten<%
				}
				
			%></td>
				</tr>
				<%
		 %>
		</table>
	<% } else { %>
	<h3>Keine Artikel-ID angegeben</h3>
	<% } %>
	</td>
</tr>
<%@ include file="Footer.jsp" %>
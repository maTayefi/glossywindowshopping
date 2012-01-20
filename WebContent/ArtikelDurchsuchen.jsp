<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>


<%@ include file="Header.jsp" %>
<tr>
	<td valign=top colspan=2>
	<table width=100%><tr><td valign=top>
		<form>
		<input type=hidden name=a value="searchartikel">
		Artikel durchsuchen: <input type=text name=search value="<%=(request.getParameter("search") != null?request.getParameter("search"):"")%>">
		<input type=submit value="suchen">
		</form>
		<br><br>
		<b>Kategorien</b><br>
		<%
			Artikel a = new Artikel();
			Kategorie[] ak = a.getKats();
			
			for (int i = 0; i < ak.length; i++){
				%><a href="?a=searchartikel&kat=<%=ak[i].getKid() %>"><%=ak[i].getName() %></a><br><%
			}
		%>
	</td>
	<td valign=top>
		<table cellpadding=10><tr><th>Name</th><th>Aktuelles&nbsp;Gebot</th><th>Voting</th><th>Deadline</th><th>Verk&auml;ufer</th></tr>
		<%
		
		Artikelliste al = new Artikelliste();
		
		Artikel[] alleA = al.suche((request.getParameter("search") != null?request.getParameter("search"):""),(request.getParameter("kat") != null?Integer.valueOf(request.getParameter("kat")):0));
		
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
					%>Gebot: <%=geb[0].getPreis() %><%
						
					} else {
						%><b>Sofort Kaufen</b> <%=alleA[i].getPreis() %><%
					}
										%> &euro;</td>
										<td><%=alleA[i].getVoting() %></td>
				<td>
				<%	String d = alleA[i].getDeadline(); %>
				<%=d.substring(8,10)+"."+d.substring(5,7)+"."+d.substring(0,4)+"&nbsp;"+d.substring(11,16) %></td>
				<td><%
					Person verkaeufer = new Person(alleA[i].getVerkaeufer()); 
					%>
					<a href='?pid=<%=alleA[i].getVerkaeufer() %>'><%=verkaeufer.getName() %></a>
				</td>
			</tr>
			<%
		} %>
		</table>
	</td></tr></table>
	</td>
</tr>
<%@ include file="Footer.jsp" %>
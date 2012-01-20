<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %> 

<%
			Person p = new Person(Integer.parseInt(request.getParameter("pid")));
			
				%>
<tr>
	<td valign=top>
	<h2>User: <%=p.getName() %></h2> 
	</td>
	<td valign=top>
	<h3>Voting als K&auml;ufer: <%=p.getVotingKaeufer() %></h3>
	</td>
	
</tr>
<tr>
	<td><h3>Typ: <%=p.getTyp() %></h3> </td>
	<td><% double votingK = p.getVotingKaeufer()/5*100; %>
	<img src="http://chart.apis.google.com/chart?chxl=0:|0|3|5&chxt=y&chs=300x150&cht=gm&chd=t:<%=votingK %>&chl=Bewertung" width="300" height="150" alt="" />
	</td>
</tr>


<tr>
	<td><h3>Aufteilung der Artikel</h3></td>
	<td>Bewerten Sie diese Person als Käufer: 
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=0">0</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=1">1</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=2">2</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=3">3</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=4">4</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteKaeufer=<%=request.getParameter("pid")%>&vote=5">5</a>&nbsp;
	</td>
</tr>
<tr>
	<td>
	<%
	Artikel[] gekaufteArtikel = p.gekaufteArtikel();
	Artikel[] beboteneArtikel = p.beboteneArtikel();
	Artikel[] angeboteneArtikel = p.angeboteneArtikel();
	
	%>
	<img src="http://chart.apis.google.com/chart?chs=300x150&cht=p&chd=t:<%=gekaufteArtikel.length %>,<%=beboteneArtikel.length %>,<%=angeboteneArtikel.length %>&chp=0.628&chl=gekauft|beboten|angeboten" width="300" height="150" alt="" />
	</td>
	<td>
	<h3>Voting als Verk&auml;ufer: <%=p.getVotingVerkaeufer() %></h3>
	<% double votingV = p.getVotingVerkaeufer()/5*100; %>
	<img src="http://chart.apis.google.com/chart?chxl=0:|0|3|5&chxt=y&chs=300x150&cht=gm&chd=t:<%=votingV %>&chl=Bewertung" width="300" height="150" alt="" />
	<br>Bewerten Sie diese Person als Verkäufer: 
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=0">0</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=1">1</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=2">2</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=3">3</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=4">4</a>&nbsp;
	<a href="?pid=<%=request.getParameter("pid")%>&voteVerkaeufer=<%=request.getParameter("pid")%>&vote=5">5</a>&nbsp;
	</td>
</tr>

<tr>
	<td>
		<h3>gekaufte Artikel:</h3>
		<%
			
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
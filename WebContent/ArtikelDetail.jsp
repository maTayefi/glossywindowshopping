<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>


<%@ include file="Header.jsp" %>
<tr>
	<td valign=top>
	
	<% if (request.getParameter("aid")!=null) { %>
		<table>
		<%
		Artikel myArt = new Artikel(Integer.parseInt(request.getParameter("aid")));
		
		
		
		MySQLConnection t = new MySQLConnection();
		t.connect();
		
		// abfangen ob ein Gebot gesendet wurde -> wenn ja, dann in die gebote-tabelle schreiben
		if (request.getParameter("g") != null){
			// altes gebot laden und vergleichen (damit nicht weniger geboten wird)
			ResultSet geb = t.get("select count(*) from gebot where artikel = '"+request.getParameter("aid")+"'");
			geb.next();
			if (geb.getInt(1) > 0){
				ResultSet check = t.get("select * from gebot where artikel = '"+request.getParameter("aid")+"' order by uhrzeit desc limit 1");
				check.next();
				if (check.getFloat("preis")+1 <= Float.valueOf(request.getParameter("g")) ){
					t.set("insert into gebot (preis,uhrzeit,kaeufer,artikel) values ('"+request.getParameter("g")+"',NOW(),'"+session.getAttribute("uid")+"', '"+request.getParameter("aid")+"') ");
				}
			} else
				t.set("insert into gebot (preis,uhrzeit,kaeufer,artikel) values ('"+request.getParameter("g")+"',NOW(),'"+session.getAttribute("uid")+"', '"+request.getParameter("aid")+"') ");
			
		}
		
		ResultSet rs = t.get("select * from artikel where aid = '"+request.getParameter("aid")+"'");
		while (rs.next()) {
			%>
				<tr><td><a href='?a=searchartikel'>zur&uuml;ck</a></td></tr>
				<tr>
					<td><h2><%=myArt.getName() %></h2></td>
				</tr>
				<tr>
					<td><%
						// check if Gebote exists
						ResultSet geb = t.get("select count(*) from gebot where artikel = '"+rs.getInt("aid")+"'");
						geb.next();
						if (geb.getInt(1) > 0){
							ResultSet geb1 = t.get("select * from gebot where artikel = '"+rs.getInt("aid")+"' order by uhrzeit desc limit 1");
							geb1.next();
							%>Aktuelles Gebot: <%=geb1.getFloat("preis") %> &euro;
							<% if (session.getAttribute("uid") != null) {%>
								<a href='?aid=<%=request.getParameter("aid") %>&g=<%=(geb1.getFloat("preis")+1)%>'>Jetzt &uuml;berbieten</a>
							<% } else { %>
								<a href='?a=login&aid=<%=request.getParameter("aid") %>'>Jetzt einloggen um zu bieten</a>
							<% }
							
						} else {
							%><b>Sofort Kaufen</b> f&uuml;r <%=rs.getFloat("preis")  %> &euro;
							<br> oder 
							<% if (session.getAttribute("uid") != null) {%>
								<a href='?aid=<%=request.getParameter("aid") %>&g=1'>Jetzt bieten</a>
							<% } else { %>
								<a href='?a=login&aid=<%=request.getParameter("aid") %>'>Jetzt einloggen um zu bieten</a>
							<% }
						}
						%> 
					</td>
				</tr>
				<tr>
				<td>
				<h4>Diese Gebote wurden f&uumlr diesen Artikel abgegeben</h4>
				<%
				
				if (myArt.gebote.length > 0){
					for (int i = 0; i < myArt.gebote.length; i++){
						%><a href='?pid=<%=myArt.gebote[i].Kaeufer.getPid() %>'><%=myArt.gebote[i].Kaeufer.getName() %></a> ( <%=myArt.gebote[i].Kaeufer.getPreis()  %>&euro;) <br>    <%
					}
				} else {
					%>Der Artikel wurde noch nicht beboten<%
				}
				ResultSet ba = t.get("select distinct * from person p, gebot g where p.pid = g.kaeufer and g.artikel = '"+request.getParameter("aid")+"' order by uhrzeit desc");
				int bacount = 0;
				while(ba.next()){
					%><a href='?pid=<%=ba.getInt("pid") %>'><%=ba.getString("name") %></a> ( <%=ba.getString("preis")  %>&euro;) <br>    <%
					bacount++;
				}
				if (bacount < 1){
					%>Der Artikel wurde noch nicht beboten<%
				}
			%></td>
				</tr>
				<%
		} %>
		</table>
	<% } else { %>
	<h3>Keine Artikel-ID angegeben</h3>
	<% } %>
	</td>
</tr>
<%@ include file="Footer.jsp" %>
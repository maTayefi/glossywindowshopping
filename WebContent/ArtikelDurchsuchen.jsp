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
		Toolbox t = new Toolbox();
		t.connect();
		
		ResultSet rs = t.get("select * from artikel where deadline > NOW() order by deadline");
		String grey = "dddddd";
		
		while (rs.next()) {
			if (grey.equals("dddddd")) grey = "ffffff";
			else grey = "dddddd";
			
			%>
			<tr style='background:#<%=grey %>'>
				<td><a href='?aid=<%=rs.getInt("aid") %>'><%=rs.getString("name") %></a></td>
				<td><%
					// check if Gebote exists
					ResultSet geb = t.get("select count(*) from gebot where artikel = '"+rs.getInt("aid")+"'");
					geb.next();
					if (geb.getInt(1) > 0){
						ResultSet geb1 = t.get("select * from gebot where artikel = '"+rs.getInt("aid")+"' order by uhrzeit desc limit 1");
						geb1.next();
						%>Gebot: <%=geb1.getFloat("preis") %><%
					} else {
						%><b>Sofort Kaufen</b> <%=rs.getFloat("preis") %><%
					}
					%> &euro;</td>
				<td><%=rs.getDate("deadline") %></td>
				<td><%
				
					ResultSet verkaeufer = t.get("select * from person where pid = '"+rs.getInt("verkaeufer")+"'"); 
					verkaeufer.next(); %>
					<a href='?pid=<%=verkaeufer.getInt("pid") %>'><%=verkaeufer.getString("name") %></a>
				</td>
			</tr>
			<%
		} %>
		</table>
	
	</td>
</tr>
<%@ include file="Footer.jsp" %>
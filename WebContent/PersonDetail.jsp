<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %>

<%
			Toolbox t = new Toolbox();
			t.connect();
			ResultSet rs = t.get("select * from person where pid='"+request.getParameter("pid")+"'");
			rs.next();
				%>
<tr style='height:30px;'>
	<td><a href='?'>Zur Startseite</a></td>
</tr>

<tr>
	<td valign=top>
	<h2>User: <%=rs.getString("name") %></h2> 
	</td>
</tr>
<tr>
	<td>
		<h3>gekaufte Artikel:</h3>
		<%
			ResultSet ga = t.get("select distinct a.* from artikel a, gebot g where a.deadline < NOW() and a.aid = g.artikel and g.kaeufer = '"+request.getParameter("pid")+"'");
			int gacount = 0;
			while(ga.next()){
				%><a href='?aid=<%=ga.getInt("aid") %>'><%=ga.getString("name") %></a><br>    <%
				gacount++;
			}
			if (gacount < 1){
				%>Der User hat noch keine Artikel gekauft<%
			}
		%>
		
		<h3>bebotene Artikel:</h3>
		<%
			ResultSet ba = t.get("select distinct a.* from artikel a, gebot g where a.aid = g.artikel and g.kaeufer = '"+request.getParameter("pid")+"'");
			int bacount = 0;
			while(ba.next()){
				%><a href='?aid=<%=ba.getInt("aid") %>'><%=ba.getString("name") %></a><br>    <%
				bacount++;
			}
			if (bacount < 1){
				%>Der User hat noch keine Artikel beboten<%
			}
			
		%>
		<h3>angebotene Artikel:</h3>
		<%
			ResultSet aa = t.get("select distinct * from artikel a where verkaeufer = '"+request.getParameter("pid")+"'");
			int aacount = 0;
			while(aa.next()){
				%><a href='?aid=<%=aa.getInt("aid") %>'><%=aa.getString("name") %></a><br>    <%
				aacount++;
			}
			if (aacount < 1){
				%>Der User hat noch keine Artikel angeboten<%
			}
			
		%>
	</td>
</tr>




<%@ include file="Footer.jsp" %>
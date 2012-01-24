<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %> 

<tr> 
	<td><h3>Entwicklung der gesamten Produktverkäufe</h3>
	<img src="http://chart.apis.google.com/chart?chxr=0,0,36&chxt=y&chs=500x225&cht=lc&chco=3D7930&chd=t:<%
	Artikel a = new Artikel();
	Integer[] iii = a.getEnd();
	for(int c = 0;c < iii.length;c++){
		%><%=iii[c] %><%=(c!=iii.length-1?",":"") %><%
	}
	%>&chg=14.3,-1,1,1&chls=2,4,0&chm=B,C5D4B5BB,0,0,0" width="500" height="225" alt="" /></td>
	
	</tr>
	
	
<tr>
	</tr>
	
	
<tr>
	<td><br><h2>Umsatz im Monat </h2></td>
	<% Person p = new Person(Integer.parseInt(session.getAttribute("uid").toString()));
	Artikel[] angeboteneArtikel = p.angeboteneArtikel();
	Artikel[] verkaufteArtikel = p.verkaufteArtikel();

	double gesamtumsatz = 0;
	for(int i = 0; i< verkaufteArtikel.length;i++){
			gesamtumsatz += verkaufteArtikel[i].getPreis();			
	}%>
</tr>
<tr>
<td>Gesamtumsatz: <%=gesamtumsatz %>!
	
	<% 
	double u1 = 0, u2 = 0, u3 = 0, u4 = 0;
	String d;
	for(int i = 0; i<verkaufteArtikel.length; i++){
		d = verkaufteArtikel[i].getDeadline();
		if(d.substring(5,7).equals("11")){
			u1 += verkaufteArtikel[i].getPreis();
		}
		if(d.substring(5,7).equals("12")){
			u2 += verkaufteArtikel[i].getPreis();
		}		
		if(d.substring(5,7).equals("01")){
			u3 += verkaufteArtikel[i].getPreis();
		}		
		if(d.substring(5,7).equals("02")){
			u4 += verkaufteArtikel[i].getPreis();
		}
	}
	%>
	<br>Umsatz November: <%=u1 %> Euro
	<br>Umsatz Dezember: <%=u2 %> Euro
	<br>Umsatz Jänner: <%=u3 %> Euro
	<br>Umsatz Februar: <%=u4 %> Euro</td>
</tr>

<%@ include file="Footer.jsp" %>
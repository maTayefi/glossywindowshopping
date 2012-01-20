<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="at.univie.swe.*" %>

<%@ include file="Header.jsp" %> 

<tr> 
	<td><h3>Entwicklung unserer Produktverkäufe</h3>
	<img src="http://chart.apis.google.com/chart?chxr=0,0,36&chxt=y&chs=500x225&cht=lc&chco=3D7930&chd=t:<%
	Artikel a = new Artikel();
	Integer[] iii = a.getEnd();
	for(int c = 0;c < iii.length;c++){
		%><%=iii[c] %><%=(c!=iii.length-1?",":"") %><%
	}
	%>&chg=14.3,-1,1,1&chls=2,4,0&chm=B,C5D4B5BB,0,0,0" width="500" height="225" alt="" /></td>
	
	</tr>


<%@ include file="Footer.jsp" %>
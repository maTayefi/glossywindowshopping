package at.univie.swe;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.SingleThreadModel;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GlossyWindowShopping
 */
@SuppressWarnings("deprecation")
public class GlossyWindowShopping extends HttpServlet implements SingleThreadModel{
	private static final long serialVersionUID = 1L;
    
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GlossyWindowShopping() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		boolean ignorelogin = false;
		
		// loginprozess
		if ( request.getParameter("username") != null && request.getParameter("passwort") != null) { 
			
			MySQLConnection t = new MySQLConnection();
			t.connect();
			ResultSet rs = t.get("select pid from person where name='"+request.getParameter("username")+"' and passwort='"+request.getParameter("passwort")+"'");
			try {
				rs.next();
				if (rs.getString("pid") != null){
					session = request.getSession(true);
					session.setAttribute("uid",rs.getString("pid"));
					ignorelogin = true;
				}
			} catch (SQLException e) {e.printStackTrace();
			}
			
			
		}
		
		// userdatenupdate
		if ( request.getParameter("changeusername") != null && request.getParameter("changepasswort") != null && request.getParameter("changepid") != null) { 
			
			MySQLConnection t = new MySQLConnection();
			t.connect();
			t.set("update person set name='"+request.getParameter("changeusername")+"', passwort='"+request.getParameter("changepasswort")+"' where pid='"+request.getParameter("changepid")+"'");
			
		}
		
		// neuer Artikel wird angelegt
		if ( request.getParameter("newartikelname") != null && request.getParameter("newartikelprice") != null ) { 
			
			MySQLConnection t = new MySQLConnection();
			t.connect();
			t.set("insert into artikel (name,preis,deadline,verkaeufer) values ('"+request.getParameter("newartikelname")+"','"+request.getParameter("newartikelprice")+"',DATE_ADD(NOW(), INTERVAL 7 DAY),'"+session.getAttribute("uid")+"')");
			
		}
				
		
		
		
		
		
		if (request.getParameter("a")!=null && request.getParameter("a").equals("login") && !ignorelogin){
			getServletConfig().getServletContext().getRequestDispatcher(
			        "/Login.jsp").forward(request,response);
		} else if (request.getParameter("a")!=null && request.getParameter("a").equals("searchartikel")){
			getServletConfig().getServletContext().getRequestDispatcher(
			        "/ArtikelDurchsuchen.jsp").forward(request,response);
		} else if (request.getParameter("a")!=null && request.getParameter("a").equals("artikelneu")){
			getServletConfig().getServletContext().getRequestDispatcher(
			        "/ArtikelNeu.jsp").forward(request,response);
		} else if (request.getParameter("aid")!=null){
			getServletConfig().getServletContext().getRequestDispatcher(
		        "/ArtikelDetail.jsp").forward(request,response);
		} else if (request.getParameter("pid")!=null){
			getServletConfig().getServletContext().getRequestDispatcher(
		        "/PersonDetail.jsp").forward(request,response);
		} else if (request.getParameter("rid")!=null){
			getServletConfig().getServletContext().getRequestDispatcher(
		        "/PersonChange.jsp").forward(request,response);
		} else {
			getServletConfig().getServletContext().getRequestDispatcher(
			        "/Start.jsp").forward(request,response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

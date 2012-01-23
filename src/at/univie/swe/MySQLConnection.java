package at.univie.swe;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class MySQLConnection implements DBConnection {
	ResultSet rs = null;
	Statement statement = null;
	static Connection c = null;
	
	boolean makedone = false;
	
	public MySQLConnection() {
		
		connect();
	}

	@Override
	public ResultSet get(String a) {
		Statement statement = null;
		try {
			statement = c.createStatement();
			rs = statement.executeQuery(a);
			//statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	@Override
	public void set(String a) {
		Statement statement = null;
		try {
			statement = c.createStatement();
			statement.executeUpdate(a);
			statement.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public Connection connect(){
		
		try {
		      Class.forName("com.mysql.jdbc.Driver" ).newInstance();
		  } catch (Exception e) {
		      System.err.println("ERROR: failed to load MYSQL JDBC driver.");
		      e.printStackTrace();
		      return null;
		  }
		
			try {
				if (c == null) {
					c = DriverManager.getConnection("jdbc:mysql://mysql5.univie.ac.at/a1047034", "a1047034", "swe11");
				}
				} catch (SQLException e1) {
				e1.printStackTrace();
			}
		
		
		
		return c;
	}

	@Override
	public void fill_db() {
		// this is just a alibi-function
		this.makedone = true;
		

	}

}

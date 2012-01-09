package at.univie.swe;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Person {
	private String Name;
	private String Passwort;
	private int Pid;
	Connection c;
	
	public Person(int pid) throws SQLException {
		MySQLConnection mysql = new MySQLConnection();
		c = mysql.connect();
		init(pid);

	}
	
	public Person(int pid, String name, String passwort){
		Name = name;
		Passwort = passwort;
		Pid = pid;
	}
	
	private void init(int pid) throws SQLException{
		// Gebot suchen und laden
		ResultSet rs = ((MySQLConnection) c).get("select * from person where pid = '"+ pid +"'");
		while (rs.next()) {
			 Name = rs.getString("name");
			 Passwort = rs.getString("passwort");
			 Pid = rs.getInt("pid");
					
		}
	}
	
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getPasswort() {
		return Passwort;
	}
	public void setPasswort(String passwort) {
		Passwort = passwort;
	}
	public int getPid() {
		return Pid;
	}
	public void setPid(int pid) {
		Pid = pid;
	}

}

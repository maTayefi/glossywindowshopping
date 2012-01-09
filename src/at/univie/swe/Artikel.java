package at.univie.swe;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Bildet abstrakt alle Artikel ab
 * @author Nico Pasquale Silvester Spataro a1047034
 */                   


public class Artikel {

	/**
	 * @param args
	 */
	
	private String Name;
	private int Aid;
	private float Preis;
	private int deadline;
	private int Verkaeufer;
	public Gebote[] gebote;
	
	
	Connection c = null;
	
	public Artikel(){
		
	}
	public Artikel(int aid) throws SQLException{
		MySQLConnection mysql = new MySQLConnection();
		c = mysql.connect();
		initme(aid);
	}
	
	private void initme(int aid) throws SQLException{
		// Artikel suchen und laden
		ResultSet rs = ((MySQLConnection) c).get("select * from artikel where aid = '"+ aid +"'");
		while (rs.next()) {
			 Name = rs.getString("name");
			 Aid = rs.getInt("aid");
			 Preis = rs.getFloat("preis");
			 Verkaeufer = rs.getInt("verkaeufer");
		}
//		Anzahl der Gebote holen um das Array zu initialisieren
		ResultSet rs2c = ((MySQLConnection) c).get("select count(*) from gebot where artikel = '"+ aid +"'");
		rs2c.next();
		if (rs2c.getInt(1) != 0){
			gebote = new Gebote[rs2c.getInt(1)];
		}
		ResultSet rs2 = ((MySQLConnection) c).get("select * from gebot where artikel = '"+ aid +"'  order by uhrzeit desc ");
		
		int gcount = 0;
		while (rs2.next()) {
			 gebote[gcount] = new Gebote();
			 gebote[gcount].setGid(rs.getInt("gid"));
			 gebote[gcount].setPreis(rs.getFloat("preis"));
			 gebote[gcount].setUhrzeit(rs.getInt("uhrzeit"));
			 gebote[gcount].setKaeufer(rs.getInt("kaeufer"));
			 gebote[gcount].setArtikel(rs.getInt("artikel"));
			 gcount++;
		}
		 
		 
	}
	

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public int getAid() {
		return Aid;
	}

	public void setAid(int aid) {
		Aid = aid;
	}

	public float getPreis() {
		return Preis;
	}

	public void setPreis(float preis) {
		Preis = preis;
	}

	public int getDeadline() {
		return deadline;
	}

	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}

	public int getVerkaeufer() {
		return Verkaeufer;
	}

	public void setVerkaeufer(int verkaeufer) {
		Verkaeufer = verkaeufer;
	}

	public Gebote[] getGebote() {
		return gebote;
	}

	public void setGebote(Gebote[] gebote) {
		this.gebote = gebote;
	}
	
}



package at.univie.swe;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Person {
	private String Name;
	private String Passwort;
	private int Pid;
	private String Typ;
	private double VotingVerkaeufer;
	private double VotingKaeufer;
	
	MySQLConnection c;
	
	public Person(int pid) throws SQLException {
		c = new MySQLConnection();
		init(pid);

	}
	
	public String getTyp() {
		return Typ;
	}

	public void setTyp(String typ) {
		Typ = typ;
	}

	public Person(int pid, String name, String passwort){
		Name = name;
		Passwort = passwort;
		Pid = pid;
		Typ = "Kunde";
	}
	
	public Person(int pid, String name, String passwort, String typ){
		Name = name;
		Passwort = passwort;
		Pid = pid;
		Typ = typ;
	}
	
	private void init(int pid) throws SQLException{
		// Gebot suchen und laden
		ResultSet rs = c.get("select * from person where pid = '"+ pid +"'");
		while (rs.next()) {
			 Name = rs.getString("name");
			 Passwort = rs.getString("passwort");
			 Pid = rs.getInt("pid");
			 Typ = rs.getString("typ");				
		}
		rs.close();
		ResultSet rs1 = c.get("select avg(vote) from votingverkaeufer where vid = '"+ Pid +"'");
		rs1.next();
		VotingVerkaeufer = rs1.getDouble(1);
		rs1.close();
		ResultSet rs2 = c.get("select avg(vote) from votingkaeufer where kid = '"+ Pid +"'");
		rs2.next();
		VotingKaeufer = rs2.getDouble(1);
		rs2.close();
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
	public double getVotingVerkaeufer() throws SQLException {
		return Math.round((VotingVerkaeufer* 100 ) / 100.);

	}

	public void setVotingVerkaeufer(double votingVerkaeufer) {
		VotingVerkaeufer = votingVerkaeufer;
	}

	public double getVotingKaeufer() throws SQLException {
		return VotingKaeufer;
	}

	public void setVotingKaeufer(double votingKaeufer) {
		VotingKaeufer = votingKaeufer;
	}
	
	public Artikel[] gekaufteArtikel () throws SQLException {
		ResultSet ga_count = ((MySQLConnection) c).get("select count(distinct a.aid) as ccc from artikel a, gebot g where a.deadline < NOW() and a.aid = g.artikel and g.kaeufer = '"+Pid+"'");
		ga_count.next();
		Artikel[] a = new Artikel[ga_count.getInt("ccc")];
		ga_count.close();
		ResultSet ga = ((MySQLConnection) c).get("select distinct a.aid from artikel a, gebot g where a.deadline < NOW() and a.aid = g.artikel and g.kaeufer = '"+Pid+"'");
		int gacount = 0;
		while(ga.next()){
			a[gacount] = new Artikel(ga.getInt("aid"));
			gacount++;
		}
		ga.close();
		return a;
	}
	
	public Artikel[] beboteneArtikel () throws SQLException {
		ResultSet ga_count = ((MySQLConnection) c).get("select count(distinct a.aid) as ccc from artikel a, gebot g where a.aid = g.artikel and g.kaeufer = '"+Pid+"'");
		ga_count.next();
		Artikel[] a = new Artikel[ga_count.getInt("ccc")];
		ga_count.close();
		ResultSet ga = ((MySQLConnection) c).get("select distinct a.aid from artikel a, gebot g where a.aid = g.artikel and g.kaeufer = '"+Pid+"'");
		int gacount = 0;
		while(ga.next()){
			a[gacount] = new Artikel(ga.getInt("aid"));
			gacount++;
		}
		ga.close();
		return a;
	}
	
	public Artikel[] angeboteneArtikel () throws SQLException {
		ResultSet ga_count = ((MySQLConnection) c).get("select count(distinct aid) as ccc from artikel a where verkaeufer =  '"+Pid+"'");
		ga_count.next();
		Artikel[] a = new Artikel[ga_count.getInt("ccc")];
		ga_count.close();
		ResultSet ga = ((MySQLConnection) c).get("select distinct aid from artikel a where verkaeufer =  '"+Pid+"'");
		int gacount = 0;
		while(ga.next()){
			a[gacount] = new Artikel(ga.getInt("aid"));
			gacount++;
		}
		ga.close();
		return a;
	}
}

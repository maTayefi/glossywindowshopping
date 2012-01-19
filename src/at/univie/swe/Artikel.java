package at.univie.swe;

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
	private String deadline;
	private int Verkaeufer;
	private String Kategorie;
	public Gebote[] gebote;
	private int Voting;
	public boolean abgelaufen = false;
	
	
	public MySQLConnection c =  new MySQLConnection();
	
	public Artikel(){
		
	}
	public Artikel(int aid) throws SQLException{
		initme(aid);
	}
	public int getVoting() throws SQLException {
		return Voting;
	}

	public void setVoting(int voting) {
		Voting = voting;
	}

	private void initme(int aid) throws SQLException{
		// Artikel suchen und laden
		ResultSet rs = c.get("select *, kategorie from artikel, kategorie where aid = '"+ aid +"' and kat = kid");
		while (rs.next()) {
			 Name = rs.getString("name");
			 Aid = rs.getInt("aid");
			 deadline = rs.getString("deadline");
			 Preis = rs.getFloat("preis");
			 Verkaeufer = rs.getInt("verkaeufer");
			 Kategorie =  rs.getString("kategorie");
		}
		rs.close();
		
		// checken ob der Artikel schon abgelaufen ist
		try {
			ResultSet rsa = c.get("select 'true' from artikel where aid = '"+ aid +"' and deadline <= NOW()");
			if (rsa.next())
				abgelaufen = true;
			rs.close();
		} finally {
			
		}
		
//		Anzahl der Gebote holen um das Array zu initialisieren
		ResultSet rs2c =c.get("select count(*) as ccc from gebot where artikel = '"+ aid +"'");
		rs2c.next();
		gebote = new Gebote[rs2c.getInt("ccc")];
		if (rs2c.getInt("ccc") != 0){
			ResultSet rs2 = c.get("select * from gebot where artikel = '"+ aid +"'  order by uhrzeit desc ");
			
			int gcount = 0;
			int gid = 0;
			while (rs2.next()) {
				gid = rs2.getInt("gid");
				if (gid != 0){
					 gebote[gcount] = new Gebote();
					 gebote[gcount].setGid(gid);
					 gebote[gcount].setPreis(rs2.getFloat("preis"));
					 gebote[gcount].setUhrzeit(rs2.getInt("uhrzeit"));
					 gebote[gcount].setKaeufer(rs2.getInt("kaeufer"));
					 gebote[gcount].setArtikel(rs2.getInt("artikel"));
					 gcount++;
				}
			}
		} 
		rs2c.close();
		
		ResultSet rs1 = c.get("select avg(vote) from votingartikel where aid = '"+ Aid +"'");
		rs1.next();
		
		Voting = rs1.getInt(1);
		rs1.close(); 
	}
	
	public void doBit(Integer uid, Float bit){
		c.set("insert into gebot (preis,uhrzeit,kaeufer,artikel) values ('"+Float.toString(bit)+"',NOW(),'"+Integer.toString(uid)+"', '"+Aid+"') ");
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

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public int getVerkaeufer() {
		return Verkaeufer;
	}

	public void setVerkaeufer(int verkaeufer) {
		Verkaeufer = verkaeufer;
	}
	
	public String getKategorie() {
		return Kategorie;
	}

	public void setKategorie(String kategorie) {
		Kategorie = kategorie;
	}

	public Gebote[] getGebote() {
		return gebote;
	}

	public void setGebote(Gebote[] gebote) {
		this.gebote = gebote;
	}
	
	public Kategorie[] getKats() throws SQLException{
		ResultSet rsc = c.get("select count(*) from kategorie order by kategorie");
		rsc.next();
		int size = rsc.getInt(1);
		Kategorie[] k = new Kategorie[size];
		rsc.close();
		
		ResultSet rs = c.get("select * from kategorie order by kategorie");
		int kcount = 0;
		while (rs.next()) {
			if (kcount < size){
				k[kcount] = new Kategorie();
				k[kcount].setName(rs.getString("kategorie"));
				k[kcount].setKid(rs.getInt("kid"));
			}
			kcount++;
		}
		rs.close();
		return k;
	}
	
	public Integer[] getEnd() throws SQLException{
		Integer[] out = new Integer[100];
		ResultSet rsc = c.get("select distinct deadline, count(*) from artikel group by deadline order by 1");
		int i = 0;
		while (rsc.next()){
			out[i++]= rsc.getInt(2);
		}
		Integer[] out2 = new Integer[i];
		for(int a = 0;a < i;a++){
			out2[a]=out[a];
		}
		rsc.close();
		return out2;
	}
}



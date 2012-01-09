package at.univie.swe;

import java.sql.SQLException;

public class Gebote {
	private int Gid;
	private float Preis;
	private int Uhrzeit;
	private Person Kaeufer;
	private Artikel Art;
	
	public int getGid() {
		return Gid;
	}
	public void setGid(int gid) {
		Gid = gid;
	}
	public float getPreis() {
		return Preis;
	}
	public void setPreis(float preis) {
		Preis = preis;
	}
	public int getUhrzeit() {
		return Uhrzeit;
	}
	public void setUhrzeit(int uhrzeit) {
		Uhrzeit = uhrzeit;
	}
	public Person getKaeufer() {
		return Kaeufer;
	}
	public void setKaeufer(Person kaeufer) {
		Kaeufer = kaeufer;
	}
	public void setKaeufer(int kaeufer) throws SQLException {
		Person k = new Person(kaeufer);
		Kaeufer = k;
	}
	public Artikel getArtikel() {
		return Art;
	}
	public void setArtikel(Artikel artikel) {
		Art = artikel;
	}
	public void setArtikel(int aid) throws SQLException {
		Art = new Artikel(aid);
	}


}

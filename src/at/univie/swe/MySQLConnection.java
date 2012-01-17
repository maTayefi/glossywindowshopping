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
	Connection c = null;
	
	boolean makedone = false;
	
	public MySQLConnection() {
		if (c != null) {
	      try {
	        c.close();
	      } catch (SQLException ex) {
	        ex.printStackTrace();
	        System.out.println("Problem closing the connection");
	      }
	    }
		connect();
	}

	@Override
	public ResultSet get(String a) {
		Statement statement = null;
		try {
			statement = c.createStatement();
			rs = statement.executeQuery(a);
			
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
		/*
		String url = "jdbc:mysql://localhost/test";
		Properties p = new Properties();
		p.setProperty("user", "root");
		p.setProperty("password", "");
		p.setProperty("jdcbCompliantTruncation", "false");
		
		ConnectionPool cp = new ConnectionPool("com.mysql.jdbc.Driver",url,p);
		c = cp.getConnection();
		*/
			try {
				c = DriverManager.getConnection("jdbc:mysql://localhost/test", "root", "");
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
	//c = DriverManager.getConnection("jdbc:mysql://mysql5.univie.ac.at/a1047034", "a1047034", "swe11");
		
		try { // If Database is not filled: fill
			statement = c.createStatement();
			rs = statement.executeQuery("select * from artikel limit 1");
		} catch (SQLException e) {
			System.out.println("Datenbank wird gefuellt\n");
			fill_db();
		}
		return c;
	}

	@Override
	public void fill_db() {
		String drops[] = new String [4];
		drops[0] = "drop table artikel";
		drops[1] = "drop table person";
		drops[2] = "drop table gebot";
		drops[3] = "drop table bewertung";
		
		String creates[] = new String[4];
		creates[0] = "create TABLE artikel (aid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, name VARCHAR(200) NOT NULL DEFAULT '', preis FLOAT(5,2) NOT NULL DEFAULT 0, deadline DATETIME NOT NULL DEFAULT 0, verkaeufer INTEGER UNSIGNED NOT NULL DEFAULT 0,PRIMARY KEY(aid))";
		creates[1] = "create TABLE person (pid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, name VARCHAR(45) NOT NULL DEFAULT '', passwort VARCHAR(45) NOT NULL DEFAULT '', PRIMARY KEY(pid))";
		creates[2] = "create TABLE gebot (gid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, preis FLOAT(5,2) NOT NULL DEFAULT 0, uhrzeit DATETIME NOT NULL DEFAULT 0, kaeufer INTEGER UNSIGNED NOT NULL DEFAULT 0, artikel INTEGER UNSIGNED NOT NULL DEFAULT 0,PRIMARY KEY(gid))";
		creates[3] = "create TABLE bewertung (bid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, person INTEGER UNSIGNED NOT NULL DEFAULT 0, wert INTEGER UNSIGNED NOT NULL DEFAULT 0, bewerter INTEGER UNSIGNED NOT NULL DEFAULT 0,PRIMARY KEY(bid))";
	
		String inserts[] = new String[50];
		inserts[0] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Samsung Galaxy S II (i9100) DualCore Smartphone',			'399','1','2011-12-21 21:34:16')";
		inserts[1] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Kindle eReader, Wi-Fi, 15 cm',							'199','2','2011-12-15 21:34:16')";
		inserts[2] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Fujitsu Lifebook AH530 39,6 cm (15,6 Zoll) Notebook',		'239','3','2011-12-24 21:34:16')";
		inserts[3] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Acer Aspire 3750Z-B944G50Mnkk 33,8 cm (13,3 Zoll)',		'499','1','2012-01-23 21:34:16')";
		inserts[4] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Asus X54H-SO164V 39,6 cm (15,6 Zoll) Notebook',			'399','3','2011-12-22 21:34:16')";
		inserts[5] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Sony Vaio EH2J1E/W 39,4 cm (15,5 Zoll) Notebook ',			'679','4','2011-12-20 21:34:16')";
		inserts[6] = "insert into artikel (name,preis,verkaeufer,deadline) values ('AVM FRITZ!Box Fon WLAN 7390 WLAN-Router',			'786','1','2011-12-21 21:34:16')";
		inserts[7] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Belkin Conserve Switch Überspannungsschutz (8 Steckdosen, Funkfernbedienung)',			'129','3','2011-12-19 21:34:16')";
		inserts[8] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Devolo dLAN 200 AVsmart+ Starter Kit (Netzwerk aus der Steckdose)',			'546','2','2011-12-18 21:34:16')";
		inserts[9] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Logitech M325 optische Maus schnurlos dunkelsilber',			'123','3','2011-12-19 21:34:16')";
		inserts[10] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Belkin WaveRest Gel Mauspad schwarz',			'546','4','2011-12-21 21:34:16')";
		inserts[11] = "insert into artikel (name,preis,verkaeufer,deadline) values ('AmazonBasics abgeschirmtes USB 2.0-Kabel A-Stecker auf B-Stecker, mit beleuchteten Steckern (1,8 Meter)',			'99','1','2011-12-21 21:34:16')";
		inserts[12] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Creative FATAL1TY Pro Series Gaming Headset',			'19','4','2011-12-22 21:34:16')";
		inserts[13] = "insert into artikel (name,preis,verkaeufer,deadline) values ('Logitech G510 Gaming Tastatur schnurgebunden ',			'345','2','2011-12-24 21:34:16')";
	
		inserts[14] = "insert into person (name,passwort) values ('Andy','dsfgdsf')";
		inserts[15] = "insert into person (name,passwort) values ('Nico','dsfgdsf')";
		inserts[16] = "insert into person (name,passwort) values ('Ralf','dsfgdsf')";
		inserts[17] = "insert into person (name,passwort) values ('Claudio','dsfgdsf')";
		inserts[18] = "insert into person (name,passwort) values ('Horst','dsfgdsf')";
		
		inserts[19] = "insert into bewertung (person,wert,bewerter) values ('3','4','4') ";
		inserts[20] = "insert into bewertung (person,wert,bewerter) values ('1','3','3') ";
		inserts[21] = "insert into bewertung (person,wert,bewerter) values ('2','4','3') ";
		inserts[22] = "insert into bewertung (person,wert,bewerter) values ('3','1','2') ";
		inserts[23] = "insert into bewertung (person,wert,bewerter) values ('4','4','1') ";
		inserts[24] = "insert into bewertung (person,wert,bewerter) values ('1','2','2') ";
		inserts[25] = "insert into bewertung (person,wert,bewerter) values ('2','1','3') ";
		inserts[26] = "insert into bewertung (person,wert,bewerter) values ('3','3','4') ";
		inserts[27] = "insert into bewertung (person,wert,bewerter) values ('4','3','2') ";
		inserts[28] = "insert into bewertung (person,wert,bewerter) values ('1','2','4') ";
		inserts[29] = "insert into bewertung (person,wert,bewerter) values ('2','3','3') ";
		inserts[30] = "insert into bewertung (person,wert,bewerter) values ('1','4','2') ";
		inserts[30] = "insert into bewertung (person,wert,bewerter) values ('2','5','1') ";
		inserts[31] = "insert into bewertung (person,wert,bewerter) values ('3','2','1') ";
		inserts[32] = "insert into bewertung (person,wert,bewerter) values ('4','5','3') ";
		inserts[33] = "insert into bewertung (person,wert,bewerter) values ('1','4','4') ";
		inserts[34] = "insert into bewertung (person,wert,bewerter) values ('1','3','3') ";
		inserts[35] = "insert into bewertung (person,wert,bewerter) values ('2','2','3') ";
		inserts[36] = "insert into bewertung (person,wert,bewerter) values ('3','1','1') ";
		inserts[37] = "insert into bewertung (person,wert,bewerter) values ('4','4','3') ";
		
		inserts[38] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-12','12','3','11') ";
		inserts[39] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-04','10','1','1') ";
		inserts[40] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-09','120','4','12') ";
		inserts[41] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-05','102','4','6') ";
		inserts[42] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-03','99','4','8') ";
		inserts[43] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-09','45','3','7') ";
		inserts[44] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-10','12','3','6') ";
		inserts[45] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-11','19','3','5') ";
		inserts[46] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-05','18','1','5') ";
		inserts[47] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-07','112','1','8') ";
		inserts[48] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-04','198','3','3') ";
		inserts[49] = "insert into gebot (uhrzeit,preis,kaeufer,artikel) values ('2011-12-09','8','3','1') ";
		
		for (int i = 0; i < drops.length; i++){
			set(drops[i]);
		}
		
		for (int i = 0; i < creates.length; i++){
			set(creates[i]);
		}
		
		set("commit;");
		
		for (int i = 0; i < inserts.length; i++){
			set(inserts[i]);
		}
		this.makedone = true;
		

	}

}

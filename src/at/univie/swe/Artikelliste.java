package at.univie.swe;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Artikelliste {
	MySQLConnection c = null;
	
	public  Artikel[] suche (String search, int kat) throws SQLException {
		
	c =  new MySQLConnection();
	
		String select1 = "select count(distinct aid) as ccc from artikel where deadline > NOW() ";
		String select2 = "select distinct aid from artikel where deadline > NOW() ";
		
		if (!search.equals("")){ // wenn der Suchstring nicht leer ist, wird er für die selektion verwendet
			select1 = select1 + "  and name like  '%"+search+"%'";
			select2 = select2 + "  and name like  '%"+search+"%'";
		}
		if (kat != 0){ // wenn der Suchstring nicht leer ist, wird er für die selektion verwendet
			select1 = select1 + "  and kat =  "+kat+" ";
			select2 = select2 + "  and kat =  "+kat+" ";
		}
		select1 = select1 + "   order by deadline ";
		select2 = select2 + "   order by deadline ";
	
		ResultSet ga_count = c.get(select1);
		ga_count.next();
		Artikel[] a = new Artikel[ga_count.getInt("ccc")];
		ga_count.close();
		
		ResultSet ga = c.get(select2);
		
		int gacount = 0;
		while(ga.next()){
			a[gacount] = new Artikel(ga.getInt("aid"));
			gacount++;
		}
		ga.close();
		return a;
	}
}

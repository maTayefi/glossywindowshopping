package at.univie.swe;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public interface DBConnection {
	public ResultSet get(String a);
	public void set(String a);
	public Connection connect();
	public void fill_db();
}

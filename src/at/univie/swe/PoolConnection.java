package at.univie.swe;

import java.sql.Connection;

class PoolConnection{
	Connection  con;
	boolean		fInUse;
	
	public PoolConnection(Connection con, boolean fInUse){
		this.con=con;
		this.fInUse=fInUse;
	}
}
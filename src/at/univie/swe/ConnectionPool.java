package at.univie.swe;


import java.sql.*;
import java.util.*;

public class ConnectionPool{
	Vector vPool = new Vector();
	String strDriver, strURLDatabase, user, pass;
	Properties p;
	
	public ConnectionPool(String strDriver, String strURLDatabase, Properties p){
		this.strDriver=strDriver;
		this.strURLDatabase=strURLDatabase;
		this.p=p;
	}
	
	
	public Connection getConnection(){
		PoolConnection poolCon;
		for (int c=0; c < vPool.size(); c++)
			if (((PoolConnection)vPool.elementAt(c)).fInUse == false){
				poolCon = (PoolConnection)vPool.elementAt(c);
				poolCon.fInUse=true; 
				return poolCon.con;
			}

		Connection con;
		try{
			Class.forName(strDriver);
			con = DriverManager.getConnection(strURLDatabase, p);
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
		
		poolCon = new PoolConnection(con, true);
		vPool.addElement(poolCon);
		return con;
	}


	public void closeConnection(Connection con){
		try {
			int c=0;
			while (!((PoolConnection)vPool.elementAt(c)).con.equals(con))
				c++;
			((PoolConnection)vPool.elementAt(c)).fInUse=false;
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
}

package citi.test.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import citi.test.beans.Stats;

public class StatsRetriever {

	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:databaseName";
		String username = "edwdev/qarun";// username
		String password = "Hurricane1";// password
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, username, password);
		return conn;
	}
	public List queryDB() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List l = new ArrayList();
		try 
		{
			conn = getConnection();
			String query = "select distinct databasename from dbc.tables";

			pstmt = conn.prepareStatement(query); // create a statement
			pstmt.setInt(1, 1001); // set input parameter
			rs = pstmt.executeQuery();
			// extract data from the ResultSet
			while (rs.next()) {
				l.add(rs.getString(0));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return l;
		}

	}

	public List queryTables(String db) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List l = new ArrayList();
		try {
			conn = getConnection();
			String query = "select distinct tablename from dbc.tables where databasename like '%"
					+ db + "%'";

			pstmt = conn.prepareStatement(query); // create a statement
			pstmt.setInt(1, 1001); // set input parameter
			rs = pstmt.executeQuery();

			// extract data from the ResultSet
			while (rs.next()) {
				l.add(rs.getString(0));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return l;
		}

	}

	public List<Stats> queryStats(String table) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Stats> l = new ArrayList<Stats>();
		try {
			conn = getConnection();
			String query = "select "
					+ " TRIM(TRAILING ';' FROM SUBSTR(QueryText,12,60))  AS TableName,"
					+ " logdate,                                  sum(EXTRACT (SECOND "
					+ " FROM   FirstRespTime) +  (EXTRACT (MINUTE "
					+ " FROM   FirstRespTime) * 60 ) + (EXTRACT (HOUR "
					+ " FROM   FirstRespTime) *60*60 ) + (86400 * (CAST ( FirstRespTime AS DATE)  -  CAST ( starttime AS DATE) ) ) -  (EXTRACT (SECOND "
					+ " FROM   starttime) +  (EXTRACT (MINUTE "
					+ " FROM   starttime) * 60 ) +  (EXTRACT (HOUR "
					+ " FROM   starttime) *60*60 ) )) AS QryRespTime "
					+ " , sum(a.AMPCPUTIME) AS SumCPU,  sum( "
					+ " CASE   WHEN AMPCPUTime < 1 "
					+ " OR     (AMPCPUTime /  (HASHAMP()+1)) =0 THEN 0 "
					+ " ELSE   MaxAMPCPUTime/(AMPCPUTime /  (HASHAMP()+1))"
					+ " END    (DEC(8,2))) AS CPUSKW, sum("
					+ " CASE   WHEN AMPCPUTime < 1"
					+ " OR     (TotalIOCount /  (HASHAMP()+1)) =0 THEN 0"
					+ " ELSE   MaxAmpIO/(TotalIOCount /  (HASHAMP()+1))"
					+ " END    (DEC(8,2))) AS IOSKW, sum( "
					+ " CASE   WHEN AMPCPUTime < 1 "
					+ " OR     TotalIOCount = 0 THEN 0 ELSE   (a.AMPCPUTime"
					+ " *1000)/a.TotalIOCount END    )  AS PJI, sum("
					+ " CASE   WHEN AMPCPUTime < 1"
					+ " OR     AMPCPUTime = 0 THEN 0 ELSE"
					+ " a.TotalIOCount/(a.AMPCPUTime *1000)"
					+ " END    )  AS UII,"
					+ " sum(coalesce(utilityrowcount,0)) as rowct,"
					+ " sum(a.TotalIOCount) AS SumIO"
					+ " from   PDCRINFO.DBQLogTbl a"
					+ " where  a.logdate >= '2011-01-01'"
					+ " and    a.logdate <= '2011-01-05'"
					+ " and    trim(a.statementType)='Execute Mload'"
					+ " and querytext like '%" + table + "%'" + "group  by 1,2 "; 

			pstmt = conn.prepareStatement(query); // create a statement
			pstmt.setInt(1, 1001); // set input parameter
			rs = pstmt.executeQuery();
			// extract data from the ResultSet
			while (rs.next()) {
				Stats stats = new Stats();
				stats.setLogDate(String.valueOf(rs.getObject(0)));
				stats.setQueryResponseTime(String.valueOf(rs.getObject(1)));
				stats.setSumCPU(String.valueOf(rs.getObject(2)));
				stats.setCpuSkw(String.valueOf(rs.getObject(3)));
				stats.setIoSkw(String.valueOf(rs.getObject(4)));
				stats.setPji(String.valueOf(rs.getObject(5)));
				stats.setUii(String.valueOf(rs.getObject(6)));
				stats.setRowCount(String.valueOf(rs.getObject(7)));
				stats.setSumIO(String.valueOf(rs.getObject(8)));
				// stats.setImpactCpu( String.valueOf( rs.getObject(i) ) );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return l;
		}
	}
}

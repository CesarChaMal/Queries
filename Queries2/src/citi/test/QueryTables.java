package citi.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import citi.test.beans.Stats;
import citi.test.dao.StatsRetriever;

/**
 * Servlet implementation class QueryTables
 */
public class QueryTables extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryTables() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String db = request.getParameter("db");
		String table = request.getParameter("table");
		String page = request.getParameter("page");
		int pageNumber = Integer.parseInt(page);
		if (pageNumber == 1)
		{
			List<String> dbNames = new ArrayList<String>();
			for (int i = 0; i <10; i++)
			{
				dbNames.add("DB"+i);
			}
			request.setAttribute("dbNames", dbNames);
			RequestDispatcher view = request.getRequestDispatcher("db_names.jsp");
			view.forward(request, response);
		}
		else if (pageNumber==2) 
		{
			PrintWriter out = response.getWriter();
			out.print("pl" + db);
			List<String> tableNames = new ArrayList<String>();
			for (int i = 0; i <10; i++)
			{
				tableNames.add("Table :"+i);
			}
			request.setAttribute("tableNames", tableNames);
			RequestDispatcher view = request.getRequestDispatcher("table_names.jsp");
			view.forward(request, response);
		}
		else if (pageNumber==3)
		{
			String dbName = (String) request.getParameter("dbName");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			List<Stats> list = new ArrayList<Stats>();
			for (long i = 0; i < 100; i++)
			{
				Date d = new Date();
				d.setTime(System.currentTimeMillis() + ((long)(i*86400000)));
				Stats stats = new Stats();
				stats.setLogDate(sdf.format(d));
				stats.setSumIO(""+ 7* Math.random());
				stats.setRowCount(""+ 3 * Math.random());
				stats.setCpuSkw("" +  5* Math.random());
				stats.setIoSkw("" + 2* Math.random());
				stats.setPji("" +  3* Math.random());
				stats.setUii("" + 6* Math.random());
				stats.setSumCPU("" + 7* Math.random());
				stats.setQueryResponseTime("" + 9* Math.random());
				list.add(stats);
			}
			request.setAttribute("dbStats", list);
			RequestDispatcher view = request.getRequestDispatcher("result.jsp");
			view.forward(request, response);
		
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String db = request.getParameter("db");
		String table = request.getParameter("table");
		StatsRetriever dbRetiever = new StatsRetriever();
		ResultSet rs = null;
		List result = null;
		RequestDispatcher view = null;
		int page = Integer.parseInt(request.getParameter("page"));
		switch (page){

		case 1:
			if (db == null || db == "" && table == null || table == "") 
			{// get db names
				result = dbRetiever.queryDB();
				Collections.sort(result);
				request.setAttribute("dbNames", result);
				view = request.getRequestDispatcher("db_names.jsp");
			} 
			break;
		case 2:
			if (db != null && db != "" ) 
			{// get table names
				result = dbRetiever.queryTables(db);
				Collections.sort(result);
				request.setAttribute("tableNames", result);
				view = request.getRequestDispatcher("table_names.jsp");
			}
			break;
		case 3: 
			if (table != null && table != "") 
			{// get table stats
				result = dbRetiever.queryStats(table);
				request.setAttribute("dbStats", result);
				view = request.getRequestDispatcher("result.jsp");
			}
			break;
		}
		view.forward(request, response);
	}
}

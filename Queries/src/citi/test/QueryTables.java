package citi.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import citi.test.beans.Stats;

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
		String dbName = (String) request.getParameter("dbName");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		List<Stats> list = new ArrayList<Stats>();
		for (long i = 0; i < 10; i++)
		{
			Date d = new Date();
			int minutesToAdd = 360;  // 6 hrs
			//Calendar cal = Calendar.getInstance();
			//cal.add(Calendar.MINUTE, minutesToAdd*4); 			
			//d.setTime(System.currentTimeMillis() + ((long)(i*86400000)));
			d.setTime(System.currentTimeMillis() + minutesToAdd*4 );
			d.setTime(d.getTime());
			
			Stats stats = new Stats();
			//stats.setLogDate(sdf.format(d));
			stats.setLogDate(sdf.format(d));
			stats.setSumIO(""+ i*63);
			stats.setRowCount(""+ i *34);
			stats.setCpuSkw("" + i * 54);
			stats.setIoSkw("" + i *12);
			stats.setPji("" + i * 142);
			stats.setUii("" + i *15);
//			stats.setLogDate("logDate " +i + " from " + dbName);
//			stats.setCpuSkw("cpuSkw " +i + " from " + dbName);
//			stats.setImpactCpu("impactCpu " + i + "from" + dbName);
//			stats.setIoSkw("ioSkw " + i+ " from " + dbName);
//			stats.setPji("pji " + i+ " from " + dbName);
//			stats.setQueryResponseTime("queryResponseTime " + i+ " from " + dbName);
//			stats.setRowCount("rowCount " + i+ " from " + dbName);
//			stats.setSumCPU("sumCPU " + i+ " from " + dbName);
//			stats.setSumIO("sumIO " + i+ " from " + dbName);
//			stats.setUii("uii " + i+ " from " + dbName);
			list.add(stats);
		}
		request.setAttribute("stats", list);
		RequestDispatcher view = request.getRequestDispatcher("result.jsp");
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 
	}

}

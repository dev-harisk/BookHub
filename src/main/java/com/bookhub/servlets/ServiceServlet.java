package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import com.bookhub.dao.ServiceDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Book;
import com.bookhub.model.Service;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ServiceServlet
 */
public class ServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		
		ServiceDAO serviceDAO=new ServiceDAO(DbConnection.getConnection());
		String opt=request.getParameter("operation");
		
		if("loadTableData".equals(opt)) {
			List<Service> bList=serviceDAO.loadTransactions();
			Gson json=new Gson();
			String tableData=json.toJson(bList);
			response.getWriter().write(tableData);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		
		Service service=new Service();
		ServiceDAO serviceDAO=new ServiceDAO(DbConnection.getConnection());
		String opt=request.getParameter("opr");
		
		java.time.LocalDate currentDate = java.time.LocalDate.now();

        // Create a java.sql.Date object
        java.sql.Date returnDate = java.sql.Date.valueOf(currentDate);		
		
        service.setBook_id(Integer.parseInt(request.getParameter("book_id")));
		service.setMember_id(Integer.parseInt(request.getParameter("member_id")));
		service.setReturn_date(returnDate);
		
		
		if("issue".equals(opt)) {
			int isIssued=serviceDAO.issueBook(service.getBook_id(), service.getMember_id());
			
			if(isIssued==1) {
				// Create a response object
		        Response responseObj = new Response();
		        responseObj.setMessage("Book issued successfully");
		        responseObj.setStatus("success");

		        // Convert the response object to JSON
		        Gson gson = new GsonBuilder().create();
		        String jsonResponse = gson.toJson(responseObj);
		        
		     // Send the JSON response
		        PrintWriter out = response.getWriter();
		        out.print(jsonResponse);
		        out.flush();
			}
			else {
				// Create a response object
		        Response responseObj = new Response();
		        responseObj.setMessage("Book Issue Failure");
		        responseObj.setStatus("error");

		        // Convert the response object to JSON
		        Gson gson = new GsonBuilder().create();
		        String jsonResponse = gson.toJson(responseObj);
		        
		     // Send the JSON response
		        PrintWriter out = response.getWriter();
		        out.print(jsonResponse);
		        out.flush();
			}
		}
		
		
		if("return".equals(opt)) {
			
	        int isReturned=serviceDAO.returnBook(service.getBook_id(), service.getMember_id(),service.getReturn_date());
			
			if(isReturned==1) {
				// Create a response object
		        Response responseObj = new Response();
		        responseObj.setMessage("Book returned successfully");
		        responseObj.setStatus("success");

		        // Convert the response object to JSON
		        Gson gson = new GsonBuilder().create();
		        String jsonResponse = gson.toJson(responseObj);
		        
		     // Send the JSON response
		        PrintWriter out = response.getWriter();
		        out.print(jsonResponse);
		        out.flush();
			}
			else {
				// Create a response object
		        Response responseObj = new Response();
		        responseObj.setMessage("Book Issue Failure");
		        responseObj.setStatus("error");

		        // Convert the response object to JSON
		        Gson gson = new GsonBuilder().create();
		        String jsonResponse = gson.toJson(responseObj);
		        
		     // Send the JSON response
		        PrintWriter out = response.getWriter();
		        out.print(jsonResponse);
		        out.flush();
			}
		}
	}

}

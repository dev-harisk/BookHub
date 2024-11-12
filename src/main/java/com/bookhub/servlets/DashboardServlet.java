package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.bookhub.dao.DashboardDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Book;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class DashboardServlet
 */
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Book book=new Book();
		book.setBook_id(Integer.parseInt(request.getParameter("title")));
		
		DashboardDAO dashboardDAO=new DashboardDAO(DbConnection.getConnection());
		boolean isAvailable=dashboardDAO.bookIsAvailable(book.getBook_id());
	//	System.out.println(isAvailable);
		if(isAvailable) {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Book is available");
	        responseObj.setStatus("success");

	        // Convert the response object to JSON
	        Gson gson = new Gson();
	        String jsonResponse = gson.toJson(responseObj);
	       // System.out.println(jsonResponse);
	        
	     // Send the JSON response
	        PrintWriter out = response.getWriter();
	        out.print(jsonResponse);
	        out.flush();
		}
		else {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Book is not available");
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

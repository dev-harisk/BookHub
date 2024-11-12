package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.bookhub.dao.LibrarianDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Librarian;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class LibrarianEditServlet
 */
public class LibrarianEditServlet extends HttpServlet {
       
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     * @see HttpServlet#HttpServlet()
     */
    public LibrarianEditServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		String opt = request.getParameter("operation");

		if ("loadLibrarianDetails".equals(opt)) {
			String username = request.getParameter("username");

			LibrarianDAO librarianDAO = new LibrarianDAO(DbConnection.getConnection());
			List<Librarian> librarianList = librarianDAO.getLibrarianDetailsByEmail(username);
			Gson json = new Gson();
			String userData = json.toJson(librarianList);
			response.getWriter().write(userData);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Librarian librarian = new Librarian();
		librarian.setLibrarian_id(Integer.parseInt(request.getParameter("edit_librarian_id")));
		librarian.setLibrarian_name(request.getParameter("edit_name"));
		librarian.setLibrarian_email(request.getParameter("edit_email"));
		librarian.setLibrarian_address(request.getParameter("edit_address"));
		
		LibrarianDAO librarianDAO = new LibrarianDAO(DbConnection.getConnection());
		int isUpdated =librarianDAO.updateLibrarianDetails(librarian.getLibrarian_id(),
			librarian.getLibrarian_name(), librarian.getLibrarian_email(),
			librarian.getLibrarian_address());
		//System.out.println(isUpdated);
		
		if(isUpdated>=1) {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Librarian details updated successfully");
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
	        responseObj.setMessage("Librarian details updation failure");
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

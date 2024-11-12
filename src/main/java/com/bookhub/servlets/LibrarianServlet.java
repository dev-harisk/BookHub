package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.bookhub.dao.LibrarianDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Librarian;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class LibrarianServlet
 */
public class LibrarianServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LibrarianServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		String opt = request.getParameter("operation");

		if ("loadLibrarianDetails".equals(opt)) {
			//System.out.println("Hey fool you made a mistake");
			String username = request.getParameter("username");
			//System.out.println(username);

			LibrarianDAO librarianDAO = new LibrarianDAO(DbConnection.getConnection());
			List<Librarian> librarianList = librarianDAO.getLibrarianDetailsByEmail(username);
			Gson json = new Gson();
			String memberData = json.toJson(librarianList);
			response.getWriter().write(memberData);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		String pwd=request.getParameter("newpassword");
		//System.out.println(pwd);
	
		HttpSession session=request.getSession();
		String email=(String)session.getAttribute("useremail");
		
	//	System.out.println(email);
		
		Librarian librarian=new Librarian();
		librarian.setLibrarian_email(email);
		librarian.setLogin_password(pwd);
		
		LibrarianDAO librarianDAO=new LibrarianDAO(DbConnection.getConnection());
		int isUpdated=librarianDAO.updatePassword(librarian.getLogin_password(), librarian.getLibrarian_email());
		
		
		
		
		if(isUpdated>=1) {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Password updated successfully");
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
	        responseObj.setMessage("Password updation failure");
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

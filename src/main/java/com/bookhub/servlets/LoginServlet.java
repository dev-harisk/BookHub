package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.bookhub.dao.LoginDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Librarian;
import com.google.gson.Gson;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		Librarian librarian = new Librarian();
		librarian.setLibrarian_email(request.getParameter("email"));
		librarian.setLogin_password(request.getParameter("pwd"));

		LoginDAO loginDAO = new LoginDAO(DbConnection.getConnection());
		List<Librarian> librarian_details = loginDAO.authentication(librarian.getLibrarian_email(),
				librarian.getLogin_password());
		try {

			if (librarian_details.size() == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("user_details", librarian_details.get(0));
			//	System.out.println(session.getAttribute("user_details"));
				
				response.getWriter().write("{\"redirect\":\"index.jsp\"}");
				//response.getWriter().write("{\"user_details\":"+librarian_details+"}");
			}

			/*
			 * if(user_email!=null&&!user_email.isEmpty()) { try {
			 * 
			 * 
			 * System.out.println(userName); HttpSession session=request.getSession();
			 * session.setAttribute("username",userName);
			 * response.sendRedirect("index.jsp");
			 * 
			 * 
			 * HttpSession session=request.getSession(); session.setAttribute("username",
			 * user_email);
			 * 
			 * response.getWriter().write("{\"redirect\":\"index.jsp\"}");
			 * 
			 * 
			 * } catch(Exception e) { System.out.println(e); } }
			 */
			else {
				response.sendRedirect("login.jsp");
				// System.out.println("Something wrong");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}

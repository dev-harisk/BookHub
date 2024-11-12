package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.bookhub.dao.BooksDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Book;

/**
 * Servlet implementation class BookRemoveServlet
 */
public class BookRemoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookRemoveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
			
			Book book=new Book();
			book.setBook_id(Integer.parseInt(request.getParameter("bookId")));
			
			BooksDAO booksDAO=new BooksDAO(DbConnection.getConnection());
			int rowAffected=booksDAO.removeBook(book.getBook_id());
		
		
	}

}

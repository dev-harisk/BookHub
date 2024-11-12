package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.bookhub.dao.BooksDAO;
import com.bookhub.dao.GenreDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Book;

/**
 * Servlet implementation class BookEditServlet
 */
public class BookEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookEditServlet() {
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
		book.setBook_id(Integer.parseInt(request.getParameter("edit_book_id")));
		book.setGenre_id(Integer.parseInt(request.getParameter("edit_genre")));
		book.setTitle(request.getParameter("edit_title"));
		book.setAuthor_name(request.getParameter("edit_author"));
		book.setPublisher(request.getParameter("edit_publisher"));
		book.setPublished_year(request.getParameter("edit_published_year"));
		book.setIsbn(request.getParameter("edit_isbn"));
		book.setNo_of_copies(Integer.parseInt(request.getParameter("edit_copies")));
		
		GenreDAO genreDAO=new GenreDAO(DbConnection.getConnection());
		book.setAuthor_id(genreDAO.insertAuthorName(book.getAuthor_name()));
		
		BooksDAO bookEditDAO=new BooksDAO(DbConnection.getConnection());
		int isUpdated=bookEditDAO.updateBooks(book.getBook_id(),book.getTitle(), book.getAuthor_id(),book.getGenre_id(),book.getPublisher(),book.getPublished_year(),book.getIsbn(),book.getNo_of_copies());
	}

}

package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.bookhub.dao.BooksDAO;
import com.bookhub.dao.GenreDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Book;
import com.bookhub.model.Genre;
import com.google.gson.Gson;

/**
 * Servlet implementation class BookServlet
 */
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookServlet() {
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			BooksDAO booksDAO=new BooksDAO(DbConnection.getConnection());
			GenreDAO genreDAO=new GenreDAO(DbConnection.getConnection());
			String opt=request.getParameter("operation");
			
			if("loadTableData".equals(opt)) {
				List<Book> bList=booksDAO.loadTableData();
				Gson json=new Gson();
				String tableData=json.toJson(bList);
				response.getWriter().write(tableData);
			}
			
			if("loadGenres".equals(opt)) {
				List<Genre> gList=genreDAO.getAllGenre();
				Gson json=new Gson();
				String genreList=json.toJson(gList);
				response.getWriter().write(genreList);
			}
			
			if("loadBookDetails".equals(opt)){
				int bookId = Integer.parseInt(request.getParameter("bookId"));
				List<Book> bList=booksDAO.getBookDetailsByBook_Id(bookId);
				Gson json=new Gson();
				String tableData=json.toJson(bList);
				response.getWriter().write(tableData);
			}
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		
			Book book=new Book();
			book.setGenre_id(Integer.parseInt(request.getParameter("genre")));
			book.setTitle(request.getParameter("title"));
			book.setAuthor_name(request.getParameter("author"));
			book.setPublisher(request.getParameter("publisher"));
			book.setPublished_year(request.getParameter("year"));
			book.setIsbn(request.getParameter("isbn"));
			book.setNo_of_copies(Integer.parseInt(request.getParameter("copies")));
			
			GenreDAO genreDAO=new GenreDAO(DbConnection.getConnection());
			book.setAuthor_id(genreDAO.insertAuthorName(book.getAuthor_name()));
			
			BooksDAO bookAddDAO=new BooksDAO(DbConnection.getConnection());
			int affected=bookAddDAO.addBooks(book.getTitle(), book.getAuthor_id(),book.getGenre_id(),book.getPublisher(),book.getPublished_year(),book.getIsbn(),book.getNo_of_copies() );
	}

}

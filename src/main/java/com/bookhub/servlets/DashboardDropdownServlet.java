package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.bookhub.dao.DashboardDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Author;
import com.bookhub.model.Book;
import com.bookhub.model.Genre;
import com.google.gson.Gson;

/**
 * Servlet implementation class DashboardDropdownServlet
 */
public class DashboardDropdownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardDropdownServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");	
		response.setCharacterEncoding("UTF-8");
		
		
		DashboardDAO dashboardDAO=new DashboardDAO(DbConnection.getConnection());	
		String opt=request.getParameter("operation");
		
		if("genre".equals(opt)) {
			
			List<Genre> gList=dashboardDAO.getAllGenre();
			Gson json=new Gson();
			String genreList=json.toJson(gList);
			
			response.getWriter().write(genreList);
		}
		
		if("author".equals(opt)) {
			String genre_Id = request.getParameter("id");
			
			if(genre_Id!=null){
				List<Author> aList=dashboardDAO.getAuthorNameByGenreId(Integer.parseInt(genre_Id));
				Gson json=new Gson();
				String authorList=json.toJson(aList);	
				response.getWriter().write(authorList);
			}
			else {
				response.getWriter().write("[]");
			}
	}
		if("title".equals(opt)) {
			String author_Id = request.getParameter("id");
			
			if(author_Id!=null){
				List<Book> bList=dashboardDAO.getTitleByAuthorId(Integer.parseInt(author_Id));
				Gson json=new Gson();
				String bookList=json.toJson(bList);	
				response.getWriter().write(bookList);
			}
			else {
				response.getWriter().write("[]");
			}
	}
}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}

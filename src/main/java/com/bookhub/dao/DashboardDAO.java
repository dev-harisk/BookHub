package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Author;
import com.bookhub.model.Book;
import com.bookhub.model.Genre;

public class DashboardDAO {
	
	
	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst=null;
	ResultSet rs = null;
	String query;

	private int totalBooks;
	private int totalMembers;
	private int totalAuthors;
	private double fineAmount;
	
	
	public DashboardDAO() {
		
	}
	
	public DashboardDAO(Connection con) {
		this.con=con;
	}

	public int getTotalBooks() {
		return totalBooks;
	}

	public void setTotalBooks(int totalBooks) {
		this.totalBooks = totalBooks;
	}

	public int getTotalMembers() {
		return totalMembers;
	}

	public void setTotalMembers(int totalMembers) {
		this.totalMembers = totalMembers;
	}

	public int getTotalAuthors() {
		return totalAuthors;
	}

	public void setTotalAuthors(int totalAuthors) {
		this.totalAuthors = totalAuthors;
	}

	public double getFineAmount() {
		return fineAmount;
	}

	public void setFineAmount(double fineAmount) {
		this.fineAmount = fineAmount;
	}

	public void getBookCount() {

		query = "SELECT COUNT(book_id) FROM books";

		try {
			con = DbConnection.getConnection();
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			if (rs.next()) {
				this.setTotalBooks(rs.getInt(1));
			}
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void getMemberCount() {

		query = "SELECT COUNT(member_id) FROM members";

		try {
			con = DbConnection.getConnection();
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			if (rs.next()) {
				this.setTotalMembers(rs.getInt(1));
			}
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	public void getAuthorCount() {

		query = "SELECT COUNT(author_id) FROM authors";

		try {
			con = DbConnection.getConnection();
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			if (rs.next()) {
				this.setTotalAuthors(rs.getInt(1));
			}
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	public void getFineAmounts() {
		
		query="SELECT SUM(fine_amount) FROM transactions";
		
		
		try {
			con=DbConnection.getConnection();
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			if(rs.next()) {
				this.setFineAmount(rs.getDouble(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	public List<Genre> getAllGenre(){
		
		List<Genre> genreList=new ArrayList<>();
		
		query="SELECT * FROM genre";
		
		try {
			pst=this.con.prepareStatement(query);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				Genre genre=new Genre();
				genre.setGenre_id(rs.getInt("genre_id"));
				genre.setGenre_name(rs.getString("genre_name"));
				genreList.add(genre);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return genreList;
	
	}
	
public List<Author> getAuthorNameByGenreId(int genre_id){
		
		List<Author> authorList=new ArrayList<>();
		
		query="{CALL getAuthorNameByGenreId(?)}";
		try {
			cst=this.con.prepareCall(query);
			cst.setInt(1, genre_id);
			rs=cst.executeQuery();
			
			while(rs.next()) {
				Author author=new Author();
				author.setAuthor_id(rs.getInt("author_id"));
				author.setAuthor_name(rs.getString("author_name"));
				authorList.add(author);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return authorList;
	
	}

	public List<Book> getTitleByAuthorId(int author_id){
		
		List<Book> bookList=new ArrayList<>();
		
		query="{CALL getBookTitleByAuthorId(?)}";
		
		try {
			cst=this.con.prepareCall(query);
			cst.setInt(1, author_id);
			rs=cst.executeQuery();
			
			while(rs.next()) {
				Book book=new Book();
				book.setBook_id(rs.getInt("book_id"));
				book.setTitle(rs.getString("title"));
				bookList.add(book);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bookList;
		
	}
	
	public boolean bookIsAvailable(int book_id) {
		
		int isAvailable=-1;
		
		query="SELECT no_of_copies FROM book_availability WHERE book_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setInt(1, book_id);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				isAvailable=rs.getInt("no_of_copies");
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(isAvailable>0){
			return true;
		}
		
		
		return false;
	}

}

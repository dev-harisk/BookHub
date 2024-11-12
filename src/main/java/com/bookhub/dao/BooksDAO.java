package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.model.Book;


public class BooksDAO {
	
	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst=null;
	ResultSet rs = null;
	String query;
	
	public BooksDAO(){
		
	}
	
	public BooksDAO(Connection con) {
		this.con=con;	
	}
	

	public List<Book> loadTableData(){
		
		List<Book> bookList=new ArrayList<>();
		
		query="SELECT * FROM get_book_details";
		
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				Book book=new Book();
				book.setBook_id(rs.getInt("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor_name(rs.getString("author_name"));
				book.setGenre_name(rs.getString("genre_name"));
				book.setPublisher(rs.getNString("publisher"));
				book.setPublished_year(rs.getString("published_year"));
				book.setIsbn(rs.getString("isbn"));
				book.setNo_of_copies(rs.getInt("no_of_copies"));
				
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
	
	public int addBooks(String title,int author_id,int genre_id,String publisher,String published_year,String isbn,int no_of_copies) {
		
		int rowAffected=0;
		query="INSERT INTO books(title,author_id,genre_id,publisher,published_year,isbn,no_of_copies) VALUES (?,?,?,?,?,?,?)";
		try {
			pst=this.con.prepareStatement(query);
			pst.setString(1, title);
			pst.setInt(2, author_id);
			pst.setInt(3, genre_id);
			pst.setString(4, publisher);
			pst.setString(5, published_year);
			pst.setString(6, isbn);
			pst.setInt(7, no_of_copies);
			rowAffected=pst.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(rowAffected>0)
				return rowAffected;
		
		return -1;
	}
	
public int updateBooks(int book_id,String title,int author_id,int genre_id,String publisher,String published_year,String isbn,int no_of_copies) {
		
		int rowAffected=0;
		query="UPDATE  books "
				+ "SET title=?,"
				+ "author_id=?,"
				+ "genre_id=?,"
				+ "publisher=?,"
				+ "published_year=?,"
				+ "isbn=?,"
				+ "no_of_copies=? "
				+ "WHERE book_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setString(1, title);
			pst.setInt(2, author_id);
			pst.setInt(3, genre_id);
			pst.setString(4, publisher);
			pst.setString(5, published_year);
			pst.setString(6, isbn);
			pst.setInt(7, no_of_copies);
			pst.setInt(8, book_id);
			rowAffected=pst.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(rowAffected>0)
				return rowAffected;
		
		return -1;
	}

	public int removeBook(int book_id) {
		
		int rowAffected=0;
		
		query="DELETE FROM books WHERE book_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setInt(1, book_id);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(rowAffected>0)
			return rowAffected;
	
	return -1;
	}
	
public List<Book> getBookDetailsByBook_Id(int book_id){
		
		List<Book> bookList=new ArrayList<>();
		
		query="SELECT * FROM get_book_details WHERE book_id=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1,book_id);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				Book book=new Book();
				book.setBook_id(rs.getInt("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor_id(rs.getInt("author_id"));;
				book.setAuthor_name(rs.getString("author_name"));
				book.setGenre_id(rs.getInt("genre_id"));
				book.setGenre_name(rs.getString("genre_name"));
				book.setPublisher(rs.getNString("publisher"));
				book.setPublished_year(rs.getString("published_year"));
				book.setIsbn(rs.getString("isbn"));
				book.setNo_of_copies(rs.getInt("no_of_copies"));
				
				bookList.add(book);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return bookList;
		
	}

}

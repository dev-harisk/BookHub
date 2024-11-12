package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Librarian;

public class LoginDAO {
	
	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst=null;
	ResultSet rs = null;
	String query;
	
	public LoginDAO() {
	}
	
	public LoginDAO(Connection con) {
		this.con=con;
	}
	
	public List<Librarian> authentication(String email,String password) {
		
		List<Librarian> librarianList=new ArrayList<>();
		
		query="SELECT * FROM librarian WHERE librarian_email=? AND login_password=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2,password);
			
			rs=pst.executeQuery();
			
			while(rs.next()) {
					Librarian librarian=new Librarian();
					librarian.setLibrarian_id(rs.getInt("librarian_id"));
					librarian.setLibrarian_email(rs.getString("librarian_email"));
					librarian.setLibrarian_name(rs.getString("librarian_name"));
					librarian.setLibrarian_address(rs.getString("librarian_address"));
					librarianList.add(librarian);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(librarianList.size()==1)
			return librarianList;
		
		
		return null;
	}

}

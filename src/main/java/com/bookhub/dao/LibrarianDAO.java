package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.model.Librarian;

public class LibrarianDAO {

	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst = null;
	ResultSet rs = null;
	String query;

	public LibrarianDAO() {

	}

	public LibrarianDAO(Connection con) {
		this.con = con;
	}

	public List<Librarian> getLibrarianDetailsByEmail(String librarian_email) {

		List<Librarian> librarianList = new ArrayList<>();

		query = "SELECT * FROM librarian WHERE librarian_email=?";

		try {
			pst = this.con.prepareStatement(query);
			pst.setString(1, librarian_email);
			rs = pst.executeQuery();

			while (rs.next()) {
				Librarian librarian = new Librarian();
				librarian.setLibrarian_id(rs.getInt("librarian_id"));
				librarian.setLibrarian_name(rs.getString("librarian_name"));
				librarian.setLibrarian_email(rs.getString("librarian_email"));
				librarian.setLibrarian_address(rs.getString("librarian_address"));
				librarianList.add(librarian);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return librarianList;

	}
	
	public int updateLibrarianDetails(int librarian_id,String librarian_name,String librarian_email,String librarian_address) {
		
		int rowAffected=-1;
		
		query="UPDATE librarian SET librarian_name=?"
				+ ", librarian_email=?"
				+ ", librarian_address=?"
				+ "WHERE librarian_id=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, librarian_name);
			pst.setString(2, librarian_email);
			pst.setString(3, librarian_address);
			pst.setInt(4, librarian_id);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		
		
		return rowAffected;
	}
	
	public int updatePassword(String password,String librarian_email) {
		
		int isUpdated=-1;
		
		query="UPDATE librarian SET login_password=? WHERE librarian_email=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, password);
			pst.setString(2, librarian_email);
			
			isUpdated=pst.executeUpdate();
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		
		return isUpdated;
	}

}

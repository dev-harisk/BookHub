package com.bookhub.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.*;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.model.Service;

public class ServiceDAO {
	
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	String query;
	
	public ServiceDAO(){
		
	}
	
	public ServiceDAO(Connection con){
		this.con=con;
	}
	
	public List<Service> loadTransactions(){
		
		List<Service> serviceList=new ArrayList<>();
		
		
		query="SELECT * FROM transactions ORDER BY transaction_id DESC";
		
		try {
			pst=this.con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()) {
				Service service=new Service();
				service.setTransaction_id(rs.getInt("transaction_id"));
				service.setBook_id(rs.getInt("book_id"));
				service.setMember_id(rs.getInt("member_id"));
				service.setIssue_date(rs.getDate("issue_date"));
				service.setDue_date(rs.getDate("due_date"));
				service.setReturn_date(rs.getDate("return_date"));
				service.setFine_amount(rs.getDouble("fine_amount"));
				
				serviceList.add(service);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return serviceList;
		
	}
	
	public int issueBook(int book_id,int member_id) {
		
		int rowAffected=-1;
		query="INSERT INTO transactions(book_id,member_id) VALUES (?,?)";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setInt(1, book_id);
			pst.setInt(2, member_id);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(rowAffected>0)
			rowAffected=1;
		
		return rowAffected;
		
	}
	
public int returnBook(int book_id,int member_id,java.sql.Date return_date) {
		
		int rowAffected=-1;
		query="UPDATE transactions SET return_date=? "
				+ "WHERE book_id=? "
				+ "AND member_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setDate(1, return_date);
			pst.setInt(2, book_id);
			pst.setInt(3, member_id);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(rowAffected>0)
			rowAffected=1;
		
		return rowAffected;
		
	}

}

package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.model.Member;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst=null;
	ResultSet rs = null;
	String query;
	
	
	public MemberDAO() {
		
	}
	
	public MemberDAO(Connection con) {
		this.con=con;
	}
	
	public List<Member> loadTableData(){
		
		List<Member> memberList=new ArrayList<>();
		
		query="SELECT * FROM members ORDER BY member_id DESC";
		
		try {
			pst=this.con.prepareStatement(query);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				Member member=new Member();
				member.setMember_id(rs.getInt("member_id"));
				member.setFull_name(rs.getString("full_name"));
				member.setEmail(rs.getString("email"));
				member.setMembership_type(rs.getString("membership_type"));
				member.setAge(rs.getInt("age"));
				member.setAddress(rs.getString("address"));
				
				memberList.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return memberList;
	}
	
	public int addMember(String full_name,String email,String membership_type,String address,int age) {
		int rowAffected=-1;
		
		query="INSERT INTO members(full_name,email,membership_type,address,age) VALUES (?,?,?,?,?)";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setString(1, full_name);
			pst.setString(2, email);
			pst.setString(3, membership_type);
			pst.setString(4, address);
			pst.setInt(5, age);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		return rowAffected;

	}
	
	public int editMember(String full_name,String email,String membership_type,String address,int age,int member_id) {
		int rowAffected=-1;
		
		query="UPDATE members "
				+ "SET full_name=?,"
				+ "email=?,"
				+ "membership_type=?,"
				+ "address=?,"
				+ "age=? "
				+ "WHERE member_id= ? ";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setString(1, full_name);
			pst.setString(2, email);
			pst.setString(3, membership_type);
			pst.setString(4, address);
			pst.setInt(5, age);
			pst.setInt(6, member_id);
			rowAffected=pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			con.close();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		return rowAffected;

	}
	
	public int removeMember(int member_id) {
		int rowAffected=-1;
		
		query="DELETE FROM members WHERE member_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setInt(1, member_id);
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
	
	public List<Member> getMemberDetailsById(int member_id){
		
		List<Member> memberList=new ArrayList<>();
		
		query="SELECT * FROM members WHERE member_id=?";
		
		try {
			pst=this.con.prepareStatement(query);
			pst.setInt(1, member_id);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				Member member=new Member();
				member.setMember_id(rs.getInt("member_id"));
				member.setFull_name(rs.getString("full_name"));
				member.setEmail(rs.getString("email"));
				member.setMembership_type(rs.getString("membership_type"));
				member.setAge(rs.getInt("age"));
				member.setAddress(rs.getString("address"));
				
				memberList.add(member);
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
		
		return memberList;
		
	}
	
	
}

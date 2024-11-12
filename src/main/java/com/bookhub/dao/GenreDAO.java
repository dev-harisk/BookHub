package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.model.Genre;

public class GenreDAO {
	
	Connection con = null;
	PreparedStatement pst = null;
	java.sql.CallableStatement cst=null;
	ResultSet rs = null;
	String query;
	
	public GenreDAO(){
		
	}
	
	public GenreDAO(Connection con) {
		this.con=con;
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

	
	public int insertAuthorName(String author_name) {
		
		 int authorId=0;
		query="{CALL insert_author_name(?, ?)}";
		try {
			cst = this.con.prepareCall(query);
			cst.setString(1, author_name);
	        cst.registerOutParameter(2, Types.INTEGER);
	        cst.execute();
	        authorId = cst.getInt(2);
	        System.out.println(authorId);
	        cst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        if(authorId>0)
        	return authorId;
        
        return -1;
		
	}

}

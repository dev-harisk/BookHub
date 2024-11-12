package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.bookhub.dao.MemberDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class MemberEditServlet
 */
public class MemberEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEditServlet() {
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
		
		Member member=new Member();
		member.setFull_name(request.getParameter("edit_full_name"));
		member.setEmail(request.getParameter("edit_email"));
		member.setMembership_type(request.getParameter("edit_membership_type"));
		member.setAddress(request.getParameter("edit_address"));
		member.setAge(Integer.parseInt(request.getParameter("edit_age")));
		member.setMember_id(Integer.parseInt(request.getParameter("edit_member_id")));
		
		MemberDAO memberDAO=new MemberDAO(DbConnection.getConnection());
		int isUpdated=memberDAO.editMember(member.getFull_name(),member.getEmail(),member.getMembership_type(),member.getAddress(),member.getAge(),member.getMember_id());
		
		if(isUpdated>=1) {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Member details Updated successfully");
	        responseObj.setStatus("success");

	        // Convert the response object to JSON
	        Gson gson = new GsonBuilder().create();
	        String jsonResponse = gson.toJson(responseObj);
	        
	     // Send the JSON response
	        PrintWriter out = response.getWriter();
	        out.print(jsonResponse);
	        out.flush();
		}
		else {
			// Create a response object
	        Response responseObj = new Response();
	        responseObj.setMessage("Issues in updating member detailsFailure");
	        responseObj.setStatus("error");

	        // Convert the response object to JSON
	        Gson gson = new GsonBuilder().create();
	        String jsonResponse = gson.toJson(responseObj);
	        
	     // Send the JSON response
	        PrintWriter out = response.getWriter();
	        out.print(jsonResponse);
	        out.flush();
		}
		
	}

}

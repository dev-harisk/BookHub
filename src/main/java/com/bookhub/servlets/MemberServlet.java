package com.bookhub.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.bookhub.dao.MemberDAO;
import com.bookhub.dbconnection.DbConnection;
import com.bookhub.model.Member;
import com.google.gson.Gson;

/**
 * Servlet implementation class MemberServlet
 */
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		String opt=request.getParameter("operation");
		
		MemberDAO memberDAO=new MemberDAO(DbConnection.getConnection());
		
		if("loadTableData".equals(opt)) {
			List<Member> mList=memberDAO.loadTableData();
			Gson json=new Gson();
			String memberList=json.toJson(mList);
			response.getWriter().write(memberList);
		}
		
		if("loadMemberDetails".equals(opt)) {
			int member_id=Integer.parseInt(request.getParameter("member_id"));
			List<Member> mList=memberDAO.getMemberDetailsById(member_id);
			Gson json=new Gson();
			String memberData=json.toJson(mList);
			response.getWriter().write(memberData);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			Member member=new Member();
			member.setFull_name(request.getParameter("full_name"));
			member.setEmail(request.getParameter("email"));
			member.setMembership_type(request.getParameter("membership_type"));
			member.setAddress(request.getParameter("address"));
			member.setAge(Integer.parseInt(request.getParameter("age")));
			
			MemberDAO memberDAO=new MemberDAO(DbConnection.getConnection());
			int rowAffected=memberDAO.addMember(member.getFull_name(),member.getEmail(),member.getMembership_type(),member.getAddress(),member.getAge());
			
	}

}

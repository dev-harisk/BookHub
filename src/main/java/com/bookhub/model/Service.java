package com.bookhub.model;

import java.sql.Date;

public class Service {
	
	private int transaction_id;
	private int book_id;
	private int member_id;
	private Date issue_date;
	private Date due_date;
	private Date return_date;
	private double fine_amount;
	
	public Service() {
		
	}
	
	
	public int getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	public int getBook_id() {
		return book_id;
	}
	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	
	public Date getIssue_date() {
		return issue_date;
	}


	public void setIssue_date(Date issue_date) {
		this.issue_date = issue_date;
	}


	public Date getDue_date() {
		return due_date;
	}


	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}


	public Date getReturn_date() {
		return return_date;
	}


	public void setReturn_date(Date return_date) {
		this.return_date = return_date;
	}


	public double getFine_amount() {
		return fine_amount;
	}
	public void setFine_amount(double fine_amount) {
		this.fine_amount = fine_amount;
	}
	
	

}

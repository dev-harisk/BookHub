package com.bookhub.model;

public class Member {
	
	private int member_id;
	private String full_name;
	private String email;
	private String membership_type;
	private int age;
	private String address;
	
	
	public Member() {
		
	}


	public int getMember_id() {
		return member_id;
	}


	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}


	public String getFull_name() {
		return full_name;
	}


	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getMembership_type() {
		return membership_type;
	}


	public void setMembership_type(String membership_type) {
		this.membership_type = membership_type;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}
	
	

}

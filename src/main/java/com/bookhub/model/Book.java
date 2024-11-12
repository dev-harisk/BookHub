package com.bookhub.model;

public class Book {
	
	private int book_id;
	private String isbn;
	private String title;
	private int author_id;
	private int genre_id;
	private int no_of_copies;
	private String publisher;
	private String published_year;
	private String author_name;
	private String genre_name;
	
	
	public Book() {
		
	}


	public int getBook_id() {
		return book_id;
	}


	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}


	public String getIsbn() {
		return isbn;
	}


	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public int getAuthor_id() {
		return author_id;
	}


	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
	}


	public int getGenre_id() {
		return genre_id;
	}


	public void setGenre_id(int genre_id) {
		this.genre_id = genre_id;
	}


	public int getNo_of_copies() {
		return no_of_copies;
	}


	public void setNo_of_copies(int no_of_copies) {
		this.no_of_copies = no_of_copies;
	}


	public String getPublisher() {
		return publisher;
	}


	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public String getPublished_year() {
		return published_year;
	}


	public void setPublished_year(String published_year) {
		this.published_year = published_year;
	}


	public String getAuthor_name() {
		return author_name;
	}


	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}


	public String getGenre_name() {
		return genre_name;
	}


	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}


	@Override
	public String toString() {
		return "Book [book_id=" + book_id + ", isbn=" + isbn + ", title=" + title + ", author_id=" + author_id
				+ ", genre_id=" + genre_id + ", no_of_copies=" + no_of_copies + ", publisher=" + publisher
				+ ", published_year=" + published_year + "]";
	}
	

}

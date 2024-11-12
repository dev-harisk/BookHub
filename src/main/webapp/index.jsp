<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.bookhub.dao.DashboardDAO"%>
<%@page import="com.bookhub.model.Librarian" %>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Book Hub</title>
<%@include file="includes/head.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	
	*{
		font-family: "poppins";
	}
	#menu-btn{
		color: #fff;
		border: 2px solid #fff;
	}
	#nav-bar{
		background-color: rgb(0, 124, 255);
	}
	.nav-item a{
		font-family: "poppins";
		font-size:18px;
		color: #fff;
	}
	#logo{
		font-family: "poppins";
		font-size: 30px;
		font-weight: bolder;
		color: #fff;
		letter-spacing: 3px;
	}
	.card-header .h6{
		text-color: #fff; !important;
		font-size:20px;
	}
	#book-card{
		background-color: rgb(80, 194, 167);
	}
	#member-card{
		background-color: rgb(95, 99, 193);
	}
	#author-card{
		background-color: rgb(208, 122, 70);
	}
	#fine-card{
		background-color: rgb(239, 109, 132);
	}
	#submitbtn{
		width: 100px;
		height: 40px;
	}
	
	
	
	
	
</style>
</head>
<body>

	<%
		int bookCount=0;
		int memberCount=0;
		int authorCount=0;
		double fine_amount=0.0f;
		
		
		DashboardDAO dashboard=new DashboardDAO();
		
		dashboard.getBookCount();
		bookCount=dashboard.getTotalBooks();
		
		dashboard.getMemberCount();
		memberCount=dashboard.getTotalMembers();
		
		dashboard.getAuthorCount();
		authorCount=dashboard.getTotalAuthors();
		
		dashboard.getFineAmounts();
		fine_amount=dashboard.getFineAmount();
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setDateHeader("Expires", 0); // Proxies
		
		if(session.getAttribute("user_details")==null){
			response.sendRedirect("login.jsp");
		}
		
		
	%>

		<nav class="navbar navbar-expand-lg" id="nav-bar">
		<div class="container">
			<a class="navbar-brand" href="#" id="logo">BookHub</a>
			<button class="navbar-toggler" type="button" id="menu-btn"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="books.jsp">Book</a></li>
					<li class="nav-item"><a class="nav-link" href="member.jsp">Member</a></li>
					<li class="nav-item"><a class="nav-link" href="service.jsp">Service</a></li>
					<li class="nav-item"><a class="nav-link" href="librarian.jsp"><i class="fa-solid fa-user-gear" style="color: #ffffff;"></i></a></li>
					
				</ul>
			</div>
		</div>
	</nav>
	

		<div class="container">
		
		<div class="row justify-content-center mt-5">
			<div class="text-center">
        		<h1 class="display-5">Welcome to Our Library Management System</h1>
    		</div>
    	</div>
    		
			  <!-- <div class="row justify-content-center mt-5">
			    <div class="col">
			      <div class="input-group">
			        <input type="search" class="form-control" placeholder="Search Book Title..." id="search-bar">
			        <div class="input-group-append">
			        <button class="btn h-100">
			        	<span class="input-group-text h-100 rounded-0">
			            <i class="fas fa-search"></i>
			          </span>
			        </button>
			          
			        </div>
			      </div>
			    </div>
			  </div> -->
    		
	    	

			<div class="row d-flex justify-content-between mt-5">
				<div class="col-12 col-sm-6 col-md-3 col-lg-3 py-2 px-5">
					<div class="card rounded-5 border border-success h-100">
						<div class="card-header rounded-top-5" id="book-card">
							<p class="h6">Books</p>
						</div>
						<div class="card-body">
							<p class="h4 text-dark"><%= bookCount %></p>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-3 col-lg-3 py-2 px-5">
					<div class="card rounded-5 border border-primary h-100">
						<div class="card-header rounded-top-5" id="member-card">
							<p class="h6 text-white">Members</p>
						</div>
						<div class="card-body">
							<p class="h4 text-dark"><%= memberCount %></p>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-3 col-lg-3 py-2 px-5">
					<div class="card rounded-5 border border-warning h-100">
						<div class="card-header rounded-top-5" id="author-card">
							<p class="h6 text-white">Authors</p>
						</div>
						<div class="card-body">
							<p class="h4 text-dark"><%= authorCount %></p>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-3 col-lg-3 py-2 px-5">
					<div class="card rounded-5 border border-danger h-100">
						<div class="card-header rounded-top-5" id="fine-card">
							<p class="h6 text-white">Fine Collected</p>
						</div>
						<div class="card-body">
							<p class="h4 text-dark"><%= fine_amount %></p>
						</div>
					</div>
				</div>
			</div>


			<div class="row mt-5 mx-3">
				<form action="DashboardServlet" id="book_search">
					<div class="row mb-2">
						<div class="col-12">
							<div class="form-header">
								<p class="h4">Search Book</p>
							</div>
						</div>
					</div>
					<div class="row">
					
						<div class="col-md-4 col-sm-12">
							
							<div class=" form-group mb-3">
								<label for="genre" class="form-lable">Genre Name</label>
								<select class="form-select" id="genre" name="genre">
										<option value="">Select Genre</option>
								</select>
							</div>
						</div>
						
						<div class="col-md-4 col-sm-12">
						
							<div class=" form-group mb-3">
								<label for="author" class="form-lable">Author Name</label>
								<select class="form-select" id="author" name="author">
									<option value="">Select Author</option>
								</select>
							</div>
						</div>	
							
						<div class="col-md-4 col-sm-12">
							<div class=" form-group mb-3">
								<label for="title" class="form-lable">Book Title</label>
								<select class="form-select" id="title" name="title">
									<option value="">Select Title</option>
								</select>
							</div>
						</div>	
					<div class="row">
						<div class="col-md-4">
							<input class="form-control btn btn-primary" type="submit" id="submitbtn" value="Search">
						</div>
					</div>
				</div>
			</form>
		</div>

	</div>

	
	<%@include file="includes/script.jsp"%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		
	//	window.history.replaceState(null, null, window.location.href);
		
		$('#submitbtn').on('click',function(){
			$(this).blur();
		});
		
		
		
	    $.ajax({
	        url: "DashboardDropdownServlet",
	        method: "GET",
	        data: { operation: 'genre'},
	        success: function(data, textStatus, jqXHR) {
	        	//console.log(data);
	            $.each(data, function(key, value) {
	            	
	                $('#genre').append('<option value="' + value.genre_id + '">' + value.genre_name + '</option>');
	            });
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error('Error fetching genres:', textStatus, errorThrown);
	        },
	        cache: false
	    });
	    
	    $('#genre').change(function(){
	       
	        let genre_id = $('#genre').val();
	        $.ajax({
	            url: "DashboardDropdownServlet",
	            method: "GET",
	            datatype:"json",
	            data: { operation: "author", id: genre_id },
	            success: function(data, textStatus, jqXHR) {
	            	//console.log('Author Data:', data);
	                $('#author').empty().append('<option>Select Author</option>');
	                $.each(data, function(key, value) {
	                    $('#author').append('<option value="' + value.author_id + '">' + value.author_name + '</option>');
	                    
	                });
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.error('Error fetching authors:', textStatus, errorThrown);
	            },
	            cache: false
	        });
	    });
	    
	    $('#author').change(function(){
	        
	        let author_id = $('#author').val();
	        $.ajax({
	            url: "DashboardDropdownServlet",
	            method: "GET",
	            datatype:"json",
	            data: { operation: "title", id: author_id },
	            success: function(data, textStatus, jqXHR) {
	            	//console.log('Book Data:', data);
	                $('#title').empty().append('<option>Select Title</option>');
	                $.each(data, function(key, value) {
	                    $('#title').append('<option value="' + value.book_id + '">' + value.title + '</option>');
	                });
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.error('Error fetching titles:', textStatus, errorThrown);
	            },
	            cache: false
	        });
	    });
	    
	    
	  //Submit add_book form via AJAX without redirecting
	    $('#book_search').on('submit',function(e) {
	        e.preventDefault(); // prevent default form submission
			
	        var book_id=$('#title').val();
	        //console.log(book_id);
	        // Collect form data
	        var BookData = $(this).serialize(); // serialize form data
	        //console.log(BookData);

	        // Send data via AJAX
	        $.ajax({
	            url: $(this).attr('action'), // the action attribute of the form
	            type: 'POST',
	            data: BookData,
	            success: function(response) {
	            	var responseObject = JSON.parse(response);
	            	if (responseObject) {
                        swal({
                        	title:"Book Status",
                            text: responseObject.message,
                            icon: responseObject.status,
                            button: "OK",
                        });
                        
                    } else {
                        console.error('Empty response');
                        // Handle empty response case
                    }
	            },
	            error: function(xhr, status, error) {
	                // Handle error (e.g., show an error message)
	                console.error('Error submitting form:', error);
	                alert('There was an error submitting the form.');
	            }
	        });
	    });

	    
	    
	});
	</script>
	
</body>
</html>
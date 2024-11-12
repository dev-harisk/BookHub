<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.bookhub.dbconnection.DbConnection"%>
<%@ page import="com.bookhub.model.Book" %>
<%@ page import="com.bookhub.model.Genre" %>
<%@ page import="com.bookhub.dao.BooksDAO" %>
<%@ page import="java.time.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Books</title>
<%@include file="includes/head.jsp" %>
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
		position: sticky;
		top: 0;
		z-index: 3;
		
	}
	.nav-item a{
		font-size:18px;
		color: #fff;
	}
	#logo{
		font-size: 30px;
		font-weight: bolder;
		color: #fff;
		letter-spacing: 3px;
	}
	.table-responsive{
		max-height: 90vh;
	}
	.header{
		position: sticky;
        top: 0;
        text-align: justify;
        z-index: 2;
    }
    ::-webkit-scrollbar {
        width: 0px; /* Hide horizontal scrollbar */
        height: 0px; /* Hide vertical scrollbar */
    }
</style>
</head>
<body>

	<%
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
					<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link active" href="books.jsp">Book</a></li>
					<li class="nav-item"><a class="nav-link" href="member.jsp">Member</a></li>
					<li class="nav-item"><a class="nav-link" href="service.jsp">Service</a></li>
					<li class="nav-item"><a class="nav-link" href="librarian.jsp"><i class="fa-solid fa-user-gear" style="color: #ffffff;"></i></a></li>
					
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
	
	<div class="row mt-5">
		<div class="col-12 border-bottom border-dark">
			<form id="add_book" action="BookServlet" method="post">
			
				<div class="form-header py-4">
					<p class="h3">Enter Book Details</p>
				</div>
				
				<div class="row">
					
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="genre" class="form-label">Genre</label>
								<select class="form-control genre" id="genre" name="genre" required="required">
										
								</select>
							</div>
						</div>
						
						<div class="col-md-4 col-sm-12">
						
							<div class="form-group mb-3">
								<label for="title" class="form-label">Book Title</label>
								<input name="title" id="title" class="form-control" type="text" required="required">
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="author" class="form-label">Author Name</label>
								<input name="author" id="author" class="form-control" type="text" required="required">
							</div>
						</div>
					</div>
					<div class="row">
						
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="publisher" class="form-label">Publication Name</label>
								<input name="publisher" id="publisher" class="form-control" required="required">
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="publishedyear" class="form-label">Published
									Year</label> <select class="form-control" id="year" name="year" required="required">
									<%
									java.util.Calendar calendar = java.util.Calendar.getInstance();
									int currentYear = calendar.get(java.util.Calendar.YEAR);
									for (int i = currentYear; i >= 1473; i--) {
									%>
									<option value="<%=i%>"><%=i%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="isbn" class="form-label">ISBN Number</label> 
								<input name="isbn" id="isbn" class="form-control" type="text" required="required">
							</div>
						</div>
					
					</div>
					
					<div class="row">
					
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="copies" class="form-label">Number Of Copies</label>
								<input name="copies" id="copies" class="form-control"
									type="number" required="required">
							</div>

						</div>	
					</div>
				
				<div class="row mt-3 mb-5">
						<div class="col-6">
							<input class="form-control btn btn-success" type="submit">
						</div>
						<div class="col-6">
							<input class="form-control btn btn-danger" type="reset">
						</div>
				</div>
			</form>
		</div>
	</div>
	<div class="row mt-3">
		<div class="col">
		
			<div class="table-responsive">
				<table class="table table-hover" id="bookTable">
		    		<thead>
				      <tr scope="col-group">
				        <th scope="col" class="text-success header">Book Id</th>
				        <th scope="col" class="text-success header">Book Title</th>
				        <th scope="col" class="text-success header">Author Name</th>
				        <th scope="col" class="text-success header">Genre</th>
				        <th scope="col" class="text-success header">Publisher Name</th>
				        <th scope="col" class="text-success header">Published Year</th>
				        <th scope="col" class="text-success header">ISBN</th>
				        <th scope="col" class="text-success header">No.of.copies</th>
				        <th scope="col" class="text-success header">Edit</th>
				        <th scope="col" class="text-success header">Remove</th>
				      </tr>
				    </thead>
				    <tbody id="table-body">
				    
				    </tbody>
	  			</table>
			</div>
			
			
				
			</div>
		
	</div>
	
		
	</div> 
	
	<div class="modal fade" id="bookEditDialog" aria-labelledby="bookEditDialog" aria-hidden="true" data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title">Edit Book Details</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<form action="BookEditServlet" id="edit_book" method="post">
					
				        <div class="form-group mb-1">
				            <label for="edit_book_id" class="form-label">Book Id</label>
				            <input type="text" class="form-control" id="edit_book_id" readonly="readonly" name="edit_book_id">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_genre" class="form-label">Genere</label>
				            <select  id="edit_genre" class="form-control genre" name="edit_genre"></select>
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_title" class="form-label">Book Title</label>
				            <input type="text" class="form-control" id="edit_title" name="edit_title">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_author" class="form-label">Author Name</label>
				            <input type="text" class="form-control" id="edit_author" name="edit_author">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_publisher" class="form-label">Publisher Name</label>
				            <input type="text" class="form-control" id="edit_publisher" name="edit_publisher">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_published_year" class="form-label">Published Year</label>
				            <select name="edit_published_year" id="edit_published_year" class="form-control" required="required">
				            	<%
									calendar = java.util.Calendar.getInstance();
									currentYear = calendar.get(java.util.Calendar.YEAR);
									for (int i = currentYear; i >= 1473; i--) {
									%>
									<option value="<%=i%>"><%= i %></option>
									<%
									}
									%>
				            </select>
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_isbn" class="form-label">ISBN Number</label>
				            <input type="text" class="form-control" id="edit_isbn" name="edit_isbn">
				        </div>
				        <div class="form-group mb-3">
				            <label for="edit_copies" class="form-label">No.of.copies</label>
				            <input type="number" name="edit_copies" id="edit_copies" class="form-control">
				        </div>
				        <div class="form-group mb-1">
				        	<input class="form-control btn btn-success mb-1" type="submit" id="edit_submit">
							
				        </div>
				     </form>
				        
				</div>
				<div class="modal-footer col-12">
					<button class="btn btn-primary" data-bs-dismiss="modal" id="modal_close_btn">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="bookRemoveDialog" data-bs-backdrop="static" aria-labelledby="bookRemoveDialog" aria-hidden="true">

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h6>Action Needed</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close" id="remove_dialog_close"></button>
                </div>
                <div class="modal-body">
                    	
                        <h6 class="mb-4">Do you want to delete this record</h6>
                        
                        <form action="BookRemoveServlet" id="remove_book" method="post">
                        	<input type="text" id="remove_book_id"  hidden="" name="remove_book_id">
                        </form>
                        			
                        <button type="button" id="yesRemove" class="form control btn btn-success">Yes</button>
                        
                       	<button class="btn btn-danger ms-3" id="noRemove" data-bs-dismiss="modal">No</button>
                        		 </div>
             </div>
         </div>
    </div>
	

<%@include file="includes/script.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.co	m/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	// Call the function to load table data when the page loads
    loadTableData();
    loadGenreList();
	

 	//Declaring a var for storing bookId
 	var bookId;
 
 	
});

$('input[type="reset"]').on('click', function() {
    $(this).blur(); // Remove focus from the reset button
});

$('input[type="submit"]').on('click', function() {
    $(this).blur(); // Remove focus from the reset button
});


//Handle edit button click event to load genre list, retrieve book ID, and then load book details.

$('#bookTable').on('click', '#edit_btn', function() {
	// Call loadGenreList() and wait for it to complete using .then()
    loadGenreList().then(() => {
        // Get the book ID from the first cell of the clicked row
       let bookId = $(this).closest('tr').find('td:first').text().trim();
        //console.log('Book ID:', bookId);

        // Now that genres are loaded, call loadBookDetails(bookId)
        loadBookDetails(bookId);
    }).catch((error) => {
        console.error('Failed to load genre list:', error);
    });
    
});


//Handle remove button click event to retrieve book ID, and then load book details.

$('#bookTable').on('click', '#remove_btn', function() {
	
        // Get the book ID from the first cell of the clicked row
        let bookId = $(this).closest('tr').find('td:first').text().trim();
        $('#remove_book_id').val(bookId);

});

//Submit add_book form via AJAX without redirecting
$('#add_book').on('submit', function(e) {
    e.preventDefault(); // prevent default form submission

    // Collect form data
    var addBookData = $(this).serialize(); // serialize form data

    // Send data via AJAX
    $.ajax({
        url: $(this).attr('action'), // the action attribute of the form
        type: 'POST',
        data: addBookData,
        success: function(response) {
            // Handle success (e.g., show a success message)
            swal({
            	title: "Operation Successful",
                text: "Book Details added successfully",
                icon: "success",
                button: "OK",
            });
            loadTableData(); // Reload table data after successful submission
            $('#add_book')[0].reset(); // Reset the form
        },
        error: function(xhr, status, error) {
            // Handle error (e.g., show an error message)
            console.error('Error submitting form:', error);
            alert('There was an error submitting the form.');
        }
    });
});


//Submit edit_form via AJAX without redirecting
$('#edit_book').on('submit', function(e) {
    e.preventDefault(); // prevent default form submission

    // Collect form data
    var editBookData = $(this).serialize(); // serialize form data
    console.log(editBookData);

    // Send data via AJAX
    $.ajax({
        url:  $(this).attr('action'), // the action attribute of the form
        type: 'POST',
        data: editBookData,
        success: function(response) {
            // Handle success (e.g., show a success message)
            swal({
            	title: "Operation Successful",
                text: "Book details updated successfully",
                icon: "success",
                button: "OK",
            });
            loadTableData(); // Reload table data after successful submission
            //$('#edit_book')[0].reset(); // Reset the form
         // Trigger the click event on the close button when needed
            $('#modal_close_btn').click();


        },
        error: function(xhr, status, error) {
            // Handle error (e.g., show an error message)
            console.error('Error submitting form:', error);
            alert('There was an error submitting the form.');
        }
    });
});


// Perform remove the book from table by click the button
$('#yesRemove').click(function(e) {
    e.preventDefault(); // prevent default form submission

    // Collect form data
    var book_id = $('#remove_book_id').val(); // serialize form data
    console.log(book_id);

    // Send data via AJAX
    $.ajax({
        url: 'BookRemoveServlet', // the action attribute of the form
        type: 'POST',
        data: {bookId : book_id},
        success: function(response) {
        	
            // Handle success (e.g., show a success message)
            swal({
            	title: "Operation Successful",
                text: "Book removed successfully",
                icon: "success",
                button: "OK",
            });
           loadTableData(); // Reload table data after successful submission
         // Trigger the click event on the close button when needed
           $('#remove_dialog_close').click();


        },
        error: function(xhr, status, error) {
        	console.log(data);
            // Handle error (e.g., show an error message)
            console.error('Error submitting form:', error);
            alert('There was an error submitting the form.');
        }
    });
});




// Function to load data for table
function loadTableData() {
    $.ajax({
        url: "BookServlet", // Servlet URL
        method: "GET",      // HTTP method to send the request
        data: { operation: "loadTableData" }, // Passing the operation parameter
        success: function(data) {
        	//console.log(data);
            // Clear existing table body
            $('#bookTable tbody').empty();
            
            // Iterate over the JSON response data and build table rows
            $.each(data, function(index, book) {
            	var dateString=book.published_year;
            	var year=parseInt(dateString.split('-')[0]);
                var row = '<tr>' +
                    '<td>' + book.book_id + '</td>' +
                    '<td>' + book.title + '</td>' +
                    '<td>' + book.author_name + '</td>' +
                    '<td>' + book.genre_name + '</td>' +
                    '<td>' + book.publisher + '</td>' +
                    '<td>' + year + '</td>' +
                    '<td>' + (book.isbn === undefined?'NA':book.isbn) + '</td>' +
                    '<td>' + book.no_of_copies + '</td>' +
                    '<td><button id="edit_btn" type="button" class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#bookEditDialog"><i class="fa fa-pencil-square" aria-hidden="true"></i></button></td>'+
                    '<td><button id="remove_btn" type="button" class="btn btn-danger btn-sm remove_btn" data-bs-toggle="modal" data-bs-target="#bookRemoveDialog"><i class="fa fa-trash" aria-hidden="true"></i></button></td>' +
                '</tr>';
                
                // Append the row to the table body
                $('#bookTable tbody').append(row);
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error loading data: " + textStatus, errorThrown);
        },
        dataType: "json" // Expect JSON response from the server
    });
}

//Function to load genre list
function loadGenreList() {
	return new Promise((resolve, reject) => {
    $.ajax({
        url: "BookServlet", // Servlet URL for genres
        method: "GET",      // HTTP method to send the request
        data: { operation: "loadGenres" }, // Passing the operation parameter to get genres
        success: function(data) {
        	//console.log(data);
            // Clear the genre dropdown first
            $('.genre').empty();
            // Add a default option
            $('#genre').append('<option>Select Genre</option>');

            // Iterate over the JSON response and add genres as options
            $.each(data, function(index, genre) {
                $('.genre').append('<option value="' + genre.genre_id + '">' + genre.genre_name + '</option>');
            });
            resolve();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error loading genres: " + textStatus, errorThrown);
            reject(errorThrown);
        },
        dataType: "json" // Expect JSON response from the server
    });
	});
}

function loadBookDetails(bookId) {
    $.ajax({
        url: 'BookServlet',
        method: 'GET',
        data: { operation: 'loadBookDetails', bookId: bookId },
        dataType: 'json',
        success: function(data) {
        	//console.log(data);
        	if(Array.isArray(data)&&data.length>0){
        		var book=data[0];
        		$('#edit_book_id').val(book.book_id)
                $('#edit_title').val(book.title);
                $('#edit_author').val(book.author_name);
                $('#edit_genre').val(book.genre_id);
                //var text=$('#edit_genre option:selected').text();
               // console.log(text);
                $('#edit_publisher').val(book.publisher);
                var dateString=book.published_year;
            	var year=parseInt(dateString.split('-')[0]);
               	$('#edit_published_year').val(year);
                $('#edit_isbn').val(book.isbn);
                $('#edit_copies').val(book.no_of_copies);
                
                // Set the value of the select input based on the genre name
                /* var genreName = book.genre_name; // Assuming this is the genre name you have
                $('#edit_genre option').each(function() {
                    if ($(this).text() === genreName) {
                        $(this).prop('selected', true); // Set the corresponding option as selected
                    }
                }); */
                
            	
                
        	}
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('Error loading book details: ' + textStatus, errorThrown);
        },
    });
}
	
</script>


</body>
</html>
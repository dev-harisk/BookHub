<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Members</title>
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
		top:0;
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
					<li class="nav-item"><a class="nav-link" href="books.jsp">Book</a></li>
					<li class="nav-item"><a class="nav-link active" href="member.jsp">Member</a></li>
					<li class="nav-item"><a class="nav-link" href="service.jsp">Service</a></li>
					<li class="nav-item"><a class="nav-link" href="librarian.jsp"><i class="fa-solid fa-user-gear" style="color: #ffffff;"></i></a></li>
					
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
	
	<div class="row mt-5">
		<div class="col-12 border-bottom border-dark">
			<form id="add_member" action="MemberServlet" method="post">
			
				<div class="form-header py-4">
					<p class="h3">Enter Member Details</p>
				</div>
				
				<div class="row">
					
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="membership" class="form-label">Membership Type</label>
								<select class="form-control genre" id="membership_type" name="membership_type" required="required">
										<option>Select Membership Type</option>
										<option val="General">General</option>
										<option val="Student">Student</option>
										<option val="Temproary">Temporary</option>
										<option val="Senior Citizen">Senior Citizen</option>
										<option val="Faculty">Faculty</option>
								</select>
							</div>
						</div>
						
						<div class="col-md-4 col-sm-12">
						
							<div class="form-group mb-3">
								<label for="full_name" class="form-label">Full Name</label>
								<input name="full_name" id="full_name" class="form-control" type="text" required="required">
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="address" class="form-label">Address</label>
								<input name="address" id="address" class="form-control" type="text" required="required">
							</div>
						</div>
					</div>
					<div class="row">
						
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="email" class="form-label">e-mail</label>
								<input name="email" id="email" class="form-control" required="required" type="email">
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="age" class="form-label">Age</label>
								<input name="age" id="age" class="form-control"
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
				<table class="table table-hover" id="memberTable">
		    		<thead>
				      <tr scope="col-group">
				        <th scope="col" class="text-success header">Member Id</th>
				        <th scope="col" class="text-success header">Full Name</th>
				        <th scope="col" class="text-success header">email</th>
				        <th scope="col" class="text-success header">Membership Type</th>
				        <th scope="col" class="text-success header">Age</th>
				        <th scope="col" class="text-success header">Address</th>
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
	
	<div class="modal fade" id="memberEditDialog" aria-labelledby="memberEditDialog" aria-hidden="true" data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title">Edit Member Details</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<form action="MemberEditServlet" id="edit_member" method="post">
					
				        <div class="form-group mb-1">
				            <label for="edit_member_id" class="form-label">Member Id</label>
				            <input type="text" class="form-control" id="edit_member_id" readonly="readonly" name="edit_member_id">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_full_name" class="form-label">Full Name</label>
				            <input type="text" class="form-control" id="edit_full_name" name="edit_full_name">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_email" class="form-label">e-mail</label>
				            <input type="email" class="form-control" id="edit_email" name="edit_email">
				        </div>
				        <div class="form-group mb-1">
				        	<label for="membership" class="form-label">Membership Type</label>
								<select class="form-control genre" id="edit_membership_type" name="edit_membership_type" required="required">
										<option>Select Membership Type</option>
										<option val="General">General</option>
										<option val="Student">Student</option>
										<option val="Temproary">Temporary</option>
										<option val="Senior Citizen">Senior Citizen</option>
										<option val="Faculty">Faculty</option>
								</select>
				        
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_age" class="form-label">Age</label>
				            <input type="number" class="form-control" id="edit_age" name="edit_age">
				        </div>
				        <div class="form-group mb-1">
				            <label for="edit_address" class="form-label">Address</label>
				            <input type="text" class="form-control" id="edit_address" name="edit_address">
				        </div>
				        <div class="form-group mb-1 mt-3">
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
	
	<div class="modal fade" id="memberRemoveDialog" data-bs-backdrop="static" aria-labelledby="memberRemoveDialog" aria-hidden="true">

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h6>Action Needed</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close" id="remove_dialog_close"></button>
                </div>
                <div class="modal-body">
                    
                        <h6 class="mb-4">Do you want to remove this member</h6>
                        <form action="MemberRemoveServlet" id="remove_member" method="post">
                        	<input type="text" id="remove_member_id"  hidden="" name="remove_member_id">
                        </form>
                    
                        			<button type="button" id="yesRemove" class="form control btn btn-success">Yes</button>
                        
                       				 <button class="btn btn-danger ms-3" id="noRemove" data-bs-dismiss="modal">No</button>
                        		 </div>
                        	</div> 
                        	

                </div>

            </div>
       
	

<%@include file="includes/script.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
<script type="text/javascript">


	loadTableData();

	$('input[type="reset"]').on('click', function() {
	    $(this).blur(); // Remove focus from the reset button
	});
	
	$('input[type="submit"]').on('click', function() {
	    $(this).blur(); // Remove focus from the reset button
	});
	
	//Handle edit button click event to load genre list, retrieve book ID, and then load book details.

	$('#memberTable').on('click', '#edit_btn', function() {
		
	        // Get the book ID from the first cell of the clicked row
	       let memberId = $(this).closest('tr').find('td:first').text().trim();
	       // console.log('Member ID:', memberId);

	        // Now that genres are loaded, call loadBookDetails(bookId)
	        loadMemberDetails(memberId);
	});
	
	$('#memberTable').on('click', '#remove_btn', function() {
		
        // Get the book ID from the first cell of the clicked row
        let bookId = $(this).closest('tr').find('td:first').text().trim();
        $('#remove_member_id').val(bookId);

});
	
	
	//Submit add_book form via AJAX without redirecting
	$('#add_member').on('submit', function(e) {
	    e.preventDefault(); // prevent default form submission

	    // Collect form data
	    var addMemberData = $(this).serialize(); // serialize form data
	   // console.log(addMemberData);

	    // Send data via AJAX
	    $.ajax({
	        url: $(this).attr('action'), // the action attribute of the form
	        type: 'POST',
	        data: addMemberData,
	        success: function(response) {
	            // Handle success (e.g., show a success message)
	            swal({
            		title: "Operation Successful",
                	text: "Member added successfully",
                	icon: "success",
                	button: "OK",
            	});
	            loadTableData(); // Reload table data after successful submission
	            $('#add_member')[0].reset(); // Reset the form
	        },
	        error: function(xhr, status, error) {
	            // Handle error (e.g., show an error message)
	            console.error('Error submitting form:', error);
	            alert('There was an error submitting the form.');
	        }
	    });
	});
	
	
	//Submit edit_form via AJAX without redirecting
	$('#edit_member').on('submit', function(e) {
	    e.preventDefault(); // prevent default form submission

	    // Collect form data
	    var editMemberData = $(this).serialize(); // serialize form data
	    

	    // Send data via AJAX
	    $.ajax({
	        url:  $(this).attr('action'), // the action attribute of the form
	        type: 'POST',
	        data: editMemberData,
	        success: function(response) {
	        	
	        	swal({
            		title: "Operation Successful",
                	text: "Member details updated successfully",
                	icon: "success",
                	button: "OK",
            	});
	        	 
	            loadTableData(); // Reload table data after successful submission
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
	
	
	$('#yesRemove').click(function(e) {
	    e.preventDefault(); // prevent default form submission

	    // Collect form data
	    var member_id = $('#remove_member_id').val(); // serialize form data
	    console.log(member_id);

	    // Send data via AJAX
	    $.ajax({
	        url: 'MemberRemoveServlet',
	        type: 'POST',
	        data: {memberId : member_id},
	        success: function(response) {
	        	
	            // Handle success (e.g., show a success message)
	            swal({
            		title: "Operation Successful",
                	text: "Member removed successfully",
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
	        url: "MemberServlet", // Servlet URL
	        method: "GET",      // HTTP method to send the request
	        data: { operation: "loadTableData" }, // Passing the operation parameter
	        success: function(data) {
	        	//console.log(data);
	            // Clear existing table body
	            $('#memberTable tbody').empty();
	            
	            // Iterate over the JSON response data and build table rows
	            $.each(data, function(index, member) {
	                var row = '<tr>' +
	                    '<td>' + member.member_id + '</td>' +
	                    '<td>' + member.full_name + '</td>' +
	                    '<td>' + member.email + '</td>' +
	                    '<td>' + member.membership_type + '</td>' +
	                    '<td>' + member.age + '</td>' +
	                    '<td>' + member.address + '</td>' +
	                    '<td><button id="edit_btn" type="button" class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#memberEditDialog"><i class="fa fa-pencil-square" aria-hidden="true"></i></button></td>'+
	                    '<td><button id="remove_btn" type="button" class="btn btn-danger btn-sm remove_btn" data-bs-toggle="modal" data-bs-target="#memberRemoveDialog"><i class="fa fa-trash" aria-hidden="true"></i></button></td>' +
	                '</tr>';
	                
	                // Append the row to the table body
	                $('#memberTable tbody').append(row);
	            });
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error("Error loading data: " + textStatus, errorThrown);
	        },
	        dataType: "json" // Expect JSON response from the server
	    });
	}
	
	
	function loadMemberDetails(memberId) {
	    $.ajax({
	        url: 'MemberServlet',
	        method: 'GET',
	        data: { operation: 'loadMemberDetails', member_id: memberId },
	        dataType: 'json',
	        success: function(data) {
	        	//console.log(data);
	        	if(Array.isArray(data)&&data.length>0){
	        		var member=data[0];
	        		$('#edit_member_id').val(member.member_id)
	                $('#edit_full_name').val(member.full_name);
	                $('#edit_email').val(member.email);
	                $('#edit_membership_type').val(member.membership_type);
	                $('#edit_address').val(member.address);
	               	$('#edit_age').val(member.age);
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error('Error loading member details: ' + textStatus, errorThrown);
	        },
	    });
	}

</script>
	
	
	
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Services</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%@include file="includes/head.jsp"%>
<style type="text/css">
* {
	font-family: "poppins";
}

#menu-btn {
	color: #fff;
	border: 2px solid #fff;
}

#nav-bar {
	background-color: rgb(0, 124, 255);
	position: sticky;
	top: 0;
	z-index: 3;
}

.nav-item a {
	font-size: 18px;
	color: #fff;
}

#logo {
	font-size: 30px;
	font-weight: bolder;
	color: #fff;
	letter-spacing: 3px;
}

.table-responsive {
	max-height: 90vh;
}

.header {
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
					<li class="nav-item"><a class="nav-link" href="member.jsp">Member</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="service.jsp">Service</a></li>
					<li class="nav-item"><a class="nav-link" href="librarian.jsp"><i class="fa-solid fa-user-gear" style="color: #ffffff;"></i></a></li>

				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row mt-5">
			<div class="col-12 border-bottom border-dark">
				<form id="service_form" action="ServiceServlet" method="post">

					<div class="row">

						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="opr" class="form-label mb-0">Select
									Operation</label> <select class="form-control " id="opr" name="opr"
									required="required">
									<option>Select Operation</option>
									<option value="issue">Issue</option>
									<option value="return">Return</option>
								</select>
							</div>
						</div>

						<div class="col-md-4 col-sm-12">

							<div class="form-group mb-3">
								<label for="member_id" class="form-lable">Member Id</label> <input
									type="text" name="member_id" id="member_id"
									class="form-control" required="required">
							</div>
						</div>
						<div class="col-md-4 col-sm-12">
							<div class="form-group mb-3">
								<label for="book_id" class="form-lable">Book Id</label> <input
									type="text" name="book_id" id="book_id" class="form-control"
									required="required">
							</div>
						</div>
					</div>


					<div class="row mt-3 mb-5">
						<div class="col-6">
							<input type="submit" id="submit_btn"
								class="form-control btn btn-success">
						</div>
						<div class="col-6">
							<button class="form-control btn btn-danger" type="reset"
								id="reset_btn">Reset</button>
						</div>
					</div>
				</form>

			</div>
		</div>

		<div class="row mt-3">
			<div class="col">

				<div class="table-responsive">
					<table class="table table-hover" id="serviceTable">
						<thead>
							<tr scope="col-group">
								<th scope="col" class="text-success header">Transaction Id</th>
								<th scope="col" class="text-success header">Member Id</th>
								<th scope="col" class="text-success header">Book Id</th>
								<th scope="col" class="text-success header">Issue Date</th>
								<th scope="col" class="text-success header">Due Date</th>
								<th scope="col" class="text-success header">Return Date</th>
								<th scope="col" class="text-success header">Fine Amount</th>
							</tr>
						</thead>
						<tbody id="table-body">

						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>
	<%@include file="includes/script.jsp"%>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script type="text/javascript">
    
    
    $(document).ready(function() {
    	
    	// Call the function to load table data when the page loads
        loadTableData();
    	
    	
    	
        $('#service_form').on('submit', function(e) {
            e.preventDefault();

            var formData = $(this).serialize();
            //console.log(formData);
            $(this).blur();

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData, // Append the operation to the form data
                success: function(response) {
                    if (response) {
                    	var message = response.message;
                        var status = response.status;
                        swal({
                            title: "Operation Successful",
                            text: response.message,
                            icon: response.status,
                            button: "OK",
                        });
                        $('#reset_btn').click();
                        loadTableData();
                        
                    } else {
                        console.error('Empty response');
                        // Handle empty response case
                    }
                    // Handle success response
                    //alert('Operation successful: ' + response);
                },
                error: function(xhr, status, error) {
                    // Handle error response
                    console.error('Error submitting form: ' + error);
                    alert('Error performing operation. Please try again.');
                }
            });
        });
     	
     	
    });
    
    
    
    
 // Function to load data for table
    function loadTableData() {
        $.ajax({
            url: "ServiceServlet", // Servlet URL
            method: "GET",      // HTTP method to send the request
            data: { operation: "loadTableData" }, // Passing the operation parameter
            success: function(data) {
            	//console.log(data);
                // Clear existing table body
                $('#serviceTable tbody').empty();
                
                // Iterate over the JSON response data and build table rows
                $.each(data, function(index, transactions) {
                    var row = '<tr>' +
                        '<td>' + transactions.transaction_id + '</td>' +
                        '<td>' + transactions.member_id + '</td>' +
                        '<td>' + transactions.book_id + '</td>' +
                        '<td>' + transactions.issue_date + '</td>' +
                        '<td>' + transactions.due_date + '</td>' +
                        '<td>' + (transactions.return_date  === undefined ? 'Expected':transactions.return_date)+ '</td>' +
                        '<td>' + transactions.fine_amount + '</td>' +
                    '</tr>';
                    
                    // Append the row to the table body
                    $('#serviceTable tbody').append(row);
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("Error loading data: " + textStatus, errorThrown);
            },
            dataType: "json" // Expect JSON response from the server
        });
    }
    
    </script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bookhub.model.Librarian"%>
<%@ page import="jakarta.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Librarian</title>
<%@include file="includes/head.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

#user-profile {
	
}

#edit-btn, #pwd-btn, #logout-btn {
	text-decoration: none;
	color: #000;
}

#edit-btn:hover, #pwd-btn:hover, #logout-btn:hover {
	color: grey;
}

#save-btn, #cancel-btn {
	width: 50%;
}
</style>
</head>
<body>
	
	<%!
		String username;
		String useremail;
	%>

	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setDateHeader("Expires", 0);	
		if(session.getAttribute("user_details")==null){
			response.sendRedirect("login.jsp");
		}
		
		// Retrieve the session
	    HttpSession mysession = request.getSession();
		
	    
	    // Get the librarian object from the session
	    Librarian librarian = (Librarian) mysession.getAttribute("user_details");
	    
	    // Check if the librarian object is not null
	    if (librarian != null) {
	        // Get the specific value (e.g., name)
	        mysession.setAttribute("username",librarian.getLibrarian_name());
	        mysession.setAttribute("useremail",librarian.getLibrarian_email());
	        username =(String) mysession.getAttribute("username");
	        useremail=(String) mysession.getAttribute(("useremail"));
	    }

		//String username = (String) session.getAttribute("username");
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
					<li class="nav-item"><a class="nav-link" href="service.jsp">Service</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="librarian.jsp"><i class="fa-solid fa-user-gear"
							style="color: #ffffff;"></i></a></li>

				</ul>
			</div>
		</div>
	</nav>



	<div class="container mt-5">
		<div class="container">
			<!-- <div class="row justify-content-between">
                <div class="col-md-4 align-self-end">
                    <h1>Welcome, Harishiva</h1>
                </div>
                <div class="col-md-4 offset-md-4 align-self-end">
                    <div class="d-flex justify-content-end">
            			<button class="btn">Change Password</button>
            			<button class="btn">Logout</button>
        			</div>
                </div>
                
            </div> -->

			<div class="row justify-content-between align-items-end">
				<div class="col-12 col-md-6 text-center text-md-start">
					<h4 id="heroname">
						Welcome,
						<%-- <%= username != null ? username : ""%> --%>
					</h4>
						
				</div>
				<div
					class="col-12 col-md-6 text-center text-md-end align-self-center">
					<div
						class="d-flex justify-content-center justify-content-md-end gap-5">
						<a href="#" id="edit-btn" data-bs-toggle="modal"
							data-bs-target="#profileEditDialog">Edit Profile</a> <a href="#"
							id="pwd-btn" data-bs-toggle="modal"
							data-bs-target="#passwordChangeDialog">Change Password</a> <a
							href="LogoutServlet" id="logout-btn">Logout</a>
					</div>
				</div>
			</div>
			<!-- <div class="row my-5 justify-content-md-start justify-content-center">
				
				<button class="btn btn-success" id="edit-btn">Edit Profile</button>
			</div> -->
			<div class="row mt-5 justify-content-center">
				<div class="col">
					<div class=" col-12 col-sm-8 col-md-6 col-lg-4 form-container">
						<div class="card" style="width: 18rem;">
							<div class="container d-flex justify-content-center mt-3">
								<img class="rounded-circle" id="user-profile"
									src="./images/user-profile.png" alt="Card image cap"
									height="100px" width="100px">
							</div>

							<div class="card-body">
								<h5 class="card-title">Personal Details</h5>
							</div>
							<ul class="list-group list-group-flush">
								<li class="list-group-item" id="user-name"></li>
								<li class="list-group-item" id="user-email"></li>
								<li class="list-group-item" id="user-address"></li>
							</ul>

						</div>
						<!-- <form action="LibrarianEditServlet" id="edit_librarian1"
							method="POST">
							<div class="form-group my-5">
								<label for="username" class="form-label">Username</label> <input
									type="text" name="username" id="username" class="form-control"
									placeholder="Enter Username">
							</div>
							<div class="form-group my-5">
								<label for="email">Email address</label> <input type="email"
									class="form-control" id="email" placeholder="Enter email">
							</div>
							<div class="form-group my-5">
								<label for="address">Address</label> <input type="text"
									class="form-control" id="address" placeholder="Enter address">
							</div>
							<div class="form-group my-5 d-flex justify-content-between gap-5">
								<button class="btn btn-primary" id="save-btn">save</button>
								<button class="btn btn-danger" id="cancel-btn">cancel</button>
							</div>
						</form> -->
					</div>
				</div>

			</div>
		</div>
	</div>


	<!-- Modal for edit Librarian personal data -->


	<div class="modal fade" id="profileEditDialog"
		aria-labelledby="profileEditDialog" aria-hidden="true"
		data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title">Edit Personal Details</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="close"></button>
				</div>
				<div class="modal-body">
					<form action="LibrarianEditServlet" id="edit_librarian"
						method="POST">

						<div class="form-group mb-1">
							<label for="edit_librarian_id" class="form-label">Librarian
								Id</label> <input type="text" class="form-control"
								id="edit_librarian_id" readonly="readonly"
								name="edit_librarian_id">
						</div>
						<div class="form-group mb-1">
							<label for="edit_full_name" class="form-label">Full Name</label>
							<input type="text" class="form-control" id="edit_name"
								name="edit_name">
						</div>
						<div class="form-group mb-1">
							<label for="edit_email" class="form-label">e-mail</label> 
							<input
								type="email" class="form-control" id="edit_email"
								name="edit_email" readonly>
						</div>

						<!-- <div class="form-group mb-1">
                        <label for="edit_age" class="form-label">Age</label>
                        <input type="number" class="form-control" id="edit_age" name="edit_age">
                    </div> -->
						<div class="form-group mb-1">
							<label for="edit_address" class="form-label">Address</label> <input
								type="text" class="form-control" id="edit_address"
								name="edit_address">
						</div>
						<div class="form-group mb-1 mt-3">
							<input class="form-control btn btn-success mb-1" type="submit"
								id="edit_submit">

						</div>
					</form>

				</div>
				<div class="modal-footer col-12">
					<button class="btn btn-primary" data-bs-dismiss="modal"
						id="modal_close_btn">Cancel</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal for password change option -->

	<div class="modal fade" id="passwordChangeDialog"
		aria-labelledby="passwordChangeDialog" aria-hidden="true"
		data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title">Change your password</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="close"></button>
				</div>
				<div class="modal-body">
					<form action="LibrarianServlet" id="change_password" method="post">

						<div class="form-group mb-1">
							<label for="newpassword" class="form-label">New Password</label>
							<input type="password" class="form-control password"
								id="newpassword" name="newpassword">
						</div>
						<div class="form-group mb-1">
							<label for="cpassword" class="form-label">Confirm
								Password</label> <input type="password" class="form-control"
								id="cpassword" name="cpassword">
						</div>
						<div class="form-group mb-1 mt-3">
							<input class="form-control btn btn-success mb-1" type="submit"
								id="change-pwd-btn">

						</div>
					</form>

				</div>
				<div class="modal-footer col-12">
					<button class="btn btn-primary" data-bs-dismiss="modal"
						id="modal_close_btn">Cancel</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="includes/script.jsp"%>

	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



	<script type="text/javascript">
		
	
	
		$(document).ready(function(){
			
			
			const user_id= '<%= useremail %>';
			console.log(user_id);
			getUserDetails(user_id);
			
			
			
			$('#edit-btn').click(function(){
				
				//console.log(user_id);
				getUserDetails(user_id);
				//setValuesForEditModal();
			
				
			});
			
			
			
			
			
			//submit form to change password
			$('#change_password').on('submit',function(e){
				e.preventDefault();
				
				const formData=$(this).serialize();
				
				const pwd= $('#newpassword').val()
				const cpwd= $('#cpassword').val()
				if(pwd===cpwd){
					
					$.ajax({
						url: $(this).attr('action'),
						type: 'post',
						data: formData,
						dataType: 'JSON',
						success: function(response){
							if (response) {
		                        swal({
		                        	title:"Update Status",
		                            text: response.message,
		                            icon: response.status,
		                            button: "OK",
		                        }).then(() => {
		                            // Close the modal after the user clicks OK
		                            $('#passwordChangeDialog').modal('hide'); 
		                        });
		                     // Trigger the click event on the close button when needed
					           // $('#modal_close_btn').click(); 
		                        
		                    } else {
		                    	swal({
		                        	title:"Update Status",
		                            text: response.message,
		                            icon: response.status,
		                            button: "OK",
		                        }).then(() => {
		                            // Close the modal after the user clicks OK
		                            $('#passwordChangeDialog').modal('hide'); 
		                        });
		                    }
							//$('#modal_close_btn').click();
						},
						error: function(xhr, status, error) {
				            // Handle error (e.g., show an error message)
				            console.error('Error submitting form:', error);
				            alert('There was an error submitting the form.');
				        }
					
					});
					
					
				}
				else{
					alert("passwords are mismatch");
					$('#change-pwd-btn').blur();
					$('#change_password')[0].reset();
					$('#newpassword').focus();
				}
			});
				
				
			
			
			//Submit edit_form via AJAX without redirecting
			$('#edit_librarian').on('submit', function(e) {
			    e.preventDefault(); // prevent default form submission

			    // Collect form data
			    var editLibrarianData = $(this).serialize(); // serialize form data
			    //console.log(editLibrarianData);

			    // Send data via AJAX
			    $.ajax({
			        url:  $(this).attr('action'), // the action attribute of the form
			        type: $(this).attr('method'),
			        data: editLibrarianData,
			        dataType:'json',
			        success: function(response) {
			        	//var responseObject = JSON.parse(response);
		            	if (response) {
	                        swal({
	                        	title:"Update Status",
	                            text: response.message,
	                            icon: response.status,
	                            button: "OK",
	                        }).then(() => {
	                            // Close the modal after the user clicks OK
	                            $('#profileEditDialog').modal('hide'); 
	                        });
	                        
	                        
	                    } else {
	                    	swal({
	                        	title:"Update Status",
	                            text: response.message,
	                            icon: response.status,
	                            button: "OK",
	                        }).then(() => {
	                            // Close the modal after the user clicks OK
	                            $('#profileEditDialog').modal('hide'); 
	                        });
	                    } 
		            	getUserDetails(user_id);
		            	//displayUserData();
			        	// console.log(response.message);
			        	/* swal({
		            		title: "Operation Successful",
		                	text: "Personal details updated successfully",
		                	icon: "success",
		                	button: "OK",
		            	});
			        	 
				        // Trigger the click event on the close button when needed
			            $('#modal_close_btn').click(); */ 


			        },
			        error: function(xhr, status, error) {
			            // Handle error (e.g., show an error message)
			            console.error('Error submitting form:', error);
			            alert('There was an error submitting the form.');
			        }
			    });
			});
			
			
			
			async function fetchUserDetails(userName){
				 $.ajax({
			        url: 'LibrarianEditServlet',
			        method: 'GET',
			        data: { operation: 'loadLibrarianDetails', username: userName },
			        dataType: 'json',
			        success: function(data) {
			        	//console.log(data);
			        	if(Array.isArray(data)&&data.length>0){
			        		
			        		userDetails=data[0];
			        	}
			        	
			        },
			        error: function(jqXHR, textStatus, errorThrown) {
			            console.error('Error loading member details: ' + textStatus, errorThrown);
			        },
			    });
			    
				
			}
			
			let user_details;
			async function fetchUser_Details(userName) {
			    return new Promise((resolve, reject) => {
			        $.ajax({
			            url: 'LibrarianEditServlet',
			            method: 'GET',
			            data: { operation: 'loadLibrarianDetails', username: userName },
			            dataType: 'json',
			            success: function(data) {
			                if (Array.isArray(data) && data.length > 0) {
			                    resolve(data[0]); // Resolve with the user details
			                } else {
			                    resolve(null); // Resolve with null if no data
			                }
			            },
			            error: function(jqXHR, textStatus, errorThrown) {
			                console.error('Error loading member details: ' + textStatus, errorThrown);
			                reject(errorThrown); // Reject the promise on error
			            },
			        });
			    });
			}
			
			// Function to fetch and store user details in the global variable
			async function getUserDetails(userName) {
			    try {
			    	user_details = await fetchUser_Details(userName);
			        console.log('User  details fetched and stored:', user_details);
			        
			        // Optionally, update the UI with the fetched details
			        if (user_details) {
			        	loadAndDisplayUser_Details(user_details);
			        	setValuesForEditModal(user_details);
			        } else {
			            console.log('No user details found for the provided username.');
			        }
			    } catch (error) {
			        console.error('Failed to load user details:', error);
			    }
			}
			
			async function loadAndDisplayUser_Details(userDetails) {
			    try {
			        
			        if (userDetails) {
			        	
			        	// Update the user name while preserving the <i> tag
			            $('#user-name').html('<i class="fa-regular fa-user me-2"></i>' + userDetails.librarian_name);

			            // Update the user email while preserving the <i> tag
			            $('#user-email').html('<i class="fa-regular fa-envelope me-2"></i>' + userDetails.librarian_email);

			            // Update the user address while preserving the <i> tag
			            $('#user-address').html('<i class="fa-solid fa-location-dot me-2"></i>' + userDetails.librarian_address);
						
			            $('#heroname').text('Welcome, '+userDetails.librarian_name);
			            /* // Manipulate the DOM with userDetails
			        	$('#user-name').text(userDetails.librarian_name);
						$('#user-email').text(userDetails.librarian_email);
						$('#user-address').text(userDetails.librarian_address); */
			        } else {
			            console.log('No user details found.');
			            // Handle case where no user details are available
			        }
			    } catch (error) {
			        console.error('Failed to load user details:', error);
			        // Handle error accordingly
			    }
			}
			
			function setValuesForEditModal(user_Details) {
				if(user_Details){
					$('#edit_librarian_id').val(user_Details.librarian_id);
				    $('#edit_name').val(user_Details.librarian_name);
				    $('#edit_email').val(user_Details.librarian_email);
				    $('#edit_address').val(user_Details.librarian_address);
				}
				else{
					console.error("User details not found");
				}
			    
			}


		});
		
		
		
	
	</script>
</body>
</html>
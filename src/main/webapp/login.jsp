<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<%@include file="includes/head.jsp"%>
<style>
* {
	font-family: "poppins";
}

  .divider:after,
.divider:before {
content: "";
flex: 1;
height: 1px;
background: #eee;
}
</style>
</head>
<body>
	<section class="vh-100">
        <div class="container py-5 h-100">
          <div class="row d-flex align-items-center justify-content-center h-100">
            <div class="col-md-8 col-lg-7 col-xl-6">
              <!-- <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg"
                class="img-fluid" alt="Phone image"> -->
                <img src="images/login.jpg"
                class="img-fluid" alt="Phone image">
            </div>
            <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">

                <div class="login-header mb-5">

                    <p class="h2">Welcome to BookHub</p>
                    
                </div>

                <form id="login" method="post" action="LoginServlet">
                    <div class="form-group mb-3">
                        <input type="email" name="email" id="email"
                            placeholder="Email address" class="form-control" required>
                    </div>
                    <div class="form-group mb-4">
                        <input type="password" name="pwd" id="pwd" placeholder="Password"
                            class="form-control" required>
                    </div>
                    <div class="form-group mb-3">

                        <input type="submit" id="login-btn" value="Login"
                            class="form-control btn btn-primary">
                    </div>
                    <div class="form-group mb-3">
                        <input type="reset" id="reset-btn" value="Clear All"
                            class="form-control btn btn-danger">
                    </div>
                </form>
              
            </div>
          </div>
        </div>
      </section>

	<%@include file="includes/script.jsp"%>

	<script src="https://code.jquery.co	m/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<script type="text/javascript">
    $(document).ready(function() {
    	
    	
    	
        // Reset button click event
        $('#reset-btn').on('click', function() {
            $(this).blur(); // Remove focus from the reset button
        });

        // Login button click event
        $('#login-btn').on('click', function() {
            $(this).blur(); // Remove focus from the login button
        });

        // Form submission event
        $('#login').on('submit', function(event) {
            event.preventDefault(); // Prevent the default form submission

            var authenticationData = $(this).serialize(); // Serialize form data
            //console.log(authenticationData); // Log the serialized data for debugging

            // Send data via AJAX
            $.ajax({
                url: $(this).attr('action'), // The action attribute of the form
                type: 'POST',
                data: authenticationData,
                success: function(response) {
                    if (response.redirect) {
                    	//console.log("hey");
                        // If the response contains a redirect URL, navigate to it
                       // sessionStorage.setItem('isLoggedIn', 'true');
                        $('#reset-btn').click(); // Trigger reset button click
                        window.location.href = response.redirect; // Redirect to the URL
                        //console.log(response.user);
                    } 
                    else{
                    	$('#reset-btn').click(); // Trigger reset button click
                        swal({
                            title: "Authentication Failed",
                            text: "Wrong username or password",
                            icon: "error",
                            button: "OK",
                        });
                    }
                    // Uncomment the following block to handle errors in the response
                    /*
                    else if (response.error) {
                        // Handle the error (e.g., display a message)
                    }
                    */
                    // Handle success (e.g., show a success message)
                    /*
                    swal({
                        title: "Authentication",
                        text: "Authenticated successfully",
                        icon: "success",
                        button: "OK",
                    });
                    */
                },
                error: function(xhr, status, error) {
                    // Handle error (e.g., show an error message)
                    $('#reset-btn').click(); // Trigger reset button click
                    swal({
                        title: "Authentication Failed",
                        text: "Wrong username or password",
                        icon: "error",
                        button: "OK",
                    });
                }
            });
        });
        
       
    });
</script>
	
	
</body>
</html>
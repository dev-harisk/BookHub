<%
	String username=(String)session.getAttribute("username");
%>
<style>
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
</style>
<header>
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
					<li class="nav-item"><a class="nav-link" href="librarian.jsp"><%= username != null ? username : "" %></a></li>
					
				</ul>
			</div>
		</div>
	</nav>
	
	<!-- 
        	<nav class="m-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active">Home</li>
            </ol>
        </nav>
         -->
</header>
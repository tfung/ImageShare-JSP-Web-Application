<!DOCTYPE html>
<html lang="en">
<%@include file="header.jsp" %>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1>Registration</h1>
			<p id="titleLeft">Registration is always free!</p>
		</div>
	</div>
	
	<%@include file="error.jsp"%>

	<div class="row">
		<div class="col-lg-6 col-lg-offset-3">
			<!-- Registration Form -->
			<form class="form-horizontal" action="registerservlet" method="post" role="form">
				<div class="panel panel-default">
					<div class="panel-heading">Please fill in your information</div>
					<div class="panel-body">
						<div class="form-group">
							<label for="username" class="col-sm-3 control-label">Username</label>
							<div class="col-sm-9">
								<input type="username" name="username" class="form-control" placeholder="Username" id="username">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-3 control-label">Password</label>
							<div class="col-sm-9">
								<input type="password" name="password" class="form-control" placeholder="Password" id="password">
							</div>
						</div>
						<div class="form-group">
							<label for="passwordconfirm" class="col-sm-3 control-label">Password Confirmation</label>
							<div class="col-sm-9">
								<input type="password" name="passwordconfirm" class="form-control" placeholder="Password Confirmation" id="passwordconfirm">
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">First Name</label>
							<div class="col-sm-9">
								<input type="text" name="firstname" class="form-control" placeholder="First Name" id="firstname">
							</div>
						</div>
						<div class="form-group">
							<label for="lastname" class="col-sm-3 control-label">Last Name</label>
							<div class="col-sm-9">
								<input type="text" name="lastname" class="form-control" placeholder="Last Name" id="lastname">
							</div>
						</div>
						<div class="form-group">
							<label for="address" class="col-sm-3 control-label">Address</label>
							<div class="col-sm-9">
								<input type="text" name="address" class="form-control" placeholder="Address" id="address">
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-sm-3 control-label">Email</label>
							<div class="col-sm-9">
								<input type="email" name="email" class="form-control" placeholder="email@example.com" id="email">
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-sm-3 control-label">Phone</label>
							<div class="col-sm-9">
								<input type="text" name="phone" class="form-control" placeholder="1234567890" id="phone">
							</div>
						</div>
					</div>
					<div class="panel-footer" style="height:55px;">
						<div class="pull-right">
							<button type="reset" class="btn btn-default">Reset</button>
							<button type="submit" class="btn btn-primary">Register</button>
						</div>
					</div>
				</div>
			</form>

		</div>
	</div>

	<div class="container">
		<hr>
			<%@include file="footer.jsp"%>
	</div>

	<script>

	</script>
</body>
</html>

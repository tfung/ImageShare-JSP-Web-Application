<!DOCTYPE html>
<html lang="en">
<%@include file="header.jsp" %>
<%@include file="redirect.jsp" %>
<%@ page import="imageshare.model.Group,imageshare.model.Image,imageshare.oraclehandler.OracleHandler,java.util.List,java.util.ArrayList"%>
<%
	List<Group> groups = OracleHandler.getInstance().getInvolvedGroups(user);
	Integer photoId = Integer.parseInt(request.getQueryString());
	session.setAttribute("photoId", photoId);
	Image image = OracleHandler.getInstance().getImageById(photoId);
%>
<style>
	#upload {
		float: right;
	}
	.panel-footer {
		min-height: 65px;
	}
</style>
<body>
	<%@include file="navbar.jsp" %>

	<div class="jumbotron">
		<div class="container">
			<h1>Update Image</h1>
			<p id="titleLeft">Update image description fields here.</p>
		</div>
	</div>	

	<%@include file="error.jsp"%>

	<div class="row">
		<div class="col-lg-6 col-lg-offset-3">

		<!-- Image Upload Form -->
		<form class="form-horizontal" action="updateImage" enctype="multipart/form-data" method="POST" role="form">
			<div class="panel panel-default">
				<div class="panel-heading">Update the image details below:</div>
				<div class="panel-body">
					<div class="form-group">
						<label for="date" class="col-sm-3 control-label">Date</label>
						<div class="col-sm-9">
							<input type="date" name="date" class="form-control" value="<%=image.getDate().toString()%>" id="date">
						</div>
					</div>
					<div class="form-group">
						<label for="subject" class="col-sm-3 control-label">Subject</label>
						<div class="col-sm-9">
							<input type="text" name="subject" class="form-control" value="<%=image.getSubject() == null ? "": image.getSubject()%>" id="subject">
						</div>
					</div>
					<div class="form-group">
						<label for="location" class="col-sm-3 control-label">Location</label>
						<div class="col-sm-9">
							<input type="text" name="location" class="form-control" value="<%=image.getPlace() == null ? "" : image.getPlace()%>" id="location">
						</div>
					</div>
					<div class="form-group">
						<label for="description" class="col-sm-3 control-label">Description</label>
						<div class="col-sm-9">
							<input type="text" name="description" class="form-control" value="<%=image.getDescription() == null ? "" : image.getDescription()%>" id="description">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label">Permissions</label>
						<div class="col-xs-9">
							<div class="radio">
								<label>
									<input id="1" type="radio" name="permissions" value="1">public</input>
								</label>
							</div>
							<div class="radio">
								<label>
									<input id="2" type="radio" name="permissions" value="2">private</input>
								</label>
							</div>
							<% for (Group group : groups) {
								out.println("<div class='radio'><label><input id='" + group.getGroupId() + "' type='radio' name='permissions' value='" + group.getGroupId() + "'>" + group.getGroupname() + "<small class='text-muted'> " + group.getUsername() + "</small></input></label></div>");
							} %>

							<script>
								document.getElementById("<%=image.getPermitted()%>").checked = true;
							</script>
						</div>
					</div>
				</div>
				<div class="panel-footer">
					<button id="upload" type="submit" class="btn btn-primary">Update</button>
					<a href="gallery"><button type="button" class="btn btn-default">Cancel</button></a>
				</div>
			</div>
		</form>

		</div>
	</div>

	<div class="container">
		<hr>
			<%@include file="footer.jsp"%>
			<!--% include footer %-->
	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Auth Page</title>
	<style>
		body {
			margin: 0;
			padding: 0;
			display: flex;
			justify-content: center;
			align-items: center;
			min-height: 100vh;
			font-family: 'Jost', sans-serif;
			/* Use a gradient background with shades of red and black */
			background: linear-gradient(135deg, #000000 0%, #ff0000 50%, #000000 100%);
		}

		.main {
			width: 350px;
			height: 500px;
			background: rgba(0, 0, 0, 0.8); /* Semi-transparent black background for the main container */
			overflow: hidden;
			background: url("https://doc-08-2c-docs.googleusercontent.com/docs/securesc/68c90smiglihng9534mvqmq1946dmis5/fo0picsp1nhiucmc0l25s29respgpr4j/1631524275000/03522360960922298374/03522360960922298374/1Sx0jhdpEpnNIydS4rnN4kHSJtU1EyWka?e=view&authuser=0&nonce=gcrocepgbb17m&user=03522360960922298374&hash=tfhgbs86ka6divo3llbvp93mg4csvb38") no-repeat center/cover;
			border-radius: 10px;
			box-shadow: 5px 20px 50px rgba(0, 0, 0, 0.5); /* Semi-transparent black shadow */
		}

		#chk {
			display: none;
		}

		.signup, .login {
			position: relative;
			width: 100%;
			height: 100%;
		}

		label {
			color: #ff0000; /* Red color for labels */
			font-size: 2.3em;
			justify-content: center;
			display: flex;
			margin: 60px;
			font-weight: bold;
			cursor: pointer;
			transition: .5s ease-in-out;
		}

		input {
			width: 60%;
			height: 20px;
			background: #333333; /* Dark grey for input fields */
			color: #ffffff; /* White text color in input fields */
			justify-content: center;
			display: flex;
			margin: 20px auto;
			padding: 10px;
			border: none;
			outline: none;
			border-radius: 5px;
		}

		button {
			width: 60%;
			height: 40px;
			margin: 10px auto;
			justify-content: center;
			display: block;
			color: #ffffff; /* White text color on button */
			background: #ff0000; /* Red background color for button */
			font-size: 1em;
			font-weight: bold;
			margin-top: 20px;
			outline: none;
			border: none;
			border-radius: 5px;
			transition: .2s ease-in;
			cursor: pointer;
		}

		button:hover {
			background: #cc0000; /* Darker red on hover */
		}

		.login {
			height: 460px;
			background: rgba(0, 0, 0, 0.8); /* Semi-transparent black background for login container */
			border-radius: 60% / 10%;
			transform: translateY(-180px);
			transition: .8s ease-in-out;
		}

		.login label {
			color: #ff0000; /* Red color for login label */
			transform: scale(.6);
		}

		#chk:checked ~ .login {
			transform: translateY(-500px);
		}

		#chk:checked ~ .login label {
			transform: scale(1);
		}

		#chk:checked ~ .signup label {
			transform: scale(.6);
		}

		.error {
			color: black;
			font-size: 1em;
			text-align: center;
			margin-top: 10px;
		}

	</style>
</head>
<body>
<div class="main">
	<input type="checkbox" id="chk" aria-hidden="true" <%= "login".equals(request.getParameter("form")) ? "checked" : "" %> >

	<div class="signup">
		<form action="signup" method="post">
			<label for="chk" aria-hidden="true">Sign up</label>
			<% if (request.getAttribute("error") != null) { %>
			<div class="error"><%= request.getAttribute("error") %></div>
			<% } %>
			<input type="text" name="username" placeholder="User name" required="">
			<input type="email" name="email" placeholder="Email" required="">
			<input type="password" name="password" placeholder="Password" required="">
			<button type="submit">Sign up</button>
		</form>
	</div>

	<div class="login">
		<form action="login" method="post">
			<label for="chk" aria-hidden="true">Login</label>
			<% if (request.getAttribute("error") != null) { %>
			<div class="error"><%= request.getAttribute("error") %></div>
			<% } %>
			<input type="email" name="email" placeholder="Email" required="">
			<input type="password" name="password" placeholder="Password" required="">
			<button type="submit">Login</button>
		</form>
	</div>
</div>
</body>
</html>

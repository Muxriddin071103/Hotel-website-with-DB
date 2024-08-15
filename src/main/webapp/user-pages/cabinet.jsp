<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entity.User" %>
<%@ page import="org.example.repositories.UserRepository" %>
<%
    User user = (User) session.getAttribute("user");

    // Process password change form submission
    String errorMessage = null;
    String successMessage = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");
        String confirmNewPassword = request.getParameter("confirm_new_password");

        if (user != null) {
            if (!user.getPassword().equals(currentPassword)) {
                errorMessage = "Current password is incorrect.";
            } else if (!newPassword.equals(confirmNewPassword)) {
                errorMessage = "New passwords do not match.";
            } else {
                user.setPassword(newPassword);
                UserRepository userRepository = UserRepository.getInstance();
                userRepository.saveUser(user);
                successMessage = "Password changed successfully.";
            }
        } else {
            errorMessage = "User not logged in.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .info-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.15);
            width: 400px;
            text-align: center;
        }

        .info-container h2 {
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 32px;
            color: #333333;
            text-align: center;
        }

        .info-container p {
            margin: 15px 0;
            font-size: 20px;
            color: #333333;
            font-weight: bold;
        }

        .info-container p span {
            color: #666666;
            font-weight: normal;
        }

        .info-container a {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 20px;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .info-container a:hover {
            background-color: #0056b3;
        }

        .change-password-form {
            margin-top: 20px;
            text-align: left;
        }

        .change-password-form label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .change-password-form input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .change-password-form input[type="submit"] {
            background-color: #007bff;
            color: #ffffff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .change-password-form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message,
        .success-message {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<div class="info-container">
    <h2>User Information</h2>
    <% if (user != null) { %>
    <p><strong>Name:</strong> <span><%= user.getName() %></span></p>
    <p><strong>Email:</strong> <span><%= user.getEmail() %></span></p>
    <p><strong>Role:</strong> <span><%= user.getRole() %></span></p>
    <p><strong>Current Password:</strong> <span><%= user.getPassword() %></span></p>

    <% if (errorMessage != null) { %>
    <div class="error-message"><%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
    <div class="success-message"><%= successMessage %></div>
    <% } %>

    <!-- Password Change Form -->
    <form action="<%= request.getRequestURI() %>" method="post" class="change-password-form">
        <label for="current_password">Current Password:</label>
        <input type="password" id="current_password" name="current_password" required>

        <label for="new_password">New Password:</label>
        <input type="password" id="new_password" name="new_password" required>

        <label for="confirm_new_password">Confirm New Password:</label>
        <input type="password" id="confirm_new_password" name="confirm_new_password" required>

        <input type="submit" value="Change Password">
    </form>

    <a href="http://localhost:8080">Log Out</a>
    <a href="${pageContext.request.contextPath}/user-pages/main-page.jsp">Home</a>
    <% } else { %>
    <p>User information not available. Please log in.</p>
    <a href="http://localhost:8080">Login</a>
    <% } %>
</div>
</body>
</html>

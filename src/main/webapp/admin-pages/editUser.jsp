<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User - Majestic Hotel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .tm-container {
            margin: 20px auto;
            padding: 20px;
            max-width: 600px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .tm-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .tm-form-group {
            margin-bottom: 15px;
        }
        .tm-form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .tm-form-group input[type="text"],
        .tm-form-group input[type="email"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .tm-form-group input[type="checkbox"] {
            accent-color: #333;
            margin-right: 10px;
        }
        .tm-form-group .checkbox-label {
            display: inline-flex;
            align-items: center;
        }
        .tm-form-group button {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .tm-button.save {
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            padding: 10px 15px;
            border-radius: 4px;
        }
        .tm-button.save:hover {
            background-color: #2980b9;
        }
        .tm-button.cancel {
            background-color: #e74c3c;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            padding: 10px 15px;
            border-radius: 4px;
        }
        .tm-button.cancel:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="tm-container">
    <h1>Edit User</h1>
    <form action="../UserController" method="post">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="id" value="<%= request.getAttribute("user") != null ? ((User) request.getAttribute("user")).getId() : "" %>">
        <div class="tm-form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= request.getAttribute("user") != null ? ((User) request.getAttribute("user")).getName() : "" %>" required>
        </div>
        <div class="tm-form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= request.getAttribute("user") != null ? ((User) request.getAttribute("user")).getEmail() : "" %>" required>
        </div>
        <div class="tm-form-group">
            <label class="checkbox-label">
                <input type="checkbox" id="active" name="active" <%= request.getAttribute("user") != null && ((User) request.getAttribute("user")).isActive() ? "checked" : "" %>>
                Active
            </label>
        </div>
        <button type="submit" class="tm-button save">Save</button>
        <a href="${pageContext.request.contextPath}/admin-pages/manage-users.jsp" class="tm-button cancel">Cancel</a>
    </form>
</div>
</body>
</html>

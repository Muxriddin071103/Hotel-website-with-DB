<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.User" %>
<%@ page import="org.example.repositories.UserRepository" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Manage Users - Majestic Hotel</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../dist/slick.js"></script>
    <script type="text/javascript" src="../dist/jquery.scrollUp.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" type="text/css" href="../css/slick.css">
    <script type="text/javascript" src="../dist/demo.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
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
            max-width: 800px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .tm-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .tm-button {
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            margin-right: 5px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .tm-button.edit {
            background-color: #3498db;
            color: #fff;
        }
        .tm-button.edit:hover {
            background-color: #2980b9;
        }
        .tm-button.active {
            background-color: #27ae60;
            color: #fff;
        }
        .tm-button.active:hover {
            background-color: #2ecc71;
        }
        .tm-button.turn-off {
            background-color: #e74c3c;
            color: #fff;
        }
        .tm-button.turn-off:hover {
            background-color: #c0392b;
        }
        .tm-button.turn-on {
            background-color: #2ecc71;
            color: #fff;
        }
        .tm-button.turn-on:hover {
            background-color: #27ae60;
        }

        .tm-list.dropdown {
            color: cadetblue;
            position: relative;
            display: inline-block;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: black; /* Background color for dropdown menu */
            min-width: 160px;
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-menu li {
            list-style: none;
        }

        .dropdown-menu li a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-menu li a:hover {
            background-color: cadetblue;
            color: #000000;
        }

        .tm-list.dropdown:hover .dropdown-menu {
            display: block;
        }
    </style>
</head>
<body>
<header class="tm-header">
    <img class="tm-logo" src="../images/Majestic_Hotel_hd.png" alt="Majestic Hotel">
    <nav class="tm-nav">
        <div>
            <ul>
                <li class="tm-list"><a href="admin-main-page.jsp">Home</a></li>
                <li class="tm-list"><a href="manage-users.jsp">Manage Users</a></li>
                <li class="tm-list"><a href="manage-rooms.jsp">Manage Rooms</a></li>
                <li class="tm-list"><a href="manage-bookings.jsp">Manage Bookings</a></li>
                <li class="tm-list dropdown">
                    <a href="#" class="dropdown-toggle" id="cabinetButton">Cabinet</a>
                    <ul class="dropdown-menu">
                        <li><a href="cabinet.jsp">See Information</a></li>
                        <li><a href="http://localhost:8080">Log Out</a></li>
                    </ul>
                </li>
                </ul>
        </div>
    </nav>
</header>
<div class="tm-container">
    <h1>Manage Users</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Active</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            UserRepository userRepository = UserRepository.getInstance();
            List<User> users = userRepository.getUsers();
            for (User user : users) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getName() %></td>
            <td><%= user.getEmail() %></td>
            <td>
                <form action="../UserController" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="toggleActive">
                    <input type="hidden" name="id" value="<%= user.getId() %>">
                    <button type="submit" class="tm-button <%= user.isActive() ? "turn-off" : "turn-on" %>">
                        <%= user.isActive() ? "Turn Off" : "Turn On" %>
                    </button>
                </form>
            </td>
            <td>
                <form action="../UserController" method="get" style="display:inline;">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= user.getId() %>">
                    <button type="submit" class="tm-button edit">Edit</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

<%@ page import="org.example.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add Notification - Majestic Hotel</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <style>
        button[type="submit"] {
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #0056b3; /* Darker shade of primary color for hover effect */
        }

        button[type="submit"]:active {
            transform: scale(0.98); /* Slightly shrink button when clicked */
        }

        button[type="submit"]:focus {
            outline: none; /* Remove default focus outline */
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.5); /* Add a focus ring */
        }

        textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            resize: vertical; /* Allows the user to resize the textarea vertically */
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        textarea:focus {
            border-color: #007bff; /* Change border color on focus */
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25); /* Add a subtle focus shadow */
            outline: none; /* Remove default focus outline */
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .tm-add-notification form {
            max-width: 600px;
            margin: 0 auto;
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
                <li class="tm-list"><a href="notifications.jsp">Notifications</a></li>
                <li class="tm-list dropdown">
                    <a href="#" class="dropdown-toggle" id="cabinetButton">
                        <%
                            User user = (User) session.getAttribute("user");
                            String displayName = (user != null && user.getName() != null) ? user.getName() : "Cabinet";
                        %>
                        <%= displayName %>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="cabinet.jsp">See Information</a></li>
                        <li><a href="http://localhost:8080">Log Out</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>

<section class="tm-add-notification">
    <h1>Add Notification</h1>
    <form action="/notification" method="post">
        <input type="hidden" name="action" value="add">
        <label for="message">Notification Message:</label>
        <textarea id="message" name="message" required></textarea>
        <button type="submit">Add Notification</button>
        <%
            String success = request.getParameter("success");
            if ("true".equals(success)) {
        %>
        <p style="color:green;">Notification added successfully!</p>
        <%
            }
        %>
    </form>
</section>

<footer class="tm-footer">
    <p>&copy; 2024 Majestic Hotel. All Rights Reserved.</p>
</footer>
</body>
</html>

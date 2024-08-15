<%@ page import="org.example.repositories.NotificationRepository" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Notifications" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Notifications - Majestic Hotel</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <style>
        .tm-notifications {
            padding: 20px;
        }

        .add-notification-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #FFF;
            text-decoration: none;
            border-radius: 4px;
        }

        .notifications-table {
            width: 100%;
            border-collapse: collapse;
        }

        .notifications-table th, .notifications-table td {
            border: 1px solid #DDD;
            padding: 8px;
            text-align: left;
        }

        .notifications-table th {
            background-color: #F2F2F2;
        }

        .notifications-table tr:nth-child(even) {
            background-color: #F9F9F9;
        }

        .notifications-table tr:hover {
            background-color: #F1F1F1;
        }

        /* Delete button style */
        .delete-btn {
            background-color: #dc3545; /* Bootstrap danger color */
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .delete-btn:hover {
            background-color: #c82333; /* Darker shade of danger color */
        }

        .delete-btn:active {
            transform: scale(0.95); /* Slightly shrink button when clicked */
        }

        .delete-btn:focus {
            outline: none; /* Remove default focus outline */
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.5); /* Add a focus ring */
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

<section class="tm-notifications">
    <h1>Notifications</h1>
    <a href="/admin-pages/add-notification.jsp" class="add-notification-btn">Add Notification</a>
    <table class="notifications-table">
        <thead>
        <tr>
            <th>Id</th>
            <th>Message</th>
            <th>Created At</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <%
            NotificationRepository notificationRepository = NotificationRepository.getInstance();
            List<Notifications> notifications = notificationRepository.getAllNotifications();
            for (Notifications n : notifications) {
        %>
        <tr>
            <td><%= n.getId() %></td>
            <td><%= n.getMessage() %></td>
            <td><%= n.getCreatedAt() %></td>
            <td>
                <form action="/notification" method="post" onsubmit="return confirm('Are you sure you want to delete this notification?');">
                    <input type="hidden" name="id" value="<%= n.getId() %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</section>

<footer class="tm-footer">
    <p>&copy; 2024 Majestic Hotel. All Rights Reserved.</p>
</footer>
</body>
</html>

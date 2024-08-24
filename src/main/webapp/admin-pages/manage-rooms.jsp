<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Room" %>
<%@ page import="org.example.repositories.RoomRepository" %>
<%@ page import="org.example.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Manage Rooms - Majestic Hotel</title>
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
            max-width: 1000px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .tm-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f9f9f9;
            font-weight: bold;
        }
        .tm-button {
            padding: 10px 15px;
            font-size: 14px;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.2s;
        }
        .tm-button:hover {
            background-color: #555;
            transform: scale(1.05);
        }
        .tm-button.edit {
            background-color: #3498db;
            color: #fff;
        }
        .tm-button.edit:hover {
            background-color: #2980b9;
        }
        .tm-button.turn-off {
            background-color: #e74c3c;
        }
        .tm-button.turn-off:hover {
            background-color: #c0392b;
        }
        .tm-button.turn-on {
            background-color: #2ecc71;
        }
        .tm-button.turn-on:hover {
            background-color: #27ae60;
        }
        .tm-button.add {
            background-color: #2ecc71;
            display: inline-block;
            margin-bottom: 20px;
        }
        .tm-button.add:hover {
            background-color: #27ae60;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .actions form {
            margin: 0;
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
<div class="tm-container">
    <h1>Manage Rooms</h1>
    <a href="addRoom.jsp" class="tm-button add">Add Room</a>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price per Night</th>
            <th>Available</th>
            <th>Type</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                RoomRepository roomRepository = RoomRepository.getInstance();
                List<Room> rooms = roomRepository.getAllRooms();
                for (Room room : rooms) {
        %>
        <tr>
            <td><%= room.getId() %></td>
            <td><%= room.getName() != null ? room.getName() : "No Name" %></td>
            <td><%= room.getDescription() %></td>
            <td><%= room.getPricePerNight() %></td>
            <td>
                <form action="../RoomController" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="toggleActive">
                    <input type="hidden" name="id" value="<%= room.getId() %>">
                    <button type="submit" class="tm-button <%= room.isAvailable() ? "turn-off" : "turn-on" %>">
                        <%= room.isAvailable() ? "Turn Off" : "Turn On" %>
                    </button>
                </form>
            </td>
            <td><%= room.getTypeRoom() %></td>
            <td class="actions">
                <form action="../RoomController" method="get">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= room.getId() %>">
                    <button type="submit" class="tm-button edit">Edit</button>
                </form>
            </td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="7" style="text-align:center; color:red;">
                Error loading rooms: <%= e.getMessage() %>
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

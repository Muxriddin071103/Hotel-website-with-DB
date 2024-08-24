<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entity.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.repositories.ReservationRepository" %>
<%@ page import="org.example.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Manage Bookings - Majestic Hotel</title>
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
            max-width: 960px; /* Adjusted max-width for a more normal page width */
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .tm-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 24px; /* Reduced font size for a more standard appearance */
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
            padding: 8px; /* Reduced padding for a more compact table */
            text-align: left;
        }

        th {
            background-color: #f9f9f9;
            font-weight: bold;
        }

        .cancel-button, .activate-button, .delete-button {
            background-color: #ff4c4c; /* Red */
            color: white;
            border: none;
            padding: 8px 16px; /* Adjusted padding for a more standard button size */
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition-duration: 0.4s;
        }

        .activate-button {
            background-color: #4CAF50; /* Green */
        }

        .cancel-button:hover, .activate-button:hover, .delete-button:hover {
            background-color: white;
            color: #ff4c4c; /* Red for cancel and delete buttons */
            border: 2px solid #ff4c4c; /* Red for cancel and delete buttons */
        }

        .activate-button:hover {
            color: #4CAF50;
            border: 2px solid #4CAF50;
        }

        .delete-button {
            background-color: #ff4c4c; /* Red */
        }

        .delete-button:hover {
            background-color: white;
            color: #ff4c4c;
            border: 2px solid #ff4c4c;
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
<section class="tm-container">
    <h1>Manage Bookings</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>User Name</th>
            <th>Room Name</th>
            <th>Check-in Date</th>
            <th>Check-out Date</th>
            <th>Total Amount</th>
            <th>Confirmed</th>
            <th>Status</th>
            <th>Actions</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                ReservationRepository reservationRepository = ReservationRepository.getInstance();
                List<Reservation> reservations = reservationRepository.getReservations();
                if (reservations != null) {
                    for (Reservation reservation : reservations) {
        %>
        <tr>
            <td><%= reservation.getId() %></td>
            <td><%= reservation.getUserName() %></td>
            <td><%= reservation.getRoomName() %></td>
            <td><%= reservation.getCheckInDate() %></td>
            <td><%= reservation.getCheckOutDate() %></td>
            <td><%= reservation.getTotalAmount() %></td>
            <td><%= reservation.isConfirmed() %></td>
            <td><%= reservation.getStatus().name() %></td>
            <td>
                <form action="../reservation" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="cancel">
                    <input type="hidden" name="id" value="<%= reservation.getId() %>">
                    <button type="submit" class="cancel-button">Cancel</button>
                </form>
                <form action="../reservation" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="activate">
                    <input type="hidden" name="id" value="<%= reservation.getId() %>">
                    <button type="submit" class="activate-button">Activate</button>
                </form>
            </td>
            <td>
                <form action="../reservation" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= reservation.getId() %>">
                    <button type="submit" class="delete-button" style="background-color: #ff4c4c; color: white;">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="9">No reservations found.</td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="9">Error retrieving reservations.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</section>
<footer class="tm-footer">
    <p>&copy; 2024 Majestic Hotel. All Rights Reserved.</p>
</footer>
</body>
</html>

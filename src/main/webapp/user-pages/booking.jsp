<%@ page import="org.example.entity.Reservation" %>
<%@ page import="org.example.entity.User" %>
<%@ page import="org.example.entity.Room" %>
<%@ page import="org.example.repositories.RoomRepository" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.repositories.NotificationRepository" %>
<%@ page import="org.example.entity.Notifications" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Magestic Hotel - Booking</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <style>
        .booking-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .booking-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
            color: #007BFF;
        }

        .booking-container .section-header {
            font-size: 20px;
            margin-bottom: 15px;
            color: #333;
        }

        .booking-form {
            display: flex;
            flex-direction: column;
        }

        .booking-form label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .booking-form select,
        .booking-form input[type="text"],
        .booking-form input[type="number"],
        .booking-form input[type="datetime-local"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .booking-form input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .booking-form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .info-table th,
        .info-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .info-table th {
            background-color: #f4f4f4;
            color: #333;
        }

        .success-message,
        .error-message {
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

        .footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f8f8;
            margin-top: 20px;
            border-top: 1px solid #ddd;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }

        .notification-container {
            position: relative;
            display: inline-block;
        }

        #notification-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            /* color of page = #211f17 */
            padding: 10px;
            border-radius: 4px;
            color: white;
            transition: background-color 0.3s ease;
            width: 48px;
            height: 48px;
        }

        #notification-icon img {
            width: 28px;
            height: 28px;
        }

        #notification-icon:hover {
            background-color: #0056b3;
        }

        #notification-count {
            position: absolute;
            top: -6px;
            right: -6px;
            width: 22px;
            height: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: red;
            color: white;
            font-size: 14px;
            font-weight: bold;
            line-height: 1;
            padding: 0;
        }

        #notification-dropdown {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 250px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            padding: 12px 16px;
            z-index: 1;
            right: 0;
            top: 100%;
            border-radius: 4px;
        }

        .notification-item {
            padding: 8px 0;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
            color: #333;
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-item p {
            margin: 0;
        }

        .notification-item p strong {
            display: block;
            margin-bottom: 5px;
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
    <script>
        function calculateTotalAmount() {
            const checkInDate = new Date(document.getElementById('check_in_date').value);
            const checkOutDate = new Date(document.getElementById('check_out_date').value);
            const pricePerNight = parseFloat(document.getElementById('price_per_night').value);

            if (checkInDate && checkOutDate && pricePerNight) {
                const timeDifference = checkOutDate.getTime() - checkInDate.getTime();

                const hours = timeDifference / (1000 * 3600);

                let totalAmount;

                if (hours <= 24 && checkInDate.toDateString() === checkOutDate.toDateString()) {
                    const hourlyRate = pricePerNight / 24;
                    totalAmount = hours * hourlyRate;
                } else {
                    const days = Math.ceil(timeDifference / (1000 * 3600 * 24));
                    totalAmount = days * pricePerNight;
                }

                document.getElementById('total_amount').value = totalAmount.toFixed(2);
            }
        }

        function updatePrice() {
            const roomSelect = document.getElementById('room_id');
            const selectedOption = roomSelect.options[roomSelect.selectedIndex];
            const pricePerNight = selectedOption.getAttribute('data-price');
            document.getElementById('price_per_night').value = pricePerNight;
            calculateTotalAmount();
        }

        function validateDate() {
            const checkInDate = new Date(document.getElementById('check_in_date').value);
            const checkOutDate = new Date(document.getElementById('check_out_date').value);
            const now = new Date();
            const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

            if (checkInDate < today || checkOutDate < today) {
                alert("You cannot enter a date before today.");
                document.getElementById('check_in_date').value = "";
                document.getElementById('check_out_date').value = "";
                return false;
            }

            return true;
        }

    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Toggle notification dropdown
            $('#notification-icon').click(function(event) {
                event.preventDefault();
                $('#notification-dropdown').toggle(); // Toggle the display of the dropdown
            });

            // Hide notification dropdown if clicking outside
            $(document).click(function(event) {
                if (!$(event.target).closest('#notification-icon, #notification-dropdown').length) {
                    $('#notification-dropdown').hide();
                }
            });
        });
    </script>
</head>
<body>
<header class="tm-header">
    <img class="tm-logo" src="../images/Majestic_Hotel_hd.png" alt="Majestic Hotel">
    <nav class="tm-nav">
        <div>
            <ul>
                <li class="tm-list"><a href="main-page.jsp">Home</a></li>
                <li class="tm-list"><a href="explore.jsp">Explore</a></li>
                <li class="tm-list"><a href="rooms.jsp">Rooms</a></li>
                <li class="tm-list"><a href="booking.jsp">Booking</a></li>
                <li class="tm-list dropdown">
                    <a href="#" class="dropdown-toggle" id="cabinetButton">Cabinet</a>
                    <ul class="dropdown-menu">
                        <li><a href="cabinet.jsp">See Information</a></li>
                        <li><a href="http://localhost:8080">Log Out</a></li>
                    </ul>
                </li>
                <li>
                    <div class="notification-container">
                        <a href="#" id="notification-icon">
                            <img src="../images/bell.png" alt="Notifications">
                            <span id="notification-count">
            <%= NotificationRepository.getInstance().getCountNotifications() %>
        </span>
                        </a>
                        <div id="notification-dropdown" class="dropdown-content">
                            <%
                                NotificationRepository notificationRepository = NotificationRepository.getInstance();
                                List<Notifications> notifications = notificationRepository.getAllNotifications();
                                for (Notifications n : notifications) {
                            %>
                            <div class="notification-item">
                                <p><strong><%= n.getMessage() %></strong></p>
                                <p><%= n.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %></p>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</header>

<section class="booking-container">
    <h2>Make a Reservation</h2>
    <form action="/booking" method="post" class="booking-form">
        <%
            User user = (User) session.getAttribute("user");
            if (user != null) {
        %>
        <label for="user_name">User:</label>
        <input type="text" id="user_name" name="user_name" value="<%= user.getName() %>" readonly>
        <input type="hidden" id="user_id" name="user_id" value="<%= user.getId() %>">

        <label for="room_id">Room:</label>
        <select id="room_id" name="room_id" required onchange="updatePrice()">
            <%
                RoomRepository roomRepository = RoomRepository.getInstance();
                List<Room> rooms = roomRepository.getAllRooms();
                for (Room room : rooms) {
            %>
            <option value="<%= room.getId() %>" data-price="<%= room.getPricePerNight() %>"><%= room.getName() %> - <%= room.getPricePerNight() %> per night</option>
            <%
                }
            %>
        </select>

        <label for="check_in_date">Check-In Date:</label>
        <input type="datetime-local" id="check_in_date" name="check_in_date" required onchange="validateDate(); calculateTotalAmount()">

        <label for="check_out_date">Check-Out Date:</label>
        <input type="datetime-local" id="check_out_date" name="check_out_date" required onchange="validateDate(); calculateTotalAmount()">

        <label for="price_per_night">Price Per Night:</label>
        <input type="text" id="price_per_night" name="price_per_night" readonly>

        <label for="total_amount">Total Amount:</label>
        <input type="number" id="total_amount" name="total_amount" step="0.01" readonly>

        <input type="submit" value="Book Now">
        <%
        } else {
        %>
        <p class="error-message">You need to log in to make a reservation.</p>
        <%
            }
        %>
    </form>

    <% if (session.getAttribute("successMessage") != null) { %>
    <p class="success-message"><%= session.getAttribute("successMessage") %></p>
    <p>Reservation ID: <%= ((Reservation) session.getAttribute("reservation")).getId() %></p>
    <p>Room ID: <%= ((Reservation) session.getAttribute("reservation")).getRoomId() %></p>
    <p>Check-In Date: <%= ((Reservation) session.getAttribute("reservation")).getCheckInDate() %></p>
    <p>Check-Out Date: <%= ((Reservation) session.getAttribute("reservation")).getCheckOutDate() %></p>
    <p>Total Amount: <%= ((Reservation) session.getAttribute("reservation")).getTotalAmount() %></p>
    <% session.removeAttribute("successMessage"); %>
    <% session.removeAttribute("reservation"); %>
    <% } %>

    <% if (session.getAttribute("errorMessage") != null) { %>
    <p class="error-message"><%= session.getAttribute("errorMessage") %></p>
    <% session.removeAttribute("errorMessage"); %>
    <% } %>

</section>

<footer class="footer">
    <div>
        <p>&copy; 2024 Magestic Hotel. All rights reserved.</p>
    </div>
</footer>
</body>
</html>

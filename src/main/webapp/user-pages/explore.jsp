<%@ page import="org.example.repositories.NotificationRepository" %>
<%@ page import="org.example.entity.Notifications" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Explore Page</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../dist/jquery.scrollUp.js"></script>
    <script type="text/javascript" src="../dist/demo.js"></script>
    <style>
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
        $(document).ready(function() {
            $('#notification-icon').click(function(event) {
                event.preventDefault();
                $('#notification-dropdown').toggle();
            });

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
                            <% } %>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</header>
<section class="tm-main">
    <p>Explore</p>
</section>
<section class="tm-expsection">
    <div class="tm-exp1">
        <p>Luxurious and Spacious Rooms</p>
        <img src="../images/luxorius.png" alt="Luxurious Rooms">
    </div>
</section>
<section class="tm-expsection">
    <div class="tm-exp2">
        <p>In-house Spa</p>
        <img src="../images/spahouse.png" alt="In-house Spa">
    </div>
</section>
<section class="tm-expsection">
    <div class="tm-exp1">
        <p>Swimming Pools</p>
        <img src="../images/swimming.png" alt="Swimming Pools">
    </div>
</section>
<section class="tm-expsection">
    <div class="tm-exp2">
        <p>Indoor Game Room</p>
        <img src="../images/play.png" alt="Indoor Game Room">
    </div>
</section>
<section class="tm-makeres">
    <div class="tm-res">
        <div class="tm-resbutton">
            <a href="booking.jsp"><p>Make Reservation</p></a>
        </div>
    </div>
</section>
<footer class="tm-footer">
    <div class="tm-us">
        <p class="bold">About Us</p>
        <p>We are part of a chain of luxury hotels which extends all over the world. We provide a luxurious stay with various value-added and free services which will make you visit us over and over again.</p>
    </div>
    <div class="tm-address">
        <p class="bold">Address</p>
        <p>Tashkent city, Uchtepa street<br>Phone: +(998) 93 104 55 33<br>Email: kingofdark0703@gmil.com</p>
    </div>
</footer>
</body>
</html>

<%@ page import="org.example.entity.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.repositories.RoomRepository" %>
<%@ page import="java.util.Random" %>
<%@ page import="org.example.repositories.NotificationRepository" %>
<%@ page import="org.example.entity.Notifications" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Magestic Hotel - Rooms</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../dist/jquery.scrollUp.js"></script>
    <script type="text/javascript" src="../dist/demo.js"></script>
    <style>
        /* General Page Styles */
        body {
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }

        header.tm-header {
            background-color: #333;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        .tm-logo {
            max-width: 150px;
        }

        .tm-nav {
            margin-top: 10px;
        }

        .tm-nav ul {
            list-style: none;
            padding: 0;
        }

        .tm-nav ul li {
            display: inline;
            margin: 0 15px;
        }

        .tm-nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .tm-nav ul li a:hover {
            text-decoration: underline;
        }

        .tm-main {
            padding: 20px;
            text-align: center;
            background-color: #f4f4f4;
        }

        .tm-main .highlight {
            color: #cc0000;
            font-size: 48px;
            font-weight: bolder;
            font-style: oblique;
        }

        .tm-roomsection {
            padding: 20px;
            background-color: #fff;
        }

        .tm-roomsection table {
            width: 100%;
            border-collapse: collapse;
        }

        .tm-roomsection th, .tm-roomsection td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .tm-roomsection th {
            background-color: #f2f2f2;
        }

        .tm-roomsection tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .tm-roomsection tr:hover {
            background-color: #f1f1f1;
        }

        .tm-roomsection td {
            vertical-align: top;
        }

        /* Footer Styles */
        footer.tm-footer {
            background-color: #333;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .tm-footer p {
            margin: 5px 0;
        }

        .tm-footer .bold {
            font-weight: bold;
        }

        .tm-footer .tm-address {
            margin-top: 20px;
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
        $(document).ready(function() {
            $("#searchInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#roomTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });

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
    <p class="highlight">Available Rooms</p>
    <input type="text" id="searchInput" placeholder="Search for rooms..." style="width: 80%; padding: 10px; margin-bottom: 20px;">
</section>

<section class="tm-roomsection">
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Price per Night</th>
            <th>Type</th>
            <th>Image</th>
        </tr>
        </thead>
        <tbody id="roomTable">
        <%
            try {
                RoomRepository roomRepository = RoomRepository.getInstance();
                List<Room> rooms = roomRepository.getAvailableRooms();
                String[] images = {"delux.png", "deluxroom.png", "luxorius.png", "luxury.png","luxuryroom.png","premier.png","premiumroom.png"};
                Random rand = new Random();
                for (Room room : rooms) {
                    String randomImage = images[rand.nextInt(images.length)];
        %>
        <tr>
            <td><%= room.getName() != null ? room.getName() : "No Name" %></td>
            <td><%= room.getDescription() %></td>
            <td><%= room.getPricePerNight() %></td>
            <td><%= room.getTypeRoom() %></td>
            <td><img src="../roomImages/<%= randomImage %>" alt="Room Image" style="width:200px;height:150px;"></td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="5" style="text-align:center; color:red;">
                Error loading rooms: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</section>

<footer class="tm-footer">
    <div class="tm-us">
        <p class="bold">About Us</p>
        <p>We are a part of a chain of luxury hotels which extends all over the world. We provide a luxurious stay with various value-added and free services which will make you visit us over and over again.</p>
    </div>
    <div class="tm-address">
        <p class="bold">Address</p>
        <p>Tashkent city, Uchtepa street<br>Phone: +(998) 93 104 55 33<br>Email: kingofdark0703@gmil.com</p>
    </div>
    <br/>
</footer>
</body>
</html>

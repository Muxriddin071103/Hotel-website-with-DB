<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Magestic Hotel</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../dist/slick.js"></script>
    <script type="text/javascript" src="../dist/jquery.scrollUp.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" type="text/css" href="../css/slick.css">
    <script type="text/javascript" src="../dist/demo.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <style>
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
<section class="tm-imgslider">
    <div class="slider single">
        <div>
            <div class="tm-slider">
                <img class="tm-sliderimage" src="../images/main_slider11.png" alt="Majestic Hotel">
                <div class="tm-slidertext">
                    <p class="bold">Experience</p>
                    <p class="simple">The Beauty and ambience</p>
                    <p class="simple">All in one place</p>
                </div>
            </div>
        </div>
        <div>
            <div class="tm-slider">
                <img class="tm-sliderimage" src="../images/main_slider12.png" alt="Majestic Hotel">
                <div class="tm-slidertext">
                    <p class="bold">Experience</p>
                    <p class="simple">The tranquility</p>
                    <p class="simple">in hotel spa and swimming pool</p>
                </div>
            </div>
        </div>
        <div>
            <div class="tm-slider">
                <img class="tm-sliderimage" src="../images/main_slider13.png" alt="Majestic Hotel">
                <div class="tm-slidertext">
                    <p class="bold">Experience</p>
                    <p class="simple">The luxurious interiors</p>
                    <p class="simple">in every hotel room</p>
                </div>
            </div>
        </div>
        <div>
            <div class="tm-slider">
                <img class="tm-sliderimage" src="../images/main_slider14.png" alt="Majestic Hotel">
                <div class="tm-slidertext">
                    <p class="bold">Experience</p>
                    <p class="simple">The mesmerizing beach view</p>
                    <p class="simple">from your room's balcony</p>
                </div>
            </div>
        </div>
    </div>
    <img src="../images/back.png" class="left">
    <img src="../images/next.png" class="right">
</section>
<section class="slider room flex">
    <div class="tm-rooms">
        <img src="../images/luxury.png">
        <p class="s">Luxury Suite</p>
    </div>
    <div class="tm-rooms">
        <img src="../images/delux.png">
        <p class="s">Deluxe Suite</p>
    </div>
    <div class="tm-rooms">
        <img src="../images/premier.png">
        <p>Premier Suite</p>
    </div>
    <div class="tm-rooms">
        <img src="../images/luxuryroom.png">
        <p class="s">Luxury Room</p>
    </div>
    <div class="tm-rooms">
        <img src="../images/deluxroom.png">
        <p>Deluxe Room</p>
    </div>
    <div class="tm-rooms">
        <img src="../images/premiumroom.png">
        <p>Premier Room</p>
    </div>
</section>
<section class="tm-servicesection">
    <div class="tm-service">
        <img class="tm-serimage" src="../images/bell.png">
        <div>
            <p class="b">Room Service</p>
            <p>Enjoy your stay with excellent and timely room service</p>
        </div>
    </div>
    <div class="tm-service">
        <img class="tm-serimage" src="../images/coffee.png">
        <div>
            <p class="b">Free Breakfast</p>
            <p>Enjoy free breakfast every morning</p>
        </div>
    </div>
</section>
<section class="tm-servicesection">
    <div class="tm-service">
        <img class="tm-serimage" src="../images/car-front.png">
        <div>
            <p class="b">Free Parking</p>
            <p>No need to pay any extra charges to park your vehicle</p>
        </div>
    </div>
    <div class="tm-service">
        <img class="tm-serimage" src="../images/spa.png">
        <div>
            <p class="b">Free Spa</p>
            <p>Relax at the in-house Spa once every day of your stay</p>
        </div>
    </div>
</section>
<section class="tm-reviewsection">
    <div class="tm-review">
        <div class="slider review">
            <div class="tm-revcon">
                <div class="tm-rev-header">
                    <p class="b">Reviews</p>
                    <div class="tm-stars">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                    </div>
                </div>
                <div class="tm-rev-content">
                    <p>"Great hotel, I am recommending it to everyone. Wished I had stayed a few more days there."</p>
                    <p class="reviewer">Rachel Green <span class="reviewer-role">Tripster</span></p>
                </div>
            </div>
            <div class="tm-revcon">
                <div class="tm-rev-header">
                    <p class="b">Reviews</p>
                    <div class="tm-stars">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                    </div>
                </div>
                <div class="tm-rev-content">
                    <p>"Nice hotel, I had a wonderful experience and there are plenty of amenities."</p>
                    <p class="reviewer">Ross Geller <span class="reviewer-role">Visitor</span></p>
                </div>
            </div>
            <div class="tm-revcon">
                <div class="tm-rev-header">
                    <p class="b">Reviews</p>
                    <div class="tm-stars">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                    </div>
                </div>
                <div class="tm-rev-content">
                    <p>"Great hotel, great food enough said."</p>
                    <p class="reviewer">Joey Tribiani <span class="reviewer-role">Actor</span></p>
                </div>
            </div>
            <div class="tm-revcon">
                <div class="tm-rev-header">
                    <p class="b">Reviews</p>
                    <div class="tm-stars">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                        <img src="../images/star.png" alt="Star">
                    </div>
                </div>
                <div class="tm-rev-content">
                    <p>"Best hotel experience ever!"</p>
                    <p class="reviewer">Monica Geller <span class="reviewer-role">Chef</span></p>
                </div>
            </div>
        </div>
    </div>
</section>
<footer class="tm-footer">
    <p>&copy; 2024 Majestic Hotel. All Rights Reserved.</p>
</footer>
</body>
</html>

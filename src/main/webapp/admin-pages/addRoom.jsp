<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add Room - Majestic Hotel</title>
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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .tm-button {
            padding: 8px 12px;
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
            margin-right: 5px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 4px;
        }
        .tm-button:hover {
            background-color: #555;
        }
        .tm-button.cancel {
            background-color: #e74c3c;
        }
        .tm-button.cancel:hover {
            background-color: #c0392b;
        }

        .custom-checkbox {
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            position: relative;
            user-select: none;
        }

        .custom-checkbox input {
            opacity: 0;
            position: absolute;
            cursor: pointer;
            width: 0;
            height: 0;
        }

        .custom-checkbox span {
            position: relative;
            display: inline-block;
            width: 24px;
            height: 24px;
            border: 2px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .custom-checkbox input:checked + span {
            background-color: #4CAF50;
            border-color: #4CAF50;
        }

        .custom-checkbox span::after {
            content: '';
            position: absolute;
            top: 6px;
            left: 10px;
            width: 6px;
            height: 12px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .custom-checkbox input:checked + span::after {
            opacity: 1;
        }

        .checkbox-label {
            margin-left: 10px;
            color: #333;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="tm-container">
    <h1>Add Room</h1>
    <form action="../RoomController" method="post">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" id="description" name="description" required>
        </div>
        <div class="form-group">
            <label for="imageUrl">Image URL:</label>
            <input type="hidden" id="imageUrl" name="imageUrl" value="roomImages/luxury.png">
            <p>Default Image</p>
        </div>
        <div class="form-group">
            <label for="pricePerNight">Price per Night:</label>
            <input type="number" id="pricePerNight" name="pricePerNight" step="1.00" required>
        </div>
        <div class="form-group">
            <label>Available:</label>
            <div class="custom-checkbox">
                <input type="checkbox" id="available" name="available" value="true">
                <span></span>
                <label for="available" class="checkbox-label">Available</label>
            </div>
        </div>
        <div class="form-group">
            <label for="typeRoom">Type:</label>
            <select id="typeRoom" name="typeRoom" required>
                <option value="STANDARD">STANDARD</option>
                <option value="DELUXE">DELUXE</option>
                <option value="SUITE">SUITE</option>
                <option value="EXECUTIVE">EXECUTIVE</option>
            </select>
        </div>
        <button type="submit" class="tm-button">Add Room</button>
        <a href="/admin-pages/manage-rooms.jsp" class="tm-button cancel">Cancel</a>
    </form>
</div>
</body>
</html>

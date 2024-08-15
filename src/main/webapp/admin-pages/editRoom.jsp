<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entity.Room" %>
<%@ page import="org.example.repositories.RoomRepository" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Edit Room - Majestic Hotel</title>
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
            max-width: 600px;
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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            resize: vertical;
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
        .tm-button.save {
            background-color: #3498db;
        }
        .tm-button.save:hover {
            background-color: #2980b9;
        }
        .tm-button.cancel {
            background-color: #e74c3c;
            margin-left: 10px;
        }
        .tm-button.cancel:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="tm-container">
    <h1>Edit Room</h1>
    <%
        String id = request.getParameter("id");
        RoomRepository roomRepository = RoomRepository.getInstance();
        Optional<Room> room = roomRepository.getRoomById(id);
    %>
    <form action="../RoomController" method="post">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="id" value="<%= room.get().getId() %>">

        <div class="form-group">
            <label for="name">Room Name</label>
            <input type="text" id="name" name="name" value="<%= room.get().getName() %>" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" required><%= room.get().getDescription() %></textarea>
        </div>

        <div class="form-group">
            <label for="price">Price per Night</label>
            <input type="number" id="price" name="pricePerNight" value="<%= room.get().getPricePerNight() %>" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="type">Room Type</label>
            <select id="type" name="typeRoom" required>
                <option value="STANDARD" <%= "STANDARD".equals(room.get().getTypeRoom()) ? "selected" : "" %>>STANDARD</option>
                <option value="DELUXE" <%= "DELUXE".equals(room.get().getTypeRoom()) ? "selected" : "" %>>DELUXE</option>
                <option value="SUITE" <%= "SUITE".equals(room.get().getTypeRoom()) ? "selected" : "" %>>SUITE</option>
                <option value="EXECUTIVE" <%= "EXECUTIVE".equals(room.get().getTypeRoom()) ? "selected" : "" %>>EXECUTIVE</option>
            </select>
        </div>

        <div class="form-group">
            <label for="available">Available</label>
            <select id="available" name="available" required>
                <option value="true" <%= room.get().isAvailable() ? "selected" : "" %>>Yes</option>
                <option value="false" <%= !room.get().isAvailable() ? "selected" : "" %>>No</option>
            </select>
        </div>

        <button type="submit" class="tm-button save">Save</button>
        <a href="${pageContext.request.contextPath}/admin-pages/manage-rooms.jsp" class="tm-button cancel">Cancel</a>
    </form>
</div>
</body>
</html>

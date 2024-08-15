package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Room;
import org.example.repositories.RoomRepository;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewRoomController")
public class ViewRoomController extends HttpServlet {

    private final RoomRepository roomRepository = RoomRepository.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Room> rooms = roomRepository.getAvailableRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/user-pages/rooms.jsp").forward(request, response);
    }
}

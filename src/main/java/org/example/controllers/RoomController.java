package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Room;
import org.example.enums.TypeRoom;
import org.example.repositories.RoomRepository;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/RoomController")
public class RoomController extends HttpServlet {

    private final RoomRepository roomRepository = RoomRepository.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("edit".equals(action)) {
            Optional<Room> room = roomRepository.getRoomById(id);
            room.ifPresent(value -> request.setAttribute("room", value));
            request.getRequestDispatcher("/admin-pages/editRoom.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.getRequestDispatcher("/admin-pages/addRoom.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            handleEditPost(req, resp);
        } else if ("add".equals(action)) {
            handleAddPost(req, resp);
        } else if ("toggleActive".equals(action)) {
            handleToggleAvailable(req, resp);
        }
    }

    private void handleEditPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String imageUrl = req.getParameter("imageUrl");
        double pricePerNight = Double.parseDouble(req.getParameter("pricePerNight"));
//        boolean available = req.getParameter("available") != null;
        String typeRoom = req.getParameter("typeRoom");

        Optional<Room> room = roomRepository.getRoomById(id);
        if (room.isPresent()) {
            Room updatedRoom = room.get();
            updatedRoom.setName(name);
            updatedRoom.setDescription(description);
            updatedRoom.setImageUrl(imageUrl);
            updatedRoom.setPricePerNight(pricePerNight);
            updatedRoom.setAvailable(true);
            updatedRoom.setTypeRoom(TypeRoom.valueOf(typeRoom));
            roomRepository.saveRoom(updatedRoom);
        }
        resp.sendRedirect("/admin-pages/manage-rooms.jsp");
    }

    private void handleAddPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String imageUrl = req.getParameter("imageUrl");
        double pricePerNight = Double.parseDouble(req.getParameter("pricePerNight"));
        boolean available = req.getParameter("available") != null;
        String typeRoom = req.getParameter("typeRoom");

        Room newRoom = new Room();
        newRoom.setName(name);
        newRoom.setDescription(description);
        newRoom.setImageUrl(imageUrl);
        newRoom.setPricePerNight(pricePerNight);
        newRoom.setAvailable(available);
        newRoom.setTypeRoom(TypeRoom.valueOf(typeRoom));

        roomRepository.saveRoom(newRoom);
        resp.sendRedirect("/admin-pages/manage-rooms.jsp");
    }

    private void handleToggleAvailable(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Optional<Room> room = roomRepository.getRoomById(id);
        if (room.isPresent()) {
            Room updatedRoom = room.get();
            boolean newAvailability = !updatedRoom.isAvailable();
            updatedRoom.setAvailable(newAvailability);
            roomRepository.saveRoom(updatedRoom);
        }
        resp.sendRedirect("/admin-pages/manage-rooms.jsp");
    }

}

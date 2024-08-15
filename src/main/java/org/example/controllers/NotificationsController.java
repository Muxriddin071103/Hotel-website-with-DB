package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import org.example.entity.Notifications;
import org.example.repositories.NotificationRepository;

import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class NotificationsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NotificationRepository notificationRepository = NotificationRepository.getInstance();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Notifications> notifications = notificationRepository.getAllNotifications();
        System.out.println("Notifications: " + notifications);
        request.setAttribute("notifications", notifications);
        request.getRequestDispatcher("/notifications.jsp").forward(request, response);
    }
}


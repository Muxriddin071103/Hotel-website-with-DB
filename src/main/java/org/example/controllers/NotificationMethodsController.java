package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.repositories.NotificationRepository;

import java.io.IOException;

@WebServlet("/notification")
public class NotificationMethodsController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NotificationRepository notificationRepository = NotificationRepository.getInstance();
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                notificationRepository.deleteNotification(Integer.parseInt(id));
            }
        } else if ("add".equals(action)) {
            String message = request.getParameter("message");
            if (message != null && !message.isEmpty()) {
                notificationRepository.addNotification(message);
                response.sendRedirect("/admin-pages/add-notification.jsp?success=true");
                return;
            }
        }

        response.sendRedirect("/admin-pages/notifications.jsp");
    }
}

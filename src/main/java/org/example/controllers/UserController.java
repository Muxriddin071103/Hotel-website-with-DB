package org.example.controllers;

import org.example.entity.User;
import org.example.repositories.UserRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/UserController")
public class UserController extends HttpServlet {

    private final UserRepository userRepository = UserRepository.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("edit".equals(action)) {
            Optional<User> user = userRepository.getUserById(id);
            if (user.isPresent()) {
                request.setAttribute("user", user.get());
                request.getRequestDispatcher("/admin-pages/editUser.jsp").forward(request, response);
            } else {
                response.sendRedirect("/admin-pages/manage-users.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            handleEditPost(req, resp);
        } else if ("toggleActive".equals(action)) {
            handleToggleActive(req, resp);
        }
    }

    private void handleEditPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        boolean active = req.getParameter("active") != null;

        Optional<User> user = userRepository.getUserById(id);
        if (user.isPresent()) {
            User updatedUser = user.get();
            updatedUser.setName(name);
            updatedUser.setEmail(email);
            updatedUser.setActive(active);
            userRepository.saveUser(updatedUser);
        }
        resp.sendRedirect(req.getContextPath() + "/admin-pages/manage-users.jsp");
    }

    private void handleToggleActive(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Optional<User> user = userRepository.getUserById(id);
        if (user.isPresent()) {
            User updatedUser = user.get();
            updatedUser.setActive(!updatedUser.isActive());
            userRepository.saveUser(updatedUser);
        }
        resp.sendRedirect("/admin-pages/manage-users.jsp");
    }
}

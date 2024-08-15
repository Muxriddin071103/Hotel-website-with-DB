package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.enums.Role;
import org.example.repositories.UserRepository;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/signup")
public class SignUpController extends HttpServlet {
    private final UserRepository userRepository = UserRepository.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if(userRepository.getUserByEmail(email).isPresent()){
            req.setAttribute("error", "You already have an account with that email");
            req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
            return;
        }

        Role role = determineRoleBasedOnEmail(email);

        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setName(username);
        user.setEmail(email);
        user.setPassword(password); // Consider hashing the password here
        user.setRole(role);
        user.setActive(true);

        // Save the user to the repository
        userRepository.saveUser(user);

        // Automatically log in the user and redirect based on role
        req.getSession().setAttribute("user", user);
        if (user.getRole() == Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/admin-pages/admin-main-page.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user-pages/main-page.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
    }

    private Role determineRoleBasedOnEmail(String email) {
        if (email.startsWith("admin")) {
            return Role.ADMIN;
        }
        return Role.USER;
    }
}

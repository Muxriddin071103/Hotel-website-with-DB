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
import java.util.Optional;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final UserRepository userRepository = UserRepository.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Optional<User> optionalUser = userRepository.getUserByEmail(email);

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (!user.isActive()){
                req.setAttribute("error", "User is blocked from admin!!!");
                req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
                return;
            }
            if (user.getPassword().equals(password)) {
                req.getSession().setAttribute("user", user);

                if (user.getRole() == Role.ADMIN) {
                    resp.sendRedirect(req.getContextPath() + "/admin-pages/admin-main-page.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/user-pages/main-page.jsp");
                }
            } else {
                req.setAttribute("error", "Invalid password.");
                req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "User not found.");
            req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("modern_login.jsp").forward(req, resp);
    }
}

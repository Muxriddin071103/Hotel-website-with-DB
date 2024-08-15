package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;

import java.io.IOException;

@WebServlet("/cabinet")
public class CabinetController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user != null) {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/user-pages/cabinet.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("modern_login.jsp");
        }
    }
}

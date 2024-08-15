package org.example.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.User;
import org.example.enums.Role;

import java.io.IOException;

@WebFilter("/*")
public class MainFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession(false);

        if (req.getRequestURI().contains("/admin-pages/")) {
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null || user.getRole() != Role.ADMIN) {
                res.sendRedirect("/modern_login.jsp");
                return;
            }
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }
}

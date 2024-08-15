package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.enums.ReservationStatus;
import org.example.repositories.ReservationRepository;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/reservation")
public class ReservationController extends HttpServlet {
    private final ReservationRepository reservationRepository;

    public ReservationController() {
        this.reservationRepository = ReservationRepository.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("reservations", reservationRepository.getReservations());
        request.getRequestDispatcher("/admin-pages/manage-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UUID reservationId = UUID.fromString(request.getParameter("id"));
        if ("cancel".equals(action)) {
            reservationRepository.updateReservationStatus(reservationId, ReservationStatus.CANCELED);
        } else if ("activate".equals(action)) {
            reservationRepository.updateReservationStatus(reservationId, ReservationStatus.ACTIVE);
        } else if ("delete".equals(action)) {
            reservationRepository.deleteReservation(reservationId);
        }
        response.sendRedirect("/admin-pages/manage-bookings.jsp");
    }
}

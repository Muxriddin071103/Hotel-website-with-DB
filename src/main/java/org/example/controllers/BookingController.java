package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Reservation;
import org.example.enums.ReservationStatus;
import org.example.repositories.ReservationRepository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.UUID;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private final ReservationRepository reservationRepository = ReservationRepository.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            UUID userId = UUID.fromString(request.getParameter("user_id"));
            UUID roomId = UUID.fromString(request.getParameter("room_id"));
            LocalDateTime checkInDateTime = LocalDateTime.parse(request.getParameter("check_in_date"));
            LocalDateTime checkOutDateTime = LocalDateTime.parse(request.getParameter("check_out_date"));
            double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
            boolean confirmed = true;

            OffsetDateTime checkInDate = checkInDateTime.atOffset(ZoneOffset.UTC);
            OffsetDateTime checkOutDate = checkOutDateTime.atOffset(ZoneOffset.UTC);

            // Check if the room is available
            boolean isAvailable = reservationRepository.isAvailableRoom(roomId, checkInDate, checkOutDate);

            if (!isAvailable) {
                // Check for conflicting reservations
                Reservation conflictingReservation = reservationRepository
                        .getReservationsByRoomId(roomId)
                        .stream()
                        .filter(reservation -> reservation.getCheckInDate().isBefore(checkOutDate) && reservation.getCheckOutDate().isAfter(checkInDate))
                        .findFirst()
                        .orElse(null);

                if (conflictingReservation != null) {
                    String userName = reservationRepository.getUserNameById(conflictingReservation.getUserId());
                    String message = String.format("The selected room is already booked by %s from %s to %s.",
                            userName,
                            conflictingReservation.getCheckInDate().toLocalDate(),
                            conflictingReservation.getCheckOutDate().toLocalDate());
                    session.setAttribute("errorMessage", message);
                    response.sendRedirect(request.getContextPath() + "/user-pages/booking.jsp");
                    return;
                }
            }

            // Create and save the reservation
            Reservation reservation = new Reservation();
            reservation.setId(UUID.randomUUID());
            reservation.setUserId(userId);
            reservation.setRoomId(roomId);
            reservation.setCheckInDate(checkInDate);
            reservation.setCheckOutDate(checkOutDate);
            reservation.setTotalAmount(totalAmount);
            reservation.setConfirmed(confirmed);
            reservation.setStatus(ReservationStatus.ACTIVE);

            reservationRepository.saveReservation(reservation);

            session.setAttribute("successMessage", "Your reservation has been confirmed successfully!");
            session.setAttribute("reservation", reservation);
        } catch (Exception e) {
            session.setAttribute("errorMessage", "There was an error processing your reservation. Please try again.");
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/user-pages/booking.jsp");
    }

}

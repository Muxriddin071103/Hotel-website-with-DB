package org.example.repositories;

import lombok.AccessLevel;
import lombok.Cleanup;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import org.example.connection.DbConnection;
import org.example.entity.Reservation;
import org.example.enums.ReservationStatus;

import java.sql.*;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ReservationRepository {
    DbConnection configurations = DbConnection.getInstance();
    Connection connection = configurations.connection();

    public String getUserNameById(UUID userId) {
        String query = "SELECT name FROM users WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setObject(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getRoomNameById(UUID roomId) {
        String query = "SELECT name FROM room WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setObject(1, roomId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Reservation> getReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String query = "SELECT id, user_id, room_id, check_in_date, check_out_date, total_amount, confirmed, status " +
                "FROM reservation";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setId(UUID.fromString(rs.getString("id")));
                reservation.setUserId(UUID.fromString(rs.getString("user_id")));
                reservation.setRoomId(UUID.fromString(rs.getString("room_id")));
                reservation.setUserName(getUserNameById(reservation.getUserId()));
                reservation.setRoomName(getRoomNameById(reservation.getRoomId()));
                reservation.setCheckInDate(rs.getObject("check_in_date", OffsetDateTime.class));
                reservation.setCheckOutDate(rs.getObject("check_out_date", OffsetDateTime.class));
                reservation.setTotalAmount(rs.getDouble("total_amount"));
                reservation.setConfirmed(rs.getBoolean("confirmed"));
                reservation.setStatus(ReservationStatus.valueOf(rs.getString("status")));
                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }

    @SneakyThrows
    public void saveReservation(Reservation reservation) {
        String query;
        if (reservationExists(reservation.getId())) {
            query = "UPDATE reservation SET user_id = ?, room_id = ?, check_in_date = ?, check_out_date = ?, total_amount = ?, confirmed = ?, status = CAST(? AS status) WHERE id = CAST(? AS UUID);";
        } else {
            query = "INSERT INTO reservation (id, user_id, room_id, check_in_date, check_out_date, total_amount, confirmed, status) VALUES (?, ?, ?, ?, ?, ?, ?, CAST(? AS status));";
        }

        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setObject(1, reservation.getId());
        preparedStatement.setObject(2, reservation.getUserId());
        preparedStatement.setObject(3, reservation.getRoomId());
        preparedStatement.setObject(4, reservation.getCheckInDate());
        preparedStatement.setObject(5, reservation.getCheckOutDate());
        preparedStatement.setDouble(6, reservation.getTotalAmount());
        preparedStatement.setBoolean(7, reservation.isConfirmed());
        preparedStatement.setString(8, reservation.getStatus().name());

        preparedStatement.executeUpdate();
    }

    @SneakyThrows
    private boolean reservationExists(UUID id) {
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement("SELECT 1 FROM reservation WHERE id = CAST(? AS UUID)");
        preparedStatement.setObject(1, id);
        @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
        return resultSet.next();
    }

    @SneakyThrows
    public Optional<Reservation> getReservationById(UUID id) {
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM reservation WHERE id = CAST(? AS UUID)");
        preparedStatement.setObject(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return Optional.of(getReservation(resultSet));
        }
        return Optional.empty();
    }

    @SneakyThrows
    public List<Reservation> getReservationsByUserId(UUID userId) {
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM reservation WHERE user_id = ?");
        preparedStatement.setObject(1, userId);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Reservation> reservations = new ArrayList<>();
        while (resultSet.next()) {
            reservations.add(getReservation(resultSet));
        }
        return reservations;
    }

    @SneakyThrows
    public List<Reservation> getReservationsByRoomId(UUID roomId) {
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM reservation WHERE room_id = ?");
        preparedStatement.setObject(1, roomId);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Reservation> reservations = new ArrayList<>();
        while (resultSet.next()) {
            reservations.add(getReservation(resultSet));
        }
        return reservations;
    }

    @SneakyThrows
    public void deleteReservation(UUID id) {
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM reservation WHERE id = ?");
        preparedStatement.setObject(1, id);
        preparedStatement.executeUpdate();
    }

    private Reservation getReservation(ResultSet resultSet) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(UUID.fromString(resultSet.getString("id")));
        reservation.setUserId(UUID.fromString(resultSet.getString("user_id")));
        reservation.setRoomId(UUID.fromString(resultSet.getString("room_id")));
        reservation.setCheckInDate(resultSet.getObject("check_in_date", OffsetDateTime.class));
        reservation.setCheckOutDate(resultSet.getObject("check_out_date", OffsetDateTime.class));
        reservation.setTotalAmount(resultSet.getDouble("total_amount"));
        reservation.setConfirmed(resultSet.getBoolean("confirmed"));
        reservation.setStatus(ReservationStatus.valueOf(resultSet.getString("status")));
        return reservation;
    }

    public void updateReservationStatus(UUID id, ReservationStatus status) {
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "UPDATE reservation SET status = CAST(? AS status) WHERE id = CAST(? as UUID)"
            );
            statement.setString(1, status.name());
            statement.setObject(2, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static ReservationRepository reservationRepository;

    public static ReservationRepository getInstance() {
        if (reservationRepository == null)
            synchronized (ReservationRepository.class) {
                if (reservationRepository == null) {
                    reservationRepository = new ReservationRepository();
                }
            }
        return reservationRepository;
    }

    @SneakyThrows
    public boolean isAvailableRoom(UUID roomId, OffsetDateTime checkInDate, OffsetDateTime checkOutDate) {
        String query = "SELECT 1 FROM reservation WHERE room_id = ? " +
                "AND (check_in_date <= ? AND check_out_date >= ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setObject(1, roomId);
            pstmt.setObject(2, checkOutDate);
            pstmt.setObject(3, checkInDate);

            try (ResultSet rs = pstmt.executeQuery()) {
                return !rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

package org.example.repositories;

import lombok.AccessLevel;
import lombok.Cleanup;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import org.example.connection.DbConnection;
import org.example.entity.Room;
import org.example.enums.TypeRoom;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class RoomRepository {
    private final DbConnection configurations = DbConnection.getInstance();
    private final Connection connection = configurations.connection();

    @SneakyThrows
    public List<Room> getAllRooms() {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM room;");
        List<Room> rooms = new ArrayList<>();
        while (resultSet.next()) {
            rooms.add(getRoom(resultSet));
        }
        return rooms;
    }

    @SneakyThrows
    public List<Room> getAvailableRooms() {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM room WHERE available = TRUE;");
        List<Room> rooms = new ArrayList<>();
        while (resultSet.next()) {
            rooms.add(getRoom(resultSet));
        }
        return rooms;
    }

    @SneakyThrows
    public void saveRoom(Room room) {
        String query;
        boolean isUpdate = room.getId() != null && getRoomById(room.getId()).isPresent();
        if (isUpdate) {
            query = "UPDATE room SET name = ?, description = ?, image_url = ?, price_per_night = ?, available = ?, type_room = CAST(? AS type_room) WHERE id = CAST(? AS UUID)";
        } else {
            query = "INSERT INTO room (id, name, description, image_url, price_per_night, available, type_room) VALUES (CAST(? AS UUID), ?, ?, ?, ?, ?, CAST(? AS type_room))";
        }

        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(query);

        int index = 1;
        if (isUpdate) {
            preparedStatement.setString(index++, room.getName());
            preparedStatement.setString(index++, room.getDescription());
            preparedStatement.setString(index++, room.getImageUrl());
            preparedStatement.setDouble(index++, room.getPricePerNight());
            preparedStatement.setBoolean(index++, room.isAvailable());
            preparedStatement.setString(index++, room.getTypeRoom().name());
            preparedStatement.setString(index++, room.getId());
        } else {
            preparedStatement.setString(index++, room.getId());
            preparedStatement.setString(index++, room.getName());
            preparedStatement.setString(index++, room.getDescription());
            preparedStatement.setString(index++, room.getImageUrl());
            preparedStatement.setDouble(index++, room.getPricePerNight());
            preparedStatement.setBoolean(index++, room.isAvailable());
            preparedStatement.setString(index++, room.getTypeRoom().name());
        }

        preparedStatement.executeUpdate();
    }

    @SneakyThrows
    public Optional<Room> getRoomById(String id) {
        String query = "SELECT * FROM room WHERE id = CAST(? AS UUID)";
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, id);
        @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return Optional.of(getRoom(resultSet));
        }
        return Optional.empty();
    }

    private Room getRoom(ResultSet resultSet) throws SQLException {
        Room room = new Room();
        room.setId(resultSet.getString("id"));
        room.setName(resultSet.getString("name"));
        room.setDescription(resultSet.getString("description"));
        room.setImageUrl(resultSet.getString("image_url"));
        room.setPricePerNight(resultSet.getDouble("price_per_night"));
        room.setAvailable(resultSet.getBoolean("available"));
        room.setTypeRoom(TypeRoom.valueOf(resultSet.getString("type_room")));

        return room;
    }

    private static RoomRepository roomRepository;

    public static RoomRepository getInstance() {
        if (roomRepository == null) {
            synchronized (RoomRepository.class) {
                if (roomRepository == null) {
                    roomRepository = new RoomRepository();
                }
            }
        }
        return roomRepository;
    }
}

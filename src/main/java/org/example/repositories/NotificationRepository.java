package org.example.repositories;

import lombok.AccessLevel;
import lombok.Cleanup;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import org.example.connection.DbConnection;
import org.example.entity.Notifications;

import java.sql.*;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class NotificationRepository {
    private final DbConnection configurations = DbConnection.getInstance();
    private final Connection connection = configurations.connection();
    private static NotificationRepository instance;

    public static NotificationRepository getInstance() {
        if (instance == null) {
            synchronized (NotificationRepository.class) {
                if (instance == null) {
                    instance = new NotificationRepository();
                }
            }
        }
        return instance;
    }

    @SneakyThrows
    public List<Notifications> getAllNotifications() {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM notifications;");
        List<Notifications> notifications = new ArrayList<>();
        while (resultSet.next()) {
            notifications.add(getNotification(resultSet));
        }
        return notifications;
    }

    private Notifications getNotification(ResultSet resultSet) throws SQLException {
        Notifications notification = new Notifications();
        notification.setId(resultSet.getInt("id"));
        notification.setMessage(resultSet.getString("message"));
        notification.setCreatedAt(resultSet.getObject("created_at", OffsetDateTime.class));

        return notification;
    }

    @SneakyThrows
    public void addNotification(String message) {
        String query;
        query = "INSERT INTO notifications (message) VALUES (?);";

        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, message);
        preparedStatement.executeUpdate();
    }

    @SneakyThrows
    public void deleteNotification(int id) {
        String query = "DELETE FROM notifications WHERE id = ?;";

        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }

    @SneakyThrows
    public int getCountNotifications() {
        @Cleanup Statement statement = connection.createStatement();

        String sql = "SELECT COUNT(*) FROM notifications;";

        ResultSet resultSet = statement.executeQuery(sql);
        resultSet.next();

        return resultSet.getInt(1);
    }

}

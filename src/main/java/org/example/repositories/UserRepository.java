package org.example.repositories;

import lombok.AccessLevel;
import lombok.Cleanup;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import org.example.connection.DbConnection;
import org.example.entity.User;
import org.example.enums.Role;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class UserRepository {
    private final DbConnection configurations = DbConnection.getInstance();
    private final Connection connection = configurations.connection();

    @SneakyThrows
    public List<User> getUsers() {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users where role = 'USER';");
        List<User> users = new ArrayList<>();
        while (resultSet.next()) {
            users.add(getUser(resultSet));
        }
        return users;
    }

    @SneakyThrows
    public void saveUser(User user) {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE id = '" + user.getId() + "';");
        String query;
        if (resultSet.next()) {
            query = String.format("UPDATE users SET name = '%s', email = '%s', password = '%s', is_active = %b, role = '%s' WHERE id = '%s';",
                    user.getName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.isActive(),
                    user.getRole().name(),
                    user.getId());
        } else {
            query = String.format("INSERT INTO users (id, name, email, password, is_active, role) VALUES ('%s', '%s', '%s', '%s', %b, '%s');",
                    user.getId(),
                    user.getName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.isActive(),
                    user.getRole().name());
        }
        statement.execute(query);
    }

    @SneakyThrows
    public Optional<User> getUserByEmail(String email) {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE email = '" + email + "'");
        if (resultSet.next()) {
            return Optional.of(getUser(resultSet));
        }
        return Optional.empty();
    }

    @SneakyThrows
    public Optional<User> getUserById(String id) {
        @Cleanup Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE id = '" + id + "'");
        if (resultSet.next()) {
            return Optional.of(getUser(resultSet));
        }
        return Optional.empty();
    }

    private User getUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setId(resultSet.getString("id"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setActive(resultSet.getBoolean("is_active"));
        user.setRole(Role.valueOf(resultSet.getString("role")));
        return user;
    }

    private static UserRepository userRepository;

    public static UserRepository getInstance() {
        if (userRepository == null) {
            synchronized (UserRepository.class) {
                if (userRepository == null) {
                    userRepository = new UserRepository();
                }
            }
        }
        return userRepository;
    }
}

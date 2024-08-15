package org.example.connection;

import lombok.SneakyThrows;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
    public static final String DB_DRIVER = "org.postgresql.Driver";
    public static final String DB_URL = "jdbc:postgresql://localhost:5432/hotel_db";
    private static Connection connection;

    @SneakyThrows
    public Connection connection() {
        Class.forName(DB_DRIVER);
        if (connection == null)
            connection = DriverManager.getConnection(DB_URL, "postgres", "root123");
        return connection;
    }


    private static DbConnection instance;

    public static DbConnection getInstance() {
        if (instance == null) {
            instance = new DbConnection();
        }
        return instance;
    }
}

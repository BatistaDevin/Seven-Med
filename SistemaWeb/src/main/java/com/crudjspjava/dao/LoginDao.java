package com.crudjspjava.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
    private static final String URL = "jdbc:mysql://localhost:3307/crudjspjava";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";

    static {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC do MySQL não encontrado. Certifique-se de que o driver está no classpath da aplicação.", e);
        }
    }

    public boolean validate(String email, String password) {
        boolean status = false;
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email = ? AND password = ?")) {
            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                status = rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar usuário.", e);
        }
        return status;
    }
}


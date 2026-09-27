package com.collegeevent.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.collegeevent.model.Admin;
import com.collegeevent.util.DBConnection;

public class AdminDAO {

    public boolean addAdmin(Admin admin) {

        String sql = "INSERT INTO admins (name, email, password) " +
                     "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, admin.getName());
            statement.setString(2, admin.getEmail());
            statement.setString(3, admin.getPassword());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Admin creation failed.");
            e.printStackTrace();
            return false;
        }
    }

    public Admin loginAdmin(String email, String password) {

        String sql = "SELECT admin_id, name, email, password " +
                     "FROM admins " +
                     "WHERE email = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {
                    return new Admin(
                            result.getInt("admin_id"),
                            result.getString("name"),
                            result.getString("email"),
                            result.getString("password")
                    );
                }
            }

        } catch (SQLException e) {
            System.out.println("Admin login failed.");
            e.printStackTrace();
        }

        return null;
    }
}
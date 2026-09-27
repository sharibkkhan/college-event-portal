package com.collegeevent.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.collegeevent.model.Registration;
import com.collegeevent.util.DBConnection;

public class RegistrationDAO {

    public boolean registerForEvent(int studentId, int eventId) {

        String sql = "INSERT INTO registrations " +
                     "(student_id, event_id, registration_date, status) " +
                     "VALUES (?, ?, CURDATE(), 'Registered')";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, eventId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Event registration failed.");
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAlreadyRegistered(int studentId, int eventId) {

        String sql = "SELECT registration_id FROM registrations " +
                     "WHERE student_id = ? AND event_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, eventId);

            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }

        } catch (SQLException e) {
            System.out.println("Could not check registration.");
            e.printStackTrace();
            return false;
        }
    }

    public List<Registration> getStudentRegistrations(int studentId) {

        List<Registration> registrations = new ArrayList<>();

        String sql = "SELECT registration_id, student_id, event_id, " +
                     "registration_date, status " +
                     "FROM registrations " +
                     "WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (ResultSet result = statement.executeQuery()) {

                while (result.next()) {

                    Registration registration = new Registration(
                            result.getInt("registration_id"),
                            result.getInt("student_id"),
                            result.getInt("event_id"),
                            result.getString("registration_date"),
                            result.getString("status")
                    );

                    registrations.add(registration);
                }
            }

        } catch (SQLException e) {
            System.out.println("Could not retrieve registrations.");
            e.printStackTrace();
        }

        return registrations;
    }

    public boolean cancelRegistration(int registrationId) {

        String sql = "DELETE FROM registrations " +
                     "WHERE registration_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, registrationId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Registration cancellation failed.");
            e.printStackTrace();
            return false;
        }
    }
}
package com.collegeevent.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.collegeevent.model.Student;
import com.collegeevent.util.DBConnection;

public class StudentDAO {

    public boolean registerStudent(Student student) {

        String sql = "INSERT INTO students " +
                     "(name, email, password, department, phone) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, student.getName());
            statement.setString(2, student.getEmail());
            statement.setString(3, student.getPassword());
            statement.setString(4, student.getDepartment());
            statement.setString(5, student.getPhone());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Student registration failed.");
            e.printStackTrace();
            return false;
        }
    }

    public Student loginStudent(String email, String password) {

        String sql = "SELECT student_id, name, email, password, department, phone " +
                     "FROM students " +
                     "WHERE email = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    return new Student(
                            result.getInt("student_id"),
                            result.getString("name"),
                            result.getString("email"),
                            result.getString("password"),
                            result.getString("department"),
                            result.getString("phone")
                    );
                }
            }

        } catch (SQLException e) {
            System.out.println("Student login failed.");
            e.printStackTrace();
        }

        return null;
    }
}
package com.collegeevent.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.collegeevent.model.Student;
import com.collegeevent.util.DBConnection;

public class StudentDAO {

    // =========================================================
    // REGISTER STUDENT
    // Existing registration functionality
    // =========================================================

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


    // =========================================================
    // LOGIN STUDENT
    // Now also loads profile information
    // =========================================================

    public Student loginStudent(String email, String password) {

        String sql =
                "SELECT student_id, name, email, password, " +
                "department, phone, year, division, roll_number, prn " +
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
                            result.getString("phone"),
                            result.getString("year"),
                            result.getString("division"),
                            result.getString("roll_number"),
                            result.getString("prn")
                    );
                }
            }

        } catch (SQLException e) {

            System.out.println("Student login failed.");
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET STUDENT BY ID
    // Used by the profile page
    // =========================================================

    public Student getStudentById(int studentId) {

        String sql =
                "SELECT student_id, name, email, password, " +
                "department, phone, year, division, roll_number, prn " +
                "FROM students " +
                "WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    return new Student(
                            result.getInt("student_id"),
                            result.getString("name"),
                            result.getString("email"),
                            result.getString("password"),
                            result.getString("department"),
                            result.getString("phone"),
                            result.getString("year"),
                            result.getString("division"),
                            result.getString("roll_number"),
                            result.getString("prn")
                    );
                }
            }

        } catch (SQLException e) {

            System.out.println("Failed to get student.");
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE STUDENT PROFILE
    // =========================================================

    public boolean updateProfile(Student student) {

        String sql =
                "UPDATE students SET " +
                "name = ?, " +
                "department = ?, " +
                "phone = ?, " +
                "year = ?, " +
                "division = ?, " +
                "roll_number = ?, " +
                "prn = ? " +
                "WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, student.getName());
            statement.setString(2, student.getDepartment());
            statement.setString(3, student.getPhone());
            statement.setString(4, student.getYear());
            statement.setString(5, student.getDivision());
            statement.setString(6, student.getRollNumber());
            statement.setString(7, student.getPrn());
            statement.setInt(8, student.getStudentId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {

            System.out.println("Student profile update failed.");
            e.printStackTrace();

            return false;
        }
    }
}
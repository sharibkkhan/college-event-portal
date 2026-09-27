package com.collegeevent;

import com.collegeevent.dao.StudentDAO;
import com.collegeevent.model.Student;

public class StudentDAOTest {

    public static void main(String[] args) {

        StudentDAO studentDAO = new StudentDAO();

        Student student = new Student(
                0,
                "Test Student",
                "teststudent@gmail.com",
                "test123",
                "CSE",
                "9876543210"
        );

        // Test registration
        boolean registered = studentDAO.registerStudent(student);

        if (registered) {
            System.out.println("STUDENT REGISTRATION SUCCESSFUL");
        } else {
            System.out.println("STUDENT REGISTRATION FAILED");
        }

        // Test login
        Student loggedIn =
                studentDAO.loginStudent(
                        "teststudent@gmail.com",
                        "test123"
                );

        if (loggedIn != null) {
            System.out.println("STUDENT LOGIN SUCCESSFUL");
            System.out.println("Name: " + loggedIn.getName());
            System.out.println("Email: " + loggedIn.getEmail());
            System.out.println("Department: " + loggedIn.getDepartment());
        } else {
            System.out.println("STUDENT LOGIN FAILED");
        }
    }
}
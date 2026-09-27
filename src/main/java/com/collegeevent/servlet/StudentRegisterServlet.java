package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.StudentDAO;
import com.collegeevent.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class StudentRegisterServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String department = request.getParameter("department");
        String phone = request.getParameter("phone");

        Student student = new Student(
                0,
                name,
                email,
                password,
                department,
                phone
        );

        boolean registered = studentDAO.registerStudent(student);

        if (registered) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=registration_failed");
        }
    }
}
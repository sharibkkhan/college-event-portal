package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.StudentDAO;
import com.collegeevent.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class StudentLoginServlet extends HttpServlet {

    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Student student = studentDAO.loginStudent(email, password);

        if (student != null) {

            HttpSession session = request.getSession();
            session.setAttribute("student", student);

            response.sendRedirect("student-dashboard.jsp");

        } else {

            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
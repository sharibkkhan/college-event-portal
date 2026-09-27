package com.collegeevent.servlet;

import java.io.IOException;
import java.util.List;

import com.collegeevent.dao.RegistrationDAO;
import com.collegeevent.model.Registration;
import com.collegeevent.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-registrations")
public class MyRegistrationsServlet extends HttpServlet {

    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check login session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("student") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in student
        Student student =
                (Student) session.getAttribute("student");

        int studentId = student.getStudentId();

        try {

            // Get this student's registrations
            List<Registration> registrations =
                    registrationDAO.getStudentRegistrations(studentId);

            request.setAttribute(
                    "registrations",
                    registrations
            );

            request.getRequestDispatcher(
                    "my-registrations.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load registrations."
            );
        }
    }
}
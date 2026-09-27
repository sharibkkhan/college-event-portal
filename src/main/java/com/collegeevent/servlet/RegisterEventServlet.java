package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.RegistrationDAO;
import com.collegeevent.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register-event")
public class RegisterEventServlet extends HttpServlet {

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

        // Get event ID
        String eventIdParameter =
                request.getParameter("eventId");

        if (eventIdParameter == null ||
            eventIdParameter.trim().isEmpty()) {

            response.sendRedirect("events");
            return;
        }

        try {

            int eventId = Integer.parseInt(eventIdParameter);

            int studentId = student.getStudentId();

            // Check whether already registered
            if (registrationDAO.isAlreadyRegistered(
                    studentId, eventId)) {

                response.sendRedirect(
                        "events?message=already"
                );

                return;
            }

            // Register student for event
            boolean success =
                    registrationDAO.registerForEvent(
                            studentId,
                            eventId
                    );

            if (success) {

                response.sendRedirect(
                        "events?message=registered"
                );

            } else {

                response.sendRedirect(
                        "events?message=error"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect("events");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to register for event."
            );
        }
    }
}
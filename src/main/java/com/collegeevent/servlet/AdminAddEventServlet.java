package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.EventDAO;
import com.collegeevent.model.Admin;
import com.collegeevent.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-add-event")
public class AdminAddEventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        Admin admin =
                (Admin) session.getAttribute("admin");

        try {

            String eventName =
                    request.getParameter("eventName");

            String description =
                    request.getParameter("description");

            String eventDate =
                    request.getParameter("eventDate");

            String eventTime =
                    request.getParameter("eventTime");

            String venue =
                    request.getParameter("venue");

            int maxParticipants =
                    Integer.parseInt(
                            request.getParameter("maxParticipants")
                    );

            int createdBy =
                    admin.getAdminId();

            Event event = new Event(
                    0,
                    eventName,
                    description,
                    eventDate,
                    eventTime,
                    venue,
                    maxParticipants,
                    createdBy
            );

            boolean success =
                    eventDAO.addEvent(event);

            if (success) {

response.sendRedirect(
        "admin-events"
);

            } else {

                response.sendRedirect(
                        "admin-events.jsp?message=error"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "admin-events.jsp?message=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add event."
            );
        }
    }
}
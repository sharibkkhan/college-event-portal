package com.collegeevent.servlet;

import java.io.IOException;
import java.util.List;

import com.collegeevent.dao.EventDAO;
import com.collegeevent.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-edit-event")
public class AdminEditEventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {

            int eventId = Integer.parseInt(
                    request.getParameter("eventId")
            );

            List<Event> events = eventDAO.getAllEvents();

            Event selectedEvent = null;

            for (Event event : events) {

                if (event.getEventId() == eventId) {
                    selectedEvent = event;
                    break;
                }
            }

            if (selectedEvent == null) {

                response.sendRedirect("admin-events");
                return;
            }

            request.setAttribute(
                    "event",
                    selectedEvent
            );

            request.getRequestDispatcher(
                    "admin-edit-event.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect("admin-events");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {

            int eventId = Integer.parseInt(
                    request.getParameter("eventId")
            );

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
                            request.getParameter(
                                    "maxParticipants"
                            )
                    );

            Event event = new Event(
                    eventId,
                    eventName,
                    description,
                    eventDate,
                    eventTime,
                    venue,
                    maxParticipants,
                    0
            );

            boolean success =
                    eventDAO.updateEvent(event);

            response.sendRedirect("admin-events");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("admin-events");
        }
    }
}
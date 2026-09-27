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

@WebServlet("/admin-events")
public class AdminEventsServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        // Get all events
        List<Event> events = eventDAO.getAllEvents();

        // Send events to JSP
        request.setAttribute("events", events);

        request.getRequestDispatcher("admin-events.jsp")
               .forward(request, response);
    }
}
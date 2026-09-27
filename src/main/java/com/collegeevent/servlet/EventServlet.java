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

@WebServlet("/events")
public class EventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

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

        try {

            List<Event> events = eventDAO.getAllEvents();

            request.setAttribute("events", events);

            request.getRequestDispatcher("events.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load events."
            );
        }
    }
}
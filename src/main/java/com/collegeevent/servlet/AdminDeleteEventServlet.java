package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.EventDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-delete-event")
public class AdminDeleteEventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

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

            eventDAO.deleteEvent(eventId);

            response.sendRedirect("admin-events");

        } catch (NumberFormatException e) {

            response.sendRedirect("admin-events");
        }
    }
}
package com.collegeevent.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-logout")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Destroy session if it exists
        if (session != null) {
            session.invalidate();
        }

        // Go back to admin login
        response.sendRedirect("admin-login.jsp");
    }
}
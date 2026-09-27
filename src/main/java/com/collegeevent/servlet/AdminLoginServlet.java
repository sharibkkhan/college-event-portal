package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.AdminDAO;
import com.collegeevent.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            response.sendRedirect("admin-login.jsp?error=empty");
            return;
        }

        try {

            Admin admin = adminDAO.loginAdmin(email, password);

            if (admin != null) {

                // Create session after successful login
                HttpSession session = request.getSession(true);

                session.setAttribute("admin", admin);

                response.sendRedirect("admin-dashboard.jsp");

            } else {

                response.sendRedirect("admin-login.jsp?error=invalid");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Admin login failed."
            );
        }
    }
}
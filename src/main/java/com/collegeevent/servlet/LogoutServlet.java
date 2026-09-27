package com.collegeevent.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            System.out.println("LOGOUT: Session found");
            System.out.println("LOGOUT: Session ID = " + session.getId());

            session.invalidate();

            System.out.println("LOGOUT: Session invalidated");
        } else {
            System.out.println("LOGOUT: No session found");
        }

        response.sendRedirect("login.jsp");
    }
}
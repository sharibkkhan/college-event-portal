package com.collegeevent.servlet;

import java.io.IOException;

import com.collegeevent.dao.StudentDAO;
import com.collegeevent.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);

        // No session = not logged in
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in student
        Student student =
                (Student) session.getAttribute("student");

        // No student = not logged in
        if (student == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get profile information from form
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String phone = request.getParameter("phone");
        String year = request.getParameter("year");
        String division = request.getParameter("division");
        String rollNumber = request.getParameter("rollNumber");
        String prn = request.getParameter("prn");

        // Update Student object
        student.setName(name);
        student.setDepartment(department);
        student.setPhone(phone);
        student.setYear(year);
        student.setDivision(division);
        student.setRollNumber(rollNumber);
        student.setPrn(prn);

        // Save to database
        boolean updated =
                studentDAO.updateProfile(student);

        if (updated) {

            // Keep updated information in session
            session.setAttribute("student", student);

            response.sendRedirect("student-profile.jsp?success=updated");

        } else {

            response.sendRedirect("student-profile.jsp?error=update_failed");
        }
    }
}
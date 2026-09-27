package com.collegeevent;

import java.util.List;

import com.collegeevent.dao.RegistrationDAO;
import com.collegeevent.model.Registration;

public class RegistrationDAOTest {

    public static void main(String[] args) {

        RegistrationDAO registrationDAO = new RegistrationDAO();

        int studentId = 1;
        int eventId = 1;

        // Check whether already registered
        boolean alreadyRegistered =
                registrationDAO.isAlreadyRegistered(studentId, eventId);

        if (alreadyRegistered) {
            System.out.println("STUDENT IS ALREADY REGISTERED");
        } else {

            boolean registered =
                    registrationDAO.registerForEvent(studentId, eventId);

            if (registered) {
                System.out.println("EVENT REGISTRATION SUCCESSFUL");
            } else {
                System.out.println("EVENT REGISTRATION FAILED");
            }
        }

        // Display student's registrations
        System.out.println("\n--- STUDENT REGISTRATIONS ---");

        List<Registration> registrations =
                registrationDAO.getStudentRegistrations(studentId);

        for (Registration registration : registrations) {

            System.out.println(
                    "Registration ID: " +
                    registration.getRegistrationId() +
                    " | Event ID: " +
                    registration.getEventId() +
                    " | Date: " +
                    registration.getRegistrationDate() +
                    " | Status: " +
                    registration.getStatus()
            );
        }
    }
}
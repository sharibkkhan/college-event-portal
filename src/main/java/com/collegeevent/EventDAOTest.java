package com.collegeevent;

import java.util.List;

import com.collegeevent.dao.EventDAO;
import com.collegeevent.model.Event;

public class EventDAOTest {

    public static void main(String[] args) {

        EventDAO eventDAO = new EventDAO();

        // Add event
        Event event = new Event(
                0,
                "Cybersecurity Workshop",
                "Introduction to Ethical Hacking and Network Security",
                "2026-10-15",
                "10:00:00",
                "Seminar Hall",
                100,
                1
        );

        boolean added = eventDAO.addEvent(event);

        if (added) {
            System.out.println("EVENT ADDED SUCCESSFULLY");
        } else {
            System.out.println("EVENT ADDITION FAILED");
        }

        // Display events
        System.out.println("\n--- ALL EVENTS ---");

        List<Event> events = eventDAO.getAllEvents();

        for (Event e : events) {
            System.out.println(
                    e.getEventId() + " | " +
                    e.getEventName() + " | " +
                    e.getEventDate() + " | " +
                    e.getVenue()
            );
        }
    }
}
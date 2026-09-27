package com.collegeevent.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.collegeevent.model.Event;
import com.collegeevent.util.DBConnection;

public class EventDAO {

    public boolean addEvent(Event event) {

        String sql = "INSERT INTO events " +
                     "(event_name, description, event_date, event_time, venue, max_participants, created_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, event.getEventName());
            statement.setString(2, event.getDescription());
            statement.setString(3, event.getEventDate());
            statement.setString(4, event.getEventTime());
            statement.setString(5, event.getVenue());
            statement.setInt(6, event.getMaxParticipants());
            statement.setInt(7, event.getCreatedBy());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Event creation failed.");
            e.printStackTrace();
            return false;
        }
    }

    public List<Event> getAllEvents() {

        List<Event> events = new ArrayList<>();

        String sql = "SELECT event_id, event_name, description, " +
                     "event_date, event_time, venue, max_participants, created_by " +
                     "FROM events ORDER BY event_date, event_time";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {

            while (result.next()) {

                Event event = new Event(
                        result.getInt("event_id"),
                        result.getString("event_name"),
                        result.getString("description"),
                        result.getString("event_date"),
                        result.getString("event_time"),
                        result.getString("venue"),
                        result.getInt("max_participants"),
                        result.getInt("created_by")
                );

                events.add(event);
            }

        } catch (SQLException e) {
            System.out.println("Could not retrieve events.");
            e.printStackTrace();
        }

        return events;
    }

    public boolean updateEvent(Event event) {

        String sql = "UPDATE events SET " +
                     "event_name = ?, description = ?, event_date = ?, " +
                     "event_time = ?, venue = ?, max_participants = ? " +
                     "WHERE event_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, event.getEventName());
            statement.setString(2, event.getDescription());
            statement.setString(3, event.getEventDate());
            statement.setString(4, event.getEventTime());
            statement.setString(5, event.getVenue());
            statement.setInt(6, event.getMaxParticipants());
            statement.setInt(7, event.getEventId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Event update failed.");
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEvent(int eventId) {

        String sql = "DELETE FROM events WHERE event_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, eventId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Event deletion failed.");
            e.printStackTrace();
            return false;
        }
    }
}
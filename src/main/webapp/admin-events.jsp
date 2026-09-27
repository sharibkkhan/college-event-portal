<%@ page contentType="text/html;charset=UTF-8" session="false" %>
<%@ page import="java.util.List" %>
<%@ page import="com.collegeevent.model.Admin" %>
<%@ page import="com.collegeevent.model.Event" %>

<%
    // Get existing session WITHOUT creating a new one
    jakarta.servlet.http.HttpSession currentSession =
            request.getSession(false);

    // No session = not logged in
    if (currentSession == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // Get logged-in admin
    Admin admin =
            (Admin) currentSession.getAttribute("admin");

    // No admin = not logged in
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // Get events loaded by AdminEventsServlet
    List<Event> events =
            (List<Event>) request.getAttribute("events");

    // Prevent browser caching
    response.setHeader(
            "Cache-Control",
            "no-cache, no-store, must-revalidate"
    );

    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Events</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
        }

        .navbar {
            background: #2864e8;
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
        }

        .nav-buttons {
            display: flex;
            gap: 10px;
        }

        .nav-btn {
            color: white;
            text-decoration: none;
            background: #1749b5;
            padding: 8px 15px;
            border-radius: 5px;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
        }

        .add-btn {
            background: #2864e8;
            color: white;
            text-decoration: none;
            padding: 11px 18px;
            border-radius: 6px;
        }

        .add-btn:hover {
            background: #1749b5;
        }

        .events-container {
            display: grid;
            grid-template-columns: repeat(
                auto-fit,
                minmax(300px, 1fr)
            );
            gap: 20px;
        }

        .event-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .event-card h2 {
            margin-top: 0;
            color: #2864e8;
        }

        .description {
            color: #555;
            line-height: 1.5;
        }

        .event-info {
            margin: 10px 0;
        }

        .event-info strong {
            display: inline-block;
            width: 130px;
        }

        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

        .edit-btn,
        .delete-btn {
            padding: 9px 15px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
        }

        .edit-btn {
            background: #2864e8;
        }

        .edit-btn:hover {
            background: #1749b5;
        }

        .delete-btn {
            background: #dc3545;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .delete-btn:hover {
            background: #b02a37;
        }

        .no-events {
            background: white;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>College Event Portal - Admin</h2>

    <div class="nav-buttons">

        <a href="admin-dashboard.jsp" class="nav-btn">
            Dashboard
        </a>

        <a href="admin-logout" class="nav-btn">
            Logout
        </a>

    </div>

</div>


<div class="container">

    <div class="header">

        <h1>Manage Events</h1>

        <a href="admin-add-event.jsp" class="add-btn">
            + Add Event
        </a>

    </div>


    <% if (events != null && !events.isEmpty()) { %>

        <div class="events-container">

            <% for (Event event : events) { %>

                <div class="event-card">

                    <h2>
                        <%= event.getEventName() %>
                    </h2>

                    <p class="description">
                        <%= event.getDescription() %>
                    </p>

                    <div class="event-info">
                        <strong>Date:</strong>
                        <%= event.getEventDate() %>
                    </div>

                    <div class="event-info">
                        <strong>Time:</strong>
                        <%= event.getEventTime() %>
                    </div>

                    <div class="event-info">
                        <strong>Venue:</strong>
                        <%= event.getVenue() %>
                    </div>

                    <div class="event-info">
                        <strong>Max Participants:</strong>
                        <%= event.getMaxParticipants() %>
                    </div>


                    <div class="actions">

                        <a
                            href="admin-edit-event?eventId=<%= event.getEventId() %>"
                            class="edit-btn">
                            Edit
                        </a>

                        <form
                            action="admin-delete-event"
                            method="post"
                            style="margin: 0;"
                            onsubmit="return confirm(
                                'Are you sure you want to delete this event?'
                            );">

                            <input
                                type="hidden"
                                name="eventId"
                                value="<%= event.getEventId() %>"
                            >

                            <button
                                type="submit"
                                class="delete-btn">
                                Delete
                            </button>

                        </form>

                    </div>

                </div>

            <% } %>

        </div>

    <% } else { %>

        <div class="no-events">

            <h2>No events available</h2>

            <p>
                There are currently no events in the system.
            </p>

        </div>

    <% } %>

</div>

</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.collegeevent.model.Event" %>

<%
    List<Event> events = (List<Event>) request.getAttribute("events");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>College Events</title>

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

        .back {
            color: white;
            text-decoration: none;
            background: #1749b5;
            padding: 8px 15px;
            border-radius: 5px;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            margin-bottom: 25px;
        }

        /* Registration messages */

        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 16px;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
        }

        .already-message {
            background: #fff3cd;
            color: #856404;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
        }

        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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

        .event-info {
            margin: 12px 0;
        }

        .event-info strong {
            display: inline-block;
            width: 80px;
        }

        .register-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 18px;
            background: #2864e8;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .register-btn:hover {
            background: #1749b5;
        }

        .no-events {
            background: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>College Event Portal</h2>

    <a href="student-dashboard.jsp" class="back">
        Dashboard
    </a>

</div>


<div class="container">

    <h1>Upcoming Events</h1>


    <!-- Registration Messages -->

    <%
        String message = request.getParameter("message");
    %>

    <% if ("registered".equals(message)) { %>

        <div class="message success-message">
            Successfully registered for the event!
        </div>

    <% } else if ("already".equals(message)) { %>

        <div class="message already-message">
            You are already registered for this event.
        </div>

    <% } else if ("error".equals(message)) { %>

        <div class="message error-message">
            Registration failed. Please try again.
        </div>

    <% } %>


    <!-- Events -->

    <% if (events != null && !events.isEmpty()) { %>

        <div class="events-container">

            <% for (Event event : events) { %>

                <div class="event-card">

                    <h2>
                        <%= event.getEventName() %>
                    </h2>

                    <div class="event-info">
                        <strong>Date:</strong>
                        <%= event.getEventDate() %>
                    </div>

                    <div class="event-info">
                        <strong>Venue:</strong>
                        <%= event.getVenue() %>
                    </div>

                    <a
                        href="register-event?eventId=<%= event.getEventId() %>"
                        class="register-btn">
                        Register
                    </a>

                </div>

            <% } %>

        </div>

    <% } else { %>

        <div class="no-events">

            <h2>No events available</h2>

            <p>
                There are currently no upcoming events.
            </p>

        </div>

    <% } %>

</div>

</body>

</html>
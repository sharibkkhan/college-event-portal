<%@ page contentType="text/html;charset=UTF-8" session="false" %>
<%@ page import="com.collegeevent.model.Admin" %>
<%@ page import="com.collegeevent.model.Event" %>

<%
    jakarta.servlet.http.HttpSession currentSession =
            request.getSession(false);

    if (currentSession == null ||
        currentSession.getAttribute("admin") == null) {

        response.sendRedirect("admin-login.jsp");
        return;
    }

    Admin admin =
            (Admin) currentSession.getAttribute("admin");

    Event event =
            (Event) request.getAttribute("event");

    if (event == null) {
        response.sendRedirect("admin-events");
        return;
    }

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

    <title>Edit Event</title>

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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #2864e8;
        }

        .update-btn {
            width: 100%;
            padding: 12px;
            background: #2864e8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .update-btn:hover {
            background: #1749b5;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>College Event Portal - Admin</h2>

    <a href="admin-events" class="back">
        Back to Events
    </a>

</div>


<div class="container">

    <div class="form-card">

        <h1>Edit Event</h1>

        <form action="admin-edit-event" method="post">

            <input
                type="hidden"
                name="eventId"
                value="<%= event.getEventId() %>"
            >


            <div class="form-group">

                <label for="eventName">
                    Event Name
                </label>

                <input
                    type="text"
                    id="eventName"
                    name="eventName"
                    value="<%= event.getEventName() %>"
                    required
                >

            </div>


            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                    id="description"
                    name="description"
                    required
                ><%= event.getDescription() %></textarea>

            </div>


            <div class="form-group">

                <label for="eventDate">
                    Event Date
                </label>

                <input
                    type="date"
                    id="eventDate"
                    name="eventDate"
                    value="<%= event.getEventDate() %>"
                    required
                >

            </div>


            <div class="form-group">

                <label for="eventTime">
                    Event Time
                </label>

                <input
                    type="time"
                    id="eventTime"
                    name="eventTime"
                    value="<%= event.getEventTime() %>"
                    required
                >

            </div>


            <div class="form-group">

                <label for="venue">
                    Venue
                </label>

                <input
                    type="text"
                    id="venue"
                    name="venue"
                    value="<%= event.getVenue() %>"
                    required
                >

            </div>


            <div class="form-group">

                <label for="maxParticipants">
                    Maximum Participants
                </label>

                <input
                    type="number"
                    id="maxParticipants"
                    name="maxParticipants"
                    value="<%= event.getMaxParticipants() %>"
                    min="1"
                    required
                >

            </div>


            <button
                type="submit"
                class="update-btn">

                Update Event

            </button>

        </form>

    </div>

</div>

</body>

</html>
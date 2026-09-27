<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.collegeevent.model.Registration" %>

<%
    List<Registration> registrations =
            (List<Registration>) request.getAttribute("registrations");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Registrations</title>

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

        .registration-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .registration-card p {
            font-size: 16px;
            margin: 10px 0;
        }

        .status {
            display: inline-block;
            margin-top: 10px;
            padding: 6px 12px;
            border-radius: 5px;
            background: #d4edda;
            color: #155724;
        }

        .no-registrations {
            background: white;
            padding: 35px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
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

    <h1>My Registrations</h1>


    <% if (registrations != null && !registrations.isEmpty()) { %>

        <% for (Registration registration : registrations) { %>

            <div class="registration-card">

                <p>
                    <strong>Registration ID:</strong>
                    <%= registration.getRegistrationId() %>
                </p>

                <p>
                    <strong>Event ID:</strong>
                    <%= registration.getEventId() %>
                </p>

                <p>
                    <strong>Registration Date:</strong>
                    <%= registration.getRegistrationDate() %>
                </p>

                <span class="status">
                    <%= registration.getStatus() %>
                </span>

            </div>

        <% } %>

    <% } else { %>

        <div class="no-registrations">

            <h2>No Registrations Yet</h2>

            <p>
                You have not registered for any events.
            </p>

        </div>

    <% } %>

</div>

</body>

</html>
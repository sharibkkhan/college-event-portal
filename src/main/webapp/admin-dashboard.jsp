<%@ page contentType="text/html;charset=UTF-8" session="false" %>
<%@ page import="com.collegeevent.model.Admin" %>

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

    // No admin in session = not logged in
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

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

    <title>Admin Dashboard</title>

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

        .logout {
            color: white;
            text-decoration: none;
            background: #1749b5;
            padding: 8px 15px;
            border-radius: 5px;
        }

        .logout:hover {
            background: #103b94;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .welcome {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .welcome h1 {
            margin-top: 0;
        }

        .details {
            margin-top: 20px;
        }

        .details p {
            font-size: 17px;
            margin: 10px 0;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(
                auto-fit,
                minmax(280px, 1fr)
            );
            gap: 20px;
            margin-top: 25px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .card h3 {
            margin-top: 0;
        }

        .card-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 18px;
            background: #2864e8;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .card-btn:hover {
            background: #1749b5;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>College Event Portal - Admin</h2>

    <a href="admin-logout" class="logout">
        Logout
    </a>

</div>


<div class="container">

    <div class="welcome">

        <h1>
            Welcome, <%= admin.getName() %>!
        </h1>

        <div class="details">

            <p>
                <strong>Email:</strong>
                <%= admin.getEmail() %>
            </p>

        </div>

    </div>


    <div class="card-container">

        <!-- Manage Events -->

        <div class="card">

            <h3>Manage Events</h3>

            <p>
                Create and manage college events.
            </p>

            <a href="admin-events" class="card-btn">
                Manage Events
            </a>

        </div>


        <!-- Registrations -->

        <div class="card">

            <h3>Registrations</h3>

            <p>
                View students registered for events.
            </p>

            <a href="admin-registrations" class="card-btn">
                View Registrations
            </a>

        </div>

    </div>

</div>

</body>

</html>
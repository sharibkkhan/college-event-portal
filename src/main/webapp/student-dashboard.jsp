<%@ page contentType="text/html;charset=UTF-8" session="false" %>
<%@ page import="com.collegeevent.model.Student" %>

<%
    // Get the existing session WITHOUT creating a new one
    jakarta.servlet.http.HttpSession currentSession =
            request.getSession(false);

    // No session = not logged in
    if (currentSession == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get logged-in student
    Student student =
            (Student) currentSession.getAttribute("student");

    // No student in session = not logged in
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Prevent browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Dashboard</title>

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
            max-width: 900px;
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
            margin-top: 25px;
        }

        .details p {
            font-size: 17px;
            margin: 12px 0;
        }

        .card-container {
            display: flex;
            gap: 20px;
            margin-top: 25px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            flex: 1;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .card h3 {
            margin-top: 0;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>College Event Portal</h2>

    <a href="logout" class="logout">
        Logout
    </a>

</div>

<div class="container">

    <div class="welcome">

        <h1>
            Welcome, <%= student.getName() %>!
        </h1>

        <div class="details">

            <p>
                <strong>Email:</strong>
                <%= student.getEmail() %>
            </p>

            <p>
                <strong>Department:</strong>
                <%= student.getDepartment() %>
            </p>

            <p>
                <strong>Phone:</strong>
                <%= student.getPhone() %>
            </p>

        </div>

    </div>

<div class="card">

    <h3>Events</h3>

    <p>
        View upcoming college events.
    </p>

    <a href="events"
       style="
           display: inline-block;
           margin-top: 10px;
           padding: 10px 18px;
           background: #2864e8;
           color: white;
           text-decoration: none;
           border-radius: 6px;
       ">
        View Events
    </a>

</div>
<div class="card">

    <h3>Registrations</h3>

    <p>
        View your registered events.
    </p>

    <a href="my-registrations"
       style="
           display: inline-block;
           margin-top: 10px;
           padding: 10px 18px;
           background: #2864e8;
           color: white;
           text-decoration: none;
           border-radius: 6px;
       ">
        My Registrations
    </a>

</div>

    </div>

</div>

</body>

</html>
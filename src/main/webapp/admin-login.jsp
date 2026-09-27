<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Login</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            width: 380px;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #2864e8;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background: #2864e8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #1749b5;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #2864e8;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="login-container">

    <h1>Admin Login</h1>

    <% if ("empty".equals(error)) { %>

        <div class="error">
            Please enter both email and password.
        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="error">
            Invalid email or password.
        </div>

    <% } %>


    <form action="admin-login" method="post">

        <div class="form-group">

            <label for="email">
                Email
            </label>

            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter admin email"
                required
            >

        </div>


        <div class="form-group">

            <label for="password">
                Password
            </label>

            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter password"
                required
            >

        </div>


        <button type="submit" class="login-btn">
            Login
        </button>

    </form>


    <a href="login.jsp" class="back">
        Student Login
    </a>

</div>

</body>

</html>
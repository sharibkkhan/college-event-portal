<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .login-container {
            background: white;
            width: 360px;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.10);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-size: 16px;
        }

        input {
            width: 100%;
            padding: 11px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #2864e8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #1f54c7;
        }

        .message {
            text-align: center;
            margin-bottom: 20px;
            color: red;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>

<body>

<div class="login-container">

    <h1>Student Login</h1>

    <%
        String error = request.getParameter("error");

        if ("invalid".equals(error)) {
    %>
        <div class="message">
            Invalid email or password.
        </div>
    <%
        }
    %>

    <form action="login" method="post">

        <label>Email</label>
        <input type="email"
               name="email"
               required>

        <label>Password</label>
        <input type="password"
               name="password"
               required>

        <button type="submit">Login</button>

    </form>

    <div class="register-link">
        Don't have an account?
        <a href="register.jsp">Register</a>
    </div>

</div>

</body>
</html>
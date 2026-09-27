<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: white;
            width: 400px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 12px;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 11px;
            margin-top: 20px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Student Registration</h2>

    <% if ("registration_failed".equals(request.getParameter("error"))) { %>
        <div class="error">
            Registration failed. Email may already exist.
        </div>
    <% } %>

    <form action="register" method="post">

        <label>Name</label>
        <input type="text"
               name="name"
               required>

        <label>Email</label>
        <input type="email"
               name="email"
               required>

        <label>Password</label>
        <input type="password"
               name="password"
               required>

        <label>Department</label>
        <input type="text"
               name="department"
               required>

        <label>Phone</label>
        <input type="text"
               name="phone"
               required>

        <button type="submit">
            Register
        </button>

    </form>

</div>

</body>
</html>
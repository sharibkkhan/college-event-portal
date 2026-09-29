<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>College Event Portal</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            min-height: 100vh;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 420px;
            max-width: 90%;
            background: white;

            padding: 45px 40px;
            border-radius: 16px;

            text-align: center;

            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.10);
        }

        .icon {
            width: 65px;
            height: 65px;

            margin: 0 auto 20px;

            background: #2864e8;
            color: white;

            border-radius: 14px;

            display: flex;
            justify-content: center;
            align-items: center;

            font-size: 28px;
            font-weight: bold;
        }

        h1 {
            margin: 0;
            color: #222;
            font-size: 30px;
        }

        .subtitle {
            color: #666;
            margin: 10px 0 35px;
            font-size: 15px;
        }

        .btn {
            display: block;

            width: 100%;

            padding: 14px;
            margin: 15px 0;

            border-radius: 8px;

            text-decoration: none;
            color: white;

            font-size: 16px;
            font-weight: bold;

            transition: 0.2s;
        }

        .student {
            background: #2864e8;
        }

        .student:hover {
            background: #1749b5;
        }

        .admin {
            background: #222;
        }

        .admin:hover {
            background: #000;
        }

        .footer {
            margin-top: 30px;

            font-size: 12px;
            color: #999;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="icon">
        CE
    </div>

    <h1>College Event Portal</h1>

    <p class="subtitle">
        Choose your login type to continue
    </p>

    <a href="login.jsp" class="btn student">
        Student Login
    </a>

    <a href="admin-login.jsp" class="btn admin">
        Admin Login
    </a>

    <div class="footer">
        College Event Management System
    </div>

</div>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" session="false" %>
<%@ page import="com.collegeevent.model.Student" %>

<%
    jakarta.servlet.http.HttpSession currentSession =
            request.getSession(false);

    if (currentSession == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Student student =
            (Student) currentSession.getAttribute("student");

    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Profile | College Event Portal</title>

    <!-- Prevent theme flash -->
    <script>
        (function () {

            const savedTheme =
                localStorage.getItem("portal-theme");

            if (
                savedTheme === "light" ||
                savedTheme === "dark" ||
                savedTheme === "nothing"
            ) {
                document.documentElement.setAttribute(
                    "data-theme",
                    savedTheme
                );
            }

        })();
    </script>


    <style>

        /* =========================================================
           DESIGN SYSTEM
        ========================================================= */

        :root {

            --bg: #f7f9fc;
            --surface: #ffffff;
            --surface-hover: #fafbff;

            --text: #111827;
            --text-secondary: #667085;
            --text-muted: #98a2b3;

            --border: #e4e7ec;
            --border-hover: #cfd6e2;

            --accent: #2864e8;
            --accent-hover: #1749b5;
            --accent-soft: #edf3ff;

            --success: #16a34a;
            --danger: #dc2626;

            --shadow:
                0 12px 35px rgba(16, 24, 40, 0.06);

            --shadow-hover:
                0 20px 45px rgba(16, 24, 40, 0.10);

            --radius-xl: 22px;
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;

            --transition-fast: 180ms ease;
            --transition: 250ms ease;

            --font:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Arial,
                sans-serif;
        }


        /* =========================================================
           DARK
        ========================================================= */

        [data-theme="dark"] {

            --bg: #0b0d10;
            --surface: #111418;
            --surface-hover: #171a1f;

            --text: #f2f4f7;
            --text-secondary: #98a2b3;
            --text-muted: #667085;

            --border: #242932;
            --border-hover: #343b46;

            --accent: #5b8cff;
            --accent-hover: #7aa1ff;
            --accent-soft: #17233f;

            --success: #32d583;
            --danger: #f04438;

            --shadow:
                0 15px 40px rgba(0, 0, 0, 0.25);

            --shadow-hover:
                0 20px 50px rgba(0, 0, 0, 0.38);
        }


        /* =========================================================
           NOTHING
        ========================================================= */

        [data-theme="nothing"] {

            --bg: #050505;
            --surface: #0b0b0b;
            --surface-hover: #111111;

            --text: #ffffff;
            --text-secondary: #a1a1a1;
            --text-muted: #666666;

            --border: #333333;
            --border-hover: #666666;

            --accent: #ff3333;
            --accent-hover: #ff5555;
            --accent-soft: #241010;

            --success: #ff3333;
            --danger: #ff3333;

            --shadow: none;
            --shadow-hover: 0 0 0 1px #555555;

            --radius-xl: 4px;
            --radius-lg: 3px;
            --radius-md: 2px;
            --radius-sm: 0;

            --font:
                "Arial Narrow",
                Arial,
                Helvetica,
                sans-serif;
        }


        /* =========================================================
           RESET
        ========================================================= */

        * {
            box-sizing: border-box;
        }

        html,
        body {
            margin: 0;
            width: 100%;
            min-height: 100%;
        }

        body {

            min-height: 100vh;

            font-family: var(--font);

            background: var(--bg);
            color: var(--text);

            transition:
                background var(--transition),
                color var(--transition);

            overflow-x: hidden;
        }

        button,
        input,
        select {
            font-family: inherit;
        }


        /* =========================================================
           BACKGROUND
        ========================================================= */

        .background {
            position: fixed;
            inset: 0;

            pointer-events: none;

            overflow: hidden;

            z-index: 0;
        }

        .glow {

            position: absolute;

            width: 450px;
            height: 450px;

            border-radius: 50%;

            background:
                rgba(40, 100, 232, 0.055);

            filter: blur(90px);

            animation:
                floatingGlow 12s ease-in-out infinite alternate;
        }

        .glow.one {
            top: -230px;
            left: -200px;
        }

        .glow.two {

            right: -230px;
            bottom: -230px;

            width: 400px;
            height: 400px;

            background:
                rgba(99, 102, 241, 0.04);

            animation-delay: -5s;
        }

        [data-theme="dark"] .glow {
            background:
                rgba(91, 140, 255, 0.035);
        }

        [data-theme="nothing"] .glow {

            width: 1px;
            height: 1px;

            background: transparent;

            filter: none;

            animation: none;
        }

        @keyframes floatingGlow {

            from {
                transform: translate(0, 0);
            }

            to {
                transform: translate(35px, 25px);
            }
        }


        /* =========================================================
           NOTHING GRID
        ========================================================= */

        .nothing-grid {

            position: fixed;
            inset: 0;

            pointer-events: none;

            z-index: 0;

            opacity: 0;

            background-image:
                linear-gradient(
                    rgba(255,255,255,0.035) 1px,
                    transparent 1px
                ),
                linear-gradient(
                    90deg,
                    rgba(255,255,255,0.035) 1px,
                    transparent 1px
                );

            background-size: 45px 45px;

            transition:
                opacity var(--transition);
        }

        [data-theme="nothing"] .nothing-grid {
            opacity: 1;
        }


        /* =========================================================
           PAGE
        ========================================================= */

        .page {

            position: relative;

            z-index: 1;

            min-height: 100vh;

            display: flex;
            flex-direction: column;
        }


        /* =========================================================
           NAVBAR
        ========================================================= */

        .navbar {

            width: 100%;

            padding: 25px 7%;

            display: flex;

            align-items: center;

            justify-content: space-between;

            animation:
                reveal 650ms ease forwards;
        }

        .brand {

            color: var(--text);

            text-decoration: none;

            font-size: 18px;

            font-weight: 700;

            letter-spacing: -0.4px;
        }

        [data-theme="nothing"] .brand {

            text-transform: uppercase;

            letter-spacing: 1.5px;
        }

        .back-link {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            color:
                var(--text-secondary);

            text-decoration: none;

            font-size: 13px;

            font-weight: 600;

            transition:
                color var(--transition-fast);
        }

        .back-link:hover {
            color: var(--text);
        }


        /* =========================================================
           THEME SWITCHER
        ========================================================= */

        .theme-switcher {

            position: relative;

            width: 225px;
            height: 42px;

            padding: 4px;

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            align-items: center;

            background:
                var(--surface);

            border:
                1px solid var(--border);

            border-radius:
                999px;

            box-shadow:
                var(--shadow);

            transition:
                background var(--transition),
                border-color var(--transition);
        }

        .theme-slider {

            position: absolute;

            top: 4px;
            left: 4px;

            width:
                calc((100% - 8px) / 3);

            height:
                calc(100% - 8px);

            border-radius:
                999px;

            background:
                var(--accent-soft);

            border:
                1px solid var(--border);

            pointer-events: none;

            transition:
                transform 300ms cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                );
        }

        [data-theme="dark"]
        .theme-slider {
            transform:
                translateX(100%);
        }

        [data-theme="nothing"]
        .theme-slider {
            transform:
                translateX(200%);
        }

        .theme-option {

            position: relative;

            z-index: 2;

            height: 100%;

            border: 0;

            background: transparent;

            color:
                var(--text-muted);

            cursor: pointer;

            font-size: 11px;

            font-weight: 700;

            letter-spacing:
                0.4px;

            transition:
                color var(--transition-fast);
        }

        .theme-option:hover {
            color: var(--text);
        }

        [data-theme="light"]
        .theme-option[data-theme-option="light"],

        [data-theme="dark"]
        .theme-option[data-theme-option="dark"],

        [data-theme="nothing"]
        .theme-option[data-theme-option="nothing"] {

            color: var(--text);
        }

        [data-theme="nothing"]
        .theme-switcher {

            border-radius: 2px;

            box-shadow: none;

            background: #080808;
        }

        [data-theme="nothing"]
        .theme-slider {

            border-radius: 0;

            background: #171717;

            border-color: #555;

            box-shadow:
                inset 3px 0 #ff3333;
        }

        [data-theme="nothing"]
        .theme-option {

            font-family:
                "Arial Narrow",
                Arial,
                sans-serif;

            text-transform:
                uppercase;

            letter-spacing:
                0.8px;
        }


        /* =========================================================
           MAIN
        ========================================================= */

        .main {

            flex: 1;

            display: flex;

            justify-content: center;

            padding:
                25px 20px 70px;
        }

        .profile-container {

            width: 100%;

            max-width: 850px;

            animation:
                profileEnter 700ms
                cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                )
                forwards;
        }


        /* =========================================================
           PROFILE HEADER
        ========================================================= */

        .profile-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 25px;

            margin-bottom: 28px;
        }

        .header-copy {
            flex: 1;
        }

        .eyebrow {

            display: block;

            margin-bottom: 10px;

            color:
                var(--accent);

            font-size:
                11px;

            font-weight:
                700;

            letter-spacing:
                1.8px;

            text-transform:
                uppercase;
        }

        h1 {

            margin: 0;

            font-size:
                38px;

            line-height:
                1.1;

            letter-spacing:
                -1.7px;
        }

        .subtitle {

            margin:
                10px 0 0;

            color:
                var(--text-secondary);

            font-size:
                14px;

            line-height:
                1.6;
        }

        [data-theme="nothing"] h1 {

            text-transform:
                uppercase;

            letter-spacing:
                -0.5px;
        }


        /* =========================================================
           AVATAR
        ========================================================= */

        .avatar {

            width: 76px;
            height: 76px;

            flex-shrink: 0;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background:
                var(--accent-soft);

            border:
                1px solid var(--border);

            color:
                var(--accent);

            font-size:
                28px;

            font-weight:
                750;
        }

        [data-theme="nothing"] .avatar {

            border-radius: 2px;

            border-color:
                var(--accent);
        }


        /* =========================================================
           MESSAGE
        ========================================================= */

        .message {

            margin-bottom:
                20px;

            padding:
                13px 15px;

            border:
                1px solid var(--border);

            border-radius:
                var(--radius-md);

            font-size:
                13px;

            line-height:
                1.4;
        }

        .message.success {

            color:
                var(--success);

            background:
                color-mix(
                    in srgb,
                    var(--success) 8%,
                    var(--surface)
                );

            border-color:
                color-mix(
                    in srgb,
                    var(--success) 35%,
                    var(--border)
                );
        }

        .message.error {

            color:
                var(--danger);

            background:
                color-mix(
                    in srgb,
                    var(--danger) 8%,
                    var(--surface)
                );

            border-color:
                color-mix(
                    in srgb,
                    var(--danger) 35%,
                    var(--border)
                );
        }


        /* =========================================================
           FORM CARD
        ========================================================= */

        .profile-card {

            padding:
                32px;

            background:
                var(--surface);

            border:
                1px solid var(--border);

            border-radius:
                var(--radius-xl);

            box-shadow:
                var(--shadow);

            transition:
                background var(--transition),
                border-color var(--transition);
        }

        [data-theme="nothing"]
        .profile-card {

            border-radius: 2px;

            box-shadow: none;

            background:
                rgba(8, 8, 8, 0.94);
        }


        /* =========================================================
           FORM SECTIONS
        ========================================================= */

        .form-section {

            margin-bottom:
                34px;
        }

        .form-section:last-of-type {
            margin-bottom: 0;
        }

        .section-title {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom:
                20px;
        }

        .section-number {

            color:
                var(--accent);

            font-size:
                11px;

            font-weight:
                800;

            letter-spacing:
                1px;
        }

        .section-title h2 {

            margin: 0;

            font-size:
                16px;

            font-weight:
                700;
        }

        .section-line {

            flex: 1;

            height: 1px;

            background:
                var(--border);
        }


        /* =========================================================
           FORM GRID
        ========================================================= */

        .form-grid {

            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap:
                20px;
        }

        .form-group {

            min-width: 0;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {

            display: block;

            margin-bottom:
                8px;

            color:
                var(--text);

            font-size:
                13px;

            font-weight:
                650;
        }

        .field-note {

            margin:
                -3px 0 8px;

            color:
                var(--text-muted);

            font-size:
                11px;
        }

        input,
        select {

            width: 100%;

            height: 48px;

            padding:
                0 14px;

            border:
                1px solid var(--border);

            border-radius:
                var(--radius-md);

            outline: none;

            background:
                var(--surface);

            color:
                var(--text);

            font-size:
                14px;

            transition:
                border-color var(--transition-fast),
                box-shadow var(--transition-fast),
                background var(--transition);
        }

        input::placeholder {
            color:
                var(--text-muted);
        }

        input:hover,
        select:hover {

            border-color:
                var(--border-hover);
        }

        input:focus,
        select:focus {

            border-color:
                var(--accent);

            box-shadow:
                0 0 0 3px
                color-mix(
                    in srgb,
                    var(--accent) 12%,
                    transparent
                );
        }

        input[readonly] {

            color:
                var(--text-secondary);

            background:
                var(--surface-hover);

            cursor:
                not-allowed;
        }

        [data-theme="nothing"]
        input,
        [data-theme="nothing"]
        select {

            border-radius: 0;

            background: #080808;
        }

        [data-theme="nothing"]
        input[readonly] {
            background: #111;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .form-actions {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            margin-top:
                32px;

            padding-top:
                24px;

            border-top:
                1px solid var(--border);
        }

        .cancel-link {

            color:
                var(--text-secondary);

            text-decoration:
                none;

            font-size:
                13px;

            font-weight:
                650;

            transition:
                color var(--transition-fast);
        }

        .cancel-link:hover {
            color:
                var(--text);
        }

        .save-button {

            min-width:
                155px;

            height:
                48px;

            padding:
                0 22px;

            border:
                none;

            border-radius:
                var(--radius-md);

            background:
                var(--accent);

            color:
                #ffffff;

            font-size:
                14px;

            font-weight:
                700;

            cursor:
                pointer;

            transition:
                background var(--transition-fast),
                transform var(--transition-fast),
                box-shadow var(--transition-fast);
        }

        .save-button:hover {

            background:
                var(--accent-hover);

            transform:
                translateY(-1px);

            box-shadow:
                0 8px 20px
                color-mix(
                    in srgb,
                    var(--accent) 20%,
                    transparent
                );
        }

        .save-button:active {
            transform:
                translateY(0);
        }

        [data-theme="nothing"]
        .save-button {

            border-radius: 0;

            text-transform:
                uppercase;

            letter-spacing:
                1px;
        }


        /* =========================================================
           ANIMATION
        ========================================================= */

        @keyframes reveal {

            from {
                opacity: 0;
                transform:
                    translateY(-10px);
            }

            to {
                opacity: 1;
                transform:
                    translateY(0);
            }
        }

        @keyframes profileEnter {

            from {

                opacity: 0;

                transform:
                    translateY(25px)
                    scale(0.985);
            }

            to {

                opacity: 1;

                transform:
                    translateY(0)
                    scale(1);
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 700px) {

            .navbar {

                padding:
                    20px 6%;

                flex-wrap:
                    wrap;

                gap:
                    18px;
            }

            .theme-switcher {

                order: 3;

                width:
                    100%;
            }

            .main {

                padding:
                    25px 18px 50px;
            }

            .profile-header {

                align-items:
                    flex-start;
            }

            h1 {

                font-size:
                    31px;
            }

            .avatar {

                width: 60px;
                height: 60px;

                font-size: 22px;
            }

            .profile-card {

                padding:
                    25px 20px;
            }

            .form-grid {

                grid-template-columns:
                    1fr;

                gap:
                    18px;
            }

            .form-group.full {
                grid-column: auto;
            }

            .form-actions {

                align-items:
                    stretch;

                flex-direction:
                    column-reverse;
            }

            .save-button {

                width:
                    100%;
            }

            .cancel-link {

                text-align:
                    center;
            }
        }


        /* =========================================================
           REDUCED MOTION
        ========================================================= */

        @media (prefers-reduced-motion: reduce) {

            *,
            *::before,
            *::after {

                animation-duration:
                    1ms !important;

                transition-duration:
                    1ms !important;
            }
        }

    </style>

</head>


<body>

<div class="background">

    <div class="glow one"></div>
    <div class="glow two"></div>

</div>

<div class="nothing-grid"></div>


<div class="page">


    <!-- =========================================================
         NAVBAR
    ========================================================= -->

    <header class="navbar">

        <a
            href="student-dashboard.jsp"
            class="back-link">

            ← Dashboard

        </a>


        <div class="theme-switcher">

            <div class="theme-slider"></div>

            <button
                class="theme-option"
                type="button"
                data-theme-option="light">

                ☀ Light

            </button>

            <button
                class="theme-option"
                type="button"
                data-theme-option="dark">

                ◐ Dark

            </button>

            <button
                class="theme-option"
                type="button"
                data-theme-option="nothing">

                ◉ Nothing

            </button>

        </div>


        <a
            href="student-dashboard.jsp"
            class="brand">

            College Event Portal

        </a>

    </header>


    <!-- =========================================================
         MAIN
    ========================================================= -->

    <main class="main">

        <section class="profile-container">


            <!-- PROFILE HEADER -->

            <div class="profile-header">

                <div class="header-copy">

                    <span class="eyebrow">
                        Student Profile
                    </span>

                    <h1>
                        Your profile.
                    </h1>

                    <p class="subtitle">
                        Keep your personal and academic
                        information up to date.
                    </p>

                </div>


                <div class="avatar">

                    <%= student.getName()
                        .substring(0, 1)
                        .toUpperCase() %>

                </div>

            </div>


            <!-- SUCCESS -->

            <% if ("updated".equals(success)) { %>

                <div class="message success">
                    ✓ Profile updated successfully.
                </div>

            <% } %>


            <!-- ERROR -->

            <% if ("update_failed".equals(error)) { %>

                <div class="message error">
                    Profile could not be updated. Please try again.
                </div>

            <% } %>


            <!-- PROFILE FORM -->

            <div class="profile-card">

                <form
                    action="update-profile"
                    method="post">


                    <!-- PERSONAL INFORMATION -->

                    <section class="form-section">

                        <div class="section-title">

                            <span class="section-number">
                                01
                            </span>

                            <h2>
                                Personal Information
                            </h2>

                            <span class="section-line"></span>

                        </div>


                        <div class="form-grid">


                            <!-- NAME -->

                            <div class="form-group full">

                                <label for="name">
                                    Full Name
                                </label>

                                <input
                                    id="name"
                                    type="text"
                                    name="name"
                                    value="<%= student.getName() %>"
                                    placeholder="Enter your full name"
                                    autocomplete="name"
                                    required>

                            </div>


                            <!-- EMAIL -->

                            <div class="form-group">

                                <label for="email">
                                    Email
                                </label>

                                <input
                                    id="email"
                                    type="email"
                                    value="<%= student.getEmail() %>"
                                    readonly>

                                <div class="field-note">
                                    Email is linked to your login account.
                                </div>

                            </div>


                            <!-- PHONE -->

                            <div class="form-group">

                                <label for="phone">
                                    Contact Number
                                </label>

                                <input
                                    id="phone"
                                    type="text"
                                    name="phone"
                                    value="<%= student.getPhone() == null ? "" : student.getPhone() %>"
                                    placeholder="Enter your phone number"
                                    autocomplete="tel"
                                    required>

                            </div>

                        </div>

                    </section>


                    <!-- ACADEMIC INFORMATION -->

                    <section class="form-section">

                        <div class="section-title">

                            <span class="section-number">
                                02
                            </span>

                            <h2>
                                Academic Information
                            </h2>

                            <span class="section-line"></span>

                        </div>


                        <div class="form-grid">


                            <!-- DEPARTMENT -->

                            <div class="form-group">

                                <label for="department">
                                    Department
                                </label>

                                <input
                                    id="department"
                                    type="text"
                                    name="department"
                                    value="<%= student.getDepartment() == null ? "" : student.getDepartment() %>"
                                    placeholder="e.g. CSE"
                                    required>

                            </div>


                            <!-- YEAR -->

                            <div class="form-group">

                                <label for="year">
                                    Year
                                </label>

                                <select
                                    id="year"
                                    name="year">

                                    <option
                                        value=""
                                        <%= student.getYear() == null
                                            || student.getYear().isEmpty()
                                            ? "selected"
                                            : "" %>>

                                        Select year

                                    </option>

                                    <option
                                        value="1st Year"
                                        <%= "1st Year".equals(student.getYear())
                                            ? "selected"
                                            : "" %>>

                                        1st Year

                                    </option>

                                    <option
                                        value="2nd Year"
                                        <%= "2nd Year".equals(student.getYear())
                                            ? "selected"
                                            : "" %>>

                                        2nd Year

                                    </option>

                                    <option
                                        value="3rd Year"
                                        <%= "3rd Year".equals(student.getYear())
                                            ? "selected"
                                            : "" %>>

                                        3rd Year

                                    </option>

                                    <option
                                        value="4th Year"
                                        <%= "4th Year".equals(student.getYear())
                                            ? "selected"
                                            : "" %>>

                                        4th Year

                                    </option>

                                </select>

                            </div>


                            <!-- DIVISION -->

                            <div class="form-group">

                                <label for="division">
                                    Division
                                </label>

                                <input
                                    id="division"
                                    type="text"
                                    name="division"
                                    value="<%= student.getDivision() == null ? "" : student.getDivision() %>"
                                    placeholder="e.g. A">

                            </div>


                            <!-- ROLL NUMBER -->

                            <div class="form-group">

                                <label for="rollNumber">
                                    Roll Number
                                </label>

                                <input
                                    id="rollNumber"
                                    type="text"
                                    name="rollNumber"
                                    value="<%= student.getRollNumber() == null ? "" : student.getRollNumber() %>"
                                    placeholder="e.g. 42">

                            </div>


                            <!-- PRN -->

                            <div class="form-group full">

                                <label for="prn">
                                    PRN / Student ID
                                </label>

                                <input
                                    id="prn"
                                    type="text"
                                    name="prn"
                                    value="<%= student.getPrn() == null ? "" : student.getPrn() %>"
                                    placeholder="Enter your PRN or university student ID">

                            </div>

                        </div>

                    </section>


                    <!-- ACTIONS -->

                    <div class="form-actions">

                        <a
                            href="student-dashboard.jsp"
                            class="cancel-link">

                            Cancel

                        </a>

                        <button
                            type="submit"
                            class="save-button">

                            Save Profile

                        </button>

                    </div>


                </form>

            </div>


        </section>

    </main>

</div>


<!-- =========================================================
     THEME ENGINE
========================================================= -->

<script>

    const root =
        document.documentElement;

    const themeOptions =
        document.querySelectorAll(
            ".theme-option"
        );

    const themes = [
        "light",
        "dark",
        "nothing"
    ];


    function setTheme(theme) {

        if (!themes.includes(theme)) {
            theme = "light";
        }

        root.setAttribute(
            "data-theme",
            theme
        );

        localStorage.setItem(
            "portal-theme",
            theme
        );

        updateThemeButtons();
    }


    function updateThemeButtons() {

        const currentTheme =
            root.getAttribute(
                "data-theme"
            );

        themeOptions.forEach(
            function (button) {

                const buttonTheme =
                    button.dataset.themeOption;

                button.setAttribute(
                    "aria-pressed",
                    buttonTheme === currentTheme
                );

            }
        );
    }


    themeOptions.forEach(
        function (button) {

            button.addEventListener(
                "click",
                function () {

                    setTheme(
                        button.dataset.themeOption
                    );

                }
            );

        }
    );


    const savedTheme =
        localStorage.getItem(
            "portal-theme"
        );


    if (
        savedTheme &&
        themes.includes(savedTheme)
    ) {

        setTheme(savedTheme);

    } else {

        setTheme("light");

    }

</script>


</body>
</html>
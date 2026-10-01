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
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | College Event Portal</title>

    <style>

        /* =========================================================
           THEME SYSTEM
        ========================================================= */

        :root {
            --bg: #f5f6f8;
            --surface: rgba(255,255,255,0.82);
            --surface-solid: #ffffff;
            --text: #111318;
            --muted: #70757f;
            --border: rgba(0,0,0,0.08);
            --accent: #2864e8;
            --accent-hover: #174fc7;
            --accent-soft: rgba(40,100,232,0.10);
            --danger: #e5484d;
            --shadow: 0 18px 50px rgba(0,0,0,0.07);
            --radius: 20px;
            --grid: transparent;
        }

        body.dark {
            --bg: #0c0d0f;
            --surface: rgba(23,24,28,0.84);
            --surface-solid: #17181c;
            --text: #f4f5f7;
            --muted: #9297a1;
            --border: rgba(255,255,255,0.09);
            --accent: #5f8cff;
            --accent-hover: #7ba0ff;
            --accent-soft: rgba(95,140,255,0.13);
            --danger: #ff6268;
            --shadow: 0 18px 55px rgba(0,0,0,0.28);
        }

        body.nothing {
            --bg: #050505;
            --surface: #0b0b0b;
            --surface-solid: #0b0b0b;
            --text: #f4f4f4;
            --muted: #8b8b8b;
            --border: #292929;
            --accent: #ff3333;
            --accent-hover: #ff5555;
            --accent-soft: rgba(255,51,51,0.10);
            --danger: #ff3333;
            --shadow: none;
            --radius: 5px;
            --grid: rgba(255,255,255,0.035);
        }


        /* =========================================================
           RESET
        ========================================================= */

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            min-height: 100vh;

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                sans-serif;

            background: var(--bg);
            color: var(--text);

            transition:
                background 0.35s ease,
                color 0.35s ease;

            overflow-x: hidden;
        }


        /* =========================================================
           BACKGROUND
        ========================================================= */

        .background {
            position: fixed;
            inset: 0;
            pointer-events: none;
            z-index: -2;
            overflow: hidden;
        }

        .background::before {
            content: "";
            position: absolute;
            inset: 0;

            background-image:
                linear-gradient(var(--grid) 1px, transparent 1px),
                linear-gradient(90deg, var(--grid) 1px, transparent 1px);

            background-size: 45px 45px;

            opacity: 0;

            transition: opacity 0.4s ease;
        }

        body.nothing .background::before {
            opacity: 1;
        }

        .glow {
            position: absolute;
            width: 500px;
            height: 500px;

            border-radius: 50%;

            background: var(--accent);
            filter: blur(150px);

            opacity: 0.06;

            top: -250px;
            right: -180px;
        }

        body.nothing .glow {
            display: none;
        }


        /* =========================================================
           NAVBAR
        ========================================================= */

        .navbar {
            height: 76px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 42px;

            border-bottom: 1px solid var(--border);

            background: var(--surface);

            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);

            position: sticky;
            top: 0;
            z-index: 50;

            animation: navIn 0.6s ease both;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;

            font-size: 17px;
            font-weight: 700;
            letter-spacing: -0.3px;
        }

        .brand-dot {
            width: 9px;
            height: 9px;

            background: var(--accent);
            border-radius: 50%;

            transition: all 0.3s ease;
        }

        body.nothing .brand-dot {
            border-radius: 0;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }


        /* =========================================================
           THEME SWITCHER
        ========================================================= */

        .theme-switcher {
            position: relative;

            display: flex;
            align-items: center;

            width: 246px;
            height: 38px;

            padding: 3px;

            border: 1px solid var(--border);
            border-radius: 100px;

            background: var(--surface-solid);

            overflow: hidden;
        }

        .theme-slider {
            position: absolute;

            top: 3px;
            left: 3px;

            width: calc((100% - 6px) / 3);
            height: 30px;

            border-radius: 100px;

            background: var(--accent-soft);

            transition:
                transform 0.35s cubic-bezier(.4,0,.2,1),
                background 0.35s ease;
        }

        body.nothing .theme-slider {
            border-radius: 2px;
            background: var(--accent);
        }

        .theme-option {
            position: relative;
            z-index: 2;

            width: 33.333%;

            border: 0;
            background: transparent;

            color: var(--muted);

            font-size: 11px;
            font-weight: 700;

            cursor: pointer;

            transition: color 0.25s ease;
        }

        .theme-option.active {
            color: var(--text);
        }

        body.nothing .theme-option.active {
            color: #fff;
        }


        /* =========================================================
           MAIN
        ========================================================= */

        .container {
            width: min(1180px, calc(100% - 40px));

            margin: 0 auto;

            padding: 62px 0 80px;
        }


        /* =========================================================
           HERO
        ========================================================= */

        .hero {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;

            gap: 30px;

            margin-bottom: 38px;

            animation: heroIn 0.7s 0.08s ease both;
        }

        .eyebrow {
            display: flex;
            align-items: center;
            gap: 9px;

            margin-bottom: 13px;

            color: var(--accent);

            font-size: 12px;
            font-weight: 800;

            letter-spacing: 1.8px;
            text-transform: uppercase;
        }

        .eyebrow-line {
            width: 25px;
            height: 1px;

            background: var(--accent);
        }

        .hero h1 {
            margin: 0;

            font-size: clamp(38px, 5vw, 64px);
            line-height: 0.98;

            letter-spacing: -3px;
            font-weight: 750;
        }

        .hero h1 span {
            color: var(--accent);
        }

        .hero-subtitle {
            margin: 18px 0 0;

            color: var(--muted);

            font-size: 15px;
            line-height: 1.6;
        }

        .student-chip {
            display: flex;
            align-items: center;
            gap: 12px;

            padding: 10px 15px 10px 10px;

            border: 1px solid var(--border);
            border-radius: 100px;

            background: var(--surface);

            box-shadow: var(--shadow);

            white-space: nowrap;
        }

        .avatar {
            width: 36px;
            height: 36px;

            display: grid;
            place-items: center;

            border-radius: 50%;

            background: var(--accent);
            color: white;

            font-size: 14px;
            font-weight: 800;
        }

        body.nothing .avatar {
            border-radius: 2px;
        }

        .student-chip strong {
            display: block;

            font-size: 13px;
        }

        .student-chip small {
            color: var(--muted);
            font-size: 11px;
        }


        /* =========================================================
           STATS / INFO STRIP
        ========================================================= */

        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);

            gap: 14px;

            margin-bottom: 42px;

            animation: riseIn 0.7s 0.16s ease both;
        }

        .info-card {
            position: relative;

            padding: 22px 24px;

            border: 1px solid var(--border);
            border-radius: var(--radius);

            background: var(--surface);

            box-shadow: var(--shadow);

            overflow: hidden;

            transition:
                transform 0.3s ease,
                border-color 0.3s ease;
        }

        .info-card:hover {
            transform: translateY(-3px);
            border-color: var(--accent);
        }

        body.nothing .info-card {
            border-radius: 3px;
        }

        body.nothing .info-card:hover {
            transform: translateY(-2px);
        }

        .info-label {
            margin-bottom: 8px;

            color: var(--muted);

            font-size: 10px;
            font-weight: 800;

            letter-spacing: 1.4px;
            text-transform: uppercase;
        }

        .info-value {
            font-size: 16px;
            font-weight: 650;

            word-break: break-word;
        }


        /* =========================================================
           SECTION HEADER
        ========================================================= */

        .section-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-bottom: 18px;
        }

        .section-heading h2 {
            margin: 0;

            font-size: 22px;
            letter-spacing: -0.7px;
        }

        .section-heading span {
            color: var(--muted);

            font-size: 12px;
        }


        /* =========================================================
           ACTION CARDS
        ========================================================= */

        .actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);

            gap: 18px;

            animation: riseIn 0.7s 0.24s ease both;
        }

        .action-card {
            position: relative;

            min-height: 235px;

            padding: 30px;

            display: flex;
            flex-direction: column;
            justify-content: space-between;

            border: 1px solid var(--border);
            border-radius: var(--radius);

            background: var(--surface);

            box-shadow: var(--shadow);

            overflow: hidden;

            transition:
                transform 0.35s ease,
                border-color 0.35s ease,
                background 0.35s ease;
        }

        .action-card::before {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            right: -80px;
            top: -80px;

            border-radius: 50%;

            background: var(--accent);

            opacity: 0.06;

            transition:
                transform 0.4s ease,
                opacity 0.4s ease;
        }

        .action-card:hover {
            transform: translateY(-6px);
            border-color: var(--accent);
        }

        .action-card:hover::before {
            transform: scale(1.5);
            opacity: 0.10;
        }

        body.nothing .action-card {
            border-radius: 3px;
        }

        body.nothing .action-card::before {
            width: 1px;
            height: 100%;

            right: 0;
            top: 0;

            border-radius: 0;

            opacity: 0.5;

            background: var(--accent);
        }

        body.nothing .action-card:hover {
            transform: translateY(-3px);
        }

        .action-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .action-number {
            color: var(--accent);

            font-size: 12px;
            font-weight: 800;

            letter-spacing: 1px;
        }

        .action-symbol {
            width: 42px;
            height: 42px;

            display: grid;
            place-items: center;

            border: 1px solid var(--border);
            border-radius: 12px;

            background: var(--accent-soft);

            color: var(--accent);

            font-size: 18px;

            transition:
                transform 0.3s ease,
                border-radius 0.3s ease;
        }

        .action-card:hover .action-symbol {
            transform: rotate(-5deg) scale(1.05);
        }

        body.nothing .action-symbol {
            border-radius: 2px;
        }

        .action-card h3 {
            margin: 25px 0 8px;

            font-size: 25px;
            letter-spacing: -1px;
        }

        .action-card p {
            max-width: 390px;

            margin: 0;

            color: var(--muted);

            font-size: 14px;
            line-height: 1.6;
        }

        .action-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            width: fit-content;

            margin-top: 25px;

            color: var(--text);

            text-decoration: none;

            font-size: 13px;
            font-weight: 750;

            transition:
                color 0.25s ease,
                gap 0.25s ease;
        }

        .action-link::after {
            content: "→";

            color: var(--accent);

            transition: transform 0.25s ease;
        }

        .action-link:hover {
            color: var(--accent);
            gap: 13px;
        }

        .action-link:hover::after {
            transform: translateX(3px);
        }


        /* =========================================================
           FOOTER / LOGOUT
        ========================================================= */

        .bottom-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;

            margin-top: 46px;
            padding-top: 22px;

            border-top: 1px solid var(--border);

            animation: riseIn 0.7s 0.32s ease both;
        }

        .bottom-note {
            color: var(--muted);

            font-size: 11px;
        }

        .logout {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            color: var(--muted);

            text-decoration: none;

            font-size: 12px;
            font-weight: 700;

            transition: color 0.25s ease;
        }

        .logout:hover {
            color: var(--danger);
        }


        /* =========================================================
           NOTHING MODE
        ========================================================= */

        body.nothing .navbar {
            backdrop-filter: none;
            -webkit-backdrop-filter: none;
            background: #050505;
        }

        body.nothing .hero h1 {
            text-transform: uppercase;
            letter-spacing: -3px;
        }

        body.nothing .section-heading h2,
        body.nothing .action-card h3 {
            text-transform: uppercase;
            letter-spacing: -0.5px;
        }

        body.nothing .info-label,
        body.nothing .eyebrow {
            letter-spacing: 2px;
        }

        body.nothing .action-link::after {
            content: "↗";
        }


        /* =========================================================
           ANIMATIONS
        ========================================================= */

        @keyframes navIn {
            from {
                opacity: 0;
                transform: translateY(-12px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes heroIn {
            from {
                opacity: 0;
                transform: translateY(18px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes riseIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 800px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-right {
                gap: 10px;
            }

            .theme-switcher {
                width: 210px;
            }

            .container {
                width: min(100% - 28px, 650px);
                padding-top: 42px;
            }

            .hero {
                align-items: flex-start;
                flex-direction: column;
            }

            .student-chip {
                width: 100%;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .actions {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 560px) {

            .navbar {
                height: auto;
                min-height: 70px;

                padding: 15px;

                gap: 14px;
                flex-direction: column;
                align-items: stretch;
            }

            .brand {
                justify-content: center;
            }

            .nav-right {
                justify-content: center;
            }

            .theme-switcher {
                width: 100%;
            }

            .hero h1 {
                font-size: 42px;
                letter-spacing: -2px;
            }

            .action-card {
                min-height: 220px;
                padding: 24px;
            }

            .bottom-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }

    </style>
</head>


<body>

<div class="background">
    <div class="glow"></div>
</div>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar">

    <div class="brand">
        <span class="brand-dot"></span>
        College Event Portal
    </div>

    <div class="nav-right">

        <div class="theme-switcher">

            <div class="theme-slider"></div>

            <button
                type="button"
                class="theme-option"
                data-theme-option="light">
                ☀ Light
            </button>

            <button
                type="button"
                class="theme-option"
                data-theme-option="dark">
                ◐ Dark
            </button>

            <button
                type="button"
                class="theme-option"
                data-theme-option="nothing">
                ◉ Nothing
            </button>

        </div>

    </div>

</nav>


<!-- =========================================================
     MAIN CONTENT
========================================================= -->

<main class="container">


    <!-- HERO -->

    <section class="hero">

        <div>

            <div class="eyebrow">
                <span class="eyebrow-line"></span>
                Student Dashboard
            </div>

            <h1>
                Welcome,<br>
                <span><%= student.getName() %></span>
            </h1>

            <p class="hero-subtitle">
                Manage your college events and registrations
                from one place.
            </p>

        </div>


        <div class="student-chip">

            <div class="avatar">
                <%= student.getName().substring(0, 1).toUpperCase() %>
            </div>

            <div>
                <strong><%= student.getName() %></strong>
                <small><%= student.getDepartment() %></small>
            </div>

        </div>

    </section>


    <!-- STUDENT INFORMATION -->

    <div class="info-grid">

        <div class="info-card">

            <div class="info-label">
                Email
            </div>

            <div class="info-value">
                <%= student.getEmail() %>
            </div>

        </div>


        <div class="info-card">

            <div class="info-label">
                Department
            </div>

            <div class="info-value">
                <%= student.getDepartment() %>
            </div>

        </div>


        <div class="info-card">

            <div class="info-label">
                Phone
            </div>

            <div class="info-value">
                <%= student.getPhone() %>
            </div>

        </div>

    </div>


    <!-- ACTIONS -->

    <div class="section-heading">

        <h2>
            Your Portal
        </h2>

        <span>
            Choose an action
        </span>

    </div>


    <div class="actions">


        <!-- EVENTS -->

        <article class="action-card">

            <div>

                <div class="action-top">

                    <span class="action-number">
                        01
                    </span>

                    <div class="action-symbol">
                        ◇
                    </div>

                </div>

                <h3>
                    Events
                </h3>

                <p>
                    Discover upcoming college events,
                    workshops, activities and opportunities
                    available to students.
                </p>

            </div>


            <a
                href="events"
                class="action-link">
                View Events
            </a>

        </article>


        <!-- REGISTRATIONS -->

        <article class="action-card">

            <div>

                <div class="action-top">

                    <span class="action-number">
                        02
                    </span>

                    <div class="action-symbol">
                        ✓
                    </div>

                </div>

                <h3>
                    Registrations
                </h3>

                <p>
                    Keep track of the events you have
                    registered for and review your
                    registration details.
                </p>

            </div>


            <a
                href="my-registrations"
                class="action-link">
                My Registrations
            </a>

        </article>


    </div>


    <!-- BOTTOM -->

    <div class="bottom-bar">

        <div class="bottom-note">
            College Event Management Portal
        </div>

        <a
            href="logout"
            class="logout">
            Log out →
        </a>

    </div>

</main>


<!-- =========================================================
     THEME ENGINE
========================================================= -->

<script>

    const themeOptions =
        document.querySelectorAll(".theme-option");

    const themeSlider =
        document.querySelector(".theme-slider");

    const body =
        document.body;


    function applyTheme(theme) {

        body.classList.remove(
            "dark",
            "nothing"
        );


        if (theme === "dark") {
            body.classList.add("dark");
        }

        if (theme === "nothing") {
            body.classList.add("nothing");
        }


        let position = 0;

        if (theme === "dark") {
            position = 1;
        }

        if (theme === "nothing") {
            position = 2;
        }


        themeSlider.style.transform =
            `translateX(${position * 100}%)`;


        themeOptions.forEach(option => {

            option.classList.toggle(
                "active",
                option.dataset.themeOption === theme
            );

        });


        localStorage.setItem(
            "portal-theme",
            theme
        );
    }


    themeOptions.forEach(option => {

        option.addEventListener(
            "click",
            () => {

                applyTheme(
                    option.dataset.themeOption
                );

            }
        );

    });


    const savedTheme =
        localStorage.getItem("portal-theme")
        || "light";


    applyTheme(savedTheme);

</script>


</body>
</html>
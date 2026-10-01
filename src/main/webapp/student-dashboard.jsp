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

    response.setHeader(
            "Cache-Control",
            "no-cache, no-store, must-revalidate"
    );
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    String studentName = student.getName();

    if (studentName == null || studentName.trim().isEmpty()) {
        studentName = "Student";
    }

    String initial =
            studentName.substring(0, 1).toUpperCase();

    String department = student.getDepartment();

    if (department == null || department.trim().isEmpty()) {
        department = "Not set";
    }

    String year = student.getYear();

    if (year == null || year.trim().isEmpty()) {
        year = "Not set";
    }

    String phone = student.getPhone();

    if (phone == null || phone.trim().isEmpty()) {
        phone = "Not set";
    }

    String email = student.getEmail();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>

    <meta charset="UTF-8">

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0"
    >

    <title>Student Dashboard | College Event Portal</title>


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


    <!-- Font -->

    <link
            rel="preconnect"
            href="https://fonts.googleapis.com"
    >

    <link
            rel="preconnect"
            href="https://fonts.gstatic.com"
            crossorigin
    >

    <link
            href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
    >


    <style>

        /* =========================================================
           GLOBAL
        ========================================================= */

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        html {
            scroll-behavior: smooth;
        }


        body {

            min-height: 100vh;

            font-family:
                    "Plus Jakarta Sans",
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


        a {
            color: inherit;
            text-decoration: none;
        }


        button {
            font-family: inherit;
        }


        /* =========================================================
           THEME VARIABLES
        ========================================================= */

        :root {

            --bg: #f6f7f9;

            --surface: #ffffff;

            --surface-2: #f0f1f4;

            --text: #111318;

            --muted: #70747d;

            --border: #e2e4e8;

            --border-strong: #d3d6dc;

            --accent: #111318;

            --accent-text: #ffffff;

            --shadow:
                    0 20px 50px rgba(0, 0, 0, 0.07);

            --radius: 20px;
        }


        /* =========================================================
           DARK
        ========================================================= */

        [data-theme="dark"] {

            --bg: #090a0d;

            --surface: #111318;

            --surface-2: #181a20;

            --text: #f4f5f7;

            --muted: #9b9fa8;

            --border: #282b32;

            --border-strong: #363941;

            --accent: #ffffff;

            --accent-text: #08090b;

            --shadow:
                    0 20px 60px rgba(0, 0, 0, 0.35);
        }


        /* =========================================================
           NOTHING
        ========================================================= */

        [data-theme="nothing"] {

            --bg: #050505;

            --surface: #090909;

            --surface-2: #101010;

            --text: #ffffff;

            --muted: #999999;

            --border: #303030;

            --border-strong: #555555;

            --accent: #ff3333;

            --accent-text: #ffffff;

            --shadow: none;

            --radius: 4px;
        }


        /* =========================================================
           NOTHING GRID
        ========================================================= */

        .nothing-grid {

            position: fixed;

            inset: 0;

            pointer-events: none;

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

            background-size: 40px 40px;

            transition: opacity 0.35s ease;

            z-index: 0;
        }


        [data-theme="nothing"] .nothing-grid {
            opacity: 1;
        }


        /* =========================================================
           BACKGROUND
        ========================================================= */

        .background-glow {

            position: fixed;

            width: 500px;
            height: 500px;

            border-radius: 50%;

            background:
                    radial-gradient(
                            circle,
                            rgba(80, 110, 255, 0.08),
                            transparent 70%
                    );

            top: -250px;
            right: -180px;

            pointer-events: none;

            z-index: 0;
        }


        [data-theme="nothing"] .background-glow {
            display: none;
        }


        /* =========================================================
           NAVBAR
        ========================================================= */

        .navbar {

            position: relative;

            z-index: 20;

            height: 76px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 6%;

            border-bottom: 1px solid var(--border);

            background: var(--bg);

            backdrop-filter: blur(18px);
        }


        .brand {

            display: flex;

            align-items: center;

            gap: 11px;

            font-size: 15px;

            font-weight: 700;

            letter-spacing: -0.2px;
        }


        .brand-dot {

            width: 10px;
            height: 10px;

            border-radius: 50%;

            background: var(--accent);
        }


        [data-theme="nothing"] .brand-dot {

            border-radius: 0;

            background: var(--accent);
        }


        /* =========================================================
           NAV RIGHT
        ========================================================= */

        .nav-right {

            display: flex;

            align-items: center;

            gap: 14px;
        }


        /* =========================================================
           THEME SWITCHER
        ========================================================= */

        .theme-switcher {

            position: relative;

            display: flex;

            align-items: center;

            width: 174px;

            height: 38px;

            padding: 3px;

            border: 1px solid var(--border);

            border-radius: 999px;

            background: var(--surface);

            overflow: hidden;
        }


        [data-theme="nothing"] .theme-switcher {
            border-radius: 4px;
        }


        .theme-slider {

            position: absolute;

            top: 3px;
            left: 3px;

            width: calc((100% - 6px) / 3);

            height: 30px;

            border-radius: 999px;

            background: var(--accent);

            transition:
                    transform 0.28s cubic-bezier(.4,0,.2,1);

            z-index: 0;
        }


        [data-theme="nothing"] .theme-slider {
            border-radius: 2px;
        }


        [data-theme="dark"] .theme-slider {
            transform: translateX(100%);
        }


        [data-theme="nothing"] .theme-slider {
            transform: translateX(200%);
        }


        .theme-option {

            position: relative;

            z-index: 1;

            flex: 1;

            height: 30px;

            border: none;

            background: transparent;

            color: var(--muted);

            font-size: 11px;

            font-weight: 700;

            cursor: pointer;

            transition: color 0.25s ease;
        }


        [data-theme="light"]
        .theme-option[data-theme-option="light"],

        [data-theme="dark"]
        .theme-option[data-theme-option="dark"],

        [data-theme="nothing"]
        .theme-option[data-theme-option="nothing"] {

            color: var(--accent-text);
        }


        /* =========================================================
           PROFILE BUTTON
        ========================================================= */

        .profile-wrapper {
            position: relative;
        }


        .profile-button {

            width: 40px;
            height: 40px;

            border-radius: 50%;

            border: 1px solid var(--border);

            background: var(--surface);

            color: var(--text);

            display: flex;

            align-items: center;

            justify-content: center;

            cursor: pointer;

            font-size: 13px;

            font-weight: 800;

            transition:
                    transform 0.2s ease,
                    border-color 0.2s ease,
                    background 0.2s ease;
        }


        .profile-button:hover {

            transform: translateY(-1px);

            border-color: var(--border-strong);
        }


        [data-theme="nothing"] .profile-button {

            border-radius: 4px;

            color: var(--accent);
        }


        /* =========================================================
           PROFILE MENU
        ========================================================= */

        .profile-menu {

            position: absolute;

            top: calc(100% + 12px);

            right: 0;

            width: 250px;

            padding: 10px;

            border: 1px solid var(--border);

            border-radius: 16px;

            background: var(--surface);

            box-shadow: var(--shadow);

            opacity: 0;

            visibility: hidden;

            transform:
                    translateY(-7px)
                    scale(0.98);

            transform-origin: top right;

            transition:
                    opacity 0.18s ease,
                    visibility 0.18s ease,
                    transform 0.18s ease;
        }


        [data-theme="nothing"] .profile-menu {

            border-radius: 4px;

            box-shadow: none;
        }


        .profile-wrapper.open .profile-menu {

            opacity: 1;

            visibility: visible;

            transform:
                    translateY(0)
                    scale(1);
        }


        .profile-header {

            padding: 12px;

            border-bottom: 1px solid var(--border);

            margin-bottom: 6px;
        }


        .profile-name {

            font-size: 14px;

            font-weight: 800;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }


        .profile-meta {

            margin-top: 4px;

            font-size: 11px;

            color: var(--muted);
        }


        .menu-item {

            display: flex;

            align-items: center;

            gap: 11px;

            width: 100%;

            padding: 11px 12px;

            border-radius: 10px;

            font-size: 13px;

            font-weight: 600;

            color: var(--text);

            transition:
                    background 0.18s ease,
                    color 0.18s ease;
        }


        .menu-item:hover {
            background: var(--surface-2);
        }


        .menu-item.logout {
            color: #d64545;
        }


        [data-theme="nothing"] .menu-item {
            border-radius: 2px;
        }


        [data-theme="nothing"] .menu-item.logout {
            color: var(--accent);
        }


        /* =========================================================
           MAIN
        ========================================================= */

        .page {

            position: relative;

            z-index: 1;

            width: min(1120px, 90%);

            margin: 0 auto;

            padding: 55px 0 40px;
        }


        /* =========================================================
           HERO
        ========================================================= */

        .hero {

            animation:
                    pageEnter 0.65s
                    cubic-bezier(.2,.8,.2,1)
                    both;
        }


        @keyframes pageEnter {

            from {

                opacity: 0;

                transform: translateY(18px);
            }

            to {

                opacity: 1;

                transform: translateY(0);
            }
        }


        .eyebrow {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            margin-bottom: 18px;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 1.5px;

            text-transform: uppercase;

            color: var(--muted);
        }


        .eyebrow-line {

            width: 24px;

            height: 1px;

            background: var(--border-strong);
        }


        /* =========================================================
           HERO TITLE
        ========================================================= */

        .hero-title {

            max-width: none;

            display: flex;

            flex-direction: column;

            white-space: nowrap;

            font-family:
                    "Plus Jakarta Sans",
                    Inter,
                    -apple-system,
                    BlinkMacSystemFont,
                    "Segoe UI",
                    sans-serif;

            font-weight: 800;

            line-height: 0.98;

            letter-spacing: -2.4px;
        }


        .hero-title .welcome-line {

            display: block;

            font-size: clamp(36px, 3.7vw, 48px);

            color: var(--text);
        }


        .hero-title .name-line {

            display: block;

            margin-top: 5px;

            font-size: clamp(40px, 4.2vw, 54px);

            color: var(--accent);

            letter-spacing: -2.8px;
        }


        .hero-description {

            max-width: 600px;

            margin-top: 16px;

            color: var(--muted);

            font-size: 13px;

            line-height: 1.6;
        }


        [data-theme="nothing"] .hero-title {

            letter-spacing: -2px;

            text-transform: uppercase;
        }


        /* =========================================================
           STUDENT CHIP
        ========================================================= */

        .student-chip {

            display: inline-flex;

            align-items: center;

            gap: 10px;

            margin-top: 22px;

            padding: 7px 13px 7px 7px;

            border: 1px solid var(--border);

            border-radius: 999px;

            background: var(--surface);
        }


        [data-theme="nothing"] .student-chip {
            border-radius: 4px;
        }


        .student-avatar {

            width: 31px;
            height: 31px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 50%;

            background: var(--accent);

            color: var(--accent-text);

            font-size: 12px;

            font-weight: 800;
        }


        [data-theme="nothing"] .student-avatar {

            border-radius: 2px;

            color: #fff;
        }


        .student-chip-text {

            font-size: 12px;

            font-weight: 700;
        }


        .student-chip-meta {

            margin-left: 3px;

            color: var(--muted);

            font-weight: 500;
        }


        /* =========================================================
           INFO GRID
        ========================================================= */

        .info-grid {

            display: grid;

            grid-template-columns:
                    repeat(4, 1fr);

            gap: 12px;

            margin-top: 28px;

            animation:
                    pageEnter 0.65s
                    0.08s
                    cubic-bezier(.2,.8,.2,1)
                    both;
        }


        .info-card {

            min-height: 90px;

            padding: 17px 18px;

            border: 1px solid var(--border);

            border-radius: var(--radius);

            background: var(--surface);

            transition:
                    transform 0.22s ease,
                    border-color 0.22s ease,
                    box-shadow 0.22s ease;
        }


        .info-card:hover {

            transform: translateY(-3px);

            border-color: var(--border-strong);

            box-shadow:
                    0 12px 28px rgba(0, 0, 0, 0.06);
        }


        [data-theme="nothing"] .info-card {
            border-radius: 4px;
        }


        .info-label {

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 1.2px;

            color: var(--muted);

            font-weight: 800;
        }


        .info-value {

            margin-top: 9px;

            font-size: 13px;

            font-weight: 700;

            word-break: break-word;
        }


        /* =========================================================
           ACTION SECTION
        ========================================================= */

        .section-heading {

            margin-top: 28px;

            margin-bottom: 12px;

            display: flex;

            align-items: end;

            justify-content: space-between;
        }


        .section-heading h2 {

            font-size: 20px;

            letter-spacing: -0.7px;

            font-weight: 800;
        }


        .section-heading p {

            font-size: 11px;

            color: var(--muted);
        }


        .actions-grid {

            display: grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap: 14px;

            animation:
                    pageEnter 0.65s
                    0.16s
                    cubic-bezier(.2,.8,.2,1)
                    both;
        }


        .action-card {

            position: relative;

            min-height: 190px;

            padding: 23px;

            border: 1px solid var(--border);

            border-radius: var(--radius);

            background: var(--surface);

            overflow: hidden;

            transition:
                    transform 0.25s ease,
                    border-color 0.25s ease,
                    box-shadow 0.25s ease;
        }


        .action-card:hover {

            transform: translateY(-5px);

            border-color: var(--border-strong);

            box-shadow:
                    0 16px 34px rgba(0, 0, 0, 0.08);
        }


        [data-theme="nothing"] .action-card {
            border-radius: 4px;
        }


        .action-number {

            font-size: 11px;

            font-weight: 800;

            color: var(--muted);

            letter-spacing: 1px;
        }


        .action-title {

            margin-top: 32px;

            font-size: 22px;

            letter-spacing: -0.8px;

            font-weight: 800;
        }


        .action-description {

            max-width: 400px;

            margin-top: 9px;

            color: var(--muted);

            font-size: 12px;

            line-height: 1.55;
        }


        .action-arrow {

            position: absolute;

            right: 22px;

            bottom: 20px;

            width: 40px;
            height: 40px;

            display: flex;

            align-items: center;

            justify-content: center;

            border: 1px solid var(--border);

            border-radius: 50%;

            font-size: 17px;

            transition:
                    transform 0.25s ease,
                    background 0.25s ease,
                    color 0.25s ease;
        }


        .action-card:hover .action-arrow {

            transform: translate(3px, -3px);

            background: var(--accent);

            color: var(--accent-text);
        }


        [data-theme="nothing"] .action-arrow {

            border-radius: 2px;

            color: var(--accent);
        }


        /* =========================================================
           BOTTOM NOTE
        ========================================================= */

        .bottom-note {

            margin-top: 16px;

            padding-top: 10px;

            border-top: 1px solid var(--border);

            display: flex;

            justify-content: space-between;

            gap: 20px;

            color: var(--muted);

            font-size: 10px;
        }


        /* =========================================================
           DESKTOP — NO SCROLL
        ========================================================= */

        @media (min-width: 851px) {

            html,
            body {

                height: 100vh;

                min-height: 100vh;

                overflow: hidden;
            }


            .page {

                width: min(1180px, 92%);

                height: calc(100vh - 76px);

                padding: 25px 0 14px;

                display: flex;

                flex-direction: column;

                justify-content: space-between;
            }


            .hero {
                flex: 0 0 auto;
            }


            .hero-description {

                margin-top: 12px;

                font-size: 12px;

                line-height: 1.5;
            }


            .student-chip {
                margin-top: 16px;
            }


            .info-grid {
                margin-top: 20px;
            }


            .info-card {

                min-height: 72px;

                padding: 13px 17px;
            }


            .info-value {

                margin-top: 7px;

                font-size: 12px;
            }


            .section-heading {

                margin-top: 17px;

                margin-bottom: 9px;
            }


            .actions-grid {

                flex: 1;

                min-height: 0;
            }


            .action-card {

                min-height: 0;

                height: 100%;

                padding: 20px;
            }


            .action-title {

                margin-top: 25px;

                font-size: 20px;
            }


            .action-description {

                font-size: 11px;

                line-height: 1.5;
            }


            .bottom-note {

                margin-top: 9px;

                padding-top: 7px;
            }
        }


        /* =========================================================
           SHORT LAPTOP
        ========================================================= */

        @media (min-width: 851px) and (max-height: 800px) {

            .page {

                padding-top: 16px;

                padding-bottom: 8px;
            }


            .hero-title .welcome-line {
                font-size: 34px;
            }


            .hero-title .name-line {
                font-size: 41px;
            }


            .hero-description {

                margin-top: 7px;

                font-size: 11px;
            }


            .student-chip {
                margin-top: 10px;
            }


            .info-grid {
                margin-top: 13px;
            }


            .info-card {

                min-height: 62px;

                padding: 10px 14px;
            }


            .section-heading {
                margin-top: 11px;
            }


            .action-card {
                padding: 16px;
            }


            .action-title {

                margin-top: 18px;

                font-size: 18px;
            }


            .bottom-note {

                margin-top: 6px;

                padding-top: 6px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 850px) {

            .hero-title {
                white-space: normal;
            }


            .hero-title .welcome-line {
                font-size: 38px;
            }


            .hero-title .name-line {
                font-size: 44px;
            }


            .info-grid {

                grid-template-columns:
                        repeat(2, 1fr);

                margin-top: 35px;
            }


            .actions-grid {

                grid-template-columns: 1fr;
            }
        }


        @media (max-width: 650px) {

            .navbar {
                height: 68px;
            }


            .brand {
                font-size: 13px;
            }


            .theme-switcher {
                width: 145px;
            }


            .profile-button {

                width: 37px;
                height: 37px;
            }


            .page {

                width: 92%;

                padding:
                        40px 0
                        35px;
            }


            .hero-title .welcome-line {
                font-size: 34px;
            }


            .hero-title .name-line {
                font-size: 39px;
            }


            .info-grid {

                grid-template-columns: 1fr;

                margin-top: 35px;
            }


            .section-heading {
                display: block;
            }


            .section-heading p {
                margin-top: 6px;
            }


            .bottom-note {

                display: block;

                line-height: 1.6;
            }
        }


        @media (max-width: 480px) {

            .nav-right {
                gap: 7px;
            }


            .theme-switcher {
                width: 132px;
            }


            .theme-option {
                font-size: 9px;
            }


            .profile-menu {
                right: -5px;
            }
        }


        /* =========================================================
           NOTHING THEME
        ========================================================= */

        [data-theme="nothing"] .hero-title .welcome-line {

            text-transform: uppercase;

            color: var(--text);
        }


        [data-theme="nothing"] .hero-title .name-line {

            text-transform: uppercase;

            color: var(--accent);
        }

    </style>

</head>


<body>

    <div class="nothing-grid"></div>

    <div class="background-glow"></div>


    <!-- =========================================================
         NAVBAR
    ========================================================= -->

    <nav class="navbar">

        <a
                href="student-dashboard.jsp"
                class="brand"
        >

            <span class="brand-dot"></span>

            <span>College Event Portal</span>

        </a>


        <div class="nav-right">


            <!-- Theme -->

            <div class="theme-switcher">

                <div class="theme-slider"></div>


                <button
                        type="button"
                        class="theme-option"
                        data-theme-option="light"
                >
                    Light
                </button>


                <button
                        type="button"
                        class="theme-option"
                        data-theme-option="dark"
                >
                    Dark
                </button>


                <button
                        type="button"
                        class="theme-option"
                        data-theme-option="nothing"
                >
                    Nothing
                </button>

            </div>


            <!-- Profile -->

            <div
                    class="profile-wrapper"
                    id="profileWrapper"
            >

                <button
                        type="button"
                        class="profile-button"
                        id="profileButton"
                        aria-label="Open profile menu"
                >
                    <%= initial %>
                </button>


                <div
                        class="profile-menu"
                        id="profileMenu"
                >

                    <div class="profile-header">

                        <div class="profile-name">
                            <%= studentName %>
                        </div>

                        <div class="profile-meta">

                            <%= department %>

                            <% if (!"Not set".equals(year)) { %>
                                · <%= year %>
                            <% } %>

                        </div>

                    </div>


                    <a
                            href="student-profile.jsp"
                            class="menu-item"
                    >

                        <span>◉</span>

                        <span>Profile</span>

                    </a>


                    <a
                            href="logout"
                            class="menu-item logout"
                    >

                        <span>↪</span>

                        <span>Logout</span>

                    </a>

                </div>

            </div>

        </div>

    </nav>


    <!-- =========================================================
         MAIN
    ========================================================= -->

    <main class="page">


        <!-- HERO -->

        <section class="hero">

            <div class="eyebrow">

                <span class="eyebrow-line"></span>

                Student Dashboard

            </div>


            <h1 class="hero-title">

                <span class="welcome-line">
                    Welcome back,
                </span>

                <span class="name-line">
                    <%= studentName %>.
                </span>

            </h1>


            <p class="hero-description">

                Manage your college events, registrations,
                and student profile from one place.

            </p>


            <div class="student-chip">

                <div class="student-avatar">
                    <%= initial %>
                </div>


                <div class="student-chip-text">

                    <%= studentName %>

                    <span class="student-chip-meta">
                        · Student
                    </span>

                </div>

            </div>

        </section>


        <!-- =====================================================
             STUDENT INFO
        ====================================================== -->

        <section class="info-grid">


            <div class="info-card">

                <div class="info-label">
                    Email
                </div>

                <div class="info-value">
                    <%= email %>
                </div>

            </div>


            <div class="info-card">

                <div class="info-label">
                    Department
                </div>

                <div class="info-value">
                    <%= department %>
                </div>

            </div>


            <div class="info-card">

                <div class="info-label">
                    Year
                </div>

                <div class="info-value">
                    <%= year %>
                </div>

            </div>


            <div class="info-card">

                <div class="info-label">
                    Phone
                </div>

                <div class="info-value">
                    <%= phone %>
                </div>

            </div>

        </section>


        <!-- =====================================================
             ACTIONS
        ====================================================== -->

        <div class="section-heading">

            <div>

                <h2>
                    What would you like to do?
                </h2>

            </div>


            <p>
                Choose an option to continue
            </p>

        </div>


        <section class="actions-grid">


            <!-- EVENTS -->

            <a
                    href="events"
                    class="action-card"
            >

                <div class="action-number">
                    01
                </div>


                <div class="action-title">
                    Browse Events
                </div>


                <p class="action-description">

                    Explore upcoming college events,
                    workshops and activities available
                    for registration.

                </p>


                <div class="action-arrow">
                    →
                </div>

            </a>


            <!-- REGISTRATIONS -->

            <a
                    href="my-registrations"
                    class="action-card"
            >

                <div class="action-number">
                    02
                </div>


                <div class="action-title">
                    My Registrations
                </div>


                <p class="action-description">

                    View the events you have registered for
                    and keep track of your participation.

                </p>


                <div class="action-arrow">
                    →
                </div>

            </a>


        </section>


        <!-- =====================================================
             BOTTOM NOTE
        ====================================================== -->

        <div class="bottom-note">

            <span>
                College Event Management Portal
            </span>

            <span>
                Student access
            </span>

        </div>


    </main>


    <!-- =========================================================
         THEME + PROFILE JS
    ========================================================= -->

    <script>

        const root = document.documentElement;

        const themes = [
            "light",
            "dark",
            "nothing"
        ];


        /* =====================================================
           THEME
        ===================================================== */

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


            document
                    .querySelectorAll(".theme-option")
                    .forEach(button => {

                        button.classList.toggle(
                                "active",
                                button.dataset.themeOption === theme
                        );

                    });

        }


        document
                .querySelectorAll(".theme-option")
                .forEach(button => {

                    button.addEventListener(
                            "click",
                            function () {

                                setTheme(
                                        this.dataset.themeOption
                                );

                            }
                    );

                });


        const savedTheme =
                localStorage.getItem("portal-theme");


        setTheme(

                themes.includes(savedTheme)
                        ? savedTheme
                        : "light"

        );


        /* =====================================================
           PROFILE MENU
        ===================================================== */

        const profileWrapper =
                document.getElementById("profileWrapper");


        const profileButton =
                document.getElementById("profileButton");


        profileButton.addEventListener(
                "click",
                function (event) {

                    event.stopPropagation();

                    profileWrapper.classList.toggle(
                            "open"
                    );

                }
        );


        document.addEventListener(
                "click",
                function (event) {

                    if (
                            !profileWrapper.contains(
                                    event.target
                            )
                    ) {

                        profileWrapper.classList.remove(
                                "open"
                        );

                    }

                }
        );


        document.addEventListener(
                "keydown",
                function (event) {

                    if (event.key === "Escape") {

                        profileWrapper.classList.remove(
                                "open"
                        );

                    }

                }
        );

    </script>


</body>

</html>
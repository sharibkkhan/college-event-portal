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

        html,
        body {
            width: 100%;
            min-height: 100%;
        }

        body {
            font-family:
                    "Plus Jakarta Sans",
                    Inter,
                    -apple-system,
                    BlinkMacSystemFont,
                    "Segoe UI",
                    sans-serif;

            background: var(--bg);
            color: var(--text);

            overflow-x: hidden;

            transition:
                    background 0.3s ease,
                    color 0.3s ease;
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
            --bg: #f6f7fb;
            --surface: #ffffff;
            --surface-2: #f0f2f7;

            --text: #151720;
            --muted: #777d8d;

            --border: #e1e4ec;
            --border-strong: #d2d6e0;

            --accent: #635bff;
            --accent-2: #8b5cf6;
            --accent-soft: #eeecff;

            --blue: #3b82f6;
            --green: #10b981;
            --orange: #f59e0b;
            --pink: #ec4899;

            --shadow:
                    0 12px 30px rgba(28, 35, 60, 0.07);

            --radius: 16px;
        }


        /* =========================================================
           DARK THEME
        ========================================================= */

        [data-theme="dark"] {
            --bg: #08090d;
            --surface: #111319;
            --surface-2: #181b23;

            --text: #f4f5f8;
            --muted: #969ca9;

            --border: #262a34;
            --border-strong: #363b48;

            --accent: #8178ff;
            --accent-2: #a78bfa;
            --accent-soft: #1d1b35;

            --blue: #60a5fa;
            --green: #34d399;
            --orange: #fbbf24;
            --pink: #f472b6;

            --shadow:
                    0 15px 40px rgba(0, 0, 0, 0.3);
        }


        /* =========================================================
           NOTHING THEME
        ========================================================= */

        [data-theme="nothing"] {
            --bg: #080808;
            --surface: #0d0d0d;
            --surface-2: #141414;

            --text: #ffffff;
            --muted: #969696;

            --border: #303030;
            --border-strong: #555555;

            --accent: #ff3030;
            --accent-2: #ff3030;
            --accent-soft: #281010;

            --blue: #ff3030;
            --green: #ff3030;
            --orange: #ff3030;
            --pink: #ff3030;

            --shadow: none;

            --radius: 4px;
        }


        /* =========================================================
           BACKGROUND GRAPHICS
        ========================================================= */

        .background-glow {
            position: fixed;

            width: 430px;
            height: 430px;

            right: -170px;
            top: -190px;

            border-radius: 50%;

            background:
                    radial-gradient(
                            circle,
                            rgba(99, 91, 255, 0.14),
                            transparent 68%
                    );

            pointer-events: none;
            z-index: 0;
        }

        .background-glow::after {
            content: "";

            position: absolute;

            width: 250px;
            height: 250px;

            left: -500px;
            top: 450px;

            border-radius: 50%;

            background:
                    radial-gradient(
                            circle,
                            rgba(59, 130, 246, 0.08),
                            transparent 70%
                    );
        }

        [data-theme="dark"] .background-glow {
            background:
                    radial-gradient(
                            circle,
                            rgba(129, 120, 255, 0.12),
                            transparent 68%
                    );
        }

        [data-theme="nothing"] .background-glow {
            display: none;
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
                            rgba(255, 255, 255, 0.035) 1px,
                            transparent 1px
                    ),
                    linear-gradient(
                            90deg,
                            rgba(255, 255, 255, 0.035) 1px,
                            transparent 1px
                    );

            background-size: 32px 32px;

            z-index: 0;
        }

        [data-theme="nothing"] .nothing-grid {
            opacity: 1;
        }


        /* =========================================================
           NAVBAR
        ========================================================= */

        .navbar {
            position: relative;
            z-index: 20;

            height: 64px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 5.5%;

            border-bottom: 1px solid var(--border);

            background: var(--bg);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;

            font-size: 13px;
            font-weight: 800;

            letter-spacing: -0.25px;
        }

        .brand-dot {
            width: 8px;
            height: 8px;

            border-radius: 50%;

            background: var(--accent);

            box-shadow:
                    0 0 14px
                    color-mix(
                            in srgb,
                            var(--accent) 55%,
                            transparent
                    );
        }

        [data-theme="nothing"] .brand-dot {
            border-radius: 0;
            box-shadow: none;
        }


        /* =========================================================
           NAV RIGHT
        ========================================================= */

        .nav-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }


        /* =========================================================
           THEME SWITCHER
        ========================================================= */

        .theme-switcher {
            position: relative;

            width: 171px;
            height: 36px;

            display: flex;
            align-items: center;

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
            height: 28px;

            border-radius: 999px;

            background: var(--accent);

            transition:
                    transform 0.25s
                    cubic-bezier(.4, 0, .2, 1);

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
            height: 28px;

            border: 0;
            background: transparent;

            color: var(--muted);

            font-size: 10px;
            font-weight: 700;

            cursor: pointer;

            transition: color 0.2s ease;
        }

        [data-theme="light"]
        .theme-option[data-theme-option="light"],

        [data-theme="dark"]
        .theme-option[data-theme-option="dark"],

        [data-theme="nothing"]
        .theme-option[data-theme-option="nothing"] {
            color: #ffffff;
        }


        /* =========================================================
           PROFILE
        ========================================================= */

        .profile-wrapper {
            position: relative;
        }

        .profile-button {
            width: 36px;
            height: 36px;

            display: flex;
            align-items: center;
            justify-content: center;

            border: 1px solid var(--border);
            border-radius: 50%;

            background: var(--surface);
            color: var(--text);

            font-size: 11px;
            font-weight: 800;

            cursor: pointer;

            transition:
                    transform 0.2s ease,
                    border-color 0.2s ease;
        }

        .profile-button:hover {
            transform: translateY(-1px);
            border-color: var(--border-strong);
        }

        [data-theme="nothing"] .profile-button {
            border-radius: 3px;
            color: var(--accent);
        }

        .profile-menu {
            position: absolute;

            top: calc(100% + 10px);
            right: 0;

            width: 220px;

            padding: 8px;

            border: 1px solid var(--border);
            border-radius: 14px;

            background: var(--surface);
            box-shadow: var(--shadow);

            opacity: 0;
            visibility: hidden;

            transform:
                    translateY(-6px)
                    scale(0.98);

            transition:
                    opacity 0.18s ease,
                    visibility 0.18s ease,
                    transform 0.18s ease;
        }

        .profile-wrapper.open .profile-menu {
            opacity: 1;
            visibility: visible;

            transform:
                    translateY(0)
                    scale(1);
        }

        [data-theme="nothing"] .profile-menu {
            border-radius: 3px;
            box-shadow: none;
        }

        .profile-header {
            padding: 10px 11px;

            border-bottom: 1px solid var(--border);

            margin-bottom: 5px;
        }

        .profile-name {
            font-size: 12px;
            font-weight: 800;

            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .profile-meta {
            margin-top: 3px;

            font-size: 9px;
            color: var(--muted);
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 9px;

            width: 100%;

            padding: 9px 10px;

            border-radius: 8px;

            color: var(--text);

            font-size: 11px;
            font-weight: 600;

            transition:
                    background 0.18s ease,
                    color 0.18s ease;
        }

        .menu-item:hover {
            background: var(--surface-2);
        }

        .menu-item.logout {
            color: #e25555;
        }

        [data-theme="nothing"] .menu-item {
            border-radius: 2px;
        }

        [data-theme="nothing"] .menu-item.logout {
            color: var(--accent);
        }


        /* =========================================================
           MAIN PAGE
        ========================================================= */

        .page {
            position: relative;
            z-index: 1;

            width: min(1160px, 89%);

            height: calc(100vh - 64px);

            margin: 0 auto;

            padding: 20px 0 10px;

            display: grid;

            grid-template-rows:
                    auto
                    auto
                    1fr
                    auto;

            gap: 12px;
        }


        /* =========================================================
           HERO
        ========================================================= */

        .hero {
            animation:
                    pageEnter 0.55s
                    cubic-bezier(.2, .8, .2, 1)
                    both;
        }

        @keyframes pageEnter {

            from {
                opacity: 0;
                transform: translateY(12px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .eyebrow {
            display: flex;
            align-items: center;
            gap: 7px;

            margin-bottom: 7px;

            font-size: 8px;
            font-weight: 800;

            text-transform: uppercase;
            letter-spacing: 1.5px;

            color: var(--muted);
        }

        .eyebrow-line {
            width: 20px;
            height: 2px;

            border-radius: 2px;

            background: var(--accent);
        }


        /* =========================================================
           HERO TITLE
        ========================================================= */

        .hero-title {
            display: flex;
            flex-direction: column;

            margin: 0;

            white-space: nowrap;

            font-weight: 800;

            line-height: 1;

            letter-spacing: -1.8px;
        }

        .welcome-line {
            display: block;

            font-size: clamp(27px, 2.6vw, 34px);

            color: var(--text);
        }

        .name-line {
            display: block;

            margin-top: 2px;

            font-size: clamp(31px, 3vw, 40px);

            color: var(--accent);

            letter-spacing: -2px;
        }

        [data-theme="nothing"] .name-line {
            text-transform: uppercase;
        }

        .hero-description {
            margin-top: 7px;

            font-size: 10px;
            line-height: 1.45;

            color: var(--muted);
        }


        /* =========================================================
           STUDENT CHIP
        ========================================================= */

        .student-chip {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            margin-top: 8px;

            padding: 4px 9px 4px 4px;

            border: 1px solid var(--border);
            border-radius: 999px;

            background: var(--surface);

            font-size: 9px;
            font-weight: 700;
        }

        [data-theme="nothing"] .student-chip {
            border-radius: 3px;
        }

        .student-avatar {
            width: 23px;
            height: 23px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: var(--accent);
            color: #ffffff;

            font-size: 8px;
            font-weight: 800;
        }

        [data-theme="nothing"] .student-avatar {
            border-radius: 2px;
        }

        .student-chip-meta {
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

            gap: 10px;

            animation:
                    pageEnter 0.55s
                    0.07s
                    cubic-bezier(.2, .8, .2, 1)
                    both;
        }

        .info-card {
            position: relative;

            min-height: 68px;

            padding: 11px 14px;

            border: 1px solid var(--border);
            border-radius: 12px;

            background: var(--surface);

            box-shadow: var(--shadow);

            overflow: hidden;

            transition:
                    transform 0.2s ease,
                    border-color 0.2s ease;
        }

        .info-card:hover {
            transform: translateY(-2px);
            border-color: var(--border-strong);
        }

        [data-theme="nothing"] .info-card {
            border-radius: 3px;
            box-shadow: none;
        }

        .info-card::before {
            content: "";

            position: absolute;

            left: 0;
            top: 0;

            width: 100%;
            height: 2px;

            background: var(--card-color);
        }

        .info-card:nth-child(1) {
            --card-color: var(--accent);
        }

        .info-card:nth-child(2) {
            --card-color: var(--blue);
        }

        .info-card:nth-child(3) {
            --card-color: var(--orange);
        }

        .info-card:nth-child(4) {
            --card-color: var(--green);
        }

        .info-label {
            font-size: 8px;

            text-transform: uppercase;
            letter-spacing: 1.1px;

            color: var(--muted);

            font-weight: 800;
        }

        .info-value {
            margin-top: 6px;

            font-size: 11px;
            font-weight: 700;

            color: var(--text);

            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }


        /* =========================================================
           ACTION AREA
        ========================================================= */

        .actions-area {
            min-height: 0;

            display: flex;
            flex-direction: column;
        }

        .section-heading {
            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 7px;
        }

        .section-heading h2 {
            font-size: 16px;

            letter-spacing: -0.5px;

            font-weight: 800;
        }

        .section-heading p {
            font-size: 9px;
            color: var(--muted);
        }


        /* =========================================================
           ACTION CARDS
        ========================================================= */

        .actions-grid {
            flex: 1;
            min-height: 0;

            display: grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap: 10px;

            animation:
                    pageEnter 0.55s
                    0.13s
                    cubic-bezier(.2, .8, .2, 1)
                    both;
        }

        .action-card {
            position: relative;

            min-height: 0;

            padding: 15px 18px;

            display: flex;
            flex-direction: column;
            justify-content: space-between;

            border: 1px solid var(--border);
            border-radius: 13px;

            background: var(--surface);

            box-shadow: var(--shadow);

            overflow: hidden;

            transition:
                    transform 0.2s ease,
                    border-color 0.2s ease,
                    box-shadow 0.2s ease;
        }

        .action-card::before {
            content: "";

            position: absolute;

            left: 0;
            top: 0;

            width: 4px;
            height: 100%;

            background: var(--action-color);
        }

        .action-card:nth-child(1) {
            --action-color: var(--accent);
        }

        .action-card:nth-child(2) {
            --action-color: var(--blue);
        }

        .action-card::after {
            content: "";

            position: absolute;

            width: 160px;
            height: 160px;

            right: -75px;
            bottom: -105px;

            border-radius: 50%;

            background:
                    color-mix(
                            in srgb,
                            var(--action-color) 10%,
                            transparent
                    );

            pointer-events: none;
        }

        .action-card:hover {
            transform: translateY(-3px);

            border-color:
                    color-mix(
                            in srgb,
                            var(--action-color) 45%,
                            var(--border)
                    );

            box-shadow:
                    0 14px 30px
                    color-mix(
                            in srgb,
                            var(--action-color) 9%,
                            transparent
                    );
        }

        [data-theme="nothing"] .action-card {
            border-radius: 3px;
            box-shadow: none;
        }

        [data-theme="nothing"] .action-card:hover {
            transform: none;
            border-color: var(--accent);
        }

        .action-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .action-number {
            font-size: 8px;

            font-weight: 800;

            letter-spacing: 1px;

            color: var(--action-color);
        }

        .action-mini-icon {
            width: 25px;
            height: 25px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 7px;

            background:
                    color-mix(
                            in srgb,
                            var(--action-color) 11%,
                            transparent
                    );

            color: var(--action-color);

            font-size: 12px;
            font-weight: 800;
        }

        [data-theme="nothing"] .action-mini-icon {
            border-radius: 2px;
        }

        .action-bottom {
            position: relative;
            z-index: 1;

            display: flex;

            align-items: flex-end;
            justify-content: space-between;

            gap: 20px;
        }

        .action-title {
            font-size: 17px;

            letter-spacing: -0.5px;

            font-weight: 800;
        }

        .action-description {
            max-width: 470px;

            margin-top: 5px;

            font-size: 9px;

            line-height: 1.45;

            color: var(--muted);
        }

        .action-arrow {
            width: 31px;
            height: 31px;

            flex: 0 0 31px;

            display: flex;
            align-items: center;
            justify-content: center;

            border: 1px solid var(--border);
            border-radius: 50%;

            background: var(--surface);

            color: var(--text);

            font-size: 13px;

            transition:
                    transform 0.2s ease,
                    background 0.2s ease,
                    color 0.2s ease,
                    border-color 0.2s ease;
        }

        .action-card:hover .action-arrow {
            transform: translate(2px, -2px);

            background: var(--action-color);

            border-color: var(--action-color);

            color: #ffffff;
        }

        [data-theme="nothing"] .action-arrow {
            border-radius: 2px;
            color: var(--accent);
        }


        /* =========================================================
           BOTTOM NOTE
        ========================================================= */

        .bottom-note {
            display: flex;

            align-items: center;
            justify-content: space-between;

            padding-top: 6px;

            border-top: 1px solid var(--border);

            color: var(--muted);

            font-size: 8px;
        }


        /* =========================================================
           DESKTOP — FORCE ONE SCREEN
        ========================================================= */

        @media (min-width: 851px) {

            html,
            body {
                height: 100vh;
                min-height: 100vh;

                overflow: hidden;
            }

            .page {
                height: calc(100vh - 64px);

                overflow: hidden;
            }
        }


        /* =========================================================
           SMALL LAPTOP
        ========================================================= */

        @media
        (min-width: 851px)
        and (max-height: 760px) {

            .navbar {
                height: 58px;
            }

            .page {
                height: calc(100vh - 58px);

                padding-top: 13px;
                padding-bottom: 7px;

                gap: 8px;
            }

            .welcome-line {
                font-size: 26px;
            }

            .name-line {
                font-size: 31px;
            }

            .hero-description {
                margin-top: 5px;
                font-size: 9px;
            }

            .student-chip {
                margin-top: 6px;
            }

            .info-card {
                min-height: 60px;
                padding: 9px 12px;
            }

            .info-value {
                margin-top: 4px;
                font-size: 10px;
            }

            .section-heading {
                margin-bottom: 5px;
            }

            .section-heading h2 {
                font-size: 14px;
            }

            .action-card {
                padding: 12px 15px;
            }

            .action-title {
                font-size: 15px;
            }

            .action-description {
                font-size: 8px;
            }

            .action-arrow {
                width: 27px;
                height: 27px;
                flex-basis: 27px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 850px) {

            body {
                overflow-y: auto;
            }

            .navbar {
                height: 64px;
                padding: 0 4%;
            }

            .page {
                width: 92%;
                height: auto;

                padding: 28px 0 30px;

                display: block;
            }

            .hero-title {
                white-space: normal;
            }

            .welcome-line {
                font-size: 31px;
            }

            .name-line {
                font-size: 37px;
            }

            .hero-description {
                max-width: 520px;
            }

            .info-grid {
                grid-template-columns:
                        repeat(2, 1fr);

                margin-top: 24px;
            }

            .actions-area {
                margin-top: 24px;
            }

            .actions-grid {
                grid-template-columns: 1fr;

                min-height: auto;
            }

            .action-card {
                min-height: 150px;
            }

            .bottom-note {
                margin-top: 18px;
            }
        }


        /* =========================================================
           SMALL MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .brand {
                font-size: 11px;
            }

            .theme-switcher {
                width: 140px;
            }

            .theme-option {
                font-size: 9px;
            }

            .profile-button {
                width: 34px;
                height: 34px;
            }

            .nav-right {
                gap: 7px;
            }

            .welcome-line {
                font-size: 28px;
            }

            .name-line {
                font-size: 34px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .info-card {
                min-height: 64px;
            }

            .section-heading {
                display: block;
            }

            .section-heading p {
                margin-top: 4px;
            }

            .bottom-note {
                display: block;

                line-height: 1.5;
            }
        }


        /* =========================================================
           NOTHING THEME DETAILS
        ========================================================= */

        [data-theme="nothing"] body {
            background:
                    linear-gradient(
                            rgba(255, 255, 255, 0.025) 1px,
                            transparent 1px
                    ),
                    linear-gradient(
                            90deg,
                            rgba(255, 255, 255, 0.025) 1px,
                            transparent 1px
                    ),
                    var(--bg);

            background-size: 20px 20px;
        }

        [data-theme="nothing"] .navbar {
            border-bottom: 2px solid #222222;
        }

        [data-theme="nothing"] .hero-title {
            letter-spacing: -1.5px;
        }

        [data-theme="nothing"] .welcome-line,
        [data-theme="nothing"] .name-line {
            text-transform: uppercase;
        }

        [data-theme="nothing"] .info-card::before,
        [data-theme="nothing"] .action-card::before {
            background: var(--accent);
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

                <div>

                    <%= studentName %>

                    <span class="student-chip-meta">
                        · Student
                    </span>

                </div>

            </div>

        </section>


        <!-- =====================================================
             STUDENT INFORMATION
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
             ACTION AREA
        ====================================================== -->

        <section class="actions-area">

            <div class="section-heading">

                <h2>
                    What would you like to do?
                </h2>

                <p>
                    Choose an option to continue
                </p>

            </div>


            <div class="actions-grid">


                <!-- EVENTS -->

                <a
                        href="events"
                        class="action-card"
                >

                    <div class="action-top">

                        <div class="action-number">
                            01
                        </div>

                        <div class="action-mini-icon">
                            ↗
                        </div>

                    </div>


                    <div class="action-bottom">

                        <div>

                            <div class="action-title">
                                Browse Events
                            </div>

                            <p class="action-description">
                                Explore upcoming college events,
                                workshops and activities available
                                for registration.
                            </p>

                        </div>


                        <div class="action-arrow">
                            →
                        </div>

                    </div>

                </a>


                <!-- REGISTRATIONS -->

                <a
                        href="my-registrations"
                        class="action-card"
                >

                    <div class="action-top">

                        <div class="action-number">
                            02
                        </div>

                        <div class="action-mini-icon">
                            ✓
                        </div>

                    </div>


                    <div class="action-bottom">

                        <div>

                            <div class="action-title">
                                My Registrations
                            </div>

                            <p class="action-description">
                                View the events you have registered
                                for and keep track of your
                                participation.
                            </p>

                        </div>


                        <div class="action-arrow">
                            →
                        </div>

                    </div>

                </a>


            </div>

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

        const root =
                document.documentElement;

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
                document.getElementById(
                        "profileWrapper"
                );


        const profileButton =
                document.getElementById(
                        "profileButton"
                );


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
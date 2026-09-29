<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>College Event Portal</title>

    <style>
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
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f9fc;
            color: #111827;
            overflow-x: hidden;
        }

        /* =========================
           BACKGROUND
           ========================= */

        .background {
            position: fixed;
            inset: 0;
            overflow: hidden;
            pointer-events: none;
            z-index: 0;
        }

        .glow {
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;

            background: rgba(40, 100, 232, 0.08);
            filter: blur(80px);

            animation: floatGlow 10s ease-in-out infinite alternate;
        }

        .glow.one {
            top: -220px;
            left: -180px;
        }

        .glow.two {
            right: -220px;
            bottom: -220px;

            width: 450px;
            height: 450px;

            background: rgba(99, 102, 241, 0.06);

            animation-delay: -4s;
        }

        @keyframes floatGlow {
            from {
                transform: translate(0, 0);
            }

            to {
                transform: translate(35px, 25px);
            }
        }

        /* =========================
           INTRO SCREEN
           ========================= */

        .intro {
            position: fixed;
            inset: 0;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f7f9fc;

            z-index: 20;

            animation: introExit 0.7s ease forwards;
            animation-delay: 2.1s;
        }

        .intro-title {
            margin: 0;

            font-size: clamp(30px, 5vw, 58px);
            font-weight: 700;
            letter-spacing: -1.5px;

            color: #111827;
            text-align: center;

            opacity: 0;

            animation: introEnter 0.8s ease forwards;
            animation-delay: 0.25s;
        }

        @keyframes introEnter {
            from {
                opacity: 0;
                transform: translateY(18px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes introExit {
            0% {
                opacity: 1;
                transform: scale(1);
                filter: blur(0);
            }

            100% {
                opacity: 0;
                transform: scale(0.96);
                filter: blur(7px);
                visibility: hidden;
            }
        }

        /* =========================
           MAIN CONTENT
           ========================= */

        .page {
            position: relative;
            z-index: 1;

            min-height: 100vh;

            display: flex;
            flex-direction: column;
        }

        .navbar {
            width: 100%;
            padding: 26px 7%;

            display: flex;
            align-items: center;
            justify-content: space-between;

            opacity: 0;

            animation: reveal 0.7s ease forwards;
            animation-delay: 2.45s;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 11px;

            font-size: 18px;
            font-weight: 700;

            color: #111827;
        }

        .brand-mark {
            width: 36px;
            height: 36px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: #2864e8;
            color: white;

            font-size: 13px;
            font-weight: 700;
        }

        .main {
            flex: 1;

            width: 100%;
            max-width: 1100px;

            margin: 0 auto;

            padding: 70px 30px 50px;

            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .hero {
            text-align: center;

            max-width: 760px;

            opacity: 0;

            animation: reveal 0.8s ease forwards;
            animation-delay: 2.65s;
        }

        .eyebrow {
            display: inline-block;

            margin-bottom: 18px;

            color: #2864e8;

            font-size: 13px;
            font-weight: 700;

            letter-spacing: 1.8px;
            text-transform: uppercase;
        }

        .hero h1 {
            margin: 0;

            font-size: clamp(40px, 6vw, 68px);
            line-height: 1.05;

            letter-spacing: -2.5px;

            color: #111827;
        }

        .hero p {
            margin: 22px auto 0;

            max-width: 580px;

            color: #6b7280;

            font-size: 17px;
            line-height: 1.7;
        }

        /* =========================
           ROLE CARDS
           ========================= */

        .roles {
            width: 100%;
            max-width: 850px;

            display: grid;
            grid-template-columns: repeat(2, 1fr);

            gap: 22px;

            margin-top: 55px;
        }

        .role-card {
            position: relative;

            padding: 30px;

            background: rgba(255, 255, 255, 0.9);

            border: 1px solid #e5e7eb;
            border-radius: 18px;

            text-decoration: none;
            color: inherit;

            box-shadow: 0 10px 35px rgba(17, 24, 39, 0.05);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease,
                border-color 0.25s ease;

            opacity: 0;
        }

        .student-card {
            animation:
                cardLeft 0.7s ease forwards;

            animation-delay: 2.9s;
        }

        .admin-card {
            animation:
                cardRight 0.7s ease forwards;

            animation-delay: 3.05s;
        }

        .role-card:hover {
            transform: translateY(-5px);

            box-shadow: 0 18px 45px rgba(17, 24, 39, 0.09);

            border-color: #cbd5e1;
        }

        .role-icon {
            width: 48px;
            height: 48px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            margin-bottom: 24px;

            font-size: 15px;
            font-weight: 700;
        }

        .student-icon {
            background: #eaf0ff;
            color: #2864e8;
        }

        .admin-icon {
            background: #f0f0f0;
            color: #222;
        }

        .role-card h2 {
            margin: 0 0 9px;

            font-size: 23px;
            letter-spacing: -0.5px;
        }

        .role-card p {
            margin: 0;

            color: #6b7280;

            font-size: 14px;
            line-height: 1.6;

            min-height: 45px;
        }

        .role-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            margin-top: 25px;

            font-size: 14px;
            font-weight: 700;

            color: #2864e8;
        }

        .admin-card .role-action {
            color: #222;
        }

        .arrow {
            transition: transform 0.2s ease;
        }

        .role-card:hover .arrow {
            transform: translateX(4px);
        }

        @keyframes cardLeft {
            from {
                opacity: 0;
                transform: translateX(-25px);
            }

            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes cardRight {
            from {
                opacity: 0;
                transform: translateX(25px);
            }

            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes reveal {
            from {
                opacity: 0;
                transform: translateY(15px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* =========================
           FOOTER
           ========================= */

        .footer {
            text-align: center;

            padding: 25px;

            color: #9ca3af;

            font-size: 12px;

            opacity: 0;

            animation: reveal 0.7s ease forwards;
            animation-delay: 3.25s;
        }

        /* =========================
           MOBILE
           ========================= */

        @media (max-width: 700px) {

            .navbar {
                padding: 20px 6%;
            }

            .main {
                padding: 55px 20px 35px;
            }

            .hero h1 {
                letter-spacing: -1.5px;
            }

            .hero p {
                font-size: 15px;
            }

            .roles {
                grid-template-columns: 1fr;
                margin-top: 40px;
            }

            .role-card {
                padding: 25px;
            }
        }

        /* =========================
           REDUCED MOTION
           ========================= */

        @media (prefers-reduced-motion: reduce) {

            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }

            .intro {
                display: none;
            }

            .navbar,
            .hero,
            .role-card,
            .footer {
                opacity: 1;
            }
        }
    </style>
</head>

<body>

<!-- Background -->
<div class="background">
    <div class="glow one"></div>
    <div class="glow two"></div>
</div>


<!-- Intro -->
<div class="intro" id="intro">
    <h1 class="intro-title">
        College Event Management Portal
    </h1>
</div>


<!-- Main Page -->
<div class="page">

    <!-- Navbar -->
    <header class="navbar">

        <div class="brand">
            <div class="brand-mark">
                CE
            </div>

            <span>College Event Portal</span>
        </div>

    </header>


    <!-- Main Content -->
    <main class="main">

        <section class="hero">

            <span class="eyebrow">
                College Event Management System
            </span>

            <h1>
                College Event Portal
            </h1>

            <p>
                Discover upcoming events, manage registrations,
                and organize college activities from one place.
            </p>

        </section>


        <!-- Role Selection -->
        <section class="roles">

            <!-- Student -->
            <a href="login.jsp" class="role-card student-card">

                <div class="role-icon student-icon">
                    ST
                </div>

                <h2>
                    Student Portal
                </h2>

                <p>
                    Browse upcoming college events,
                    register for events, and manage your registrations.
                </p>

                <div class="role-action">
                    Continue as Student
                    <span class="arrow">→</span>
                </div>

            </a>


            <!-- Admin -->
            <a href="admin-login.jsp" class="role-card admin-card">

                <div class="role-icon admin-icon">
                    AD
                </div>

                <h2>
                    Admin Portal
                </h2>

                <p>
                    Create, edit, and manage college events
                    through the administration portal.
                </p>

                <div class="role-action">
                    Admin Login
                    <span class="arrow">→</span>
                </div>

            </a>

        </section>

    </main>


    <!-- Footer -->
    <footer class="footer">
        College Event Management System
    </footer>

</div>


<script>
    /*
     * Intro animation:
     * Play the cinematic intro once per browser session.
     */

    const intro = document.getElementById("intro");

    if (sessionStorage.getItem("portalIntroShown") === "true") {

        intro.style.display = "none";

        document.querySelector(".navbar").style.animationDelay = "0s";
        document.querySelector(".hero").style.animationDelay = "0s";

        document.querySelector(".student-card").style.animationDelay = "0.15s";
        document.querySelector(".admin-card").style.animationDelay = "0.25s";
        document.querySelector(".footer").style.animationDelay = "0.4s";

    } else {

        sessionStorage.setItem("portalIntroShown", "true");
    }
</script>

</body>
</html>
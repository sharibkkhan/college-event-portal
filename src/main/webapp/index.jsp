<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>College Event Portal</title>

    <!-- Prevent theme flash -->
    <script>
        (function () {
            const savedTheme = localStorage.getItem("portal-theme");

            if (savedTheme) {
                document.documentElement.setAttribute(
                    "data-theme",
                    savedTheme
                );
            }
        })();
    </script>


    <style>

        /* =========================================================
           COLLEGE EVENT PORTAL
           GLOBAL DESIGN SYSTEM
           
           Themes:
           1. light
           2. dark
           3. nothing
           
           Reuse these variables on every JSP page.
           ========================================================= */


        /* =========================================================
           LIGHT THEME
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

            --danger: #dc2626;

            --shadow:
                0 12px 35px rgba(16, 24, 40, 0.06);

            --shadow-hover:
                0 20px 45px rgba(16, 24, 40, 0.10);

            --radius-xl: 22px;
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;

            --card-border-width: 1px;

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
           DARK THEME
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

            --danger: #f04438;

            --shadow:
                0 15px 40px rgba(0, 0, 0, 0.25);

            --shadow-hover:
                0 20px 50px rgba(0, 0, 0, 0.38);

            --radius-xl: 22px;
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;
        }


        /* =========================================================
           NOTHING THEME
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

            --danger: #ff3333;

            --shadow:
                none;

            --shadow-hover:
                0 0 0 1px #555555;

            --radius-xl: 4px;
            --radius-lg: 3px;
            --radius-md: 2px;
            --radius-sm: 0;

            --card-border-width: 1px;

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
            width: 100%;
            min-height: 100%;
            margin: 0;
        }

        body {

            font-family: var(--font);

            background: var(--bg);
            color: var(--text);

            overflow-x: hidden;

            transition:
                background var(--transition),
                color var(--transition);
        }

        a {
            color: inherit;
        }

        button {
            font-family: inherit;
        }


        /* =========================================================
           BACKGROUND
           ========================================================= */

        .background {

            position: fixed;
            inset: 0;

            z-index: 0;

            pointer-events: none;

            overflow: hidden;
        }


        .glow {

            position: absolute;

            width: 500px;
            height: 500px;

            border-radius: 50%;

            background:
                rgba(40, 100, 232, 0.055);

            filter: blur(90px);

            animation:
                floatingGlow 12s ease-in-out infinite alternate;
        }


        .glow.one {

            top: -250px;
            left: -200px;
        }


        .glow.two {

            right: -250px;
            bottom: -250px;

            width: 450px;
            height: 450px;

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
           NOTHING MODE GRID
           ========================================================= */

        .nothing-grid {

            position: fixed;
            inset: 0;

            z-index: 0;

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

            background-size: 45px 45px;

            transition:
                opacity var(--transition);
        }


        [data-theme="nothing"] .nothing-grid {

            opacity: 1;
        }


        /* =========================================================
           INTRO
           ========================================================= */

        .intro {

            position: fixed;
            inset: 0;

            z-index: 100;

            display: flex;

            align-items: center;
            justify-content: center;

            background: var(--bg);

            animation:
                introExit 700ms ease forwards;

            animation-delay: 2100ms;
        }


        .intro-title {

            max-width: 90%;

            margin: 0;

            text-align: center;

            font-size:
                clamp(30px, 5vw, 58px);

            line-height: 1.05;

            font-weight: 700;

            letter-spacing: -2px;

            color: var(--text);

            opacity: 0;

            animation:
                introEnter 800ms ease forwards;

            animation-delay: 250ms;
        }


        [data-theme="nothing"] .intro-title {

            text-transform: uppercase;

            letter-spacing: 2px;

            font-weight: 600;
        }


        @keyframes introEnter {

            from {

                opacity: 0;

                transform:
                    translateY(18px);
            }

            to {

                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        @keyframes introExit {

            from {

                opacity: 1;

                transform:
                    scale(1);

                filter:
                    blur(0);
            }

            to {

                opacity: 0;

                transform:
                    scale(0.96);

                filter:
                    blur(7px);

                visibility:
                    hidden;
            }
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

            padding:
                25px 7%;

            display: flex;

            align-items: center;

            justify-content: space-between;

            opacity: 0;

            animation:
                reveal 700ms ease forwards;

            animation-delay: 2450ms;
        }


        .brand {

            font-size: 18px;

            font-weight: 700;

            letter-spacing:
                -0.4px;

            color: var(--text);
        }


        [data-theme="nothing"] .brand {

            font-family:
                "Arial Narrow",
                Arial,
                sans-serif;

            text-transform:
                uppercase;

            letter-spacing:
                1.5px;
        }


        /* =========================================================
           THREE-WAY THEME SLIDER
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

            background: var(--surface);

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

            background: var(--accent-soft);

            border:
                1px solid var(--border);

            transition:
                transform 300ms cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                );

            pointer-events: none;
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

            color: var(--text-muted);

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

            width: 100%;

            max-width:
                1080px;

            margin:
                0 auto;

            padding:
                70px 30px 50px;

            display:
                flex;

            flex-direction:
                column;

            align-items:
                center;
        }


        /* =========================================================
           HERO
           ========================================================= */

        .hero {

            max-width:
                760px;

            text-align:
                center;

            opacity: 0;

            animation:
                reveal 800ms ease forwards;

            animation-delay:
                2650ms;
        }


        .eyebrow {

            display:
                inline-block;

            margin-bottom:
                18px;

            color:
                var(--accent);

            font-size:
                12px;

            font-weight:
                700;

            letter-spacing:
                1.8px;

            text-transform:
                uppercase;
        }


        .hero h1 {

            margin:
                0;

            font-size:
                clamp(42px, 6vw, 68px);

            line-height:
                1.05;

            letter-spacing:
                -3px;
        }


        [data-theme="nothing"]
        .hero h1 {

            text-transform:
                uppercase;

            letter-spacing:
                -1px;
        }


        .hero p {

            max-width:
                590px;

            margin:
                22px auto 0;

            color:
                var(--text-secondary);

            font-size:
                17px;

            line-height:
                1.7;
        }


        /* =========================================================
           ROLE CARDS
           ========================================================= */

        .roles {

            width:
                100%;

            max-width:
                850px;

            display:
                grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap:
                20px;

            margin-top:
                55px;
        }


        .role-card {

            position:
                relative;

            padding:
                32px;

            background:
                var(--surface);

            border:
                var(--card-border-width)
                solid
                var(--border);

            border-radius:
                var(--radius-xl);

            color:
                var(--text);

            text-decoration:
                none;

            box-shadow:
                var(--shadow);

            transition:
                transform var(--transition),
                background var(--transition),
                border-color var(--transition),
                box-shadow var(--transition);

            opacity:
                0;
        }


        .role-card:hover {

            transform:
                translateY(-5px);

            background:
                var(--surface-hover);

            border-color:
                var(--border-hover);

            box-shadow:
                var(--shadow-hover);
        }


        .student-card {

            animation:
                cardLeft
                700ms
                ease
                forwards;

            animation-delay:
                2900ms;
        }


        .admin-card {

            animation:
                cardRight
                700ms
                ease
                forwards;

            animation-delay:
                3050ms;
        }


        .role-card h2 {

            margin:
                0 0 10px;

            font-size:
                24px;

            letter-spacing:
                -0.7px;
        }


        .role-card p {

            margin:
                0;

            min-height:
                46px;

            color:
                var(--text-secondary);

            font-size:
                14px;

            line-height:
                1.65;
        }


        .role-action {

            display:
                inline-flex;

            align-items:
                center;

            gap:
                8px;

            margin-top:
                27px;

            color:
                var(--accent);

            font-size:
                14px;

            font-weight:
                700;
        }


        .arrow {

            transition:
                transform var(--transition);
        }


        .role-card:hover
        .arrow {

            transform:
                translateX(5px);
        }


        /* =========================================================
           NOTHING CARD OVERRIDES
           ========================================================= */

        [data-theme="nothing"]
        .role-card {

            border-radius:
                2px;

            box-shadow:
                none;

            background:
                rgba(8, 8, 8, 0.92);
        }


        [data-theme="nothing"]
        .role-card:hover {

            transform:
                translateY(-2px);

            border-color:
                #777;

            box-shadow:
                0 0 0 1px #222;
        }


        [data-theme="nothing"]
        .role-card h2 {

            text-transform:
                uppercase;

            letter-spacing:
                1px;
        }


        [data-theme="nothing"]
        .role-action {

            text-transform:
                uppercase;

            letter-spacing:
                0.8px;
        }


        /* =========================================================
           NOTHING CARD INDEX
           ========================================================= */

        .card-index {

            margin-bottom:
                35px;

            color:
                var(--text-muted);

            font-size:
                11px;

            font-weight:
                700;

            letter-spacing:
                1.5px;
        }


        [data-theme="nothing"]
        .card-index {

            color:
                var(--accent);
        }


        /* =========================================================
           ANIMATIONS
           ========================================================= */

        @keyframes reveal {

            from {

                opacity:
                    0;

                transform:
                    translateY(15px);
            }

            to {

                opacity:
                    1;

                transform:
                    translateY(0);
            }
        }


        @keyframes cardLeft {

            from {

                opacity:
                    0;

                transform:
                    translateX(-25px);
            }

            to {

                opacity:
                    1;

                transform:
                    translateX(0);
            }
        }


        @keyframes cardRight {

            from {

                opacity:
                    0;

                transform:
                    translateX(25px);
            }

            to {

                opacity:
                    1;

                transform:
                    translateX(0);
            }
        }


        /* =========================================================
           FOOTER
           ========================================================= */

        .footer {

            padding:
                25px;

            text-align:
                center;

            color:
                var(--text-muted);

            font-size:
                12px;

            opacity:
                0;

            animation:
                reveal
                700ms
                ease
                forwards;

            animation-delay:
                3250ms;
        }


        [data-theme="nothing"]
        .footer {

            text-transform:
                uppercase;

            letter-spacing:
                1px;
        }


        /* =========================================================
           MOBILE
           ========================================================= */

        @media (max-width: 700px) {

            .navbar {

                padding:
                    20px 6%;

                gap:
                    15px;
            }


            .brand {

                font-size:
                    16px;
            }


            .theme-switcher {

                width:
                    195px;

                height:
                    40px;
            }


            .theme-option {

                font-size:
                    10px;
            }


            .main {

                padding:
                    55px 20px 35px;
            }


            .hero h1 {

                letter-spacing:
                    -1.8px;
            }


            .hero p {

                font-size:
                    15px;
            }


            .roles {

                grid-template-columns:
                    1fr;

                margin-top:
                    40px;
            }


            .role-card {

                padding:
                    27px;
            }
        }


        /* =========================================================
           SMALL MOBILE
           ========================================================= */

        @media (max-width: 430px) {

            .navbar {

                align-items:
                    flex-start;

                flex-direction:
                    column;
            }


            .theme-switcher {

                width:
                    100%;
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

                animation-iteration-count:
                    1 !important;

                transition-duration:
                    1ms !important;
            }


            .intro {

                display:
                    none;
            }


            .navbar,
            .hero,
            .role-card,
            .footer {

                opacity:
                    1;
            }
        }

    </style>

</head>


<body>


    <!-- =========================================================
         BACKGROUND
         ========================================================= -->

    <div class="background">

        <div class="glow one"></div>

        <div class="glow two"></div>

    </div>


    <!-- Nothing-style grid -->

    <div class="nothing-grid"></div>


    <!-- =========================================================
         INTRO
         ========================================================= -->

    <div class="intro" id="intro">

        <h1 class="intro-title">
            College Event Management Portal
        </h1>

    </div>


    <!-- =========================================================
         APPLICATION
         ========================================================= -->

    <div class="page">


        <!-- =====================================================
             NAVIGATION
             ===================================================== -->

        <header class="navbar">


            <div class="brand">
                College Event Portal
            </div>


            <!-- THREE-WAY THEME SLIDER -->

            <div
                class="theme-switcher"
                role="group"
                aria-label="Choose appearance">


                <!-- Sliding indicator -->

                <div
                    class="theme-slider"
                    id="themeSlider">
                </div>


                <!-- Light -->

                <button
                    class="theme-option"
                    type="button"
                    data-theme-option="light">

                    ☀ Light

                </button>


                <!-- Dark -->

                <button
                    class="theme-option"
                    type="button"
                    data-theme-option="dark">

                    ◐ Dark

                </button>


                <!-- Nothing -->

                <button
                    class="theme-option"
                    type="button"
                    data-theme-option="nothing">

                    ◉ Nothing

                </button>


            </div>


        </header>


        <!-- =====================================================
             MAIN
             ===================================================== -->

        <main class="main">


            <!-- HERO -->

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


            <!-- =================================================
                 ROLE SELECTION
                 ================================================= -->

            <section class="roles">


                <!-- STUDENT -->

                <a
                    href="login.jsp"
                    class="role-card student-card">


                    <div class="card-index">
                        01 / STUDENT
                    </div>


                    <h2>
                        Student Portal
                    </h2>


                    <p>
                        Browse upcoming college events,
                        register for events, and manage
                        your registrations.
                    </p>


                    <div class="role-action">

                        Continue as Student

                        <span class="arrow">
                            →
                        </span>

                    </div>


                </a>


                <!-- ADMIN -->

                <a
                    href="admin-login.jsp"
                    class="role-card admin-card">


                    <div class="card-index">
                        02 / ADMIN
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

                        <span class="arrow">
                            →
                        </span>

                    </div>


                </a>


            </section>


        </main>


        <!-- =====================================================
             FOOTER
             ===================================================== -->

        <footer class="footer">

            College Event Management System

        </footer>


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


        /*
         * Available themes.
         *
         * Keep these names identical across
         * the rest of the project.
         */

        const themes = [
            "light",
            "dark",
            "nothing"
        ];


        /*
         * Apply theme.
         */

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


        /*
         * Update active button.
         */

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


        /*
         * Clicking a theme option.
         */

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


        /*
         * Initialize theme.
         */

        const savedTheme =
            localStorage.getItem(
                "portal-theme"
            );


        if (savedTheme &&
            themes.includes(savedTheme)) {

            setTheme(savedTheme);

        } else {

            setTheme("light");

        }


        /* =====================================================
           INTRO
           ===================================================== */

        const intro =
            document.getElementById(
                "intro"
            );


        /*
         * Intro plays once per browser session.
         */

        if (
            sessionStorage.getItem(
                "portalIntroShown"
            ) === "true"
        ) {


            intro.style.display =
                "none";


            document.querySelector(
                ".navbar"
            ).style.animationDelay =
                "0ms";


            document.querySelector(
                ".hero"
            ).style.animationDelay =
                "0ms";


            document.querySelector(
                ".student-card"
            ).style.animationDelay =
                "150ms";


            document.querySelector(
                ".admin-card"
            ).style.animationDelay =
                "250ms";


            document.querySelector(
                ".footer"
            ).style.animationDelay =
                "400ms";

        } else {


            sessionStorage.setItem(
                "portalIntroShown",
                "true"
            );

        }

    </script>


</body>

</html>
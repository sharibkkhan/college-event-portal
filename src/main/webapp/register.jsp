<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Registration | College Event Portal</title>

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
           DESIGN SYSTEM
           ========================================================= */

        :root {
            --bg: #f7f9fc;
            --surface: #ffffff;
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

            --radius-xl: 22px;
            --radius-md: 12px;

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
           DARK MODE
           ========================================================= */

        [data-theme="dark"] {
            --bg: #0b0d10;
            --surface: #111418;
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
        }


        /* =========================================================
           NOTHING MODE
           ========================================================= */

        [data-theme="nothing"] {
            --bg: #050505;
            --surface: #0b0b0b;

            --text: #ffffff;
            --text-secondary: #a1a1a1;
            --text-muted: #666666;

            --border: #333333;
            --border-hover: #666666;

            --accent: #ff3333;
            --accent-hover: #ff5555;
            --accent-soft: #241010;

            --danger: #ff3333;

            --shadow: none;

            --radius-xl: 3px;
            --radius-md: 2px;

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
        input {
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

            color: var(--text-secondary);

            text-decoration: none;

            font-size: 13px;
            font-weight: 600;

            transition:
                color 180ms ease;
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

            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 999px;

            box-shadow: var(--shadow);
        }

        .theme-slider {
            position: absolute;

            top: 4px;
            left: 4px;

            width:
                calc((100% - 8px) / 3);

            height:
                calc(100% - 8px);

            border-radius: 999px;

            background: var(--accent-soft);

            border: 1px solid var(--border);

            pointer-events: none;

            transition:
                transform 300ms
                cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                );
        }

        [data-theme="dark"] .theme-slider {
            transform: translateX(100%);
        }

        [data-theme="nothing"] .theme-slider {
            transform: translateX(200%);
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

            letter-spacing: 0.4px;

            transition:
                color 180ms ease;
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

        [data-theme="nothing"] .theme-switcher {
            border-radius: 2px;

            box-shadow: none;

            background: #080808;
        }

        [data-theme="nothing"] .theme-slider {
            border-radius: 0;

            background: #171717;

            border-color: #555;

            box-shadow:
                inset 3px 0 #ff3333;
        }

        [data-theme="nothing"] .theme-option {
            text-transform: uppercase;

            letter-spacing: 0.8px;
        }


        /* =========================================================
           MAIN
           ========================================================= */

        .main {
            flex: 1;

            display: flex;

            justify-content: center;
            align-items: center;

            padding:
                30px 20px 65px;
        }


        /* =========================================================
           REGISTRATION CARD
           ========================================================= */

        .container {
            width: 100%;

            max-width: 520px;

            padding: 38px;

            background: var(--surface);

            border:
                1px solid var(--border);

            border-radius:
                var(--radius-xl);

            box-shadow:
                var(--shadow);

            animation:
                registerEnter 700ms
                cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                )
                forwards;
        }

        @keyframes registerEnter {
            from {
                opacity: 0;

                transform:
                    translateY(25px)
                    scale(0.98);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0)
                    scale(1);
            }
        }


        /* =========================================================
           HEADER
           ========================================================= */

        .header {
            margin-bottom: 28px;
        }

        .eyebrow {
            display: block;

            margin-bottom: 10px;

            color: var(--accent);

            font-size: 11px;
            font-weight: 700;

            letter-spacing: 1.8px;

            text-transform: uppercase;
        }

        h1 {
            margin: 0;

            font-size: 34px;

            line-height: 1.1;

            letter-spacing: -1.5px;
        }

        .subtitle {
            margin:
                10px 0 0;

            color:
                var(--text-secondary);

            font-size: 14px;

            line-height: 1.6;
        }

        [data-theme="nothing"] h1 {
            text-transform: uppercase;

            letter-spacing: -0.5px;
        }


        /* =========================================================
           ERROR
           ========================================================= */

        .error {
            margin-bottom: 20px;

            padding: 12px 14px;

            border:
                1px solid
                color-mix(
                    in srgb,
                    var(--danger) 35%,
                    var(--border)
                );

            border-radius:
                var(--radius-md);

            background:
                color-mix(
                    in srgb,
                    var(--danger) 8%,
                    var(--surface)
                );

            color:
                var(--danger);

            font-size: 13px;

            line-height: 1.4;
        }


        /* =========================================================
           FORM GRID
           ========================================================= */

        .form-grid {
            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap:
                0 16px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .full {
            grid-column:
                1 / -1;
        }

        label {
            display: block;

            margin-bottom: 8px;

            color:
                var(--text);

            font-size: 13px;

            font-weight: 650;
        }


        /* =========================================================
           INPUTS
           ========================================================= */

        input {
            width: 100%;

            height: 48px;

            padding:
                0 14px;

            border:
                1px solid
                var(--border);

            border-radius:
                var(--radius-md);

            outline: none;

            background:
                var(--surface);

            color:
                var(--text);

            font-size: 14px;

            transition:
                border-color 180ms ease,
                box-shadow 180ms ease,
                background 250ms ease;
        }

        input::placeholder {
            color:
                var(--text-muted);
        }

        input:hover {
            border-color:
                var(--border-hover);
        }

        input:focus {
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


        /* =========================================================
           REGISTER BUTTON
           ========================================================= */

        button[type="submit"] {
            width: 100%;

            height: 48px;

            margin-top: 5px;

            border: none;

            border-radius:
                var(--radius-md);

            background:
                var(--accent);

            color: #ffffff;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;

            transition:
                background 180ms ease,
                transform 180ms ease,
                box-shadow 180ms ease;
        }

        button[type="submit"]:hover {
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

        button[type="submit"]:active {
            transform:
                translateY(0);
        }


        /* =========================================================
           LOGIN LINK
           ========================================================= */

        .login-link {
            margin-top: 24px;

            padding-top: 22px;

            border-top:
                1px solid
                var(--border);

            text-align: center;

            color:
                var(--text-secondary);

            font-size: 13px;
        }

        .login-link a {
            color:
                var(--accent);

            font-weight: 700;

            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration:
                underline;
        }


        /* =========================================================
           NOTHING MODE
           ========================================================= */

        [data-theme="nothing"] .container {
            border-radius: 2px;

            box-shadow: none;

            background:
                rgba(8, 8, 8, 0.94);
        }

        [data-theme="nothing"] input {
            border-radius: 0;

            background: #080808;
        }

        [data-theme="nothing"]
        button[type="submit"] {
            border-radius: 0;

            text-transform: uppercase;

            letter-spacing: 1px;
        }

        [data-theme="nothing"] .login-link {
            border-color: #333;
        }


        /* =========================================================
           FOOTER
           ========================================================= */

        .footer {
            padding: 20px;

            text-align: center;

            color:
                var(--text-muted);

            font-size: 11px;
        }

        [data-theme="nothing"] .footer {
            text-transform: uppercase;

            letter-spacing: 1px;
        }


        /* =========================================================
           MOBILE
           ========================================================= */

        @media (max-width: 700px) {

            .navbar {
                padding:
                    20px 6%;

                flex-wrap: wrap;

                gap: 18px;
            }

            .theme-switcher {
                order: 3;

                width: 100%;
            }

            .main {
                padding:
                    25px 18px 50px;
            }

            .container {
                padding:
                    30px 24px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full {
                grid-column: auto;
            }

            h1 {
                font-size: 30px;
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


    <!-- BACKGROUND -->

    <div class="background">

        <div class="glow one"></div>

        <div class="glow two"></div>

    </div>

    <div class="nothing-grid"></div>


    <div class="page">


        <!-- =====================================================
             NAVBAR
             ===================================================== -->

        <header class="navbar">


            <a
                href="index.jsp"
                class="back-link">

                ← Back

            </a>


            <!-- THEME SWITCH -->

            <div
                class="theme-switcher"
                role="group"
                aria-label="Choose appearance">


                <div
                    class="theme-slider">
                </div>


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


            <div class="brand">
                College Event Portal
            </div>


        </header>


        <!-- =====================================================
             MAIN
             ===================================================== -->

        <main class="main">


            <section class="container">


                <!-- HEADER -->

                <div class="header">

                    <span class="eyebrow">
                        Student Portal
                    </span>

                    <h1>
                        Create your account.
                    </h1>

                    <p class="subtitle">
                        Register to discover events,
                        manage registrations, and stay
                        connected with your college.
                    </p>

                </div>


                <!-- =================================================
                     EXISTING ERROR HANDLING
                     ================================================= -->

                <%

                    if (
                        "registration_failed"
                        .equals(
                            request.getParameter("error")
                        )
                    ) {

                %>

                    <div class="error">

                        Registration failed.
                        Email may already exist.

                    </div>

                <%

                    }

                %>


                <!-- =================================================
                     REGISTRATION FORM

                     BACKEND CONTRACT UNCHANGED
                     ================================================= -->

                <form
                    action="register"
                    method="post">


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
                                placeholder="Enter your full name"
                                autocomplete="name"
                                required>

                        </div>


                        <!-- EMAIL -->

                        <div class="form-group full">

                            <label for="email">
                                Email
                            </label>

                            <input
                                id="email"
                                type="email"
                                name="email"
                                placeholder="you@example.com"
                                autocomplete="email"
                                required>

                        </div>


                        <!-- PASSWORD -->

                        <div class="form-group">

                            <label for="password">
                                Password
                            </label>

                            <input
                                id="password"
                                type="password"
                                name="password"
                                placeholder="Create a password"
                                autocomplete="new-password"
                                required>

                        </div>


                        <!-- PHONE -->

                        <div class="form-group">

                            <label for="phone">
                                Phone
                            </label>

                            <input
                                id="phone"
                                type="tel"
                                name="phone"
                                placeholder="Enter phone number"
                                autocomplete="tel"
                                required>

                        </div>


                        <!-- DEPARTMENT -->

                        <div class="form-group full">

                            <label for="department">
                                Department
                            </label>

                            <input
                                id="department"
                                type="text"
                                name="department"
                                placeholder="e.g. CSE"
                                autocomplete="organization-title"
                                required>

                        </div>


                    </div>


                    <button
                        type="submit">

                        Create Account

                    </button>


                </form>


                <!-- LOGIN LINK -->

                <div class="login-link">

                    Already have an account?

                    <a href="login.jsp">
                        Login
                    </a>

                </div>


            </section>


        </main>


        <!-- FOOTER -->

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
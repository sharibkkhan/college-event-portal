<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Login | College Event Portal</title>

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
           GLOBAL DESIGN SYSTEM
           Same system used by index.jsp
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

            animation-delay:
                -5s;
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

            padding:
                25px 7%;

            display: flex;

            align-items: center;

            justify-content: space-between;

            animation:
                reveal 650ms ease forwards;
        }


        .brand {

            font-size: 18px;

            font-weight: 700;

            letter-spacing:
                -0.4px;
        }


        [data-theme="nothing"] .brand {

            text-transform: uppercase;

            letter-spacing:
                1.5px;
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
           LOGIN AREA
           ========================================================= */

        .main {

            flex: 1;

            display: flex;

            justify-content: center;

            align-items: center;

            padding:
                45px 20px 70px;
        }


        .login-container {

            width: 100%;

            max-width: 430px;

            padding: 38px;

            background:
                var(--surface);

            border:
                1px solid var(--border);

            border-radius:
                var(--radius-xl);

            box-shadow:
                var(--shadow);

            animation:
                loginEnter 700ms
                cubic-bezier(
                    0.22,
                    1,
                    0.36,
                    1
                )
                forwards;
        }


        @keyframes loginEnter {

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
           LOGIN HEADER
           ========================================================= */

        .login-header {

            margin-bottom:
                30px;
        }


        .eyebrow {

            display: block;

            margin-bottom:
                10px;

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

            margin:
                0;

            font-size:
                34px;

            line-height:
                1.1;

            letter-spacing:
                -1.5px;
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
           ERROR MESSAGE
           ========================================================= */

        .message {

            margin-bottom:
                20px;

            padding:
                12px 14px;

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

            font-size:
                13px;

            line-height:
                1.4;
        }


        /* =========================================================
           FORM
           ========================================================= */

        .form-group {

            margin-bottom:
                19px;
        }


        label {

            display:
                block;

            margin-bottom:
                8px;

            color:
                var(--text);

            font-size:
                13px;

            font-weight:
                650;
        }


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

            outline:
                none;

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
           LOGIN BUTTON
           ========================================================= */

        .login-button {

            width: 100%;

            height: 48px;

            margin-top:
                5px;

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


        .login-button:hover {

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


        .login-button:active {
            transform:
                translateY(0);
        }


        /* =========================================================
           REGISTER
           ========================================================= */

        .register-link {

            margin-top:
                24px;

            padding-top:
                22px;

            border-top:
                1px solid
                var(--border);

            text-align:
                center;

            color:
                var(--text-secondary);

            font-size:
                13px;
        }


        .register-link a {

            color:
                var(--accent);

            font-weight:
                700;

            text-decoration:
                none;
        }


        .register-link a:hover {
            text-decoration:
                underline;
        }


        /* =========================================================
           NOTHING MODE
           ========================================================= */

        [data-theme="nothing"]
        .login-container {

            border-radius:
                2px;

            box-shadow:
                none;

            background:
                rgba(8, 8, 8, 0.94);
        }


        [data-theme="nothing"]
        input {

            border-radius:
                0;

            background:
                #080808;
        }


        [data-theme="nothing"]
        .login-button {

            border-radius:
                0;

            text-transform:
                uppercase;

            letter-spacing:
                1px;
        }


        [data-theme="nothing"]
        .register-link {

            border-color:
                #333;
        }


        /* =========================================================
           FOOTER
           ========================================================= */

        .footer {

            padding:
                20px;

            text-align:
                center;

            color:
                var(--text-muted);

            font-size:
                11px;
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

                flex-wrap:
                    wrap;

                gap:
                    18px;
            }


            .theme-switcher {

                order: 3;

                width: 100%;
            }


            .main {

                padding:
                    30px 18px 50px;
            }


            .login-container {

                padding:
                    30px 24px;
            }


            h1 {

                font-size:
                    30px;
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


    <!-- =========================================================
         BACKGROUND
         ========================================================= -->

    <div class="background">

        <div class="glow one"></div>

        <div class="glow two"></div>

    </div>


    <div class="nothing-grid"></div>


    <!-- =========================================================
         PAGE
         ========================================================= -->

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


            <!-- THREE WAY THEME SWITCH -->

            <div
                class="theme-switcher"
                role="group"
                aria-label="Choose appearance">


                <div
                    class="theme-slider"
                    id="themeSlider">
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


            <section class="login-container">


                <!-- HEADER -->

                <div class="login-header">

                    <span class="eyebrow">
                        Student Portal
                    </span>

                    <h1>
                        Welcome back.
                    </h1>

                    <p class="subtitle">
                        Sign in to access your events,
                        registrations, and student dashboard.
                    </p>

                </div>


                <!-- =================================================
                     EXISTING ERROR HANDLING
                     ================================================= -->

                <%

                    String error =
                        request.getParameter("error");

                    if ("invalid".equals(error)) {

                %>

                    <div class="message">

                        Invalid email or password.

                    </div>

                <%

                    }

                %>


                <!-- =================================================
                     LOGIN FORM

                     BACKEND CONTRACT UNCHANGED
                     ================================================= -->

                <form
                    action="login"
                    method="post">


                    <div class="form-group">

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


                    <div class="form-group">

                        <label for="password">
                            Password
                        </label>

                        <input
                            id="password"
                            type="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>

                    </div>


                    <button
                        type="submit"
                        class="login-button">

                        Login

                    </button>


                </form>


                <!-- REGISTER -->

                <div class="register-link">

                    Don't have an account?

                    <a href="register.jsp">
                        Register
                    </a>

                </div>


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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Feri's Pro</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            animation: fadeIn 1.2s ease-out;
        }
        .card {
            background: rgba(255, 255, 255, 0.10);
            padding: 40px;
            border-radius: 20px;
            text-align: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        .title {
            font-size: 35px;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .subtitle {
            font-size: 20px;
            opacity: 0.8;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="card">
    <div class="title">🔥 Feri's Super Web App 🔥</div>
    <div class="subtitle"><%= request.getAttribute("message") %></div>
    <p style="margin-top:20px;font-size:14px;opacity:0.8;">Powered by Maven WAR + Jenkins</p>
</div>
</body>
</html>

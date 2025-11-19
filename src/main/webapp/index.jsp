<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Feri Pro Dashboard</title>
<style>
:root {
    --bg-primary: #0f172a;
    --bg-secondary: #1e293b;
    --accent: #6366f1;
    --accent-glow: rgba(99, 102, 241, 0.5);
    --text-main: #f8fafc;
    --text-dim: #94a3b8;
    --glass: rgba(255, 255, 255, 0.05);
    --glass-border: rgba(255, 255, 255, 0.1);
    --success: #10b981;
    --danger: #ef4444;
    --warning: #f59e0b;
}
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    outline: none;
    font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}
body {
    background-color: var(--bg-primary);
    color: var(--text-main);
    height: 100vh;
    overflow: hidden;
    display: flex;
}
#bg-canvas {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 0;
}
.app-container {
    position: relative;
    z-index: 1;
    display: flex;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle at top right, rgba(99, 102, 241, 0.15), transparent 40%);
}
.sidebar {
    width: 260px;
    background: var(--glass);
    backdrop-filter: blur(12px);
    border-right: 1px solid var(--glass-border);
    display: flex;
    flex-direction: column;
    padding: 20px;
    transition: transform 0.3s ease;
}
.logo-area {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 40px;
    padding-bottom: 20px;
    border-bottom: 1px solid var(--glass-border);
}
.logo-icon {
    width: 40px;
    height: 40px;
    background: linear-gradient(135deg, var(--accent), #a855f7);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 20px;
    box-shadow: 0 0 15px var(--accent-glow);
}
.logo-text {
    font-size: 22px;
    font-weight: 700;
    background: linear-gradient(to right, #fff, #94a3b8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
.nav-menu {
    display: flex;
    flex-direction: column;
    gap: 8px;
    flex: 1;
}
.nav-item {
    padding: 12px 16px;
    border-radius: 8px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 12px;
    color: var(--text-dim);
    transition: all 0.2s;
    font-size: 14px;
    font-weight: 500;
}
.nav-item:hover {
    background: rgba(255, 255, 255, 0.05);
    color: var(--text-main);
}
.nav-item.active {
    background: linear-gradient(90deg, rgba(99, 102, 241, 0.2), transparent);
    border-left: 3px solid var(--accent);
    color: var(--text-main);
}
.nav-icon {
    width: 20px;
    height: 20px;
    fill: currentColor;
}
.server-status {
    margin-top: auto;
    background: rgba(0, 0, 0, 0.2);
    padding: 15px;
    border-radius: 10px;
    border: 1px solid var(--glass-border);
}
.status-header {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    margin-bottom: 8px;
    color: var(--text-dim);
}
.status-indicator {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: var(--success);
    box-shadow: 0 0 8px var(--success);
    animation: pulse 2s infinite;
}
.main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}
.top-bar {
    height: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 30px;
    border-bottom: 1px solid var(--glass-border);
    background: rgba(15, 23, 42, 0.6);
    backdrop-filter: blur(5px);
}
.search-box {
    position: relative;
    width: 300px;
}
.search-input {
    width: 100%;
    background: var(--bg-secondary);
    border: 1px solid var(--glass-border);
    padding: 10px 15px 10px 40px;
    border-radius: 20px;
    color: var(--text-main);
    font-size: 14px;
    transition: all 0.3s;
}
.search-input:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2);
}
.search-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-dim);
}
.user-profile {
    display: flex;
    align-items: center;
    gap: 15px;
}
.notification-bell {
    position: relative;
    cursor: pointer;
}
.badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background: var(--danger);
    color: white;
    font-size: 10px;
    width: 16px;
    height: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
}
.avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="%236366f1"/><circle cx="50" cy="40" r="20" fill="white"/><path d="M20 90 Q50 60 80 90" fill="white"/></svg>');
    border: 2px solid var(--glass-border);
}
.content-area {
    padding: 30px;
    overflow-y: auto;
    flex: 1;
}
.page-section {
    display: none;
    animation: fadeIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.page-section.active {
    display: block;
}
.grid-dashboard {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
    margin-bottom: 30px;
}
.card {
    background: linear-gradient(160deg, rgba(30, 41, 59, 0.7), rgba(30, 41, 59, 0.4));
    border: 1px solid var(--glass-border);
    border-radius: 16px;
    padding: 20px;
    position: relative;
    overflow: hidden;
    transition: transform 0.3s, box-shadow 0.3s;
}
.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    border-color: rgba(255, 255, 255, 0.2);
}
.card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, var(--accent), #a855f7);
    opacity: 0;
    transition: opacity 0.3s;
}
.card:hover::before {
    opacity: 1;
}
.stat-value {
    font-size: 28px;
    font-weight: 700;
    margin: 10px 0 5px;
}
.stat-label {
    color: var(--text-dim);
    font-size: 13px;
}
.stat-trend {
    font-size: 12px;
    margin-top: 8px;
    display: flex;
    align-items: center;
    gap: 4px;
}
.trend-up { color: var(--success); }
.trend-down { color: var(--danger); }
.large-card {
    grid-column: span 2;
    height: 350px;
    display: flex;
    flex-direction: column;
}
.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
.card-title {
    font-size: 16px;
    font-weight: 600;
}
.chart-container {
    flex: 1;
    width: 100%;
    position: relative;
}
.terminal-window {
    background: #0d1117;
    border-radius: 10px;
    border: 1px solid #30363d;
    font-family: 'Courier New', Courier, monospace;
    padding: 0;
    overflow: hidden;
    height: 500px;
    display: flex;
    flex-direction: column;
    box-shadow: 0 20px 50px rgba(0,0,0,0.5);
}
.terminal-header {
    background: #161b22;
    padding: 10px 15px;
    display: flex;
    gap: 8px;
    border-bottom: 1px solid #30363d;
}
.term-btn {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}
.term-close { background: #ff5f56; }
.term-min { background: #ffbd2e; }
.term-max { background: #27c93f; }
.terminal-body {
    padding: 15px;
    flex: 1;
    overflow-y: auto;
    color: #c9d1d9;
    font-size: 14px;
}
.output-line {
    margin-bottom: 5px;
    line-height: 1.5;
}
.input-line {
    display: flex;
    gap: 10px;
    align-items: center;
}
.prompt { color: var(--success); }
#term-input {
    background: transparent;
    border: none;
    color: white;
    flex: 1;
    font-family: 'Courier New', monospace;
    font-size: 14px;
}
.game-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
}
#snake-canvas {
    background: rgba(0, 0, 0, 0.3);
    border: 2px solid var(--accent);
    border-radius: 8px;
    box-shadow: 0 0 20px rgba(99, 102, 241, 0.3);
}
.btn-primary {
    background: var(--accent);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    margin-top: 20px;
    transition: all 0.2s;
}
.btn-primary:hover {
    background: #4f46e5;
    transform: scale(1.05);
}
.table-container {
    width: 100%;
    overflow-x: auto;
}
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    text-align: left;
    padding: 15px;
    border-bottom: 1px solid var(--glass-border);
}
th {
    color: var(--text-dim);
    font-weight: 600;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
tr:hover {
    background: rgba(255, 255, 255, 0.02);
}
.status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: 600;
}
.bg-success { background: rgba(16, 185, 129, 0.2); color: #34d399; }
.bg-warning { background: rgba(245, 158, 11, 0.2); color: #fbbf24; }
.bg-danger { background: rgba(239, 68, 68, 0.2); color: #f87171; }
@keyframes pulse {
    0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
    70% { box-shadow: 0 0 0 6px rgba(16, 185, 129, 0); }
    100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}
.media-player {
    display: flex;
    gap: 20px;
    height: 100%;
}
.player-main {
    flex: 2;
    background: linear-gradient(135deg, #2e1065, #4c1d95);
    border-radius: 20px;
    padding: 30px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
}
.disk {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    background: conic-gradient(#444, #111, #444);
    margin: 0 auto;
    box-shadow: 0 0 30px rgba(0,0,0,0.5);
    animation: spin 4s linear infinite;
    border: 5px solid #222;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
}
.disk::after {
    content: '';
    width: 60px;
    height: 60px;
    background: var(--accent);
    border-radius: 50%;
}
@keyframes spin { 100% { transform: rotate(360deg); } }
.player-controls {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}
.ctrl-btn {
    background: rgba(255,255,255,0.1);
    border: none;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    color: white;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.2s;
}
.ctrl-btn:hover { background: var(--accent); }
.play-list {
    flex: 1;
    background: var(--bg-secondary);
    border-radius: 20px;
    padding: 20px;
    border: 1px solid var(--glass-border);
}
.track-item {
    padding: 12px;
    border-bottom: 1px solid var(--glass-border);
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    transition: 0.2s;
}
.track-item:hover { background: rgba(255,255,255,0.05); }
.track-num { color: var(--text-dim); font-size: 12px; }
@media (max-width: 1024px) {
    .grid-dashboard { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 768px) {
    .sidebar { position: absolute; transform: translateX(-100%); z-index: 100; height: 100%; }
    .sidebar.open { transform: translateX(0); }
    .grid-dashboard { grid-template-columns: 1fr; }
    .large-card { grid-column: span 1; }
    .media-player { flex-direction: column; }
}
.progress-bar {
    width: 100%;
    height: 6px;
    background: rgba(255,255,255,0.1);
    border-radius: 3px;
    margin-bottom: 10px;
    position: relative;
}
.progress-fill {
    position: absolute;
    height: 100%;
    background: var(--accent);
    width: 45%;
    border-radius: 3px;
}
</style>
</head>
<body>

<canvas id="bg-canvas"></canvas>

<div class="app-container">
    <aside class="sidebar">
        <div class="logo-area">
            <div class="logo-icon">F</div>
            <div class="logo-text">FERI PRO</div>
        </div>
        <nav class="nav-menu">
            <div class="nav-item active" onclick="switchTab('dashboard', this)">
                <svg class="nav-icon" viewBox="0 0 24 24"><path d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"/></svg>
                Dashboard
            </div>
            <div class="nav-item" onclick="switchTab('terminal', this)">
                <svg class="nav-icon" viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zM4 18V6h16v12H4z"/><path d="M7.5 15l4.5-3-4.5-3v6zM12 15h5v-2h-5v2z"/></svg>
                Terminal
            </div>
            <div class="nav-item" onclick="switchTab('media', this)">
                <svg class="nav-icon" viewBox="0 0 24 24"><path d="M12 3v9.28c-.47-.17-.97-.28-1.5-.28C8.01 12 6 14.01 6 16.5S8.01 21 10.5 21c2.31 0 4.16-1.75 4.43-4H15v-6h4V3h-7z"/></svg>
                Media
            </div>
            <div class="nav-item" onclick="switchTab('game', this)">
                <svg class="nav-icon" viewBox="0 0 24 24"><path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm4 0c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>
                GameZone
            </div>
        </nav>
        <div class="server-status">
            <div class="status-header">
                <span>MAVEN BUILD</span>
                <span id="cpu-val">24%</span>
            </div>
            <div class="progress-bar" style="margin:0"><div class="progress-fill" id="cpu-bar" style="width:24%"></div></div>
            <div class="status-header" style="margin-top:10px">
                <span>MEMORY</span>
                <span id="mem-val">1.2GB</span>
            </div>
            <div class="progress-bar" style="margin:0"><div class="progress-fill" id="mem-bar" style="width:45%; background:#f59e0b"></div></div>
        </div>
    </aside>

    <main class="main-content">
        <div class="top-bar">
            <div class="search-box">
                <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="text" class="search-input" placeholder="Search command or file...">
            </div>
            <div class="user-profile">
                <div class="notification-bell">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                    <div class="badge">3</div>
                </div>
                <div style="text-align:right">
                    <div style="font-size:14px; font-weight:600">Feri Developer</div>
                    <div style="font-size:11px; color:var(--text-dim)">Admin</div>
                </div>
                <div class="avatar"></div>
            </div>
        </div>

        <div class="content-area">
            
            <!-- DASHBOARD SECTION -->
            <div id="dashboard" class="page-section active">
                <h2 style="margin-bottom:20px; font-weight:300">System Overview</h2>
                <div class="grid-dashboard">
                    <div class="card">
                        <div class="stat-label">TOTAL VISITORS</div>
                        <div class="stat-value">128,492</div>
                        <div class="stat-trend trend-up">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline><polyline points="17 6 23 6 23 12"></polyline></svg>
                            <span>+12.5% this week</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="stat-label">REVENUE</div>
                        <div class="stat-value">$45,230</div>
                        <div class="stat-trend trend-up">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline><polyline points="17 6 23 6 23 12"></polyline></svg>
                            <span>+8.2% vs last month</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="stat-label">ACTIVE SESSIONS</div>
                        <div class="stat-value">1,204</div>
                        <div class="stat-trend trend-down">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 18 13.5 8.5 8.5 13.5 1 6"></polyline><polyline points="17 18 23 18 23 12"></polyline></svg>
                            <span>-2.1% busy time</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="stat-label">SERVER LOAD</div>
                        <div class="stat-value">34ms</div>
                        <div class="stat-trend trend-up">
                            <span>Optimal</span>
                        </div>
                    </div>

                    <div class="card large-card">
                        <div class="card-header">
                            <div class="card-title">Traffic Analytics</div>
                            <select style="background:#0f172a; color:white; border:1px solid #333; padding:5px; border-radius:5px">
                                <option>Last 7 Days</option>
                                <option>Last Month</option>
                            </select>
                        </div>
                        <div class="chart-container">
                            <canvas id="trafficChart"></canvas>
                        </div>
                    </div>

                    <div class="card large-card" style="overflow-y:auto">
                        <div class="card-header">
                            <div class="card-title">Recent Deployments</div>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Project</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Commit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>FeriPro_Core</td>
                                        <td><span class="status-badge bg-success">Deployed</span></td>
                                        <td>Today, 10:23</td>
                                        <td style="font-family:monospace">a1b2c3d</td>
                                    </tr>
                                    <tr>
                                        <td>Auth_Service</td>
                                        <td><span class="status-badge bg-warning">Building</span></td>
                                        <td>Today, 10:20</td>
                                        <td style="font-family:monospace">f4e5d6</td>
                                    </tr>
                                    <tr>
                                        <td>Payment_GW</td>
                                        <td><span class="status-badge bg-success">Deployed</span></td>
                                        <td>Yesterday</td>
                                        <td style="font-family:monospace">98h7g6</td>
                                    </tr>
                                    <tr>
                                        <td>Legacy_JSP</td>
                                        <td><span class="status-badge bg-danger">Failed</span></td>
                                        <td>Nov 14</td>
                                        <td style="font-family:monospace">123456</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TERMINAL SECTION -->
            <div id="terminal" class="page-section">
                <div class="terminal-window">
                    <div class="terminal-header">
                        <div class="term-btn term-close"></div>
                        <div class="term-btn term-min"></div>
                        <div class="term-btn term-max"></div>
                        <span style="margin-left:10px; font-size:12px; color:#8b949e">feri@server:~/projects</span>
                    </div>
                    <div class="terminal-body" id="term-output">
                        <div class="output-line">Welcome to FeriOS Terminal v2.0.5 LTS</div>
                        <div class="output-line">Last login: Tue Nov 19 14:02:33 on ttys000</div>
                        <div class="output-line">Type 'help' for available commands.</div>
                        <br>
                    </div>
                    <div style="padding: 0 15px 15px 15px;">
                        <div class="input-line">
                            <span class="prompt">feri@pro:~$</span>
                            <input type="text" id="term-input" autocomplete="off" spellcheck="false" autofocus>
                        </div>
                    </div>
                </div>
            </div>

            <!-- MEDIA SECTION -->
            <div id="media" class="page-section">
                <div class="media-player">
                    <div class="player-main">
                        <div style="text-align:center; margin-top:10px">
                            <h3 style="font-size:24px">Neon Nights</h3>
                            <p style="color:var(--text-dim)">Synthwave Collection</p>
                        </div>
                        <div class="disk"></div>
                        
                        <div>
                            <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px; color:#ccc">
                                <span>1:24</span>
                                <span>3:45</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width:35%"></div>
                            </div>
                            <div class="player-controls">
                                <button class="ctrl-btn"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M6 6h2v12H6zm3.5 6l8.5 6V6z"/></svg></button>
                                <button class="ctrl-btn" style="width:60px; height:60px; background:white; color:black"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg></button>
                                <button class="ctrl-btn"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M6 18l8.5-6L6 6v12zM16 6v12h2V6h-2z"/></svg></button>
                            </div>
                        </div>
                    </div>
                    <div class="play-list">
                        <h3 style="margin-bottom:15px">Up Next</h3>
                        <div class="track-item">
                            <div class="track-num">01</div>
                            <div>
                                <div style="font-weight:600">Midnight City</div>
                                <div style="font-size:12px; color:var(--text-dim)">M83</div>
                            </div>
                        </div>
                        <div class="track-item">
                            <div class="track-num">02</div>
                            <div>
                                <div style="font-weight:600">Tech Noir</div>
                                <div style="font-size:12px; color:var(--text-dim)">Gunship</div>
                            </div>
                        </div>
                        <div class="track-item">
                            <div class="track-num">03</div>
                            <div>
                                <div style="font-weight:600">Nightcall</div>
                                <div style="font-size:12px; color:var(--text-dim)">Kavinsky</div>
                            </div>
                        </div>
                        <div class="track-item">
                            <div class="track-num">04</div>
                            <div>
                                <div style="font-weight:600">Resonance</div>
                                <div style="font-size:12px; color:var(--text-dim)">Home</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- GAME SECTION -->
            <div id="game" class="page-section" style="height:100%">
                <div class="game-container">
                    <div style="margin-bottom:15px; text-align:center">
                        <h2>PYTHON SNAKE</h2>
                        <div style="color:var(--text-dim)">Score: <span id="score">0</span> | High Score: <span id="high-score">0</span></div>
                    </div>
                    <canvas id="snake-canvas" width="400" height="400"></canvas>
                    <button class="btn-primary" onclick="startGame()">Start Game</button>
                    <p style="margin-top:10px; font-size:12px; color:var(--text-dim)">Use Arrow Keys to Move</p>
                </div>
            </div>

        </div>
    </main>
</div>

<script>
// PARTICLE BACKGROUND SYSTEM
const bgCanvas = document.getElementById('bg-canvas');
const bgCtx = bgCanvas.getContext('2d');
let particles = [];
function resizeBg() {
    bgCanvas.width = window.innerWidth;
    bgCanvas.height = window.innerHeight;
}
window.addEventListener('resize', resizeBg);
resizeBg();

class Particle {
    constructor() {
        this.x = Math.random() * bgCanvas.width;
        this.y = Math.random() * bgCanvas.height;
        this.vx = (Math.random() - 0.5) * 0.5;
        this.vy = (Math.random() - 0.5) * 0.5;
        this.size = Math.random() * 2;
        this.alpha = Math.random() * 0.5;
    }
    update() {
        this.x += this.vx;
        this.y += this.vy;
        if(this.x < 0) this.x = bgCanvas.width;
        if(this.x > bgCanvas.width) this.x = 0;
        if(this.y < 0) this.y = bgCanvas.height;
        if(this.y > bgCanvas.height) this.y = 0;
    }
    draw() {
        bgCtx.fillStyle = `rgba(99, 102, 241, ${this.alpha})`;
        bgCtx.beginPath();
        bgCtx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        bgCtx.fill();
    }
}
for(let i=0; i<100; i++) particles.push(new Particle());
function animateBg() {
    bgCtx.clearRect(0, 0, bgCanvas.width, bgCanvas.height);
    particles.forEach(p => { p.update(); p.draw(); });
    // Draw connections
    particles.forEach((p1, i) => {
        particles.slice(i+1).forEach(p2 => {
            const dx = p1.x - p2.x;
            const dy = p1.y - p2.y;
            const dist = Math.sqrt(dx*dx + dy*dy);
            if(dist < 100) {
                bgCtx.strokeStyle = `rgba(99, 102, 241, ${0.1 * (1 - dist/100)})`;
                bgCtx.beginPath();
                bgCtx.moveTo(p1.x, p1.y);
                bgCtx.lineTo(p2.x, p2.y);
                bgCtx.stroke();
            }
        });
    });
    requestAnimationFrame(animateBg);
}
animateBg();

// APP NAVIGATION
function switchTab(tabId, el) {
    document.querySelectorAll('.page-section').forEach(s => s.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
    el.classList.add('active');
}

// TRAFFIC CHART (Custom Implementation without Chart.js)
function initChart() {
    const c = document.getElementById('trafficChart');
    if(!c) return;
    const ctx = c.getContext('2d');
    // Scale for HiDPI
    const rect = c.parentElement.getBoundingClientRect();
    c.width = rect.width;
    c.height = rect.height;
    
    const data = [20, 45, 30, 60, 40, 75, 50];
    const padding = 40;
    const w = c.width - padding * 2;
    const h = c.height - padding * 2;
    const step = w / (data.length - 1);
    const max = 100;

    // Draw Grid
    ctx.strokeStyle = 'rgba(255,255,255,0.1)';
    ctx.lineWidth = 1;
    for(let i=0; i<=5; i++) {
        const y = padding + h - (h/5)*i;
        ctx.beginPath(); ctx.moveTo(padding, y); ctx.lineTo(padding + w, y); ctx.stroke();
        ctx.fillStyle = '#64748b'; ctx.fillText(i*20, 10, y + 4);
    }

    // Draw Line
    ctx.beginPath();
    ctx.strokeStyle = '#6366f1';
    ctx.lineWidth = 3;
    data.forEach((d, i) => {
        const x = padding + i * step;
        const y = padding + h - (d/max)*h;
        if(i===0) ctx.moveTo(x, y);
        else ctx.lineTo(x, y);
    });
    ctx.stroke();

    // Draw Gradient Area
    ctx.lineTo(padding + w, padding + h);
    ctx.lineTo(padding, padding + h);
    ctx.fillStyle = 'rgba(99, 102, 241, 0.1)';
    ctx.fill();

    // Draw Points
    data.forEach((d, i) => {
        const x = padding + i * step;
        const y = padding + h - (d/max)*h;
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, Math.PI*2);
        ctx.fillStyle = '#fff';
        ctx.fill();
    });
}
setTimeout(initChart, 500);
window.addEventListener('resize', initChart);

// TERMINAL LOGIC
const termInput = document.getElementById('term-input');
const termOutput = document.getElementById('term-output');
const commands = {
    'help': 'Available commands: help, clear, whoami, date, echo [text], reboot',
    'whoami': 'root (Feri Pro Administrator)',
    'date': () => new Date().toString(),
    'clear': () => { termOutput.innerHTML = ''; return ''; },
    'reboot': 'System rebooting... (Just kidding, this is HTML)',
    'ls': 'index.html  style.css  main.js  secret_plans.txt',
    'cat secret_plans.txt': '1. Learn Java\n2. Master Maven\n3. Rule the World'
};

termInput.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        const input = this.value;
        const cmd = input.split(' ')[0];
        const args = input.substring(cmd.length + 1);
        
        const line = document.createElement('div');
        line.className = 'output-line';
        line.innerHTML = `<span class="prompt">feri@pro:~$</span> ${input}`;
        termOutput.appendChild(line);

        let response = `Command not found: ${cmd}`;
        if (commands[cmd]) {
            response = typeof commands[cmd] === 'function' ? commands[cmd]() : commands[cmd];
            if (cmd === 'echo') response = args;
        }
        
        if(response) {
            const respLine = document.createElement('div');
            respLine.className = 'output-line';
            respLine.innerText = response;
            termOutput.appendChild(respLine);
        }
        
        this.value = '';
        termOutput.scrollTop = termOutput.scrollHeight;
    }
});

// SNAKE GAME LOGIC
const cvs = document.getElementById('snake-canvas');
const ctx = cvs.getContext('2d');
const box = 20;
let snake = [];
let food;
let score;
let d;
let game;

function startGame() {
    if(game) clearInterval(game);
    snake = [{x: 9 * box, y: 10 * box}];
    score = 0;
    document.getElementById('score').innerText = score;
    d = null;
    spawnFood();
    game = setInterval(drawGame, 100);
}

document.addEventListener('keydown', direction);
function direction(event) {
    if(event.keyCode == 37 && d != "RIGHT") d = "LEFT";
    else if(event.keyCode == 38 && d != "DOWN") d = "UP";
    else if(event.keyCode == 39 && d != "LEFT") d = "RIGHT";
    else if(event.keyCode == 40 && d != "UP") d = "DOWN";
}

function spawnFood() {
    food = {
        x: Math.floor(Math.random() * 19 + 1) * box,
        y: Math.floor(Math.random() * 19 + 1) * box
    };
}

function drawGame() {
    ctx.fillStyle = "rgba(0,0,0,0.6)";
    ctx.fillRect(0, 0, cvs.width, cvs.height);

    for(let i = 0; i < snake.length; i++) {
        ctx.fillStyle = (i == 0) ? "#6366f1" : "#a5b4fc";
        ctx.fillRect(snake[i].x, snake[i].y, box, box);
        ctx.strokeStyle = "#1e293b";
        ctx.strokeRect(snake[i].x, snake[i].y, box, box);
    }

    ctx.fillStyle = "#10b981";
    ctx.fillRect(food.x, food.y, box, box);

    let snakeX = snake[0].x;
    let snakeY = snake[0].y;

    if(d == "LEFT") snakeX -= box;
    if(d == "UP") snakeY -= box;
    if(d == "RIGHT") snakeX += box;
    if(d == "DOWN") snakeY += box;

    if(snakeX == food.x && snakeY == food.y) {
        score++;
        document.getElementById('score').innerText = score;
        spawnFood();
    } else {
        if(d) snake.pop();
    }

    let newHead = {x: snakeX, y: snakeY};

    if(snakeX < 0 || snakeX >= cvs.width || snakeY < 0 || snakeY >= cvs.height || collision(newHead, snake)) {
        clearInterval(game);
        ctx.fillStyle = "white";
        ctx.font = "30px Arial";
        ctx.fillText("GAME OVER", 110, 200);
        const high = document.getElementById('high-score');
        if(score > parseInt(high.innerText)) high.innerText = score;
    }

    if(d) snake.unshift(newHead);
}

function collision(head, array) {
    for(let i = 0; i < array.length; i++) {
        if(head.x == array[i].x && head.y == array[i].y) return true;
    }
    return false;
}

// SYSTEM MONITOR SIMULATION
setInterval(() => {
    const cpu = Math.floor(Math.random() * 30) + 20;
    const mem = (Math.random() * 0.5 + 1.0).toFixed(1);
    document.getElementById('cpu-val').innerText = cpu + '%';
    document.getElementById('cpu-bar').style.width = cpu + '%';
    document.getElementById('mem-val').innerText = mem + 'GB';
}, 2000);

</script>
</body>
</html>
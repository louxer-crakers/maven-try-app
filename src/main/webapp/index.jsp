<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lumina Creative OS</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
:root {
    --bg: #e0e5ec;
    --text-main: #4a5568;
    --text-light: #a0aec0;
    --accent: #667eea;
    --accent-grad: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --shadow-light: #ffffff;
    --shadow-dark: #a3b1c6;
    --radius: 30px;
    --neu-flat: 9px 9px 16px var(--shadow-dark), -9px -9px 16px var(--shadow-light);
    --neu-pressed: inset 6px 6px 10px var(--shadow-dark), inset -6px -6px 10px var(--shadow-light);
    --neu-icon: 5px 5px 10px var(--shadow-dark), -5px -5px 10px var(--shadow-light);
}

* { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Nunito', sans-serif; outline: none; }

body {
    background-color: var(--bg);
    color: var(--text-main);
    height: 100vh;
    display: flex;
    overflow: hidden;
}

/* --- SIDEBAR --- */
.sidebar {
    width: 100px;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 30px 0;
    z-index: 10;
}

.brand {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 800;
    font-size: 24px;
    color: var(--accent);
    margin-bottom: 50px;
}

.nav-menu {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.nav-btn {
    width: 60px;
    height: 60px;
    border-radius: 20px;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: transform 0.2s ease;
    color: var(--text-light);
}

.nav-btn:hover { transform: translateY(-2px); color: var(--accent); }
.nav-btn.active {
    box-shadow: var(--neu-pressed);
    color: var(--accent);
    transform: none;
}
.nav-btn svg { width: 24px; height: 24px; }

/* --- MAIN AREA --- */
.main-container {
    flex: 1;
    padding: 30px;
    position: relative;
    display: flex;
    flex-direction: column;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header-title h1 { font-size: 28px; font-weight: 800; }
.header-title p { color: var(--text-light); font-size: 14px; }

.search-bar {
    width: 400px;
    height: 50px;
    border-radius: 25px;
    background: var(--bg);
    box-shadow: var(--neu-pressed);
    display: flex;
    align-items: center;
    padding: 0 20px;
}

.search-bar input {
    background: transparent;
    border: none;
    width: 100%;
    margin-left: 10px;
    color: var(--text-main);
    font-size: 16px;
}

.profile-widget {
    display: flex;
    gap: 20px;
    align-items: center;
}

.btn-round {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

/* --- CONTENT VIEWS --- */
.view-section {
    display: none;
    height: 100%;
    animation: fadeScale 0.4s ease;
}
.view-section.active { display: block; }

@keyframes fadeScale {
    from { opacity: 0; transform: scale(0.98); }
    to { opacity: 1; transform: scale(1); }
}

/* --- DASHBOARD GRID --- */
.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: 150px 1fr;
    gap: 30px;
    height: 100%;
}

.stat-card {
    background: var(--bg);
    border-radius: var(--radius);
    box-shadow: var(--neu-flat);
    padding: 25px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.stat-card::after {
    content: '';
    position: absolute;
    right: -20px;
    bottom: -20px;
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: var(--accent-grad);
    opacity: 0.1;
}

.stat-value { font-size: 36px; font-weight: 800; color: #2d3748; }
.stat-label { font-size: 14px; color: var(--text-light); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
.stat-icon { position: absolute; top: 20px; right: 20px; color: var(--accent); }

.big-widget {
    grid-column: span 2;
    background: var(--bg);
    border-radius: var(--radius);
    box-shadow: var(--neu-flat);
    padding: 30px;
    display: flex;
    flex-direction: column;
}

.side-widget {
    grid-column: span 1;
    background: var(--bg);
    border-radius: var(--radius);
    box-shadow: var(--neu-flat);
    padding: 30px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* --- KANBAN BOARD --- */
.kanban-container {
    display: flex;
    gap: 30px;
    height: 85vh;
    overflow-x: auto;
    padding-bottom: 20px;
}

.kanban-col {
    flex: 1;
    min-width: 300px;
    background: var(--bg);
    border-radius: var(--radius);
    box-shadow: var(--neu-pressed);
    padding: 20px;
    display: flex;
    flex-direction: column;
}

.col-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    padding: 0 10px;
    font-weight: 700;
}

.task-card {
    background: var(--bg);
    border-radius: 15px;
    box-shadow: var(--neu-flat);
    padding: 15px;
    margin-bottom: 15px;
    cursor: grab;
    transition: transform 0.2s;
    border-left: 5px solid var(--accent);
}

.task-card:hover { transform: translateY(-3px); }
.task-card p { font-size: 14px; margin-bottom: 10px; font-weight: 600; }
.task-meta { display: flex; justify-content: space-between; font-size: 11px; color: var(--text-light); }

.add-btn {
    margin-top: auto;
    padding: 12px;
    border-radius: 15px;
    border: none;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    color: var(--accent);
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}
.add-btn:hover { box-shadow: var(--neu-pressed); }

/* --- FOCUS TIMER --- */
.timer-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
}

.timer-circle {
    width: 300px;
    height: 300px;
    border-radius: 50%;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    margin-bottom: 40px;
}

.timer-svg {
    position: absolute;
    top: 0; left: 0;
    width: 300px; height: 300px;
    transform: rotate(-90deg);
}

.timer-path {
    fill: none;
    stroke: var(--accent);
    stroke-width: 10;
    stroke-dasharray: 880; /* 2 * PI * 140 */
    stroke-dashoffset: 0;
    stroke-linecap: round;
    transition: stroke-dashoffset 1s linear;
}

.time-display { font-size: 48px; font-weight: 800; color: var(--text-main); }

.timer-controls { display: flex; gap: 20px; }
.btn-pill {
    padding: 15px 40px;
    border-radius: 30px;
    border: none;
    background: var(--bg);
    box-shadow: var(--neu-flat);
    font-weight: 700;
    color: var(--text-main);
    cursor: pointer;
    font-size: 16px;
    transition: 0.2s;
}
.btn-pill.primary { color: var(--accent); }
.btn-pill:active { box-shadow: var(--neu-pressed); transform: translateY(2px); }

/* --- CREATIVE CANVAS (PHYSICS) --- */
.canvas-wrapper {
    width: 100%;
    height: 100%;
    border-radius: var(--radius);
    box-shadow: var(--neu-pressed);
    overflow: hidden;
    position: relative;
}
#physicsCanvas { width: 100%; height: 100%; background: var(--bg); }
.canvas-overlay {
    position: absolute;
    top: 20px; left: 20px;
    pointer-events: none;
}

/* --- AI CHAT --- */
.chat-interface {
    display: flex;
    flex-direction: column;
    height: 80vh;
    background: var(--bg);
    border-radius: var(--radius);
    box-shadow: var(--neu-pressed);
    overflow: hidden;
}
.chat-window { flex: 1; padding: 30px; overflow-y: auto; display: flex; flex-direction: column; gap: 15px; }
.chat-bubble {
    max-width: 70%;
    padding: 15px 20px;
    border-radius: 20px;
    font-size: 14px;
    line-height: 1.5;
}
.bot {
    background: var(--bg);
    box-shadow: var(--neu-flat);
    align-self: flex-start;
    border-top-left-radius: 5px;
}
.user {
    background: var(--accent);
    color: white;
    box-shadow: 5px 5px 15px rgba(102, 126, 234, 0.4);
    align-self: flex-end;
    border-top-right-radius: 5px;
}
.chat-input-area {
    padding: 20px;
    display: flex;
    gap: 15px;
}
#chatInput {
    flex: 1;
    padding: 15px;
    border-radius: 15px;
    border: none;
    background: var(--bg);
    box-shadow: var(--neu-pressed);
}

/* Utility Classes */
.hidden { display: none; }
</style>
</head>
<body>

<aside class="sidebar">
    <div class="brand">L</div>
    <nav class="nav-menu">
        <div class="nav-btn active" onclick="switchTab('dashboard', this)" title="Dashboard">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
        </div>
        <div class="nav-btn" onclick="switchTab('kanban', this)" title="Project Board">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2l10 6.5v7L12 22 2 15.5v-7L12 2z"></path><path d="M12 22v-6.5"></path><path d="M22 8.5l-10 7-10-7"></path><path d="M2 15.5l10-7 10 7"></path><path d="M12 2v6.5"></path></svg>
        </div>
        <div class="nav-btn" onclick="switchTab('focus', this)" title="Focus Timer">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
        </div>
        <div class="nav-btn" onclick="switchTab('playground', this)" title="Physics Playground">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 19l7-7 3 3-7 7-3-3z"></path><path d="M18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5z"></path><path d="M2 2l7.586 7.586"></path><circle cx="11" cy="11" r="2"></circle></svg>
        </div>
        <div class="nav-btn" onclick="switchTab('ai', this)" title="Lumina AI">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
        </div>
    </nav>
</aside>

<main class="main-container">
    <header class="header">
        <div class="header-title">
            <h1 id="greeting">Good Morning, Creator</h1>
            <p>Welcome back to Lumina OS v2.0</p>
        </div>
        <div class="search-bar">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            <input type="text" placeholder="Search projects, assets, or commands...">
        </div>
        <div class="profile-widget">
            <div class="btn-round">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
            </div>
            <div class="btn-round" style="background: var(--accent-grad); box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </div>
        </div>
    </header>

    <section id="dashboard" class="view-section active">
        <div class="dashboard-grid">
            <div class="stat-card">
                <div class="stat-value">12</div>
                <div class="stat-label">Pending Tasks</div>
                <svg class="stat-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"></path><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
            </div>
            <div class="stat-card">
                <div class="stat-value">4.5h</div>
                <div class="stat-label">Focus Time</div>
                <svg class="stat-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
            </div>
            <div class="stat-card">
                <div class="stat-value">92%</div>
                <div class="stat-label">Efficiency</div>
                <svg class="stat-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline><polyline points="17 6 23 6 23 12"></polyline></svg>
            </div>

            <div class="big-widget">
                <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
                    <h3>Weekly Activity Flow</h3>
                    <select style="border:none; background:transparent; color:var(--accent); font-weight:700"><option>This Week</option></select>
                </div>
                <div style="flex:1; display:flex; align-items:flex-end; justify-content:space-between; padding: 0 20px;">
                    <div style="width:8%; height:40%; background:#cbd5e0; border-radius:10px;"></div>
                    <div style="width:8%; height:60%; background:#cbd5e0; border-radius:10px;"></div>
                    <div style="width:8%; height:30%; background:#cbd5e0; border-radius:10px;"></div>
                    <div style="width:8%; height:85%; background:var(--accent); border-radius:10px; box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);"></div>
                    <div style="width:8%; height:55%; background:#cbd5e0; border-radius:10px;"></div>
                    <div style="width:8%; height:70%; background:#cbd5e0; border-radius:10px;"></div>
                    <div style="width:8%; height:45%; background:#cbd5e0; border-radius:10px;"></div>
                </div>
                <div style="display:flex; justify-content:space-between; padding: 10px 20px 0; color:var(--text-light); font-size:12px;">
                    <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
                </div>
            </div>

            <div class="side-widget">
                <h3 style="margin-bottom:20px">Storage</h3>
                <div style="width:150px; height:150px; border-radius:50%; box-shadow:var(--neu-pressed); display:flex; align-items:center; justify-content:center; margin-bottom:20px;">
                    <div style="width:120px; height:120px; border-radius:50%; background:var(--bg); box-shadow:var(--neu-flat); display:flex; align-items:center; justify-content:center; flex-direction:column;">
                        <span style="font-size:24px; font-weight:800; color:var(--accent)">78%</span>
                        <span style="font-size:12px; color:var(--text-light)">Used</span>
                    </div>
                </div>
                <div style="width:100%;">
                    <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px;">
                        <span>Documents</span><span>65 GB</span>
                    </div>
                    <div style="width:100%; height:8px; background:#cbd5e0; border-radius:4px; margin-bottom:15px;">
                        <div style="width:65%; height:100%; background:var(--accent); border-radius:4px;"></div>
                    </div>
                     <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px;">
                        <span>Media</span><span>24 GB</span>
                    </div>
                    <div style="width:100%; height:8px; background:#cbd5e0; border-radius:4px;">
                        <div style="width:24%; height:100%; background:#9f7aea; border-radius:4px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="kanban" class="view-section">
        <h2 style="margin-bottom:20px;">Project: Apollo Launch</h2>
        <div class="kanban-container">
            <div class="kanban-col" id="todo-col">
                <div class="col-header">To Do <span style="background:#cbd5e0; padding:2px 8px; border-radius:10px; font-size:12px;">3</span></div>
                <div class="task-card" onclick="moveCard(this)">
                    <p>Design Landing Page</p>
                    <div class="task-meta"><span>UI/UX</span><span>2d</span></div>
                </div>
                <div class="task-card" onclick="moveCard(this)">
                    <p>Research Competitors</p>
                    <div class="task-meta"><span>Marketing</span><span>1d</span></div>
                </div>
                <button class="add-btn" onclick="addTask()">+ Add New Task</button>
            </div>

            <div class="kanban-col" id="progress-col">
                <div class="col-header">In Progress <span style="background:#f6ad55; color:white; padding:2px 8px; border-radius:10px; font-size:12px;">1</span></div>
                <div class="task-card" style="border-color:#f6ad55" onclick="moveCard(this)">
                    <p>Develop API Endpoints</p>
                    <div class="task-meta"><span>Backend</span><span>4d</span></div>
                </div>
            </div>

            <div class="kanban-col" id="done-col">
                <div class="col-header">Done <span style="background:#68d391; color:white; padding:2px 8px; border-radius:10px; font-size:12px;">2</span></div>
                <div class="task-card" style="border-color:#68d391; opacity:0.7" onclick="moveCard(this)">
                    <p>Client Meeting</p>
                    <div class="task-meta"><span>General</span><span>Done</span></div>
                </div>
            </div>
        </div>
    </section>

    <section id="focus" class="view-section">
        <div class="timer-container">
            <h2 style="margin-bottom:40px">Deep Focus Mode</h2>
            <div class="timer-circle">
                <svg class="timer-svg">
                    <circle class="timer-path" cx="150" cy="150" r="140"></circle>
                </svg>
                <div class="time-display" id="time-display">25:00</div>
            </div>
            <div class="timer-controls">
                <button class="btn-pill primary" onclick="toggleTimer()" id="start-btn">Start Focus</button>
                <button class="btn-pill" onclick="resetTimer()">Reset</button>
            </div>
            <p style="margin-top:30px; color:var(--text-light); font-style:italic">"Creativity requires the courage to let go of certainties."</p>
        </div>
    </section>

    <section id="playground" class="view-section">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
            <h2>Physics Canvas</h2>
            <p style="font-size:12px; color:var(--text-light)">Click and drag to create gravity wells. Balls react to mouse.</p>
        </div>
        <div class="canvas-wrapper">
            <canvas id="physicsCanvas"></canvas>
        </div>
    </section>

    <section id="ai" class="view-section">
        <h2 style="margin-bottom:20px">Lumina Assistant</h2>
        <div class="chat-interface">
            <div class="chat-window" id="chat-window">
                <div class="chat-bubble bot">Hello! I am Lumina. How can I assist with your workflow today?</div>
            </div>
            <div class="chat-input-area">
                <input type="text" id="chatInput" placeholder="Type your request here..." onkeypress="handleChat(event)">
                <button class="btn-round" style="background:var(--accent); color:white;" onclick="sendChat()">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                </button>
            </div>
        </div>
    </section>

</main>

<script>
// --- GREETING LOGIC ---
const hour = new Date().getHours();
const greetEl = document.getElementById('greeting');
if (hour < 12) greetEl.innerText = 'Good Morning, Creator';
else if (hour < 18) greetEl.innerText = 'Good Afternoon, Creator';
else greetEl.innerText = 'Good Evening, Creator';

// --- TAB NAVIGATION ---
function switchTab(tabId, el) {
    document.querySelectorAll('.view-section').forEach(s => s.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    el.classList.add('active');
    
    // If switching to playground, resize canvas
    if(tabId === 'playground') {
        setTimeout(initPhysics, 100);
    }
}

// --- KANBAN LOGIC (SIMPLE CLICK TO MOVE) ---
function addTask() {
    const title = prompt("Enter Task Title:");
    if(title) {
        const div = document.createElement('div');
        div.className = 'task-card';
        div.onclick = function() { moveCard(this) };
        div.innerHTML = `<p>${title}</p><div class="task-meta"><span>New</span><span>0d</span></div>`;
        document.getElementById('todo-col').insertBefore(div, document.getElementById('todo-col').lastElementChild);
    }
}

function moveCard(card) {
    const parent = card.parentElement.id;
    if(parent === 'todo-col') {
        document.getElementById('progress-col').appendChild(card);
        card.style.borderColor = '#f6ad55';
    } else if (parent === 'progress-col') {
        document.getElementById('done-col').appendChild(card);
        card.style.borderColor = '#68d391';
        card.style.opacity = '0.7';
    } else {
        if(confirm("Delete this task?")) card.remove();
    }
}

// --- FOCUS TIMER LOGIC ---
let timerInterval;
let timeLeft = 1500; // 25 mins
let isRunning = false;
const maxDash = 880;

function updateTimerDisplay() {
    const m = Math.floor(timeLeft / 60).toString().padStart(2, '0');
    const s = (timeLeft % 60).toString().padStart(2, '0');
    document.getElementById('time-display').innerText = `${m}:${s}`;
    
    const offset = maxDash - (timeLeft / 1500) * maxDash;
    document.querySelector('.timer-path').style.strokeDashoffset = offset;
}

function toggleTimer() {
    if(isRunning) {
        clearInterval(timerInterval);
        document.getElementById('start-btn').innerText = "Resume Focus";
        document.getElementById('start-btn').classList.remove('primary');
    } else {
        timerInterval = setInterval(() => {
            if(timeLeft > 0) {
                timeLeft--;
                updateTimerDisplay();
            } else {
                clearInterval(timerInterval);
                alert("Focus Session Complete!");
            }
        }, 1000);
        document.getElementById('start-btn').innerText = "Pause";
        document.getElementById('start-btn').classList.add('primary');
    }
    isRunning = !isRunning;
}

function resetTimer() {
    clearInterval(timerInterval);
    timeLeft = 1500;
    isRunning = false;
    updateTimerDisplay();
    document.getElementById('start-btn').innerText = "Start Focus";
}

// --- PHYSICS PLAYGROUND (BALLS) ---
const canvas = document.getElementById('physicsCanvas');
const ctx = canvas.getContext('2d');
let balls = [];
let mouse = { x: null, y: null };

class Ball {
    constructor() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;
        this.vx = (Math.random() - 0.5) * 4;
        this.vy = (Math.random() - 0.5) * 4;
        this.size = Math.random() * 20 + 10;
        this.color = `hsla(${Math.random()*60 + 220}, 80%, 60%, 0.8)`; // Blue/Purple hues
    }
    update() {
        // Mouse interaction
        if(mouse.x) {
            const dx = mouse.x - this.x;
            const dy = mouse.y - this.y;
            const dist = Math.sqrt(dx*dx + dy*dy);
            if(dist < 150) {
                const force = (150 - dist) / 150;
                this.vx -= (dx/dist) * force * 2;
                this.vy -= (dy/dist) * force * 2;
            }
        }

        this.x += this.vx;
        this.y += this.vy;

        // Wall collision
        if(this.x + this.size > canvas.width || this.x - this.size < 0) {
            this.vx *= -0.9; // Bounce with friction
            if(this.x + this.size > canvas.width) this.x = canvas.width - this.size;
            if(this.x - this.size < 0) this.x = this.size;
        }
        if(this.y + this.size > canvas.height || this.y - this.size < 0) {
            this.vy *= -0.9;
            if(this.y + this.size > canvas.height) this.y = canvas.height - this.size;
            if(this.y - this.size < 0) this.y = this.size;
        }

        // Friction
        this.vx *= 0.99;
        this.vy *= 0.99;
        
        // Gravity
        this.vy += 0.2; 
    }
    draw() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fillStyle = this.color;
        ctx.shadowColor = this.color;
        ctx.shadowBlur = 10;
        ctx.fill();
        ctx.shadowBlur = 0;
    }
}

function initPhysics() {
    canvas.width = canvas.parentElement.offsetWidth;
    canvas.height = canvas.parentElement.offsetHeight;
    balls = [];
    for(let i=0; i<20; i++) balls.push(new Ball());
}

function animatePhysics() {
    ctx.clearRect(0,0,canvas.width,canvas.height);
    balls.forEach(b => { b.update(); b.draw(); });
    requestAnimationFrame(animatePhysics);
}

canvas.addEventListener('mousemove', (e) => {
    const rect = canvas.getBoundingClientRect();
    mouse.x = e.clientX - rect.left;
    mouse.y = e.clientY - rect.top;
});
canvas.addEventListener('mouseleave', () => { mouse.x = null; mouse.y = null; });

window.addEventListener('resize', initPhysics);
setTimeout(() => { initPhysics(); animatePhysics(); }, 500);


// --- AI CHAT BOT LOGIC ---
const responses = [
    "That's an interesting perspective on the design.",
    "I've added that to your task list automatically.",
    "Focus timer suggests taking a break in 5 minutes.",
    "I can optimize the code for that if you wish.",
    "The weather looks good for a walk later.",
    "Processing your request... Done."
];

function handleChat(e) {
    if(e.key === 'Enter') sendChat();
}

function sendChat() {
    const input = document.getElementById('chatInput');
    const text = input.value;
    if(!text.trim()) return;

    // User Bubble
    const win = document.getElementById('chat-window');
    const userDiv = document.createElement('div');
    userDiv.className = 'chat-bubble user';
    userDiv.innerText = text;
    win.appendChild(userDiv);
    
    input.value = '';
    win.scrollTop = win.scrollHeight;

    // Bot Response
    setTimeout(() => {
        const botDiv = document.createElement('div');
        botDiv.className = 'chat-bubble bot';
        botDiv.innerText = responses[Math.floor(Math.random() * responses.length)];
        win.appendChild(botDiv);
        win.scrollTop = win.scrollHeight;
    }, 1000);
}
</script>
</body>
</html>
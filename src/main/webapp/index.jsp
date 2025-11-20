<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Aurora Workspace Pro - Dragon Edition</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
<style>
    :root {
        --glass-bg: rgba(255, 255, 255, 0.07);
        --glass-border: rgba(255, 255, 255, 0.12);
        --glass-shine: rgba(255, 255, 255, 0.2);
        --text-main: #ffffff;
        --text-dim: rgba(255, 255, 255, 0.6);
        --accent: #00f2ff;
        --danger: #ff0055;
        --success: #00ff9d;
        --dragon-color: #8c26f0; /* New color for dragon glow */
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Outfit', sans-serif;
    }

    body {
        background: #0f0c29;
        color: var(--text-main);
        height: 100vh;
        overflow: hidden;
        display: flex;
    }

    /* --- ANIMATED BACKGROUND (AURORA) --- */
    .bg-mesh {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: 
            radial-gradient(at 0% 0%, hsla(253,16%,7%,1) 0, transparent 50%), 
            radial-gradient(at 50% 0%, hsla(225,39%,30%,1) 0, transparent 50%), 
            radial-gradient(at 100% 0%, hsla(339,49%,30%,1) 0, transparent 50%);
        z-index: -2;
    }
    
    .blob {
        position: absolute;
        filter: blur(80px);
        z-index: -1;
        opacity: 0.6;
        animation: float 10s infinite ease-in-out;
    }
    .blob-1 { top: 10%; left: 20%; width: 400px; height: 400px; background: #7b2cbf; animation-delay: 0s; }
    .blob-2 { bottom: 20%; right: 10%; width: 300px; height: 300px; background: #f72585; animation-delay: -2s; }
    .blob-3 { bottom: 10%; left: 10%; width: 350px; height: 350px; background: #4361ee; animation-delay: -4s; }

    @keyframes float {
        0%, 100% { transform: translate(0, 0) scale(1); }
        50% { transform: translate(20px, -40px) scale(1.1); }
    }

    /* --- LAYOUT --- */
    .sidebar {
        width: 90px;
        height: 96vh;
        margin: 2vh 0 2vh 2vh;
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        border-radius: 24px;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 30px 0;
        z-index: 10;
        box-shadow: 0 20px 50px rgba(0,0,0,0.2);
    }

    .main-content {
        flex: 1;
        padding: 2vh;
        height: 100vh;
        overflow-y: auto;
        position: relative;
    }

    /* --- COMPONENTS --- */
    .nav-item {
        width: 50px;
        height: 50px;
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        cursor: pointer;
        color: var(--text-dim);
        transition: 0.3s all cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
    }
    .nav-item:hover { background: var(--glass-bg); color: white; transform: scale(1.1); }
    .nav-item.active {
        background: linear-gradient(135deg, #4361ee, #f72585);
        color: white;
        box-shadow: 0 10px 20px rgba(247, 37, 133, 0.4);
    }

    .glass-card {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        border-radius: 24px;
        padding: 25px;
        transition: 0.3s;
        position: relative;
        overflow: hidden;
    }
    .glass-card:hover {
        border-color: var(--glass-shine);
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.3);
    }

    /* --- GRID DASHBOARD --- */
    .bento-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-template-rows: 150px 280px 1fr;
        gap: 20px;
        max-width: 1400px;
        margin: 0 auto;
    }

    .span-2 { grid-column: span 2; }
    .span-4 { grid-column: span 4; }
    .row-2 { grid-row: span 2; }

    h1 { font-weight: 800; font-size: 2.5rem; margin-bottom: 5px; letter-spacing: -1px; }
    h2 { font-weight: 600; font-size: 1.2rem; margin-bottom: 15px; color: var(--text-dim); }
    
    .stat-val { font-size: 2.5rem; font-weight: 700; }
    .stat-label { font-size: 0.9rem; color: var(--text-dim); text-transform: uppercase; letter-spacing: 1px; }

    /* --- WIDGETS --- */
    .welcome-widget {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, rgba(67, 97, 238, 0.2), rgba(247, 37, 133, 0.2));
    }
    
    .time-widget {
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    #clock-time { font-size: 3rem; font-weight: 800; line-height: 1; background: linear-gradient(to bottom, #fff, #aaa); -webkit-background-clip: text; -webkit-text-fill-color: transparent;}
    #clock-date { font-size: 1rem; color: var(--accent); margin-top: 5px; }

    .chart-bars {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        height: 100px;
        gap: 5px;
    }
    .bar {
        width: 100%;
        background: var(--glass-shine);
        border-radius: 4px;
        position: relative;
        overflow: hidden;
    }
    .bar-fill {
        position: absolute;
        bottom: 0; width: 100%;
        background: linear-gradient(to top, #4361ee, #4cc9f0);
        border-radius: 4px;
        transition: height 1s ease;
    }

    .terminal-box {
        background: rgba(0, 0, 0, 0.4);
        border-radius: 12px;
        padding: 15px;
        font-family: 'Courier New', monospace;
        font-size: 14px;
        height: 100%;
        overflow: hidden;
    }
    .code-green { color: var(--success); }
    .code-blue { color: #4cc9f0; }
    .code-pink { color: #f72585; }

    /* --- INTERACTIVE CANVAS (DRAGON) --- */
    #dragonCanvas {
        position: absolute;
        top: 0; left: 0;
        width: 100%; height: 100%;
        z-index: 0;
        pointer-events: none; /* Allows interaction with elements below */
    }

    .tab-content { display: none; animation: fadeIn 0.5s ease; }
    .tab-content.active { display: block; }
    @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

    .profile-img {
        width: 50px; height: 50px; border-radius: 50%;
        background: url('https://api.dicebear.com/7.x/avataaars/svg?seed=FeriDev'); /* Avatar for Feri */
        border: 2px solid white;
        margin-top: auto;
        margin-bottom: 20px;
    }

    /* List Styles */
    .list-item {
        display: flex;
        align-items: center;
        padding: 12px;
        border-bottom: 1px solid var(--glass-border);
        transition: 0.2s;
    }
    .list-item:hover { background: rgba(255,255,255,0.05); padding-left: 20px; }
    .dot { width: 10px; height: 10px; border-radius: 50%; margin-right: 15px; }
</style>
</head>
<body>

    <div class="bg-mesh"></div>
    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>
    <div class="blob blob-3"></div>

    <nav class="sidebar">
        <div style="font-size: 24px; font-weight:800; margin-bottom: 40px; color:white;">A.</div>
        
        <div class="nav-item active" onclick="switchTab('dash', this)">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
        </div>
        <div class="nav-item" onclick="switchTab('code', this)">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
        </div>
        <div class="nav-item" onclick="switchTab('analytics', this)">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
        </div>

        <div class="profile-img"></div>
    </nav>

    <main class="main-content">
        
        <div id="dash" class="tab-content active">
            <div class="bento-grid">
                <div class="glass-card span-2 welcome-widget">
                    <div>
                        <h1 id="greeting">Hello, Feri</h1>
                        <p style="color:rgba(255,255,255,0.8)">Your server architecture is running smoothly.</p>
                    </div>
                    <div style="font-size: 4rem; opacity: 0.2;">🚀</div>
                </div>

                <div class="glass-card time-widget">
                    <div id="clock-time">12:00</div>
                    <div id="clock-date">Mon, 20 Nov</div>
                </div>

                <div class="glass-card" style="display:flex; align-items:center; justify-content:center; flex-direction:column">
                    <div class="stat-label">System Load</div>
                    <div style="position:relative; width:100px; height:100px; margin:10px 0;">
                        <svg viewBox="0 0 36 36" style="width:100%; height:100%; transform:rotate(-90deg)">
                            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="3"/>
                            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#00f2ff" stroke-width="3" stroke-dasharray="75, 100"/>
                        </svg>
                        <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); font-weight:bold">75%</div>
                    </div>
                </div>

                <div class="glass-card span-2 row-2" style="position:relative">
                    <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
                        <h2>Traffic Analytics</h2>
                        <button style="background:var(--glass-shine); border:none; color:white; padding:5px 15px; border-radius:20px">Live</button>
                    </div>
                    <canvas id="trafficCanvas" style="width:100%; height:200px;"></canvas>
                    <div class="chart-bars" style="margin-top:20px">
                        <div class="bar"><div class="bar-fill" style="height:40%"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:70%"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:50%"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:90%; background: #f72585"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:60%"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:30%"></div></div>
                        <div class="bar"><div class="bar-fill" style="height:80%"></div></div>
                    </div>
                </div>

                <div class="glass-card span-2 row-2">
                    <h2>Active Deployments</h2>
                    <div style="display:flex; flex-direction:column; gap:5px;">
                        <div class="list-item">
                            <div class="dot" style="background:var(--success)"></div>
                            <div style="flex:1">
                                <div style="font-weight:600">E-Commerce API</div>
                                <div style="font-size:12px; color:var(--text-dim)">Maven Build • Running</div>
                            </div>
                            <div style="font-family:monospace; color:var(--accent)">v2.4.0</div>
                        </div>
                        <div class="list-item">
                            <div class="dot" style="background:var(--danger)"></div>
                            <div style="flex:1">
                                <div style="font-weight:600">Auth Service</div>
                                <div style="font-size:12px; color:var(--text-dim)">Error 502 • Restarting...</div>
                            </div>
                            <div style="font-family:monospace; color:var(--danger)">Failed</div>
                        </div>
                        <div class="list-item">
                            <div class="dot" style="background:orange"></div>
                            <div style="flex:1">
                                <div style="font-weight:600">Frontend React</div>
                                <div style="font-size:12px; color:var(--text-dim)">Building...</div>
                            </div>
                            <div style="font-family:monospace;">89%</div>
                        </div>
                    </div>
                    
                    <div style="margin-top:20px; padding:15px; background:rgba(0,0,0,0.2); border-radius:12px;">
                        <div style="font-size:12px; color:var(--text-dim); margin-bottom:5px">STORAGE USAGE</div>
                        <div style="width:100%; height:6px; background:rgba(255,255,255,0.1); border-radius:3px">
                            <div style="width:65%; height:100%; background:var(--accent); border-radius:3px; box-shadow:0 0 10px var(--accent)"></div>
                        </div>
                        <div style="text-align:right; font-size:12px; margin-top:5px">650GB / 1TB</div>
                    </div>
                </div>

            </div>
        </div>

        <div id="code" class="tab-content">
            <div class="glass-card" style="height: 90vh; display:flex; flex-direction:column">
                <div style="padding-bottom:15px; border-bottom:1px solid var(--glass-border); display:flex; gap:10px">
                    <div style="width:12px; height:12px; border-radius:50%; background:#ff5f56"></div>
                    <div style="width:12px; height:12px; border-radius:50%; background:#ffbd2e"></div>
                    <div style="width:12px; height:12px; border-radius:50%; background:#27c93f"></div>
                    <span style="margin-left:10px; font-size:12px; color:var(--text-dim)">HelloServlet.java</span>
                </div>
                <div class="terminal-box" style="background:transparent; padding-top:20px; font-size:16px;">
                    <div><span class="code-pink">package</span> com.example;</div><br>
                    <div><span class="code-pink">import</span> java.io.*;</div>
                    <div><span class="code-pink">import</span> javax.servlet.http.*;</div><br>
                    <div><span class="code-blue">public class</span> <span class="code-green">HelloServlet</span> <span class="code-blue">extends</span> HttpServlet {</div>
                    <div style="padding-left:20px"><span class="code-blue">public void</span> doGet(HttpServletRequest req, HttpServletResponse res) {</div>
                    <div style="padding-left:40px">res.setContentType(<span class="code-green">"text/html"</span>);</div>
                    <div style="padding-left:40px">PrintWriter out = res.getWriter();</div>
                    <div style="padding-left:40px">out.println(<span class="code-green">"&lt;h1&gt;Hello from Aurora OS&lt;/h1&gt;"</span>);</div>
                    <div style="padding-left:20px">}</div>
                    <div>}</div>
                    <br>
                    <div style="border-top:1px solid var(--glass-border); padding-top:20px">
                        <span class="code-green">user@aurora:~$</span> mvn clean install<br>
                        <span style="color:var(--text-dim)">[INFO] Scanning for projects...</span><br>
                        <span style="color:var(--text-dim)">[INFO] BUILD SUCCESS</span><br>
                        <span class="code-green">user@aurora:~$</span> _
                    </div>
                </div>
            </div>
        </div>
        
        <div id="analytics" class="tab-content">
            <div class="glass-card" style="height:90vh; display:flex; flex-direction:column; justify-content:center; align-items:center;">
                <h1 style="font-size:3rem;">Advanced Analytics</h1>
                <p style="color:var(--text-dim)">Coming soon to optimize your workflow with AI insights!</p>
                <div style="font-size: 5rem; margin-top:30px; opacity:0.3;">📊</div>
            </div>
        </div>

    </main>

    <canvas id="dragonCanvas"></canvas>

    <script>
        // --- CLOCK LOGIC ---
        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            document.getElementById('clock-time').innerText = hours + ":" + minutes;
            
            const options = { weekday: 'short', day: 'numeric', month: 'short' };
            document.getElementById('clock-date').innerText = now.toLocaleDateString('en-US', options);
            
            // Update Greeting
            const hour = now.getHours();
            let greet = "Good Evening";
            if(hour < 12) greet = "Good Morning";
            else if(hour < 18) greet = "Good Afternoon";
            document.getElementById('greeting').innerText = greet + ", Feri"; // Personalized greeting for Feri
        }
        setInterval(updateClock, 1000);
        updateClock();

        // --- TAB SWITCHER ---
        window.switchTab = function(tabId, el) {
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            
            document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
            el.classList.add('active');
        }

        // --- TRAFFIC CHART (SIMPLE LINE) ---
        const tCanvas = document.getElementById('trafficCanvas');
        if(tCanvas) {
            const tCtx = tCanvas.getContext('2d');
            // Fix scale
            tCanvas.width = tCanvas.parentElement.offsetWidth;
            tCanvas.height = 200;
            
            let points = [];
            for(let i=0; i<10; i++) points.push(Math.random() * 100 + 50);
            
            function drawChart() {
                tCtx.clearRect(0,0,tCanvas.width, tCanvas.height);
                
                tCtx.beginPath();
                tCtx.strokeStyle = '#00f2ff';
                tCtx.lineWidth = 3;
                tCtx.shadowBlur = 10;
                tCtx.shadowColor = '#00f2ff';
                
                const step = tCanvas.width / (points.length - 1);
                
                points.forEach((p, i) => {
                    const x = i * step;
                    const y = tCanvas.height - p;
                    if(i===0) tCtx.moveTo(x, y);
                    else tCtx.lineTo(x, y);
                });
                tCtx.stroke();
                
                // Area gradient
                tCtx.lineTo(tCanvas.width, tCanvas.height);
                tCtx.lineTo(0, tCanvas.height);
                const grad = tCtx.createLinearGradient(0, 0, 0, tCanvas.height);
                grad.addColorStop(0, 'rgba(0, 242, 255, 0.2)');
                grad.addColorStop(1, 'transparent');
                tCtx.fillStyle = grad;
                tCtx.fill();
            }
            drawChart();
        }
    </script>
    <script src="js/dragon-viz.js"></script>
</body>
</html>
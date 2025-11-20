// js/dragon-viz.js

const dragonCanvas = document.getElementById('dragonCanvas');
const dCtx = dragonCanvas.getContext('2d');
let dragonSegments = []; // Array to store dragon body segments
let mouse = { x: 0, y: 0 };
const segmentSize = 25; // Size of each segment
const numSegments = 10; // Number of body segments
const trailParticles = []; // For the glowing trail

// Helper function to get a random color variation
function getDragonGlowColor(alpha = 1) {
    const baseColor = [140, 38, 240]; // Base RGB for #8c26f0
    const r = baseColor[0] + Math.floor(Math.random() * 30 - 15);
    const g = baseColor[1] + Math.floor(Math.random() * 30 - 15);
    const b = baseColor[2] + Math.floor(Math.random() * 30 - 15);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// Particle for dragon trail
class TrailParticle {
    constructor(x, y) {
        this.x = x;
        this.y = y;
        this.size = Math.random() * 5 + 2;
        this.life = 100; // frames
        this.vx = (Math.random() - 0.5) * 1;
        this.vy = (Math.random() - 0.5) * 1;
        this.color = getDragonGlowColor(0.8);
    }
    update() {
        this.x += this.vx;
        this.y += this.vy;
        this.life--;
        this.size *= 0.95; // Shrink over time
    }
    draw() {
        if (this.life <= 0) return;
        dCtx.globalAlpha = this.life / 100;
        dCtx.fillStyle = this.color;
        dCtx.beginPath();
        dCtx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        dCtx.fill();
        dCtx.globalAlpha = 1;
    }
}

// Initialize dragon segments
function initDragon() {
    dragonSegments = [];
    for (let i = 0; i < numSegments; i++) {
        dragonSegments.push({ x: mouse.x, y: mouse.y });
    }
}

// Resize canvas and re-initialize dragon position
function resizeDragonCanvas() {
    dragonCanvas.width = window.innerWidth;
    dragonCanvas.height = window.innerHeight;
    initDragon(); // Re-initialize segments on resize
}
window.addEventListener('resize', resizeDragonCanvas);
resizeDragonCanvas(); // Initial resize

// Update mouse position
window.addEventListener('mousemove', (e) => {
    mouse.x = e.clientX;
    mouse.y = e.clientY;
});

function animateDragon() {
    dCtx.clearRect(0, 0, dragonCanvas.width, dragonCanvas.height);

    // Update segments
    // Head follows mouse
    dragonSegments[0].x += (mouse.x - dragonSegments[0].x) * 0.15; // Smoother follow
    dragonSegments[0].y += (mouse.y - dragonSegments[0].y) * 0.15;

    // Body segments follow previous segment
    for (let i = 1; i < numSegments; i++) {
        const prev = dragonSegments[i - 1];
        const curr = dragonSegments[i];

        const dx = prev.x - curr.x;
        const dy = prev.y - curr.y;
        const distance = Math.sqrt(dx * dx + dy * dy);

        // Keep segments at a fixed distance
        if (distance > segmentSize) {
            curr.x = prev.x - (dx / distance) * segmentSize;
            curr.y = prev.y - (dy / distance) * segmentSize;
        }
    }

    // Draw dragon (simplified silhouette)
    for (let i = 0; i < numSegments; i++) {
        const seg = dragonSegments[i];
        const nextSeg = dragonSegments[i + 1];

        // Head
        if (i === 0) {
            dCtx.beginPath();
            dCtx.arc(seg.x, seg.y, segmentSize * 0.8, 0, Math.PI * 2); // Larger head
            dCtx.fillStyle = 'white';
            dCtx.shadowColor = getDragonGlowColor(0.8);
            dCtx.shadowBlur = 30;
            dCtx.fill();
            dCtx.shadowBlur = 0;

const eyeOffset = 10;
            const eyeSep = 0.5; // Separation angle

            // Glowing Eyes (Cyan Accent)
            dCtx.fillStyle = '#00f2ff'; 
            dCtx.shadowColor = '#00f2ff';
            dCtx.shadowBlur = 15;

            // Left Eye
            dCtx.beginPath();
            dCtx.arc(
                seg.x + Math.cos(angleToMouse - eyeSep) * eyeOffset,
                seg.y + Math.sin(angleToMouse - eyeSep) * eyeOffset, 
                3, 0, Math.PI * 2
            );
            dCtx.fill();

            // Right Eye
            dCtx.beginPath();
            dCtx.arc(
                seg.x + Math.cos(angleToMouse + eyeSep) * eyeOffset,
                seg.y + Math.sin(angleToMouse + eyeSep) * eyeOffset, 
                3, 0, Math.PI * 2
            );
            dCtx.fill();
            dCtx.shadowBlur = 0; // Reset shadow
        } 
        // Body Segments
        else {
            // Tapering logic: segments get smaller towards the tail
            const size = (segmentSize * 0.6) * ((numSegments - i) / numSegments);

            dCtx.beginPath();
            dCtx.arc(seg.x, seg.y, size, 0, Math.PI * 2);
            
            // Body Style: Glassy Purple
            dCtx.fillStyle = getDragonGlowColor(0.4); 
            dCtx.shadowBlur = 20;
            dCtx.shadowColor = getDragonGlowColor(0.8);
            dCtx.fill();
            dCtx.shadowBlur = 0;

            // Add a "spine" connection line
            if (i > 0) {
                const prev = dragonSegments[i-1];
                dCtx.beginPath();
                dCtx.moveTo(prev.x, prev.y);
                dCtx.lineTo(seg.x, seg.y);
                dCtx.strokeStyle = 'rgba(255, 255, 255, 0.2)';
                dCtx.lineWidth = 2;
                dCtx.stroke();
            }

            // Emit particles from the tail for the "Magic Trail" effect
            if (i === numSegments - 1) {
                if (Math.random() < 0.6) {
                    trailParticles.push(new TrailParticle(seg.x, seg.y));
                }
            }
        }
    }

    // Update and draw trail particles
    for (let i = 0; i < trailParticles.length; i++) {
        trailParticles[i].update();
        trailParticles[i].draw();

        // Remove dead particles
        if (trailParticles[i].life <= 0) {
            trailParticles.splice(i, 1);
            i--;
        }
    }

    requestAnimationFrame(animateDragon);
}

// Start the animation
initDragon();
animateDragon();
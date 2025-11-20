// js/dragon-viz.js

console.log("Dragon System Initiated..."); // Cek console browser kalau ini muncul

const dragonCanvas = document.getElementById('dragonCanvas');
const dCtx = dragonCanvas.getContext('2d');

let dragonSegments = []; // Array untuk menyimpan segmen badan naga
let mouse = { x: window.innerWidth / 2, y: window.innerHeight / 2 }; // Posisi awal di tengah
const segmentSize = 20; // Ukuran per segmen
const numSegments = 15; // Jumlah segmen (makin banyak makin panjang)
const trailParticles = []; // Jejak partikel

// Fungsi warna naga (Ungu/Biru Neon)
function getDragonGlowColor(alpha = 1) {
    // Warna dasar RGB: Ungu (#8c26f0) -> 140, 38, 240
    const r = 140 + Math.floor(Math.random() * 50); 
    const g = 50 + Math.floor(Math.random() * 50);
    const b = 255; 
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// Class untuk Partikel Jejak (Trail)
class TrailParticle {
    constructor(x, y) {
        this.x = x;
        this.y = y;
        this.size = Math.random() * 4 + 2;
        this.life = 60; // Umur partikel
        this.vx = (Math.random() - 0.5) * 2;
        this.vy = (Math.random() - 0.5) * 2;
        this.color = getDragonGlowColor(0.6);
    }
    update() {
        this.x += this.vx;
        this.y += this.vy;
        this.life--;
        this.size *= 0.90; // Mengecil perlahan
    }
    draw() {
        if (this.life <= 0) return;
        dCtx.globalAlpha = this.life / 60;
        dCtx.fillStyle = this.color;
        dCtx.beginPath();
        dCtx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        dCtx.fill();
        dCtx.globalAlpha = 1;
    }
}

// Inisialisasi Segmen Naga
function initDragon() {
    dragonSegments = [];
    for (let i = 0; i < numSegments; i++) {
        dragonSegments.push({ x: mouse.x, y: mouse.y });
    }
}

// Resize Canvas
function resizeDragonCanvas() {
    dragonCanvas.width = window.innerWidth;
    dragonCanvas.height = window.innerHeight;
    initDragon();
}
window.addEventListener('resize', resizeDragonCanvas);

// Update Posisi Mouse
window.addEventListener('mousemove', (e) => {
    mouse.x = e.clientX;
    mouse.y = e.clientY;
});

// Loop Animasi Utama
function animateDragon() {
    dCtx.clearRect(0, 0, dragonCanvas.width, dragonCanvas.height);

    // --- LOGIKA PERGERAKAN ---
    
    // Kepala (segmen 0) mengikuti mouse dengan easing (biar smooth)
    let head = dragonSegments[0];
    head.x += (mouse.x - head.x) * 0.12;
    head.y += (mouse.y - head.y) * 0.12;

    // Badan mengikuti segmen di depannya
    for (let i = 1; i < numSegments; i++) {
        const prev = dragonSegments[i - 1];
        const curr = dragonSegments[i];

        const dx = prev.x - curr.x;
        const dy = prev.y - curr.y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        const angle = Math.atan2(dy, dx);

        // Menjaga jarak antar segmen (Inverse Kinematics sederhana)
        if (dist > segmentSize * 0.5) { 
            const targetDist = segmentSize * 0.5;
            const moveX = dx - Math.cos(angle) * targetDist;
            const moveY = dy - Math.sin(angle) * targetDist;
            
            curr.x += moveX * 0.5; // 0.5 adalah stiffness
            curr.y += moveY * 0.5;
        }
    }

    // --- LOGIKA GAMBAR ---

    // Render Jejak Partikel dulu (di belakang naga)
    for (let i = 0; i < trailParticles.length; i++) {
        trailParticles[i].update();
        trailParticles[i].draw();
        if (trailParticles[i].life <= 0) {
            trailParticles.splice(i, 1);
            i--;
        }
    }

    // Render Naga
    for (let i = numSegments - 1; i >= 0; i--) {
        const seg = dragonSegments[i];
        
        dCtx.save();
        dCtx.translate(seg.x, seg.y);

        // Hitung rotasi segmen agar menghadap ke arah gerakan
        if (i > 0) {
            const prev = dragonSegments[i-1];
            const angle = Math.atan2(prev.y - seg.y, prev.x - seg.x);
            dCtx.rotate(angle);
        } else {
            // Rotasi kepala menghadap mouse
            const angle = Math.atan2(mouse.y - seg.y, mouse.x - seg.x);
            dCtx.rotate(angle);
        }

        if (i === 0) {
            // --- KEPALA NAGA ---
            dCtx.fillStyle = '#ffffff';
            dCtx.shadowColor = '#00f2ff';
            dCtx.shadowBlur = 30;
            
            // Gambar bentuk kepala lonjong
            dCtx.beginPath();
            dCtx.ellipse(5, 0, 18, 12, 0, 0, Math.PI*2);
            dCtx.fill();

            // Mata (Glowing Eyes)
            dCtx.shadowBlur = 0;
            dCtx.fillStyle = '#00f2ff'; // Cyan Eyes
            dCtx.beginPath();
            dCtx.arc(10, -6, 3, 0, Math.PI*2); // Mata Kiri
            dCtx.arc(10, 6, 3, 0, Math.PI*2);  // Mata Kanan
            dCtx.fill();

        } else {
            // --- BADAN NAGA ---
            // Makin ke belakang makin kecil (Tapering)
            const scale = 1 - (i / numSegments); 
            const size = segmentSize * (0.5 + 0.5 * scale);

            dCtx.fillStyle = getDragonGlowColor(0.4 + (0.4 * scale));
            dCtx.shadowColor = '#8c26f0';
            dCtx.shadowBlur = 15 * scale;

            dCtx.beginPath();
            // Gambar sirip/duri sedikit
            if (i % 3 === 0) {
                dCtx.moveTo(-size, -size*1.5);
                dCtx.lineTo(size, 0);
                dCtx.lineTo(-size, size*1.5);
            }
            dCtx.arc(0, 0, size, 0, Math.PI * 2);
            dCtx.fill();

            // Emit partikel dari ekor
            if (i === numSegments - 1 && Math.random() > 0.5) {
                // Perbaiki posisi partikel (gunakan posisi global seg, bukan relatif)
                // Karena kita pakai translate, kita harus kembalikan koordinat ke global untuk partikel
                // Tapi class TrailParticle pakai koordinat global.
                // Solusi: Ambil seg.x dan seg.y dari variabel loop, bukan 0,0
            }
        }
        dCtx.restore();

        // Emit partikel di luar translate (pakai koordinat global)
        if (i === numSegments - 1 && Math.random() > 0.7) {
            trailParticles.push(new TrailParticle(seg.x, seg.y));
        }
    }

    requestAnimationFrame(animateDragon);
}

// Jalankan
resizeDragonCanvas();
animateDragon();
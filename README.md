<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NEON HUB - Blox Fruits</title>
    <style>
        :root {
            --primary-color: #00a8ff;
            --secondary-color: #0097e6;
            --background-color: #1e272e;
            --card-color: #2f3640;
            --text-color: #f5f6fa;
            --danger-color: #e84118;
            --success-color: #4cd137;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .creator {
            font-style: italic;
            opacity: 0.8;
        }
        
        .version {
            background-color: rgba(0, 0, 0, 0.2);
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-block;
            margin-top: 10px;
        }
        
        .tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .tab-btn {
            padding: 10px 20px;
            background-color: var(--card-color);
            border: none;
            border-radius: 5px;
            color: var(--text-color);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
        }
        
        .tab-btn:hover {
            background-color: var(--primary-color);
        }
        
        .tab-btn.active {
            background-color: var(--primary-color);
        }
        
        .tab-content {
            display: none;
            background-color: var(--card-color);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .tab-content.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .section {
            margin-bottom: 25px;
        }
        
        .section-title {
            font-size: 1.3rem;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 2px solid var(--primary-color);
            display: inline-block;
        }
        
        .control-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .control {
            background-color: rgba(0, 0, 0, 0.2);
            padding: 15px;
            border-radius: 8px;
            flex: 1 1 300px;
            min-width: 250px;
        }
        
        .control-title {
            font-weight: bold;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }
        
        .control-title i {
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .control-desc {
            font-size: 0.9rem;
            opacity: 0.8;
            margin-bottom: 12px;
        }
        
        .toggle {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }
        
        .toggle input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }
        
        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        
        input:checked + .slider {
            background-color: var(--success-color);
        }
        
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: var(--primary-color);
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
        }
        
        .btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background-color: var(--danger-color);
        }
        
        .btn-danger:hover {
            background-color: #c23616;
        }
        
        select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: rgba(0, 0, 0, 0.2);
            color: var(--text-color);
            margin-bottom: 10px;
        }
        
        .slider-control {
            width: 100%;
        }
        
        .slider-value {
            display: inline-block;
            margin-left: 10px;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            display: inline-block;
            margin-left: 10px;
        }
        
        .status-on {
            background-color: var(--success-color);
        }
        
        .status-off {
            background-color: var(--danger-color);
        }
        
        footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            opacity: 0.7;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .control {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>NEON HUB</h1>
            <p class="creator">Created by XxxzgyxxX</p>
            <span class="version">v1.5 - Blox Fruits</span>
        </header>
        
        <div class="tabs">
            <button class="tab-btn active" data-tab="main">Main</button>
            <button class="tab-btn" data-tab="autofarm">Auto Farm</button>
            <button class="tab-btn" data-tab="player">Player</button>
            <button class="tab-btn" data-tab="teleport">Teleport</button>
            <button class="tab-btn" data-tab="misc">Misc</button>
        </div>
        
        <!-- Main Tab -->
        <div id="main" class="tab-content active">
            <div class="section">
                <h3 class="section-title">Main Features</h3>
                <div class="control-group">
                    <div class="control">
                        <div class="control-title"><i>⚙️</i> Auto Farm</div>
                        <div class="control-desc">Automatically farms nearby NPCs</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoFarm">
                            <span class="slider"></span>
                        </label>
                        <span id="autoFarmStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🏰</i> Auto Dungeon</div>
                        <div class="control-desc">Automatically completes dungeons</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoDungeon">
                            <span class="slider"></span>
                        </label>
                        <span id="autoDungeonStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🌊</i> Auto Sea Events</div>
                        <div class="control-desc">Automatically completes sea events</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoSeaEvents">
                            <span class="slider"></span>
                        </label>
                        <span id="autoSeaEventsStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🌎</i> Auto New World</div>
                        <div class="control-desc">Automatically travels to New World</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoNewWorld">
                            <span class="slider"></span>
                        </label>
                        <span id="autoNewWorldStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🔥</i> Auto Third Sea</div>
                        <div class="control-desc">Automatically travels to Third Sea</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoThirdSea">
                            <span class="slider"></span>
                        </label>
                        <span id="autoThirdSeaStatus" class="status status-off">OFF</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Auto Farm Tab -->
        <div id="autofarm" class="tab-content">
            <div class="section">
                <h3 class="section-title">Auto Farm Options</h3>
                <div class="control-group">
                    <div class="control">
                        <div class="control-title"><i>📈</i> Auto Farm Levels</div>
                        <div class="control-desc">Automatically farms levels</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoFarmLevel">
                            <span class="slider"></span>
                        </label>
                        <span id="autoFarmLevelStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>💰</i> Auto Farm Beli</div>
                        <div class="control-desc">Automatically farms Beli</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoFarmBeli">
                            <span class="slider"></span>
                        </label>
                        <span id="autoFarmBeliStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>💎</i> Auto Farm Fragments</div>
                        <div class="control-desc">Automatically farms Fragments</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoFarmFragments">
                            <span class="slider"></span>
                        </label>
                        <span id="autoFarmFragmentsStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>⚔️</i> Select Weapon</div>
                        <div class="control-desc">Select your weapon</div>
                        <select id="weaponSelect">
                            <option value="melee">Melee</option>
                            <option value="sword">Sword</option>
                            <option value="gun">Gun</option>
                            <option value="fruit">Fruit</option>
                        </select>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🏝️</i> Select Island</div>
                        <div class="control-desc">Select an island</div>
                        <select id="islandSelect">
                            <option value="first">First Island</option>
                            <option value="second">Second Island</option>
                            <option value="third">Third Island</option>
                        </select>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>👹</i> Select Boss</div>
                        <div class="control-desc">Select a boss</div>
                        <select id="bossSelect">
                            <option value="boss1">Boss 1</option>
                            <option value="boss2">Boss 2</option>
                            <option value="boss3">Boss 3</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Player Tab -->
        <div id="player" class="tab-content">
            <div class="section">
                <h3 class="section-title">Player Modifications</h3>
                <div class="control-group">
                    <div class="control">
                        <div class="control-title"><i>🏃‍♂️</i> Walk Speed</div>
                        <div class="control-desc">Changes your walk speed</div>
                        <input type="range" min="16" max="500" value="16" class="slider-control" id="walkSpeed">
                        <span class="slider-value" id="walkSpeedValue">16</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🦘</i> Jump Power</div>
                        <div class="control-desc">Changes your jump power</div>
                        <input type="range" min="50" max="500" value="50" class="slider-control" id="jumpPower">
                        <span class="slider-value" id="jumpPowerValue">50</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>👁️</i> Player ESP</div>
                        <div class="control-desc">Shows players through walls</div>
                        <label class="toggle">
                            <input type="checkbox" id="playerESP">
                            <span class="slider"></span>
                        </label>
                        <span id="playerESPStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🛡️</i> Auto Ken</div>
                        <div class="control-desc">Automatically uses Ken</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoKen">
                            <span class="slider"></span>
                        </label>
                        <span id="autoKenStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🔮</i> Auto Haki</div>
                        <div class="control-desc">Automatically uses Haki</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoHaki">
                            <span class="slider"></span>
                        </label>
                        <span id="autoHakiStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>💪</i> Auto Buso</div>
                        <div class="control-desc">Automatically uses Buso Haki</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoBuso">
                            <span class="slider"></span>
                        </label>
                        <span id="autoBusoStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>👀</i> Auto Observation</div>
                        <div class="control-desc">Automatically uses Observation Haki</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoObservation">
                            <span class="slider"></span>
                        </label>
                        <span id="autoObservationStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>⚡</i> Auto Soru</div>
                        <div class="control-desc">Automatically uses Soru</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoSoru">
                            <span class="slider"></span>
                        </label>
                        <span id="autoSoruStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🦅</i> Auto Geppo</div>
                        <div class="control-desc">Automatically uses Geppo</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoGeppo">
                            <span class="slider"></span>
                        </label>
                        <span id="autoGeppoStatus" class="status status-off">OFF</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Teleport Tab -->
        <div id="teleport" class="tab-content">
            <div class="section">
                <h3 class="section-title">Teleport Options</h3>
                <div class="control-group">
                    <div class="control">
                        <div class="control-title"><i>🏝️</i> Teleport to Selected Island</div>
                        <div class="control-desc">Teleports to selected island</div>
                        <button class="btn" id="teleportIsland">Teleport</button>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>👹</i> Teleport to Selected Boss</div>
                        <div class="control-desc">Teleports to selected boss</div>
                        <button class="btn" id="teleportBoss">Teleport</button>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>👤</i> Teleport to Player</div>
                        <div class="control-desc">Teleports to a player</div>
                        <button class="btn" id="teleportPlayer">Teleport</button>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🛡️</i> Teleport to Safe Zone</div>
                        <div class="control-desc">Teleports to safe zone</div>
                        <button class="btn" id="teleportSafeZone">Teleport</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Misc Tab -->
        <div id="misc" class="tab-content">
            <div class="section">
                <h3 class="section-title">Miscellaneous</h3>
                <div class="control-group">
                    <div class="control">
                        <div class="control-title"><i>🍎</i> Auto Collect Fruits</div>
                        <div class="control-desc">Automatically collects fruits</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoCollectFruits">
                            <span class="slider"></span>
                        </label>
                        <span id="autoCollectFruitsStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🧰</i> Auto Collect Chests</div>
                        <div class="control-desc">Automatically collects chests</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoCollectChests">
                            <span class="slider"></span>
                        </label>
                        <span id="autoCollectChestsStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🛒</i> Auto Buy Items</div>
                        <div class="control-desc">Automatically buys items</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoBuy">
                            <span class="slider"></span>
                        </label>
                        <span id="autoBuyStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>💰</i> Auto Sell Items</div>
                        <div class="control-desc">Automatically sells items</div>
                        <label class="toggle">
                            <input type="checkbox" id="autoSell">
                            <span class="slider"></span>
                        </label>
                        <span id="autoSellStatus" class="status status-off">OFF</span>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🔄</i> Rejoin Server</div>
                        <div class="control-desc">Rejoins the current server</div>
                        <button class="btn" id="rejoinServer">Rejoin</button>
                    </div>
                    
                    <div class="control">
                        <div class="control-title"><i>🌐</i> Server Hop</div>
                        <div class="control-desc">Joins a different server</div>
                        <button class="btn" id="serverHop">Hop Server</button>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            NEON HUB - Blox Fruits Script | Created by XxxzgyxxX | v1.5
            <br>
            <small>This is a UI demonstration only. Actual functionality requires integration with game scripts.</small>
        </footer>
    </div>
    
    <script>
        // Tab functionality
        const tabBtns = document.querySelectorAll('.tab-btn');
        const tabContents = document.querySelectorAll('.tab-content');
        
        tabBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                const tabId = btn.getAttribute('data-tab');
                
                // Remove active class from all buttons and contents
                tabBtns.forEach(b => b.classList.remove('active'));
                tabContents.forEach(c => c.classList.remove('active'));
                
                // Add active class to clicked button and corresponding content
                btn.classList.add('active');
                document.getElementById(tabId).classList.add('active');
            });
        });
        
        // Toggle switches functionality
        const toggleSwitches = document.querySelectorAll('.toggle input');
        
        toggleSwitches.forEach(switchEl => {
            switchEl.addEventListener('change', function() {
                const statusId = this.id + 'Status';
                const statusEl = document.getElementById(statusId);
                
                if (this.checked) {
                    statusEl.textContent = 'ON';
                    statusEl.classList.remove('status-off');
                    statusEl.classList.add('status-on');
                    console.log(`${this.id} activated`);
                    // Here you would add the actual functionality
                } else {
                    statusEl.textContent = 'OFF';
                    statusEl.classList.remove('status-on');
                    statusEl.classList.add('status-off');
                    console.log(`${this.id} deactivated`);
                    // Here you would remove the actual functionality
                }
            });
        });
        
        // Sliders functionality
        const walkSpeedSlider = document.getElementById('walkSpeed');
        const walkSpeedValue = document.getElementById('walkSpeedValue');
        const jumpPowerSlider = document.getElementById('jumpPower');
        const jumpPowerValue = document.getElementById('jumpPowerValue');
        
        walkSpeedSlider.addEventListener('input', function() {
            walkSpeedValue.textContent = this.value;
            console.log(`Walk speed set to: ${this.value}`);
            // Here you would set the actual walk speed in the game
        });
        
        jumpPowerSlider.addEventListener('input', function() {
            jumpPowerValue.textContent = this.value;
            console.log(`Jump power set to: ${this.value}`);
            // Here you would set the actual jump power in the game
        });
        
        // Buttons functionality
        document.getElementById('teleportIsland').addEventListener('click', function() {
            const island = document.getElementById('islandSelect').value;
            console.log(`Teleporting to ${island}`);
            alert(`Teleporting to ${island} (simulated)`);
            // Here you would add the actual teleport functionality
        });
        
        document.getElementById('teleportBoss').addEventListener('click', function() {
            const boss = document.getElementById('bossSelect').value;
            console.log(`Teleporting to ${boss}`);
            alert(`Teleporting to ${boss} (simulated)`);
            // Here you would add the actual teleport functionality
        });
        
        document.getElementById('teleportPlayer').addEventListener('click', function() {
            console.log('Teleporting to player');
            alert('Teleporting to nearest player (simulated)');
            // Here you would add the actual teleport functionality
        });
        
        document.getElementById('teleportSafeZone').addEventListener('click', function() {
            console.log('Teleporting to safe zone');
            alert('Teleporting to safe zone (simulated)');
            // Here you would add the actual teleport functionality
        });
        
        document.getElementById('rejoinServer').addEventListener('click', function() {
            console.log('Rejoining server');
            alert('Rejoining server (simulated)');
            // Here you would add the actual rejoin functionality
        });
        
        document.getElementById('serverHop').addEventListener('click', function() {
            console.log('Server hopping');
            alert('Server hopping (simulated)');
            // Here you would add the actual server hop functionality
        });
        
        // Initialize
        console.log('NEON HUB loaded successfully! Created by XxxzgyxxX');
    </script>
</body>
</html>

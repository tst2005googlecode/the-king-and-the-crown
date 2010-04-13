--
--    The King And The Crown
--    Copyright (C) 2010  Damien Carol damien.carol@gmail.com
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--


require("unit.lua")
require("castle.lua")
require("room.lua")
require("cell.lua")

systems = {}
current = 1

units = {}

--- Call back function of the 'love' engine
-- Load all sprites
-- @author Damien Carol <damien.carol@gmail.com>
function love.load()

    -- load sprites defined in table
    graphics = {castle = love.graphics.newImage("castle.png"),
                grass = love.graphics.newImage("grass.png"),
                unknow001 = love.graphics.newImage("unknow001.png"),
                archer001 = love.graphics.newImage("archer001.png"),
                knight001 = love.graphics.newImage("knight001.png"),
                
                
                roomBLOCK = love.graphics.newImage("block.png"),
                roomFREE = love.graphics.newImage("free.png"),
                
                dungeon = {},
                
                room000 = love.graphics.newImage("room000.png"),
                room001 = love.graphics.newImage("room000.png"),
                room002 = love.graphics.newImage("room002.png"),
                room004 = love.graphics.newImage("room002.png"),
                room009 = love.graphics.newImage("room009.png"),
                room018 = love.graphics.newImage("room018.png"),
                room019 = love.graphics.newImage("room019.png"),
                room032 = love.graphics.newImage("room032.png"),
                room036 = love.graphics.newImage("room000.png"),
                room038 = love.graphics.newImage("room038.png"),
                room050 = love.graphics.newImage("room050.png"),
                room064 = love.graphics.newImage("room000.png"),
                room072 = love.graphics.newImage("room072.png"),
                room073 = love.graphics.newImage("room073.png"),
                room091 = love.graphics.newImage("room091.png"),
                room127 = love.graphics.newImage("room127.png"),
                room128 = love.graphics.newImage("room000.png"),
                room144 = love.graphics.newImage("room144.png"),
                room146 = love.graphics.newImage("room146.png"),
                room182 = love.graphics.newImage("room182.png"),
                room216 = love.graphics.newImage("room216.png"),
                room218 = love.graphics.newImage("room218.png"),
                room219 = love.graphics.newImage("room219.png"),
                room256 = love.graphics.newImage("room256.png"),
                room288 = love.graphics.newImage("room002.png"),
                room432 = love.graphics.newImage("room432.png"),
                room434 = love.graphics.newImage("room434.png"),
                room438 = love.graphics.newImage("room438.png"),
                room504 = love.graphics.newImage("room504.png"),
                room506 = love.graphics.newImage("room506.png"),
                room1240 = love.graphics.newImage("room1240.png"),
                room1456 = love.graphics.newImage("room1456.png"),
                room1752 = love.graphics.newImage("room1752.png"),
                room1755 = love.graphics.newImage("room1755.png"),
                room3472 = love.graphics.newImage("room3472.png"),
                room3504 = love.graphics.newImage("room3504.png"),
                room3510 = love.graphics.newImage("room3510.png"),
                room4088 = love.graphics.newImage("room4088.png"),
                room4095 = love.graphics.newImage("room4095.png")
                }
    
    
    graphics.dungeon[9] = love.graphics.newImage("room009.png")
    graphics.dungeon[13] = graphics.dungeon[9]
    graphics.dungeon[15] = graphics.dungeon[9]
    graphics.dungeon[18] = love.graphics.newImage("room018.png")
    graphics.dungeon[19] = graphics.dungeon[18]
    graphics.dungeon[22] = graphics.dungeon[18]
    graphics.dungeon[23] = graphics.dungeon[18]
    graphics.dungeon[27] = love.graphics.newImage("room027.png")
    graphics.dungeon[31] = graphics.dungeon[27]
    graphics.dungeon[45] = graphics.dungeon[9]
    graphics.dungeon[50] = love.graphics.newImage("room050.png")
    graphics.dungeon[54] = love.graphics.newImage("room038.png")
    graphics.dungeon[63] = graphics.dungeon[50]
    graphics.dungeon[72] = love.graphics.newImage("room072.png")
    graphics.dungeon[73] = love.graphics.newImage("room073.png")
    graphics.dungeon[77] = graphics.dungeon[73]
    graphics.dungeon[79] = graphics.dungeon[73]
    graphics.dungeon[83] = graphics.dungeon[18]
    graphics.dungeon[91] = love.graphics.newImage("room091.png")
    graphics.dungeon[109] = graphics.dungeon[73]
    graphics.dungeon[144] = love.graphics.newImage("room144.png")
    graphics.dungeon[146] = love.graphics.newImage("room146.png")
    graphics.dungeon[147] = graphics.dungeon[146]
    graphics.dungeon[150] = graphics.dungeon[146]
    graphics.dungeon[155] = graphics.dungeon[146]
    graphics.dungeon[182] = graphics.dungeon[146]
    graphics.dungeon[191] = graphics.dungeon[146]
    graphics.dungeon[216] = love.graphics.newImage("room216.png")
    graphics.dungeon[217] = graphics.dungeon[216]
    graphics.dungeon[219] = love.graphics.newImage("room219.png")
    graphics.dungeon[220] = graphics.dungeon[216]
    graphics.dungeon[252] = graphics.dungeon[216]
    graphics.dungeon[255] = graphics.dungeon[219]
    graphics.dungeon[310] = graphics.dungeon[54]
    graphics.dungeon[315] = graphics.dungeon[27]
    graphics.dungeon[319] = graphics.dungeon[50]
    graphics.dungeon[329] = graphics.dungeon[73]
    graphics.dungeon[360] = graphics.dungeon[72]
    graphics.dungeon[361] = graphics.dungeon[73]
    graphics.dungeon[365] = graphics.dungeon[73]
    graphics.dungeon[432] = love.graphics.newImage("room432.png")
    graphics.dungeon[436] = graphics.dungeon[432]
    graphics.dungeon[438] = love.graphics.newImage("room438.png")
    graphics.dungeon[439] = graphics.dungeon[438]
    graphics.dungeon[504] = love.graphics.newImage("room504.png")
    graphics.dungeon[505] = graphics.dungeon[504]
    graphics.dungeon[507] = love.graphics.newImage("room507.png")
    graphics.dungeon[508] = graphics.dungeon[504]
    graphics.dungeon[511] = love.graphics.newImage("room511.png")
    graphics.dungeon[665] = graphics.dungeon[144]
    graphics.dungeon[659] = graphics.dungeon[146]
    graphics.dungeon[728] = graphics.dungeon[216]
    graphics.dungeon[731] = graphics.dungeon[219]
    graphics.dungeon[1008] = graphics.dungeon[432]
    graphics.dungeon[1023] = graphics.dungeon[511]
    graphics.dungeon[1168] = love.graphics.newImage("room3472.png")
    graphics.dungeon[1170] = love.graphics.newImage("room182.png")
    graphics.dungeon[1179] = graphics.dungeon[1170]
    graphics.dungeon[1206] = graphics.dungeon[1170]
    graphics.dungeon[1240] = love.graphics.newImage("room1240.png")
    graphics.dungeon[1243] = love.graphics.newImage("room1243.png")
    graphics.dungeon[1456] = love.graphics.newImage("room1456.png")
    graphics.dungeon[1462] = love.graphics.newImage("room1462.png")
    graphics.dungeon[1535] = love.graphics.newImage("room1535.png")
    graphics.dungeon[1689] = graphics.dungeon[1168]
    graphics.dungeon[1752] = love.graphics.newImage("room1752.png")
    graphics.dungeon[1754] = love.graphics.newImage("room1754.png")
    graphics.dungeon[1755] = love.graphics.newImage("room1755.png")
    graphics.dungeon[2480] = graphics.dungeon[432]
    graphics.dungeon[2482] = graphics.dungeon[432]
    graphics.dungeon[2486] = love.graphics.newImage("room438.png")
    graphics.dungeon[2520] = graphics.dungeon[216]
    graphics.dungeon[2552] = graphics.dungeon[504]
    graphics.dungeon[2559] = graphics.dungeon[511]
    graphics.dungeon[3216] = graphics.dungeon[1168]
    graphics.dungeon[3504] = love.graphics.newImage("room3504.png")
    graphics.dungeon[3510] = love.graphics.newImage("room3510.png")
    graphics.dungeon[3519] = graphics.dungeon[3510]
    graphics.dungeon[3800] = graphics.dungeon[1752]
    graphics.dungeon[4016] = graphics.dungeon[3504]
    graphics.dungeon[4056] = graphics.dungeon[1752]
    graphics.dungeon[4059] = graphics.dungeon[1755]
    graphics.dungeon[4086] = graphics.dungeon[3510]
    graphics.dungeon[4088] = love.graphics.newImage("room4088.png")
    graphics.dungeon[4089] = graphics.dungeon[4088]
    graphics.dungeon[4091] = love.graphics.newImage("room4091.png")
    graphics.dungeon[4095] = love.graphics.newImage("room4095.png")
    
    -- load 'CASTLE' sprite
    castle_sprite = love.graphics.newImage("castle.png");
    
    -- create one castle entity
    castle = Castle:create()
    castle.x = 15
    castle.y = 16
    
    room = Room.create()
    
    -- load 'GRASS' sprite
    grass_sprite = love.graphics.newImage("grass.png");
    
    part1 = love.graphics.newImage("part1.png");
    cloud = love.graphics.newImage("cloud.png");
    square = love.graphics.newImage("square.png")
    font = love.graphics.newFont(love._vera_ttf, 10)

    love.graphics.setFont(font)
    love.graphics.setColor(200, 200, 200);

    local p = love.graphics.newParticleSystem(part1, 1000)
    p:setEmissionRate(100)
    p:setSpeed(300, 400)
    p:setGravity(0)
    p:setSize(2, 1)
    p:setColor(255, 255, 255, 255, 58, 128, 255, 0)
    p:setPosition(400, 300)
    p:setLifetime(1)
    p:setParticleLife(1)
    p:setDirection(0)
    p:setSpread(360)
    p:setRadialAcceleration(-2000)
    p:setTangentialAcceleration(1000)
    p:stop()
    table.insert(systems, p)

    p = love.graphics.newParticleSystem(cloud, 1000)
    p:setEmissionRate(100)
    p:setSpeed(200, 250)
    p:setGravity(100, 200)
    p:setSize(1, 1)
    p:setColor(16, 81, 229, 255, 176, 16, 229, 0)
    p:setPosition(400, 300)
    p:setLifetime(1)
    p:setParticleLife(1)
    p:setDirection(180)
    p:setSpread(20)
    --p:setRadialAcceleration(-200, -300)
    p:stop()
    table.insert(systems, p)

    p = love.graphics.newParticleSystem(square, 1000)
    p:setEmissionRate(60)
    p:setSpeed(200, 250)
    p:setGravity(100, 200)
    p:setSize(1, 2)
    p:setColor(240, 3, 176, 255, 204, 240, 3, 0)
    p:setPosition(400, 300)
    p:setLifetime(1)
    p:setParticleLife(2)
    p:setDirection(90)
    p:setSpread(0)
    p:setSpin(300, 800)
    p:stop()
    table.insert(systems, p)

    p = love.graphics.newParticleSystem(part1, 1000)
    p:setEmissionRate(1000)
    p:setSpeed(300, 400)
    p:setSize(2, 1)
    p:setColor(220, 105, 20, 255, 194, 30, 18, 0)
    p:setPosition(400, 300)
    p:setLifetime(0.1)
    p:setParticleLife(0.2)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(1000)
    p:setRadialAcceleration(-2000)
    p:stop()
    table.insert(systems, p)

    p = love.graphics.newParticleSystem(part1, 1000)
    p:setEmissionRate(200)
    p:setSpeed(300, 400)
    p:setSize(1, 2)
    p:setColor(255, 255, 255, 255, 255, 128, 128, 0)
    p:setPosition(400, 300)
    p:setLifetime(1)
    p:setParticleLife(2)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(2000)
    p:setRadialAcceleration(-8000)
    p:stop()
    table.insert(systems, p)

end

direction = 0
X_ROUND = 0
Y_ROUND = 0
LEVEL = 0

function love.update(dt)

    -- if love.mouse.isDown("l") then
        -- systems[current]:setPosition(love.mouse.getX(), love.mouse.getY())
        -- systems[current]:start()
    -- end

    -- if love.keyboard.isDown("d") then
        -- systems[current]:setDirection(direction)
        -- direction = math.mod(direction + 90 * dt, 360)
    -- end

    --systems[current]:update(dt)
end

DRAW_BLOCK = 0

function love.draw()

        -- for x=0,32 do
            -- for y=0,32 do
                -- love.graphics.draw(graphics["grass"], x*32, y*32)
            -- end
        -- end
        
        if DRAW_BLOCK == 0 then
            room:draw()
        else
            room:draw_block()
        end

        --love.graphics.setColorMode("modulate")
        --love.graphics.setBlendMode("additive")

        love.graphics.draw(systems[current], 0, 0)
        love.graphics.print("System: [" .. current .. "/"..table.getn(systems).."] - " .. systems[current]:count() .. " particles.", 30, 570);
        love.graphics.print("Click: spawn particles. Mousewheel: change system.", 30, 530);
        love.graphics.print("Press escape to exit.", 30, 550);
love.graphics.print("DEBUG: number of units = " .. #units .. ".", 30, 400);
love.graphics.print("DEBUG: x = " .. X_ROUND .. " y = " .. Y_ROUND .. " level = " .. LEVEL .. ".", 30, 450);

        love.graphics.draw(castle_sprite, castle["x"]*32, castle["y"]*32)
        
        for x=1,#units do
            local unit = units[x]
            unit:draw()
        end
end

unit_type = Unit.UNKNOW

function love.mousepressed(x, y, button)
    if button == "wu" then
        unit_type = unit_type + 1
    
        current = current + 1;
        if current > table.getn(systems) then current = table.getn(systems) end
    end

    if button == "wd" then
        unit_type = unit_type - 1
        
        current = current - 1;
        if current < 1 then current = 1 end
    end
    
    --[[  if button == "l" then
        
        -- test if there are unit in that range
        local unit_selected = nil
        local unit = nil
        for x=1,#units do
            unit = units[x]
            io.write(" value = " .. math.abs(unit.x-x) .. ".")
            --debug.traceback(message = " value = " .. math.abs(unit.x-x) .. ".")
            if math.abs(unit.x-x) <= 32 and math.abs(unit.y-y) <= 32 then
                unit_selected = unit
            end
        end
        
        -- test if no unit was in range
        -- then create new one at mouse coordinate
        if unit_selected == nil then
            local unit = Unit.create()
            unit.x = love.mouse.getX()
            unit.y = love.mouse.getY()
            unit.type = unit_type
            table.insert(units, unit)
        else
            unit_selected.selected = 1
            -- unselect other units
            for x=1,#units do
                local unit = units[x]
                unit.selected = 0
            end
        end
    end   ]]--

    if button == "l" then
        X_ROUND = math.floor(x/16)
        Y_ROUND = math.floor(y/16)
        
        local cell = room.cells[X_ROUND+(Y_ROUND*14)]
        if cell.level == 2 then
            cell.level = 0
        else
            cell.level = 2
            local cellup = room.cells[X_ROUND+(Y_ROUND*14)+14]
            if cellup ~= nil then
                if cellup.level == 2 then
                    cellup.level = 0
                else
                    cellup.level = 2
                end
            end
        end
        
        
    else
    
    
        local X_ROUND_level = math.floor(x/16)
        local Y_ROUND_level = math.floor(y/16)
        
        --local cell = room.cells[X_ROUND+(Y_ROUND*14)]
        local cell = room.cells[X_ROUND_level+(Y_ROUND_level*14)]
        LEVEL = room:getNumber(X_ROUND_level, Y_ROUND_level)
    end
end

function love.keypressed(key)

    local delta = 1
    
    if key == "up" then
        castle["y"] = math.max(castle["y"] - delta, 0)
    end
    if key == "down" then
        castle["y"] = math.min(castle["y"] + delta, 600)
    end
    if key == "left" then
        castle["x"] = math.max(castle["x"] - delta, 0)
    end
    if key == "right" then
        castle["x"] = math.min(castle["x"] + delta, 600)
    end
    
    if key == "b" then
        if DRAW_BLOCK == 0 then
            DRAW_BLOCK = 1
        else
            DRAW_BLOCK = 0
        end
    end

    if key == "escape" then
        love.event.push("q")
    end

    if key == "r" then
        love.filesystem.load("main.lua")()
        love.load()
    end
end

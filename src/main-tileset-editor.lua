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
require("style.lua")

WALL = 2
WATER = -1

MODE = WALL

systems = {}
current = 1

units = {}

--- Call back function of the 'love' engine
-- Load all sprites
-- @author Damien Carol <damien.carol@gmail.com>
function love.load()

    tilesetImg = love.graphics.newImage("dungeon256x256.png")
                

    -- load sprites defined in table
    graphics = {castle = love.graphics.newImage("castle.png"),
                grass = love.graphics.newImage("grass.png"),
                unknow001 = love.graphics.newImage("unknow001.png"),
                archer001 = love.graphics.newImage("archer001.png"),
                knight001 = love.graphics.newImage("knight001.png"),
                
                
                roomBLOCK = love.graphics.newImage("block.png"),
                roomFREE = love.graphics.newImage("free.png"),
                
                dungeon = {},
                water = {},
                
                }
    
    graphics.theme = {}
    graphics.theme["dungeon"] = Style.create("dungeon256x256.png", 16)
    
    -- load 'CASTLE' sprite
    castle_sprite = love.graphics.newImage("castle.png");
    
    -- create one castle entity
    castle = Castle:create()
    castle.x = 15
    castle.y = 16
    
    room = Room.create()
    room:setStyle(Style.create("dungeon256x256.png", 16))
    room:setStyleWater(Style.create("dungeon256x256.png", 16))
    
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

    if love.keyboard.isDown("up") then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG + 1
        if NUMBER_TO_DEBUG > 4096 then
            NUMBER_TO_DEBUG = 0
        end
    end
    if love.keyboard.isDown("down") then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG - 1
        
        if NUMBER_TO_DEBUG < 0 then
            NUMBER_TO_DEBUG = 4096
        end
    end

    -- if love.mouse.isDown("l") then
        -- systems[current]:setPosition(love.mouse.getX(), love.mouse.getY())
        -- systems[current]:start()
    -- end

    -- if love.keyboard.isDown("d") then
        -- systems[current]:setDirection(direction)
        -- direction = math.mod(direction + 90 * dt, 360)
    -- end

    --systems[current]:update(dt)
    
    local decode = NUMBER_TO_DEBUG
    
    if (decode >= 2048) then
        room.cells[4][5].wall = true
        decode = decode - 2048
    else
        room.cells[4][5].wall = false
    end
    
    if (decode >= 1024) then
        room.cells[3][5].wall = true
        decode = decode - 1024
    else
        room.cells[3][5].wall = false
    end
    
    if (decode >= 512) then
        room.cells[2][5].wall = true
        decode = decode - 512
    else
        room.cells[2][5].wall = false
    end
    
    if (decode >= 256) then
        room.cells[4][4].wall = true
        decode = decode - 256
    else
        room.cells[4][4].wall = false
    end
    
    if (decode >= 128) then
        room.cells[3][4].wall = true
        decode = decode - 128
    else
        room.cells[3][4].wall = false
    end
    
    if (decode >= 64) then
        room.cells[2][4].wall = true
        decode = decode - 64
    else
        room.cells[2][4].wall = false
    end

    if (decode >= 32) then
        room.cells[4][3].wall = true
        decode = decode - 32
    else
        room.cells[4][3].wall = false
    end

    if (decode >= 16) then
        room.cells[3][3].wall = true
        decode = decode - 16
    else
        room.cells[3][3].wall = false
    end

    if (decode >= 8) then
        room.cells[2][3].wall = true
        decode = decode - 8
    else
        room.cells[2][3].wall = false
    end

    if (decode >= 4) then
        room.cells[4][2].wall = true
        decode = decode - 4
    else
        room.cells[4][2].wall = false
    end

    if (decode >= 2) then
        room.cells[3][2].wall = true
        decode = decode - 2
    else
        room.cells[3][2].wall = false
    end

    if (decode >= 1) then
        room.cells[2][2].wall = true
        decode = decode - 1
    else
        room.cells[2][2].wall = false
    end

end

DRAW_BLOCK = 1

function love.draw()

        -- for x=0,32 do
            -- for y=0,32 do
                -- love.graphics.draw(graphics["grass"], x*32, y*32)
            -- end
        -- end
        
        if DRAW_BLOCK == 0 then
            room:draw_wall()
            room:draw_water()
        else
            if MODE == WALL then
                room:draw_wall_block()
            else
                room:draw_water_block()
            end
        end

        --love.graphics.setColorMode("modulate")
        --love.graphics.setBlendMode("additive")


love.graphics.print("DEBUG: number of units = " .. #units .. ".", 30, 400);
love.graphics.print("DEBUG: x = " .. X_ROUND .. " y = " .. Y_ROUND .. " level = " .. LEVEL .. ".", 30, 450);
        
        local nb_dungeon = -1
        if MODE == WALL then
            nb_dungeon = graphics.dungeon[NUMBER_TO_DEBUG]
        else
            nb_dungeon = graphics.water[NUMBER_TO_DEBUG]
        end
        
        if nb_dungeon == nil then
            nb_dungeon = -1
        end
love.graphics.print("DEBUG: NUMBER_TO_DEBUG = " .. NUMBER_TO_DEBUG .. " DG= " .. nb_dungeon .. ".", 30, 500);

        love.graphics.draw(castle_sprite, castle["x"]*32, castle["y"]*32)
        
        
        -- draw the selected tile
        graphics.theme["dungeon"]:draw(NUMBER_OF_QUAD, 30, 550);
        love.graphics.print("NUMBER_OF_QUAD [" .. NUMBER_OF_QUAD .. "]. LEVEL = " .. MODE .. " .", 30, 580);
        
        love.graphics.draw(tilesetImg, 400, 0)
        
        for x=1,#units do
            local unit = units[x]
            unit:draw()
        end
end

unit_type = Unit.UNKNOW

function love.mousepressed(x, y, button)

    if button == "wu" then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG + 1
        return
    end

    if button == "wd" then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG - 1
        return
    end

    if (x > 400 and x < 656 and y > 0 and y < 256) then
        X_ROUND = math.floor((x-400)/16)
        Y_ROUND = math.floor(y/16)
        
        NUMBER_OF_QUAD = X_ROUND+Y_ROUND*16
        return
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
        
        local cell = room.cells[X_ROUND][Y_ROUND]
        
        if MODE == WALL then
            if cell.wall == true then
                cell.wall = false
            else
                cell.wall = true
            end
        else
            if cell.water == true then
                cell.water = false
            else
                cell.water = true
            end
        end
        
        -- local cellup = room.cells[X_ROUND][Y_ROUND+1]
        -- if cellup ~= nil then
            -- if cellup.wall == true then
                -- cellup.wall = false
            -- else
                -- cellup.wall = true
            -- end
        -- end
            
    else
    
    
        local X_ROUND_level = math.floor(x/16)
        local Y_ROUND_level = math.floor(y/16)
        
        --local cell = room.cells[X_ROUND+(Y_ROUND*14)]
        local cell = room.cells[X_ROUND_level][Y_ROUND_level]
        
        LEVEL = room:getWallNumber(X_ROUND_level, Y_ROUND_level)
        if MODE == WALL then
            LEVEL = room:getWallNumber(X_ROUND_level, Y_ROUND_level)
        else
            LEVEL = room:getWaterNumber(X_ROUND_level, Y_ROUND_level)
        end
        NUMBER_TO_DEBUG = LEVEL
    end
end

NUMBER_TO_DEBUG = 0

NUMBER_OF_QUAD = 0

function love.keypressed(key, unicode)

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
    
    
    if key == "p" then
        if MODE == WALL then
            graphics.dungeon[NUMBER_TO_DEBUG] = NUMBER_OF_QUAD
        else
            graphics.water[NUMBER_TO_DEBUG] = NUMBER_OF_QUAD
        end
    end
    
    if key == "left" then
        NUMBER_OF_QUAD = NUMBER_OF_QUAD - 1
        NUMBER_OF_QUAD = math.max(0, NUMBER_OF_QUAD)
    end
    if key == "right" then
        NUMBER_OF_QUAD = NUMBER_OF_QUAD + 1
    end
    

    if key == "b" or key == "o" then
        if DRAW_BLOCK == 0 then
            DRAW_BLOCK = 1
        else
            DRAW_BLOCK = 0
        end
    end
    
    if key == "y" then
        room:make_room(5, 5, 6, 6, 0)
    end
    -- if key == "f1" then
        -- room:save("level1.txt")
    -- end
    
    if key == "f2" then
        MODE = WATER
    end
    if key == "f3" then
        MODE = WALL
    end
    
    if key == "f4" then
        savedata()
    end
    if key == "f5" then
        loaddata()
    end


    if key == "escape" then
        love.event.push("q")
    end

    if key == "r" then
        love.filesystem.load("main.lua")()
        love.load()
    end
end

function savedata()
    
    do -- for block layer
        
        local file = love.filesystem.newFile("dungeonparse.txt")
        file:open("w")    
        for x=0,4096 do
            local num = graphics.dungeon[x]
            if num ~= nil and num ~= 0 then
                file:write(string.format("%d=%d", x, num))
                file:write("\r\n")
            end
        end    
        file:close()
    end
    
    do -- for water layer
        
        local file = love.filesystem.newFile("dungeon-water.txt")
        file:open("w")    
        for x=0,10 do
            local num = graphics.water[x]
            if num ~= nil and num ~= 0 then
                file:write(string.format("%d=%d", x, num))
                file:write("\r\n")
            end
        end    
        file:close()
    end
end
function loaddata()
    
    do -- for dungeon layer
        local file = love.filesystem.newFile("dungeonparse.txt")
        file:open("r")
        
        for line in file:lines() do
            for k, v in string.gmatch(line, "(%w+)=(%w+)") do
                --t[k] = v
                love.graphics.print("[" .. k .. "]= " .. v .. ".", 30, 570);
                graphics.dungeon[tonumber(k)] = tonumber(v)
            end
        end
        file:close()
    end

    do -- for water layer
        local file = love.filesystem.newFile("dungeon-water.txt")
        file:open("r")
        
        for line in file:lines() do
            for k, v in string.gmatch(line, "(%w+)=(%w+)") do
                --t[k] = v
                love.graphics.print("[" .. k .. "]= " .. v .. ".", 30, 570);
                graphics.water[tonumber(k)] = tonumber(v)
            end
        end
        file:close()
    end
end

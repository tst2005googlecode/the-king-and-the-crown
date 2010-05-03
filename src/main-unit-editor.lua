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

require("unittype.lua")
require("unit.lua")
require("castle.lua")
require("room.lua")
require("cell.lua")
require("style.lua")




--- Call back function of the 'love' engine
-- Load all sprites
-- @author Damien Carol <damien.carol@gmail.com>
function love.load()

    my_unit = Unit.create()
    my_unit.x = 100
    my_unit.y = 100
    my_unit:setUnitType(UnitType.HERO)

end

frame_num_time = 0
frame_num = 1

function love.update(dt)

    frame_num_time = frame_num_time + dt
    
    if frame_num_time > 0.2 then
        frame_num_time = frame_num_time - 0.2
        frame_num = frame_num + 1
    end

    if frame_num > 4 then
        frame_num = 1
    end

    
    
    
    my_unit:update(dt, love.keyboard.isDown("up"),
        love.keyboard.isDown("down"), 
        love.keyboard.isDown("left"),
        love.keyboard.isDown("right"))

end

DRAW_BLOCK = 0

function love.draw()

    local my_type = UnitType.HERO

    my_type:draw_back(50, 20, frame_num)
    my_type:draw_back_stand(50, 40)


    my_type:draw_backside_stand(35, 50)
    my_type:draw_backside(15, 50, frame_num)


    my_type:draw_side_stand(65, 50)
    my_type:draw_side(85, 50, frame_num)


    my_type:draw_front_stand(50, 60)
    my_type:draw_front(50, 80, frame_num)
    
    
    
    
    my_unit:draw()
end



function love.mousepressed(x, y, button)

    if button == "wu" then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG + 1
        return
    end

    if button == "wd" then
        NUMBER_TO_DEBUG = NUMBER_TO_DEBUG - 1
        return
    end




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


function love.keypressed(key, unicode)

    local delta = 1
    
    -- if key == "up" then
        -- ROOM_NUMBER = ROOM_NUMBER + 1
    -- end
    -- if key == "down" then
        -- ROOM_NUMBER = ROOM_NUMBER - 1
    -- end
    
    
    if key == "p" then
        if MODE == WALL then
            graphics.dungeon[NUMBER_TO_DEBUG] = NUMBER_OF_QUAD
        else
            graphics.water[NUMBER_TO_DEBUG] = NUMBER_OF_QUAD
        end
    end
    
    -- if key == "left" then
        -- NUMBER_OF_QUAD = NUMBER_OF_QUAD - 1
        -- NUMBER_OF_QUAD = math.max(0, NUMBER_OF_QUAD)
    -- end
    -- if key == "right" then
        -- NUMBER_OF_QUAD = NUMBER_OF_QUAD + 1
    -- end
    

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



    if key == "f2" then
        MODE = WATER
    end
    if key == "f3" then
        MODE = WALL
    end






    if key == "f11" then
        room:save("level" .. tostring(ROOM_NUMBER) .. ".txt")
    end
    if key == "f12" then
        room:load("level" .. tostring(ROOM_NUMBER) .. ".txt")
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

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

systems = {}
current = 1

--- Call back function of the 'love' engine
-- Load all sprites
-- @author Damien Carol <damien.carol@gmail.com>
function love.load()

    -- load sprites defined in table
    graphics = {castle = love.graphics.newImage("castle.png"),
                grass = love.graphics.newImage("grass.tga")}

    -- load 'CASTLE' sprite
    castle_sprite = love.graphics.newImage("castle.png");
    
    -- create one castle entity
    castle = Castle()
    
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

function love.update(dt)

    if love.mouse.isDown("l") then
        systems[current]:setPosition(love.mouse.getX(), love.mouse.getY())
        systems[current]:start()
    end

    if love.keyboard.isDown("d") then
        systems[current]:setDirection(direction)
        direction = math.mod(direction + 90 * dt, 360)
    end

    systems[current]:update(dt)
end

function love.draw()

        for x=0,32 do
            for y=0,32 do
                love.graphics.draw(graphics["grass"], x*32, y*32)
            end
        end

        love.graphics.setColorMode("modulate")
        love.graphics.setBlendMode("additive")

        love.graphics.draw(systems[current], 0, 0)
        love.graphics.print("System: [" .. current .. "/"..table.getn(systems).."] - " .. systems[current]:count() .. " particles.", 30, 570);
        love.graphics.print("Click: spawn particles. Mousewheel: change system.", 30, 530);
        love.graphics.print("Press escape to exit.", 30, 550);

        love.graphics.draw(castle_sprite, castle["x"]*32, castle["y"]*32)
end

function love.mousepressed(x, y, button)
    if button == "wu" then
        current = current + 1;
        if current > table.getn(systems) then current = table.getn(systems) end
    end

    if button == "wd" then
        current = current - 1;
        if current < 1 then current = 1 end
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

    if key == "escape" then
        love.event.push("q")
    end

    if key == "r" then
        love.filesystem.load("main.lua")()
        love.load()
    end
end
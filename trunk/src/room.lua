--
--    The King And The Crown
--    Copyright (C) 2010  Damien Carol <damien.carol@gmail.com>
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

-- Menu State
-- Main menu...
Room = {}
Room.__index = Room

Room.MAXWIDTH = 30
Room.MAXHEIGHT = 25

function Room.create()
    local temp = {}
    setmetatable(temp, Room)

    temp.x = 0
    temp.y = 0
    
    temp.cells = {}
    
    temp.stylewall = nil
    temp.stylewater = nil
    
    for x=1,Room.MAXWIDTH do
    temp.cells[x] = {}
        for y=1,Room.MAXHEIGHT do
            local cell = Cell.create()
            cell.x = x
            cell.y = y
            cell.wall = true
            cell.water = false
            temp.cells[x][y] = cell
        end
    end
    
    temp.hero = Unit.create()
    temp.hero.x = 50
    temp.hero.y = 50
    temp.hero:setUnitType(UnitType.HERO)
    
    temp.monsters = {}
    
    return temp
end

function Room:getWaterNumber(x, y)

    if self.cells[x] == nil then
        return 0
    end
    if self.cells[x][y] == nil then
        return 0
    end

    local cell0 = self.cells[x][y]
    local cell1 = self.cells[x][y-1]

    local number = 0
    
    if cell0 ~= nil then
        if cell0.water == true then
            number = number + 1
        end
    end
    
    if cell1 ~= nil then
        if cell1.water == true then
            number = number + 2
        end
    end

    return number
end

-- x coordinate of the cell
--
function Room:getWallNumber(x, y)

    local cell0 = self.cells[x-1][y-1]
    local cell1 = self.cells[x][y-1]
    local cell2 = self.cells[x+1][y-1]
    
    local cell3 = self.cells[x-1][y]
    local cell4 = self.cells[x][y]
    local cell5 = self.cells[x+1][y]
    
    local cell6 = self.cells[x-1][y+1]
    local cell7 = self.cells[x][y+1]
    local cell8 = self.cells[x+1][y+1]
    
    local cell9 = self.cells[x-1][y+2]
    local cell10 = self.cells[x][y+2]
    local cell11 = self.cells[x+1][y+2]
    
    local number = 0
    
    if cell0 ~= nil then
        if cell0.wall == true then
            number = number + 1
        end
    end
    
    if cell1 ~= nil then
        if cell1.wall == true then
            number = number + 2
        end
    end
    
    if cell2 ~= nil then
        if cell2.wall == true then
            number = number + 4
        end
    end
    
    if cell3 ~= nil then
        if cell3.wall == true then
            number = number + 8
        end
    end

    if cell4 ~= nil then
        if cell4.wall == true then
            number = number + 16
        end
    end
    
    if cell5 ~= nil then
        if cell5.wall == true then
            number = number + 32
        end
    end
    
    if cell6 ~= nil then
        if cell6.wall == true then
            number = number + 64
        end
    end
    
    if cell7 ~= nil then
        if cell7.wall == true then
            number = number + 128
        end
    end
    
    if cell8 ~= nil then
        if cell8.wall == true then
            number = number + 256
        end
    end
    
    if cell9 ~= nil then
        if cell9.wall == true then
            number = number + 512
        end
    end
    
    if cell10 ~= nil then
        if cell10.wall == true then
            number = number + 1024
        end        
    end
    
    if cell11 ~= nil then
        if cell11.wall == true then
            number = number + 2048
        end
    end
    
    return number
 end

function Room:draw_wall()

    for x=2,Room.MAXWIDTH-1 do
        for y=2,Room.MAXHEIGHT-2 do
            local number = 0
            
            number = self:getWallNumber(x, y)


            if self.stylewall ~= nil then
                if graphics.dungeon[number] ~= nil then
                    self.stylewall:draw(graphics.dungeon[number], x*16, y*16)
                else
                    self.stylewall:draw(1, x*16, y*16)
                end
            else
                -- love.graphics.draw(graphics["roomBLOCK"], x*16, y*16)
            end
        end
    end
end

function Room:draw_water()

    for x=2,Room.MAXWIDTH-1 do
        for y=2,Room.MAXHEIGHT-2 do
            local number = 0
            
            number = self:getWaterNumber(x, y)


            if self.stylewater ~= nil then
                if graphics.water[number] ~= nil then
                    self.stylewater:draw(graphics.water[number], x*16, y*16)
                else
                    -- self.stylewater:draw(1, x*16, y*16)
                end
            else
                -- love.graphics.draw(graphics["roomBLOCK"], x*16, y*16)
            end
        end
    end
end

function Room:draw_wall_block()

    for x=1,Room.MAXWIDTH do
        for y=1,Room.MAXHEIGHT do
            local cell = self.cells[x][y]
            
            
            -- test magic number and check what to draw
            if cell.wall == true then
                love.graphics.draw(graphics["roomBLOCK"], x*16, y*16)
            else
                love.graphics.draw(graphics["roomFREE"], x*16, y*16)
            end
        end
    end
end

function Room:draw_water_block()

    for x=1,Room.MAXWIDTH do
        for y=1,Room.MAXHEIGHT do
            local cell = self.cells[x][y]
            
            
            -- test magic number and check what to draw
            if cell.water == true then
                love.graphics.draw(graphics["roomBLOCK"], x*16, y*16)
            else
                love.graphics.draw(graphics["roomFREE"], x*16, y*16)
            end
        end
    end
end

function Room:draw_monster()

    local x_mon
    for x_mon=1,#self.monsters do
        self.monsters[x_mon]:draw()
    end

end

function Room:draw_hero()

    self.hero:draw(0, 0)

end

function Room:getCell(x, y)
    return self.cells[x][y].level
end

function Room:setCell(x, y, value)
    self.cells[x][y].level = value
end

function Room:setStyle(value)
    self.stylewall = value
end

function Room:setStyleWater(value)
    self.stylewater = value
end

function Room:save(filename)
    local file = love.filesystem.newFile(filename)
    file:open("w")

    for y=1,Room.MAXHEIGHT do
        for x=1,Room.MAXWIDTH do
            if self.cells[x][y].wall then
                file:write("2")
                file:write("\r\n")
            elseif self.cells[x][y].water then
                file:write("-1")
                file:write("\r\n")
            else
                file:write("0")
                file:write("\r\n")
            end
        end
    end
    file:close()
    
    
    local file = love.filesystem.newFile("mon-" .. filename)
    file:open("w")

    local x_mon
    for x_mon=1,#self.monsters do
        file:write("2")
        file:write("\r\n")
    end
    file:close()
end

-- Load a level
function Room:load(filename)
    
    do -- for dungeon layer
        local file = love.filesystem.newFile(filename)
        file:open("r")
        
        local xi = 1
        local yi = 1
        for line in file:lines() do
            local level = tonumber(line)
            if level == 2 then
                self.cells[xi][yi].wall = true
            else
                self.cells[xi][yi].wall = false
            end
            if level == -1 then
                self.cells[xi][yi].water = true
            else
                self.cells[xi][yi].water = false
            end

            xi = xi + 1
            if xi == Room.MAXWIDTH + 1 then
                xi = 1
                yi = yi + 1
            end
        end
        file:close()
    end
    
    do -- for monster
        self.monsters = {}
        -- local file = love.filesystem.newFile(filename)
        -- file:open("r")
        
        -- local xi = 1
        -- local yi = 1
        -- for line in file:lines() do
            -- local level = tonumber(line)
            -- if level == 2 then
                -- self.cells[xi][yi].wall = true
            -- else
                -- self.cells[xi][yi].wall = false
            -- end
            -- if level == -1 then
                -- self.cells[xi][yi].water = true
            -- else
                -- self.cells[xi][yi].water = false
            -- end

            -- xi = xi + 1
            -- if xi == Room.MAXWIDTH + 1 then
                -- xi = 1
                -- yi = yi + 1
            -- end
        -- end
        -- file:close()
    end
    
end

-- Return the cell at the coordinate x and y.
function Room:getCellAtCoordinate(x, y)
    assert(x >= 0, "x number is not between 0 and 2")
    assert(x <= 2, "x number is not between 0 and 2")
    
    local x_coo = math.floor(x/16)
    local y_coo = 


end

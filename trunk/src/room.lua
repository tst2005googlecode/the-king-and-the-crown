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

-- Unit.UNKNOW = 0
-- Unit.ARCHER = 1
-- Unit.KNIGHT = 2

function Room.create()
    local temp = {}
    setmetatable(temp, Room)

    temp.x = 0
    temp.y = 0
    
    temp.cells = {}
    
    for x=1,20 do
    temp.cells[x] = {}
        for y=1,14 do
            local cell = Cell.create()
            cell.x = x
            cell.y = y
            cell.wall = true
            temp.cells[x][y] = cell
        end
    end
    
    return temp
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

function Room:draw()

    for x=2,4 do
        for y=2,5 do
            local number = 0
            
            number = self:getWallNumber(x, y)
            
            local image = graphics.dungeon[number]
            
            if image ~= nil then
                love.graphics.draw(graphics.dungeon[number], x*16, y*16)
            else
                love.graphics.draw(graphics.dungeon[0], x*16, y*16)
            end
        end
    end
end

function Room:draw_block()

    for x=2,4 do
        for y=2,5 do
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

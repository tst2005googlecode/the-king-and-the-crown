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
        for y=1,14 do
            local cell = Cell.create()
            cell.x = x
            cell.y = y
            temp.cells[x+(y*14)] = cell
        end
    end
    
    temp.cells[15].level = 2
    
    
    temp.cells[3+(3*14)].level = 2
    temp.cells[4+(3*14)].level = 2
    temp.cells[5+(3*14)].level = 2
    
    -- temp.cells[7+(3*14)].level = 2
    -- temp.cells[7+(4*14)].level = 2
    -- temp.cells[7+(5*14)].level = 2
    
    return temp
end

function Room:getNumber(x, y)

    local cell0 = self.cells[x-1+((y-1)*14)]
    local cell1 = self.cells[x+((y-1)*14)]
    local cell2 = self.cells[x+1+((y-1)*14)]
    
    local cell3 = self.cells[x-1+(y*14)]
    local cell4 = self.cells[x+(y*14)]
    local cell5 = self.cells[x+1+(y*14)]
    
    local cell6 = self.cells[x-1+((y+1)*14)]
    local cell7 = self.cells[x+((y+1)*14)]
    local cell8 = self.cells[x+1+((y+1)*14)]
    
    local cell9 = self.cells[x-1+((y+2)*14)]
    local cell10 = self.cells[x+((y+2)*14)]
    local cell11 = self.cells[x+1+((y+2)*14)]
    
    local number = 0
    
    if cell0 ~= nil then
        if cell0.level > 0 then
            number = number + 1
        end
    end
    
    if cell1 ~= nil then
        if cell1.level > 0 then
            number = number + 2
        end
    end
    
    if cell2 ~= nil then
        if cell2.level > 0 then
            number = number + 4
        end
    end
    
    if cell3 ~= nil then
        if cell3.level > 0 then
            number = number + 8
        end
    end

    if cell4 ~= nil then
        if cell4.level > 0 then
            number = number + 16
        end
    end
    
    if cell5 ~= nil then
        if cell5.level > 0 then
            number = number + 32
        end
    end
    
    if cell6 ~= nil then
        if cell6.level > 0 then
            number = number + 64
        end
    end
    
    if cell7 ~= nil then
        if cell7.level > 0 then
            number = number + 128
        end
    end
    
    if cell8 ~= nil then
        if cell8.level > 0 then
            number = number + 256
        end
    end
    
    if cell9 ~= nil then
        if cell9.level > 0 then
            number = number + 512
        end
    end
    
    if cell10 ~= nil then
        if cell10.level > 0 then
            number = number + 1024
        end
    end
    
    if cell11 ~= nil then
        if cell11.level > 0 then
            number = number + 2048
        end
    end
    
    return number
 end

function Room:draw()

    for x=1,20 do
        for y=1,14 do
            local number = 0
            
            number = self:getNumber(x, y)
            
            
            -- test magic number and check what to draw
            if number == 0 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 1 then
                love.graphics.draw(graphics["room001"], x*16, y*16)
            elseif number == 2 then
                love.graphics.draw(graphics["room002"], x*16, y*16)
            elseif number == 3 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 4 then
                love.graphics.draw(graphics["room004"], x*16, y*16)
            elseif number == 5 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 6 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 7 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 9 then
                love.graphics.draw(graphics["room009"], x*16, y*16)
            elseif number == 18 then
                love.graphics.draw(graphics["room018"], x*16, y*16)
            elseif number == 19 then
                love.graphics.draw(graphics["room019"], x*16, y*16)
            elseif number == 27 then
                love.graphics.draw(graphics["room019"], x*16, y*16)
            elseif number == 32 then
                love.graphics.draw(graphics["room032"], x*16, y*16)
            elseif number == 36 then
                love.graphics.draw(graphics["room036"], x*16, y*16)
            elseif number == 38 then
                love.graphics.draw(graphics["room038"], x*16, y*16)
            elseif number == 45 then
                love.graphics.draw(graphics["room009"], x*16, y*16)
            elseif number == 50 then
                love.graphics.draw(graphics["room050"], x*16, y*16)
            elseif number == 54 then
                love.graphics.draw(graphics["room038"], x*16, y*16)
            elseif number == 63 then
                love.graphics.draw(graphics["room050"], x*16, y*16)
            elseif number == 64 then
                love.graphics.draw(graphics["room064"], x*16, y*16)
            elseif number == 65 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 67 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 71 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 72 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 73 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 75 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 77 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 79 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 91 then
                love.graphics.draw(graphics["room127"], x*16, y*16)
            elseif number == 109 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 127 then
                love.graphics.draw(graphics["room127"], x*16, y*16)
            elseif number == 128 then
                love.graphics.draw(graphics["room128"], x*16, y*16)
            elseif number == 130 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 131 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 134 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 144 then
                love.graphics.draw(graphics["room144"], x*16, y*16)
            elseif number == 146 then
                if self:getNumber(x, y+14) == 146 then
                    love.graphics.draw(graphics["room146b"], x*16, y*16)
                else
                    love.graphics.draw(graphics["room146"], x*16, y*16)
                end
            elseif number == 147 then
                love.graphics.draw(graphics["room146"], x*16, y*16)
            elseif number == 150 then
                love.graphics.draw(graphics["room146"], x*16, y*16)
            elseif number == 155 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 182 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 192 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 193 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 198 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 195 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 199 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 210 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 211 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 216 then
                love.graphics.draw(graphics["room216"], x*16, y*16)
            elseif number == 217 then
                love.graphics.draw(graphics["room216"], x*16, y*16)
            elseif number == 218 then
                love.graphics.draw(graphics["room218"], x*16, y*16)
            elseif number == 219 then
                love.graphics.draw(graphics["room219"], x*16, y*16)
            elseif number == 222 then
                love.graphics.draw(graphics["room218"], x*16, y*16)
            elseif number == 246 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 256 then
                love.graphics.draw(graphics["room256"], x*16, y*16)
            elseif number == 260 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 263 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 288 then
                love.graphics.draw(graphics["room288"], x*16, y*16)
            elseif number == 292 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 294 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 295 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 297 then
                love.graphics.draw(graphics["room009"], x*16, y*16)
            elseif number == 301 then
                love.graphics.draw(graphics["room009"], x*16, y*16)
            elseif number == 310 then
                love.graphics.draw(graphics["room038"], x*16, y*16)
            elseif number == 319 then
                love.graphics.draw(graphics["room050"], x*16, y*16)
            elseif number == 320 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 327 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 329 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 333 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 335 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 357 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 359 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 360 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 361 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 365 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 367 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 383 then
                love.graphics.draw(graphics["room127"], x*16, y*16)
            elseif number == 384 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 390 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 391 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 402 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 406 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 411 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 423 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 432 then
                love.graphics.draw(graphics["room432"], x*16, y*16)
            elseif number == 434 then
                love.graphics.draw(graphics["room434"], x*16, y*16)
            elseif number == 435 then
                love.graphics.draw(graphics["room434"], x*16, y*16)
            elseif number == 436 then
                love.graphics.draw(graphics["room432"], x*16, y*16)
            elseif number == 438 then
                love.graphics.draw(graphics["room438"], x*16, y*16)
            elseif number == 448 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 449 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 450 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 451 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 452 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 453 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 454 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 455 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 456 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 457 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 464 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 471 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 461 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 463 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 484 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 485 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 487 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 493 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 495 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 504 then
                love.graphics.draw(graphics["room504"], x*16, y*16)
            elseif number == 505 then
                love.graphics.draw(graphics["room504"], x*16, y*16)
            elseif number == 506 then
                love.graphics.draw(graphics["room506"], x*16, y*16)
            elseif number == 508 then
                love.graphics.draw(graphics["room504"], x*16, y*16)
            elseif number == 509 then
                love.graphics.draw(graphics["room504"], x*16, y*16)
            elseif number == 511 then
                love.graphics.draw(graphics["room511"], x*16, y*16)
            elseif number == 512 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 576 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 584 then
                love.graphics.draw(graphics["room072"], x*16, y*16)
            elseif number == 585 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 1024 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 1152 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 1456 then
                love.graphics.draw(graphics["room1456"], x*16, y*16)
            elseif number == 1536 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 1728 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 1752 then
                love.graphics.draw(graphics["room1752"], x*16, y*16)
            elseif number == 1755 then
                love.graphics.draw(graphics["room1755"], x*16, y*16)
            elseif number == 2048 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 2304 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 2336 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 2340 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 3254 then
                love.graphics.draw(graphics["room182"], x*16, y*16)
            elseif number == 3456 then
                love.graphics.draw(graphics["room000"], x*16, y*16)
            elseif number == 3504 then
                love.graphics.draw(graphics["room3504"], x*16, y*16)
            elseif number == 3510 then
                love.graphics.draw(graphics["room3510"], x*16, y*16)
            elseif number == 3472 then
                love.graphics.draw(graphics["room3472"], x*16, y*16)
            elseif number == 4079 then
                love.graphics.draw(graphics["room073"], x*16, y*16)
            elseif number == 4088 then
                love.graphics.draw(graphics["room4088"], x*16, y*16)
            elseif number == 4095 then
                love.graphics.draw(graphics["room4095"], x*16, y*16)
            else
                love.graphics.draw(graphics["room000"], x*16, y*16)
            end
        end
    end
end

function Room:draw_block()

    for x=1,20 do
        for y=1,14 do
            local cell = self.cells[x+(y*14)]
            
            
            -- test magic number and check what to draw
            if cell.level ~= 0 then
                love.graphics.draw(graphics["roomBLOCK"], x*16, y*16)
            else
                love.graphics.draw(graphics["roomFREE"], x*16, y*16)
            end
        end
    end
end
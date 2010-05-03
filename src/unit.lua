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

-- Menu State
-- Main menu...
Unit = {}
Unit.__index = Unit

function Unit.create()
    local temp = {}
    setmetatable(temp, Unit)

    temp.x = 0
    temp.y = 0
    temp.unittype = UnitType.UNKNOW
    temp.selected = 0
    
    temp.direction = "down"
    temp.moving = false
    
    -- data for animation
    temp.frame_num_time = 0
    temp.frame_num = 1

    return temp
end

function Unit:update(dt, up, down, left, right, room)

    -- update coordinates
    if up == true then
        local cellUp = room:getCellAtCoordinate(self.x, self.y-8)
        if cellUp ~= nil then
            if cellUp.wall == false and cellUp.water == false then
                self.y = self.y - dt * self.unittype.velocity
            end
        end
    elseif down == true then
        self.y = self.y + dt * self.unittype.velocity
    end
    if left == true then
        self.x = self.x - dt * self.unittype.velocity
    elseif right == true then
        self.x = self.x + dt * self.unittype.velocity
    end
    
    -- update direction for animation drawing
    if left == true then
        self.direction = "left"
    elseif right == true then
        self.direction = "right"
    elseif up == true then
        self.direction = "up"
    elseif down == true then
        self.direction = "down"
    end
    
    if up == true or down == true or 
        left == true or right == true then
        self.moving = true
    else
        self.moving = false
    end
    
    if self.moving == true then
    -- updating the animation
    self.frame_num_time = self.frame_num_time + dt
    
    if self.frame_num_time > 0.2 then
        self.frame_num_time = self.frame_num_time - 0.2
        self.frame_num = self.frame_num + 1
    end

    if self.frame_num > 4 then
        self.frame_num = 1
    end
    
    end
end

function Unit:setUnitType(unittype)
    self.unittype = unittype
end

function Unit:draw(origine_x, origine_y)
    
    if self.moving then
        if self.direction == "left" then
            self.unittype:draw_backside(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame_num)
        elseif self.direction == "right" then
            self.unittype:draw_side(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame_num)
        elseif self.direction == "up" then
            self.unittype:draw_back(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame_num)
        elseif self.direction == "down" then
            self.unittype:draw_front(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame_num)
        end
    else
        if self.direction == "left" then
            self.unittype:draw_backside_stand(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame)
        elseif self.direction == "right" then
            self.unittype:draw_side_stand(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame)
        elseif self.direction == "up" then
            self.unittype:draw_back_stand(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame)
        elseif self.direction == "down" then
            self.unittype:draw_front_stand(origine_x + math.floor(self.x), origine_y + math.floor(self.y), self.frame)
        end
    end

end

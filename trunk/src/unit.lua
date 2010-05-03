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
    temp.velocity = 100
    
    temp.direction = "down"
    temp.moving = false
    
    -- data for animation
    temp.frame_num_time = 0
    temp.frame_num = 1

    return temp
end

function Unit:update(dt, up, down, left, right)

    -- update coordinates
    if up == true then
        self.y = self.y - dt * self.velocity
    elseif down == true then
        self.y = self.y + dt * self.velocity
    end
    if left == true then
        self.x = self.x - dt * self.velocity
    elseif right == true then
        self.x = self.x + dt * self.velocity
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

function Unit:draw()
    
    if self.moving then
        if self.direction == "left" then
            self.unittype:draw_backside(self.x, self.y, self.frame_num)
        elseif self.direction == "right" then
            self.unittype:draw_side(self.x, self.y, self.frame_num)
        elseif self.direction == "up" then
            self.unittype:draw_back(self.x, self.y, self.frame_num)
        elseif self.direction == "down" then
            self.unittype:draw_front(self.x, self.y, self.frame_num)
        end
    else
        if self.direction == "left" then
            self.unittype:draw_backside_stand(self.x, self.y, self.frame)
        end
    end

end

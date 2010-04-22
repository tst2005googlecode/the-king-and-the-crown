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
    return temp
end

function Unit:update(dt, up, down, left, right)
    if up == 1 then
        self.y = self.y - dt * self.velocity
    end
    if down == 1 then
        self.y = self.y + dt * self.velocity
    end
    if left == 1 then
        self.x = self.x - dt * self.velocity
    end
    if right == 1 then
        self.x = self.x + dt * self.velocity
    end
end

function Unit:setUnitType(unittype)
    self.unittype = unittype
end

function Unit:draw()
    
    self.unittype:draw(self.x, self.y)

end

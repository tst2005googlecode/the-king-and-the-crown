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

UnitType = {}
UnitType.__index = UnitType


function UnitType.create(name, filename)
    local temp = {}
    setmetatable(temp, UnitType)

    temp.name = name

    temp.img = love.graphics.newImage(filename)

    return temp
end

-- function UnitType.create()
    -- return UnitType.create("???", "unknow001.png")
-- end

-- function Unit:update(dt, up, down, left, right)
    -- if up == 1 then
        -- self.y = self.y - dt * self.velocity
    -- end
    -- if down == 1 then
        -- self.y = self.y + dt * self.velocity
    -- end
    -- if left == 1 then
        -- self.x = self.x - dt * self.velocity
    -- end
    -- if right == 1 then
        -- self.x = self.x + dt * self.velocity
    -- end
-- end

function UnitType:draw(x, y)
    -- because 
    love.graphics.draw(self.img, x-16, y-16)
end

UnitType.UNKNOW = UnitType.create("???", "unknow001.png")
UnitType.HERO = UnitType.create("Hero", "archer001.png")
UnitType.SKELETON = UnitType.create("Skeleton", "knight001.png")

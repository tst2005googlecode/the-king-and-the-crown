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

    temp.img_front_stand = love.graphics.newImage(string.format("%s_front_stand.png", name))

    temp.img_front_1 = love.graphics.newImage(string.format("%s_front_1.png", name))
    temp.img_front_2 = love.graphics.newImage(string.format("%s_front_2.png", name))
    temp.img_front_3 = love.graphics.newImage(string.format("%s_front_3.png", name))
    temp.img_front_4 = love.graphics.newImage(string.format("%s_front_4.png", name))

    temp.img_back_stand = love.graphics.newImage(string.format("%s_back_stand.png", name))

    temp.img_back_1 = love.graphics.newImage(string.format("%s_back_1.png", name))
    temp.img_back_2 = love.graphics.newImage(string.format("%s_back_2.png", name))
    temp.img_back_3 = love.graphics.newImage(string.format("%s_back_3.png", name))
    temp.img_back_4 = love.graphics.newImage(string.format("%s_back_4.png", name))

    temp.img_side_stand = love.graphics.newImage(string.format("%s_side_stand.png", name))

    temp.img_side_1 = love.graphics.newImage(string.format("%s_side_1.png", name))
    temp.img_side_2 = love.graphics.newImage(string.format("%s_side_2.png", name))
    temp.img_side_3 = love.graphics.newImage(string.format("%s_side_3.png", name))
    temp.img_side_4 = love.graphics.newImage(string.format("%s_side_4.png", name))

    return temp
end

function UnitType:draw_back_stand(x, y)
    love.graphics.draw(self.img_back_stand, x-8, y-29)
end

function UnitType:draw_back(x, y, numframe)
    if numframe == 1 then
        love.graphics.draw(self.img_back_1, x-8, y-29)
    elseif numframe == 2 then
        love.graphics.draw(self.img_back_2, x-8, y-29)
    elseif numframe == 3 then
        love.graphics.draw(self.img_back_3, x-8, y-29)
    elseif numframe == 4 then
        love.graphics.draw(self.img_back_4, x-8, y-29)
    end
end

function UnitType:draw_side_stand(x, y)
    love.graphics.draw(self.img_side_stand, x-8, y-29)
end

function UnitType:draw_side(x, y, numframe)
    if numframe == 1 then
        love.graphics.draw(self.img_side_1, x-8, y-29)
    elseif numframe == 2 then
        love.graphics.draw(self.img_side_2, x-8, y-29)
    elseif numframe == 3 then
        love.graphics.draw(self.img_side_3, x-8, y-29)
    elseif numframe == 4 then
        love.graphics.draw(self.img_side_4, x-8, y-29)
    end
end

function UnitType:draw_backside_stand(x, y)
    local quady = love.graphics.newQuad(0, 0, 32, 32, 32, 32)
    quady:flip(true, false)
    love.graphics.drawq(self.img_side_stand, quady, x-8, y-29)
end

function UnitType:draw_backside(x, y, numframe)
    local quady = love.graphics.newQuad(0, 0, 32, 32, 32, 32)
    quady:flip(true, false)
    
    if numframe == 1 then
        love.graphics.drawq(self.img_side_1, quady, x-8, y-29)
    elseif numframe == 2 then
        love.graphics.drawq(self.img_side_2, quady, x-8, y-29)
    elseif numframe == 3 then
        love.graphics.drawq(self.img_side_3, quady, x-8, y-29)
    elseif numframe == 4 then
        love.graphics.drawq(self.img_side_4, quady, x-8, y-29)
    end
end

function UnitType:draw(x, y)
    self:draw_front_stand(x-8, y-29)
end

function UnitType:draw_front(x, y, numframe)
    if numframe == 1 then
        love.graphics.draw(self.img_front_1, x-8, y-29)
    elseif numframe == 2 then
        love.graphics.draw(self.img_front_2, x-8, y-29)
    elseif numframe == 3 then
        love.graphics.draw(self.img_front_3, x-8, y-29)
    elseif numframe == 4 then
        love.graphics.draw(self.img_front_4, x-8, y-29)
    end
end

function UnitType:draw_front_stand(x, y)
    love.graphics.draw(self.img_front_stand, x-8, y-29)
end

UnitType.UNKNOW = UnitType.create("unknow")
UnitType.HERO = UnitType.create("hero")
UnitType.SKELETON = UnitType.create("skeleton")

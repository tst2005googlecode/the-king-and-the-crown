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

Style = {}
Style.__index = Style


function Style.load()
    -- dungeon tileset
    Style.dungeon = Style.create("dungeon256x256.png", 16)
end

function Style.create(filename, pixelsize)
    local temp = {}
    setmetatable(temp, Style)

    temp.x_origine = 0
    temp.y_origine = 0
    
    temp.image = love.graphics.newImage(filename)
    
    temp.quads = {}
    
    local x
    for x = 0,(temp.image:getWidth()/pixelsize)-1 do
        local y
        for y = 0,(temp.image:getHeight()/pixelsize)-1 do
            temp.quads[x+y*temp.image:getHeight()/pixelsize] = love.graphics.newQuad(x*pixelsize, y*pixelsize, pixelsize, pixelsize, temp.image:getWidth(), temp.image:getHeight() )
        end
    end
    
    return temp
end



function Style:draw(number, x, y)
    
    local quad_ref = self.quads[number]
    if (quad_ref ~= nil) then
        love.graphics.drawq(self.image, quad_ref, x, y);
    end
end


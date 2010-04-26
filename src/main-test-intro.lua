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

require("unittype.lua")
require("unit.lua")
require("castle.lua")
require("room.lua")
require("cell.lua")
require("style.lua")
require("trailer.lua")




function love.load()
    trailer_studio = Trailer.create()
end

function love.update(dt)
    trailer_studio:update(dt)
end


function love.draw()

    trailer_studio:draw()
end

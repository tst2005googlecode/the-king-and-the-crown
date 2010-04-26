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

Trailer = {}
Trailer.__index = Trailer

Trailer.FONT_SIZE = 30
Trailer.MAX_TIME_ANIM = 4

function Trailer.create()
    local temp = {}
    setmetatable(temp, Trailer)

    temp.text = "POURRIT STUDIO(R)"
    temp.font = love.graphics.newFont("transuranium.ttf", Trailer.FONT_SIZE)

    temp.img = love.graphics.newImage("grass.png")

    temp.time = 0
    temp.alpha = 20
    temp.finished = false

    return temp
end

function Trailer:update(dt)

    if self.time > Trailer.MAX_TIME_ANIM then
        self.finished = true
    else
        -- manage alpha to fade in
        local delta = 130
        self.alpha = self.alpha + delta * dt

        if self.alpha > 255 then
            self.alpha = 255
        end
        
        -- calcul time
        self.time = self.time + dt
    end
end

function Trailer:draw()

    local width = love.graphics.getWidth( )
    local height = love.graphics.getHeight( )
    
    local h = self.img:getHeight( ) + 10 + Trailer.FONT_SIZE
    
    love.graphics.setColor(255, 255, 255, self.alpha)
    love.graphics.draw(self.img, 
        (width/2)-(self.img:getWidth()/2), 
        (height/2)-(h/2))

    love.graphics.setFont(self.font)
    love.graphics.print(self.text, (width/2) - 150, (height/2)+(h/2))
    
    
    
    -- debug
    if self.finished then
    love.graphics.print("FINISHEd!", (width/2) - 150, (height/2)+(h/2)+20)
    end 
end
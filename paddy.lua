--[[
 paddy - an onscreen controller display for touch enabled devices


 * Copyright (C) 2017 Ricky K. Thomson
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * u should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 --]]

paddy = {}
paddy.touched = {}

paddy.dpad = {}
paddy.buttonw = 120
paddy.buttonh = 120

paddy.dpad.w = paddy.buttonw*3
paddy.dpad.h = paddy.buttonh*3
paddy.dpad.x = 20
paddy.dpad.y = love.graphics.getHeight()-20-paddy.dpad.h
paddy.dpad.canvas = love.graphics.newCanvas(paddy.dpad.w,paddy.dpad.h)
paddy.dpad.opacity = 200
paddy.dpad.padding = 10

paddy.dpad.buttons = {
	{ name="up",   x=paddy.buttonw, y=0},
	{ name="left", x=0, y=paddy.buttonh },
	{ name="right",x=paddy.buttonw*2, y=paddy.buttonh },
	{ name="down", x=paddy.buttonw, y=paddy.buttonh*2 },
}




function paddy.draw()

    love.graphics.setCanvas(paddy.dpad.canvas)
    love.graphics.clear()
    
	love.graphics.setColor(155,155,155,255)
	
    for i,button in ipairs(paddy.dpad.buttons) do
		
        --love.graphics.rectangle("line", button.x, button.y, paddy.buttonw, paddy.buttonh)
        
        if button.isDown then
			love.graphics.setColor(155,155,155,255)
			love.graphics.rectangle("fill", 
				button.x+paddy.dpad.padding, 
				button.y+paddy.dpad.padding, 
				paddy.buttonw-paddy.dpad.padding*2, 
				paddy.buttonh-paddy.dpad.padding*2,
			10
			)
		else
			love.graphics.setColor(155,155,155,200)	
			love.graphics.rectangle("line", 
				button.x+paddy.dpad.padding, 
				button.y+paddy.dpad.padding, 
				paddy.buttonw-paddy.dpad.padding*2, 
				paddy.buttonh-paddy.dpad.padding*2,
			10
			)
        end
        

    end
    
    love.graphics.setCanvas()
    love.graphics.setColor(255,255,255,paddy.dpad.opacity)
    love.graphics.draw(paddy.dpad.canvas, paddy.dpad.x, paddy.dpad.y)

    
    for i,id in ipairs(paddy.touched) do
		local x,y = love.touch.getPosition(id)
		love.graphics.circle("fill",x,y,20)
    end


end

function paddy.dpad.isDown(key)
	for i,button in ipairs(paddy.dpad.buttons) do
		if button.isDown and button.name == key then return end
	end
end

function paddy.update(dt)
    paddy.touched = love.touch.getTouches()
 
	for i,button in ipairs(paddy.dpad.buttons) do
		button.isDown = false
		for i,id in ipairs(paddy.touched) do	
			local tx,ty = love.touch.getPosition(id)
			if  tx >= paddy.dpad.x+button.x 
			and tx <= paddy.dpad.x+button.x+paddy.buttonw 
			and ty >= paddy.dpad.y+button.y 
			and ty <= paddy.dpad.y+button.y+paddy.buttonh then
				button.isDown = true
			end
		end
    end
end


return paddy

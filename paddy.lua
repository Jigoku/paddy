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
paddy.debug = false

-- The size of the buttons which can be pressed.
paddy.buttonw = 150
paddy.buttonh = 100

-- This lists any buttons which are currently being pressed
paddy.touched = {}

-- Paddy setup
paddy.dpad = {}

-- The properties of the canvas to draw
paddy.dpad.w = paddy.buttonw*3
paddy.dpad.h = paddy.buttonh*3
paddy.dpad.x = 20
paddy.dpad.y = love.graphics.getHeight()-20-paddy.dpad.h
paddy.dpad.canvas = love.graphics.newCanvas(paddy.dpad.w,paddy.dpad.h)

-- These just make things look prettier
paddy.dpad.opacity = 200
paddy.dpad.padding = 5

-- Setup the names for the buttons, and their position on the canvas
paddy.dpad.buttons = {
	{ name="up",   x=paddy.buttonw, y=0 },
	{ name="left", x=0, y=paddy.buttonh },
	{ name="right",x=paddy.buttonw*2, y=paddy.buttonh },
	{ name="down", x=paddy.buttonw, y=paddy.buttonh*2 },
}



function paddy.draw()
	-- Draw the control pad

    love.graphics.setColor(155,155,155,50)
    love.graphics.circle("fill", paddy.dpad.x+paddy.dpad.w/2,paddy.dpad.y+paddy.dpad.h/2,paddy.dpad.w/2)

    love.graphics.setCanvas(paddy.dpad.canvas)
    love.graphics.clear()
    
	love.graphics.setColor(155,155,155,255)
	
    for _,button in ipairs(paddy.dpad.buttons) do
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

    -- debug
	-- Use this to see where you are pressing on the screen
	if paddy.debug then
		for _,id in ipairs(paddy.touched) do
			local x,y = love.touch.getPosition(id)
			love.graphics.circle("fill",x,y,20)
		end
	end

end

function paddy.dpad.isDown(key)
	-- Check for any buttons which are currently being pressed
	for _,button in ipairs(paddy.dpad.buttons) do
		if button.isDown and button.name == key then return true end
	end
end

function paddy.update(dt)
	-- Decide which buttons are being pressed based on a 
	-- simple collision, then change the state of the button

    paddy.touched = love.touch.getTouches()
 
	for _,button in ipairs(paddy.dpad.buttons) do
		button.isDown = false
		for _,id in ipairs(paddy.touched) do	
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

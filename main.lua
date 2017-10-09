-- Example program for using paddy library

function love.load()
	-- Load the paddy module
    require("paddy")
    
    -- Create an object we can move
    player = {}
    player.x = love.graphics.getWidth()/2
    player.y = love.graphics.getHeight()/2
    player.speed = 500
    player.w = 50
    player.h = 70
end

function love.update(dt)

	-- Check the dpad for touch events
	paddy.update(dt)

	if paddy.isDown("up") then
		player.y = player.y - player.speed  *dt
	elseif paddy.isDown("down") then
		player.y = player.y + player.speed  *dt
	elseif paddy.isDown("left") then
		player.x = player.x - player.speed  *dt
	elseif paddy.isDown("right") then
		player.x = player.x + player.speed  *dt
	end
	
	
	if paddy.isDown("x") then
		player.w = player.w - player.speed  *dt
	elseif paddy.isDown("y") then
		player.w = player.w + player.speed  *dt
	elseif paddy.isDown("a") then
		player.h = player.h - player.speed  *dt
	elseif paddy.isDown("b") then
		player.h = player.h + player.speed  *dt
	end
end

function love.draw()

	-- Draw the player
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill", player.x,player.y,player.w,player.h)
    
    -- Draw the touchpad controls
    paddy.draw()
    
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.load()
	--load the paddy module
    require("paddy")
    
    --create an object we can move
    player = {}
    player.x = love.graphics.getWidth()/2
    player.y = love.graphics.getHeight()/2
    player.speed = 500
end

function love.update(dt)

	--check the dpad for touch events
	
	if paddy.dpad.isDown("up") then
		player.y = player.y - player.speed  *dt
	elseif paddy.dpad.isDown("down") then
		player.y = player.y + player.speed  *dt
	elseif paddy.dpad.isDown("left") then
		player.x = player.x - player.speed  *dt
	elseif paddy.dpad.isDown("right") then
		player.x = player.x + player.speed  *dt
	end

end

function love.draw()

	--draw the player
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill", player.x,player.y,50,50)
    
    --draw the touchpad controls
    paddy.draw()
    
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

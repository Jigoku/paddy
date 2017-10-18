# Paddy
An onscreen controller display for touch enabled devices 

### Requirements
* love2d 0.10.2
* a touch enabled device (eg; android smartphone)

### Usage
```
require("paddy")

function love.draw()
	paddy.draw()
end

function love.update(dt)
	paddy.update(dt)

	if paddy.isDown("right") then
		--move right
	end

	if paddy.isDown("a") then
		-- jump
	end

	-- etc
	-- currently supported inputs
	-- left/right/up/down/x/y/a/b
end
```
See *main.lua* for a working example.

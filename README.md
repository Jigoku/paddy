# Paddy
an onscreen controller display for touch enabled devices 

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

	if paddy.dpad.isDown("right") then
		--move right
	end
end
```

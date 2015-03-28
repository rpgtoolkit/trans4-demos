local state = {}

function state.initialize()
	print("ShapeDrawer Initialized.")
	print("Press Escape to exit.")
end

function state.pause()
	print("ShapeDrawer Paused.")
end

function state.resume()
	print("ShapeDrawer Resumed.")
end

function state.update()
	if tk.input.isKeyDown("ESCAPE") then
		tk.game.quit() 
	end
end

function state.render()
	-- We can set the colour we draw shapes in by
	-- using setColor(red, green, blue, alpha). Each
	-- parameter can be a value between 0-255. A 255
	-- value of alpha means the shape will be opaque.
	tk.graphics.setColor(255, 0, 0, 255)
	
	-- We can draw a rectangle using the fillRect()
	-- function. This takes an x,y coordinate first,
	-- and then a width and height.
	tk.graphics.fillRect(400, 50, 200, 200)
	
	-- Let's draw a green outline around our red rectangle.
	-- First we set the colour.
	tk.graphics.setColor(0, 255, 0, 255)
	-- Then we draw the rectangle with the same parameters
	-- as fillRect
	tk.graphics.drawRect(400, 50, 200, 200)
	
	-- Now let's draw a semi-transparent rectangle inside
	-- our red rectangle with the green outline. We'll use
	-- blue.
	tk.graphics.setColor(0, 0, 255, 128)
	tk.graphics.fillRect(450, 100, 100, 100)
	
	-- Let's draw a blue line across the screen
	tk.graphics.setColor(0, 0, 255, 255)
	tk.graphics.drawLine(0,0,640,480)
	
	-- Now we reset the background colour to black.
	tk.graphics.setColor(0,0,0,0)
end

function state.quit()
	tk.game.quit()
end

return state
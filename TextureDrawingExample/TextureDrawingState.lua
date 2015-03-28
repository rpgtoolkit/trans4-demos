local state = {}

-- private variables, no one can access these if we define
-- them as local (except us, of course)
local texture
local switch = "default"

function state.initialize()
	print("TextureDrawer Initialized.")
	print("Press Escape to exit.")
	print("Press 1, 2, or 3 to draw the texture normally, stretched, or compressed.")
	
	-- In order to render a texture, we first need to
	-- load that texture. While we could load the texture
	-- in the render function, it is faster to do so only
	-- once in initialize.
	texture = tk.graphics.loadTexture("Sample1.PNG")
	
	-- Let's make sure the texture has been loaded correctly
	if texture == nil then
		print ("Couldn't load texture. Oops")
	else
		-- If it did load correctly, we can actually find out
		-- it's width and height
		print("Texture width:", texture:width())
		print("Texture height:", texture:height())
	end
end

function state.pause()
	print("TextureDrawer Paused.")
end

function state.resume()
	print("TextureDrawer Resumed.")
end

function state.update()
	if tk.input.isKeyDown("ESCAPE") then
		tk.game.quit()
	elseif tk.input.isKeyDown("1") then
		switch = "default"
	elseif tk.input.isKeyDown("2") then
		switch = "stretch"
	elseif tk.input.isKeyDown("3") then
		switch = "compress"
	end
end

function state.render()
	if switch == "default" then 
		tk.graphics.drawTexture(texture, 50, 50, 0, 0)
	elseif switch == "stretch" then 
		tk.graphics.drawTexture(texture, 0, 0, 640, 480)
	elseif switch == "compress" then
		tk.graphics.drawTexture(texture, 50, 50, 200, 200)
	end
end

function state.quit()
	tk.game.quit()
end

return state
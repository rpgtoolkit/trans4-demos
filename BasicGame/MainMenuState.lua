require("TileDrawerState")

-- first we create a lua table
MainMenuState = {}

-- Let's give it a name entry that corresponds to what we actually called it
MainMenuState.name = "MainMenuState"

-- Let's create the initialize function
MainMenuState.initialize = function()
	print("MainMenuState Initialized.")
	print("Pres S to start the game.")
	
	-- Ask the TK to load a texture (image) into memory
	tex = tk.graphics.loadTexture("tileset.PNG")
	
	if tex == nil then
		print ("Couldn't load texture")
	else
		print(tex.width)
		print(tex.height)
	end
end

MainMenuState.pause = function()
	print("MainMenuState Paused.")
end

MainMenuState.resume = function()
	print("MainMenuState Resumed.")
end

-- The update function gets called several times in the
-- main game loop
MainMenuState["update"] = function()
	-- If the user presses escape, we pop ourselves off
	-- the game stack
	if tk.input.isKeyDown("S") then
		tk.game.pushState(TileDrawerState.name)
	elseif tk.input.isKeyDown("ESCAPE") then
		tk.game.quit() -- Clears all states
	end
end

-- The render function is also called by the game loop
MainMenuState["render"] = function()
	tk.graphics.drawTexture(tex, 0, 0)
end

MainMenuState["quit"] = function()
	tk.graphics.freeTexture(tex)
	tk.game.quit()
end
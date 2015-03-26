-- first we create a lua table
TileDrawerState = {}

-- Let's give it a name entry that corresponds to what we actually called it
TileDrawerState.name = "TileDrawerState"

-- Let's create the initialize function
TileDrawerState.initialize = function()
	print("TileDrawerState Initialized.")
	
	-- Ask the TK to load a texture (image) into memory
	tex = tk.graphics.loadTexture("tileset.PNG")
	
	if tex == nil then
		print ("Couldn't load texture")
	else
		-- If the image was loaded, we know its width and height
		print(tex.width)
		print(tex.height)
	end
	
	-- Let's pick some tiles from the texture. This is known as
	-- "clipping" the texture. The clip is a specified region on
	-- the image that we want to draw.
	g = tk.graphics.TextureClip(tex, 5*16+5, 0, 16, 16) --grass
	d = tk.graphics.TextureClip(tex, 6*16+6, 0, 16, 16) --dirt
	
	-- Finally, let's create a tile map:
		map = { 
		{d,d,g,g,g,g,g,g,g,g},
        {g,d,g,g,g,g,g,g,g,g},
        {g,d,g,g,g,g,g,g,g,g},
        {d,d,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g},
        {g,g,g,g,g,g,g,g,g,g}
		}
end

-- The update function gets called several times in the
-- main game loop
TileDrawerState["update"] = function()
	-- If the user presses D, we pop ourselves off
	-- the game stack
	if tk.input.isKeyDown("D") then
		tk.graphics.freeTexture(tex)
		tk.game.popState()
	end
end

-- The render function is also called by the game loop
TileDrawerState["render"] = function()
	-- draw our tile map
	for i = 1, 10 do
        for j = 1, 10 do
			tk.graphics.drawClip(map[i][j], j*16, i*16)
        end
    end
end

TileDrawerState.quit = function() 
	tk.graphics.freeTexture(tex)
end
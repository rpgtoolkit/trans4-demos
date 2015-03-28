local state = {}

local tileset -- the tileset texture
local grass = {} -- A grass tile from the tileset
local dirt = {} -- A dirt tile from the tileset
local tree = {} -- a small tree tile from the tileset
local offset = {}

-- A tile map (e.g. board) of grass and dirt tiles, 10x10
local map = {
	{dirt,dirt,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,dirt,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,dirt,grass,grass,grass,grass,grass,grass,grass,grass},
	{dirt,dirt,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,dirt,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,grass,grass,grass},
	{grass,grass,grass,grass,grass,grass,grass,grass,grass,grass}
}

function state.initialize()	
	-- Load the image that represents our tileset
	tileset = tk.graphics.loadTexture("tileset.PNG")
	
	-- Let's make sure the tileset has been loaded correctly
	if tileset == nil then
		print ("Couldn't load tileset.")
	end
	
	-- A "clip" is a part of the texture that we want to draw,
	-- rather than drawing the whole thing. In tileset.PNG we 
	-- can see there are tiles, separated by 1 pixel of white
	-- space. 
	
	-- The grass tile is in the first row of tiles, 5 tiles
	-- over. Each tile is 16 pixels, and there is 1 pixel
	-- between each tile. Therefore, the clip region in pixel
	-- units that we want is:
	grass.source_x = 5*16 + 5 -- 5 tiles over, 16 pixel tiles, 5 pixels of padding
	grass.source_y = 0
	
	-- The dirt tile is the next tile over, so...
	dirt.source_x = 6*16 + 6
	dirt.source_y = 0
	
	-- There is a tree tile 13 tiles over and 9 tiles down
	tree.source_x = 13*16 + 13
	tree.source_y = 9*16 + 9
	
	-- The offset is how far from the top left corner of the screen we want to
	-- draw our tiles
	offset.x = 0
	offset.y = 0
	
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
		offset.x = 0
		offset.y = 0
	elseif tk.input.isKeyDown("2") then
		offset.x = 320
		offset.y = 1
	elseif tk.input.isKeyDown("3") then
		offset.x = -16
		offset.y = 240
	end
end

function state.render()
	-- We loop over our may which is 10 tiles wide and 10 tiles high
	for i = 1,10 do
		for j = 1,10 do
			-- To draw a clipped region of a texture, we provide the texture and an x,y location to
			-- draw to first. Then, we specify the clip region by providing an x and y location that
			-- corresponds to an x,y in the tileset image itself, as well as the width and height.
			tk.graphics.drawClip(tileset, offset.x + j*16, offset.y + i*16, map[i][j].source_x, map[i][j].source_y, 16, 16)
		end
	end
	
	-- Let's also draw a tree to demonstrate that alpha blending is working
	j = 5
	i = 5
	tk.graphics.drawClip(tileset, offset.x + j*16, offset.y + i*16, tree.source_x, tree.source_y, 16, 16)
	
end

function state.quit()
	tk.game.quit()
end

return state
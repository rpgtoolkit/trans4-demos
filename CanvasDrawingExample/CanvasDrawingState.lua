-- Make sure you've read the ClipDrawingExample first. In this version
-- we draw the map to a canvas first, then render it to the screen.

local state = {}

local tileset -- the tileset texture
local grass = {} -- A grass tile from the tileset
local dirt = {} -- A dirt tile from the tileset
local tree = {} -- a small tree tile from the tileset
local offset = {}
local canvas_map
local canvas_tree

-- A tile map (e.grass. board) of grass and dirt tiles, 10x10
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
	
	-- Let's create a canvas the size of our 10x10 map (16 pixel tiles)
	canvas_map = tk.graphics.createCanvas(10*16, 10*16)
	-- Just like before, we loop over our map. This time, we draw to a canvas instead.
	for i = 1,10 do
		for j = 1,10 do
			-- We don't use offset here when drawing to the canvas. Also note that because
			-- we're calling a function for the Canvas object, we use : instead of .
			canvas_map:drawClip(tileset, j*16, i*16, map[i][j].source_x, map[i][j].source_y, 16, 16)
		end
	end
	
	-- Let's create a second canvas for our tree
	canvas_tree = tk.graphics.createCanvas(16, 16)
	canvas_tree:drawClip(tileset, 0, 0, tree.source_x, tree.source_y, 16, 16)
	
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
	-- now we can easily draw our map canvas at an offset
	canvas_map:render(offset.x, offset.y)
	
	-- let's also draw our tree at a constant offset and see what happens
	canvas_tree:render(100, 100)
end

function state.quit()
	tk.game.quit()
end

return state
JSON = (loadfile "JSON.lua")()

-- first we create a lua table
JSONTileDrawer = {}

-- Let's give it a name entry that corresponds to what we actually called it
JSONTileDrawer.name = "JSONTileDrawer"

-- Let's create the initialize function
JSONTileDrawer.initialize = function()
	print("JSONTileDrawer Initialized.")
	print("Pres B to go back to main menu.")
	
	local file = io.open( "sample_map.json", "rb" ) -- open json file
	contents = file:read("*all") -- read its contents into a string
	file:close()
	map = JSON:decode(contents) -- decode string
	
	-- Ask the TK to load a texture (image) into memory
	tex = tk.graphics.loadTexture(map.tilesets[1].image)
end

camera = {}
camera.start_x = 1
camera.stop_x = 40
camera.start_y = 1
camera.stop_y = 30

camera.move_right = function(maximum)
	camera.start_x = camera.start_x + 1
	camera.stop_x = camera.stop_x + 1
	
	if(camera.stop_x >= maximum) then
		camera.start_x = camera.start_x - 1
		camera.stop_x = camera.stop_x - 1
	end
	
	print(camera.start_x)
	print(camera.stop_x)
end

camera.move_left = function(minimum)
	camera.start_x = camera.start_x - 1
	camera.stop_x = camera.stop_x - 1
	
	if(camera.start_x <= minimum) then
		camera.start_x = camera.start_x + 1
		camera.stop_x = camera.stop_x + 1
	end
end

JSONTileDrawer.pause = function()
	print("JSONTileDrawer Paused.")
end

JSONTileDrawer.resume = function()
	print("JSONTileDrawer Resumed.")
end

-- The update function gets called several times in the
-- main game loop
JSONTileDrawer["update"] = function()
	-- If the user presses B, we pop ourselves off
	-- the game stack
	if tk.input.isKeyDown("B") then
		tk.game.popState()
	elseif tk.input.isKeyDown("ESCAPE") then
		tk.game.quit() -- Clears all states
	end
end

-- The render function is also called by the game loop
JSONTileDrawer["render"] = function()	
	for k,v in pairs(map.layers) do
		local dy = 0
		for y = camera.start_y, camera.stop_y do
			dy = dy + 1
			local dx = 0
			for x = camera.start_x, camera.stop_x do
				dx = dx + 1
				local index = x + (y-1)*v.width
				local gid = v.data[index] - 1
				if gid ~= 0 then -- A 0 gid means no tile
					local col = math.floor(gid % ((map.tilesets[1].imagewidth + map.tilesets[1].spacing) / (map.tilesets[1].tilewidth + map.tilesets[1].spacing)))
					local row = math.floor(gid / ((map.tilesets[1].imagewidth + map.tilesets[1].spacing) / (map.tilesets[1].tilewidth + map.tilesets[1].spacing)))
					
					local source_y = row * (map.tilesets[1].margin + map.tilesets[1].tileheight + map.tilesets[1].spacing)
					local source_x = col * (map.tilesets[1].margin + map.tilesets[1].tilewidth + map.tilesets[1].spacing)
					
					tk.graphics.drawClip(tex, (dx-1)*16, (dy-1)*16, source_x, source_y, 16, 16)
				end
			end
		end
	end
end

JSONTileDrawer["quit"] = function()
	tk.game.quit()
end
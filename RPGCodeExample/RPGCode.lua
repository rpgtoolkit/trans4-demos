------RPGCODE------
function colorRGB(_a,_b,_c)
	tk.graphics.setColor(_a, _b, _c, 255)
end
function createCanvas(_a,_b)
	return tk.graphics.createCanvas(_a,_b)
end
function dos()
	tk.game.quit()
end
function drawCanvas(_a,_b,_c)
	_a:render(_b,_c)
end
function fillRect(_a,_b,_c,_d,_e)
	_e:fillRect(_a, _b, _c, _d)
end
function keyDown(_a)
	if tk.input.isKeyDown(_a) then
		return true
	end
	return false
end
function setImage(_a,_b,_c,_d,_e,_f,_g,_h)	--setImage(image,x,y,x on image,y on image,w,h,canvas);
	local _i = tk.graphics.loadTexture(_a)
	if _i == nil then
		print ("Couldn't load image ".._a)
		return false
	end
	_h:drawClip(_i, _b, _c, _d, _e, _f, _g)
end
------RPGCODE------

local state = {}
local grass
local player = {}
local heart = {}

function state.initialize()
	grass = createCanvas(32,32)
	player.canvas = createCanvas(32,32)
	player.x = 32
	player.y = 32
	heart.canvas = createCanvas(16,16)
	colorRGB(0,255,0)
	fillRect(0,0,32,32,grass)
	colorRGB(0,0,0)
	setImage("tileset_player.png",0,0,2*32,0*32,32,32,player.canvas)
	setImage("fullHeart.png",0,0,0,0,16,16,heart.canvas)
end
function state.pause()
	print("TextureDrawer Paused.")
end
function state.resume()
	print("TextureDrawer Resumed.")
end
function state.update()
	if keyDown("ESCAPE") then
		dos()
	end
	if keyDown("DOWN") then
		player.y = player.y+.2
	elseif keyDown("UP") then
		player.y = player.y-.2
	elseif keyDown("RIGHT") then
		player.x = player.x+.2
	elseif keyDown("LEFT") then
		player.x = player.x-.2
	end
end
function state.render()
	drawCanvas(grass,32,32)
	drawCanvas(player.canvas,player.x,player.y)
	drawCanvas(heart.canvas,player.x,player.y-16)
	drawCanvas(heart.canvas,player.x+16,player.y-16)
end
function state.quit()
	dos()
end

return state
-- Let's load in a second state to use later (see update function)
AnotherState = require 'AnotherState'

-- first we create a lua table
local state = {}

-- Trans4 will initialize your game state once when it is created.
function state.initialize()
	print("MainMenuState Initialized.")
	print("Pres S to start the game.")
end

-- Trans4 will pause your game state if it is not the
-- active state on the screen.
function state.pause()
	print("MainMenuState Paused.")
end

-- Trans4 will resume your game state if it becomes
-- active again.
function state.resume()
	print("MainMenuState Resumed.")
end

-- Trans4 will call update a LOT of times per second.
-- Use this opportunity to update your game logic.
function state.update()
	if tk.input.isKeyDown("S") then
		-- If the user presses S, we push a new state
		-- to Trans4. This will pause this state and let
		-- the new state take over. Check out AnotherState.lua
		-- to see how similar it is to this state.
		tk.game.pushState("AnotherState")
	elseif tk.input.isKeyDown("ESCAPE") then
		-- quit() will clear all the states from Trans4
		-- causing the game to end.
		tk.game.quit()
	end
end

-- The render function is also called by the game loop
-- many times per second. Render may not be called the
-- same amount of times per loop as update, though.
-- The render function is the only place where drawing
-- will take affect.
function state.render()
end

-- The quit function is called when the user asks to
-- exit the game.
function state.quit()
	tk.game.quit()
end

-- Return the local state variable
return state
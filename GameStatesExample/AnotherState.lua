-- first we create a lua table
local state = {}

function state.initialize()
	print("AnotherState Initialized.")
	print("Press B to go back to the main menu")
end

function state.pause()
	print("AnotherState Paused.")
end

function state.resume()
	print("AnotherState Resumed.")
end

function state.update()
	if tk.input.isKeyDown("B") then
		-- popState() will remove this state from trans4
		-- Trans4 will then use the previous state. In
		-- this example, that will be the MainMenuState.
		tk.game.popState()
	elseif tk.input.isKeyDown("ESCAPE") then
		-- quit() will clear all the states from Trans4
		-- causing the game to end.
		tk.game.quit() 
	end
end

function state.render()
end

function state.quit()
	tk.game.quit()
end

return state
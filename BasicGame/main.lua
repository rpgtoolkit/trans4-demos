-- The file main.lua is the default file that is run
-- so make sure it exists.

-- Load other files
require("MainMenuState")

-- Tell the TK to push a game state onto the stack
-- If there are no states on the stack, the TK
-- will exit.
tk.game.pushState(MainMenuState.name)
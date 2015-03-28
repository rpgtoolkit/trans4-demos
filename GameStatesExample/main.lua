-- This is the first tutorial in understanding Trans4.
-- Follow along in the comments.

-- The file main.lua is the default file that is run
-- so make sure it exists.

-- A Trans4 game is made up of different states. A state
-- corresponds to what the user is currently doing in the
-- game. For example, there could be a MainMenuState when 
-- the user first enters the game. 

-- Let's create one a MainMenuState in MainMenuState.lua
-- and then load that module into a global variable: MMS
MMS = require 'MainMenuState'
-- All states must reside in global variables, otherwise
-- Trans4 can't find them.

-- Now we put this state in Trans4. Trans4 will then call
-- the states functions as it needs to. Once trans4 has
-- no states to call, it will exit.
tk.game.pushState("MMS")

-- See MainMenuState.lua for more information about what
-- functions a state needs to define
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"
scene = storyboard.newScene()
freeChannel = 0
-- load menu screen
storyboard.gotoScene( "menu" )
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
-- game music channel
menuMusicChannel = 1
battleMusicChannel = 2

-- load menu screen
storyboard.gotoScene( "menu" )
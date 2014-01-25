-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--------------------------------------------
-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	--------------- Credit Start ---------------
	performanceText = display.newText("Credit", display.contentWidth/2, 100, native.systemFont, 80)
	performanceText = display.newText("-----------", display.contentWidth/2, 200, native.systemFont, 80)
	performanceText = display.newText("GGJ 2014", display.contentWidth/2, 300, native.systemFont, 50)
	performanceText = display.newText("Name1", display.contentWidth/2, 500, native.systemFont, 60)
	performanceText = display.newText("Name2", display.contentWidth/2, 600, native.systemFont, 60)
	performanceText = display.newText("Name3", display.contentWidth/2, 700, native.systemFont, 60)
	performanceText = display.newText("Name4", display.contentWidth/2, 800, native.systemFont, 60)
	performanceText = display.newText("Name5", display.contentWidth/2, 900, native.systemFont, 60)
	performanceText = display.newText("Name6", display.contentWidth/2, 1000, native.systemFont, 60)
	
	
	--------------- Credit End ---------------
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
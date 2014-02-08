-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn


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

	-- display a background image
	local background = display.newImageRect( "enter.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local title = display.newImage( "shuffle.png", 486, 738 )
	title:scale( 0.7, 0.7 )
	title.rotation = 20
	function listener1 ( obj )
    	transition.to( title, { time=750,rotation = 0, xScale=1, yScale=1 , onComplete=listener2} )
	end
	function listener2 ( obj )

    	transition.to( title, { time=750,rotation =20, xScale=0.7, yScale=0.7 , onComplete=listener1} )
	end
	-- create a widget button (which will loads level1.lua on release)
	transition.to( title, { time=750,rotation = 0, xScale=1, yScale=1 , onComplete=listener2} )
	
	-- all display objects must be inserted into group
	group:insert( background )
	group:insert( title )


	local function onPlayBtnRelease()
	
		 storyboard.gotoScene( "level1", "fade", 1500 )
	
	return true	-- indicates successful touch
end
	

	group:addEventListener( "touch", onPlayBtnRelease )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	if (not audio.isChannelActive(menuMusicChannel)) then
		local mainSong = audio.loadSound("mainSong_new.mp3")
		audio.play(mainSong , {channel =  menuMusicChannel , loops=-1})
	else
		audio.resume(menuMusicChannel)
	end
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	audio.pause(menuMusicChannel)
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
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
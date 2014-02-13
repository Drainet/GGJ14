-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local controller =  require("Objects.UI.controller")
local player =  require("Objects.player.player")
local buffEffectMod = require("buffEffect")
local eventCentralMOD =  require("eventCentral")
local map = require("Objects.map.map")
local eventCentral = eventCentralMOD.new()
local buffEffect = buffEffectMod.new()
eventCentral:start( )
-- include Corona's "physics" library
local physics = require "physics"
local testElement = require "Objects.item.element"
physics.start(); physics.pause()

physics.setGravity( 0, 0 )

-- physics.setDrawMode( "hybrid" )

system.activate("multitouch")

local trap =  require("Objects.item.trap")
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


	
	playerA = player.new({x=360,y=200,direction={x=0,y=150}, path ="image/playerA_set.png"})
	playerB = player.new({x=360,y=1080,direction={x=0,y=-150}, path = "image/playerB_set.png"})
	controllA = controller.new({y=62,player = playerA, rotate = 180})
	controllB = controller.new({y=display.contentHeight-62,player = playerB,rotate = 0})

	local elementDeploy = require "elementDeploy"
	elementGroup = elementDeploy.initDeploy()

	buffElement = {}
    buffElement[1] = display.newImage("image/buffWater.png", -100, -100, true)
    buffElement[2] = display.newImage("image/buffFire.png", -100, -100, true)
    buffElement[3] = display.newImage("image/buffTree.png", -100, -100, true)
	


	-- create a grey rectangle as the backdrop
	local background = display.newImage( "gd2.png", screenW/2, screenH/2 , true)
	--local mapA = map.new()
	
	-- make a crate (off-screen), position it, and rotate slightly
	
	-- all display objects must be inserted into group

	--group:insert(mapA.image)

	group:insert( background )
	
	
	group:insert( elementGroup )
	group:insert( playerA.image )
	group:insert( playerB.image )
	group:insert( buffElement[1] )
	group:insert( buffElement[2] )
	group:insert( buffElement[3] )
	group:insert( controllA.image )
	group:insert( controllB.image )

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	physics.start()

	-- control Game battle theme play & resume
	if (not audio.isChannelActive(battleMusicChannel)) then
		local battleSong = audio.loadSound("battleSong_new.mp3")
		audio.play(battleSong , {channel = battleMusicChannel , fadein = 1000,volume =0 ,loops=-1})
	else
		audio.resume(battleMusicChannel)
	end

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )

	local group = self.view
	-- pause game battle theme when exit scene
	audio.pause(battleMusicChannel)

	physics.stop()
	storyboard.removeScene( storyboard.getPrevious() )
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view

	package.loaded[physics] = nil
	physics = nil
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
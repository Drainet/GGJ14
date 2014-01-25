module(..., package.seeall)

local object = require('Object')

function new(config)

	local controller = object.new()
	controller.image = display.newGroup( )
	controller.ddir = 0
	controller.skilllock = false
	controller.lfbt = display.newImage( "image/left.png",105,config.y )
	controller.rtbt = display.newImage( "image/right.png",display.contentWidth-105,config.y )
	local imageSheet = graphics.newImageSheet( "image/rune.png", { width=300, height=128, numFrames=4 } )
	local sequenceData =
	{
	    { name="normal", start=4, count=1, time=1 , loopCount=1 },
	    { name="1", start=3, count=1, time=1 , loopCount=1 },
	    { name="2", start=1, count=1, time=1 , loopCount=1},
	    { name="0", start=2, count=1, time=1 , loopCount=1 }
	}
	controller.midbt = display.newSprite( imageSheet, sequenceData )
	controller.midbt:setSequence( "normal" )
	controller.midbt:play()
	controller.midbt.x =360
	controller.midbt.y = config.y

	controller.CDcover = display.newRect(360,config.y,300,128)
	controller.CDcover:setFillColor( 0 )
	controller.CDcover.alpha = 0.8
	controller.CDcover.isVisible = false

	controller.btntouchcnt = 0

	controller.image.anchorChildren = true
	controller.image.x=360
	controller.image.y=config.y

	controller.image:insert( controller.lfbt )
	controller.image:insert( controller.rtbt )
	controller.image:insert( controller.midbt )
	controller.image:insert( controller.CDcover )

	controller.image.rotation = config.rotate
	function controller.rotate( event )
	    
		--local value = math.sqrt(config.controller.direction.x^2 + config.controller.direction.y^2)
	    --config.controller.direction.x = config.controller.direction.x + controller.ddir 
	        --config.controller.direction.x = config.controller.direction.x + 10
	    config.player.deg =  config.player.deg + controller.ddir*math.pi/180



	    local ddeg = config.player.deg * 180/math.pi

	    if(ddeg>360 or ddeg<-360)then
	    	config.player.deg = 0
	    end

	    --print( ddeg)
	    
	    	config.player.direction.x =  config.player.value*math.cos(config.player.deg)
	    	config.player.direction.y =  config.player.value*math.sin(config.player.deg)
	    

	   
	end 
	controller.timers[1] = timer.performWithDelay( 10, controller.rotate,0)
	timer.pause( controller.timers[1] )

	function controller.lfbt:touch( event )
	    if event.phase == "began" then
	    	display.getCurrentStage():setFocus( controller.lfbt, event.id )
	    	timer.resume( controller.timers[1] )
	        controller.ddir = -4
	        controller.btntouchcnt = controller.btntouchcnt+1
	    end

	    if event.phase == "ended" then
	    	controller.btntouchcnt = controller.btntouchcnt-1
	    	if(controller.btntouchcnt==1)then
	    		controller.ddir = 4
	    	elseif(controller.btntouchcnt<=0)then

	    		timer.pause( controller.timers[1] )
	        	controller.ddir = 0
	        	controller.btntouchcnt=0
	    	end
	    end
	    return true
	end 

	function controller.rtbt:touch( event )
		if event.phase == "began" then
			display.getCurrentStage():setFocus( controller.rtbt, event.id )
			timer.resume( controller.timers[1] )
	    	controller.ddir = 4
	    	controller.btntouchcnt = controller.btntouchcnt+1
	    	
	    end

	    if event.phase == "ended" then
	    	controller.btntouchcnt = controller.btntouchcnt-1
	    	if(controller.btntouchcnt==1)then
	    		controller.ddir = -4
	    	elseif(controller.btntouchcnt<=0)then

		    	timer.pause( controller.timers[1] )
		        controller.ddir = 0
		        controller.btntouchcnt=0
		    end
		end
	    return true

	end

	function controller.midbt:touch( event )
		
		if event.phase == "began" and config.player.body.type ~= nil and controller.skilllock==false then
			local element = require "Objects.item.element"
			local tempx = config.player.body.x
			local tempy = config.player.body.y
			function skillDelay (event) 
				local temp = element.new({x=tempx, y=tempy, type = (config.player.body.type+1)%3})
				elementGroup:insert( temp )
			end
			controller.skilllock = true
			timer.performWithDelay( 560, skillDelay )
			controller.CDcover.isVisible = true
			local listener2 = function( obj )
   				controller.CDcover.isVisible = false
   				controller.CDcover.xScale=1.0
   				controller.skilllock = false
			end
			transition.scaleTo( controller.CDcover, { xScale=0.01, yScale=1.0, time=3500 ,onComplete=listener2} )
	    	
	    end

	    
	    return true

	end

	function controller:changeSkill(event)
		
		if(event.target.id == config.player.id )then
			controller.midbt:setSequence( tostring((event.target.type+1)%3) )
			controller.midbt:play()
		end
	end

	controller.lfbt:addEventListener( "touch",controller.lfbt)
	controller.rtbt:addEventListener( "touch",controller.rtbt)
	controller.midbt:addEventListener( "touch",controller.midbt)
	scene:addEventListener( 'changeSkill',controller)

	return controller

end
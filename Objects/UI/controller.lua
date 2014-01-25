module(..., package.seeall)

local object = require('Object')

function new(config)

	local controller = object.new()
	controller.image = display.newGroup( )
	controller.ddir = 0
	controller.lfbt = display.newImage( "image/left.png",70,config.y )
	controller.rtbt = display.newImage( "image/right.png",display.contentWidth-70,config.y )
	controller.btntouchcnt = 0

	controller.image.anchorChildren = true
	controller.image.x=360
	controller.image.y=config.y

	controller.image:insert( controller.lfbt )
	controller.image:insert( controller.rtbt )

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

	    print( ddeg)
	    
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

	controller.lfbt:addEventListener( "touch",controller.lfbt)
	controller.rtbt:addEventListener( "touch",controller.rtbt)


	return controller

end
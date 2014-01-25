module(..., package.seeall)
local object = require('Object')
function new(config)
	local group = display.newGroup( )
	imgList = {
		[1] =  "trap_w",
		[2] =  "trap_f",
		[3] =  "trap_t"
	}


	local trap = object.new()
	trap.image = display.newGroup( )
	trap.image.name = "trap"
	
	
	local imageSheet = graphics.newImageSheet( "trap_set.png", { width=72, height=72, numFrames=3 } )
	local sequenceData =
	{
	    { name="trap_w", start=1, count=1, time=1 , loopCount=0 },
	    { name="trap_f", start=2, count=1, time=1 , loopCount=0 },
	    { name="trap_t", start=3, count=1, time=1 , loopCount=0}
	  
	}
	trap.body = display.newSprite( imageSheet, sequenceData )
	trap.body:setSequence(imgList[config.type+1])
	trap.body:play()

	trap.image.type = config.type

	trap.image:insert(trap.body)
	trap.body.x = trap.image.x
	trap.body.y = trap.image.y
	trap.image.x = config.x
	trap.image.y = config.y

	physics.addBody(trap.image,"static")
	trap.image.isSensor = true
	function trap.image.collision(self , event)
		--- player can change tpye of trap ---
		if( (trap.image.type + 2)%3 == event.other.type ) then
			print( "dddd" )
			trap.image.type = event.other.type
			trap.body:setSequence( imgList[event.other.type+1] )
			trap.body:play()
		end
	end

	trap.image:addEventListener("collision")
	return trap
end
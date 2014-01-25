module(..., package.seeall)

local object = require('Object')

function new(config)

	local self = object.new()
	self.image = display.newGroup( )
	
	self.lfbt = display.newImage( "image/leftBT.png",70,config.y )
	self.rtbt = display.newImage( "image/rightBT.png",display.contentWidth-70,config.y )

	self.image:insert( self.lfbt )
	self.image:insert( self.rtbt )
	--self.timer[]

	function self.lfbt:touch( event )
	    if event.phase == "began" then


	        config.player.direction.x = config.player.direction.x - 10
	    end
	    return true
	end 

	function self.rtbt:touch( event )
		if event.phase == "began" then

	    	
	    	config.player.direction.x = config.player.direction.x + 10
	    end
	    return true

	end

	self.lfbt:addEventListener( "touch",self.lfbt)
	self.rtbt:addEventListener( "touch",self.rtbt)


	return self

end
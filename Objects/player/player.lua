module(..., package.seeall)

local object = require('Object')

function new(config)
	local self = object.new()
	self.image = display.newGroup( )
	self.body = display.newImage( "crate.png",config.x,config.y )
	self.direction = config.direction
	
	self.image:insert( self.body )
	physics.addBody( self.image,{ density=10.0, friction=1, bounce=0} )


	function self:playerState(event)

		self.image:setLinearVelocity(self.direction.x , self.direction.y)

	end


	scene:addEventListener( 'playerState', self )
	self.listeners[table.maxn(self.listeners)+1] = {event='playerState' , listener = self}
	return self
end
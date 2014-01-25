module(..., package.seeall)

local object = require('Object')

function new(config)
	local player = object.new()
	player.image = display.newGroup( )
	player.body = display.newImage( "crate.png",config.x,config.y )
	player.direction = config.direction
	player.deg = math.atan( player.direction.y/player.direction.x )
	player.value = math.sqrt(player.direction.x^2 + player.direction.y^2)
	player.image:insert( player.body )
	physics.addBody( player.body,{ density=10.0, friction=1, bounce=0.2, radius = 40} )
	--player.body.isFixedRotation = true
	--physics.setDrawMode( "hybrid" )
	function player:playerState(event)

		player.body.rotation = player.deg * 180 /math.pi 
		player.body:setLinearVelocity(player.direction.x , player.direction.y)
	end


	scene:addEventListener( 'playerState', player )
	player.listeners[table.maxn(player.listeners)+1] = {event='playerState' , listener = player}
	return player
end
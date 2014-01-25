module(..., package.seeall)

local object = require('Object')

function new(config)

	local player = object.new()
	
	player.image = display.newGroup( )
	player.image.type = nil

	local imageSheet = graphics.newImageSheet( config.path, { width=100, height=100, numFrames=8 } )
	local sequenceData =
	{
	    { name="normal", start=1, count=2, time=600 , loopCount=0 },
	    { name="wood", start=3, count=4, time=600 , loopCount=0 },
	    { name="fire", start=5, count=6, time=600 , loopCount=0},
	    { name="water", start=7, count=8, time=600 , loopCount=0 }
	}
	player.body = display.newSprite( imageSheet, sequenceData )

	player.body.x = config.x
	player.body.y = config.y
	player.body:setSequence( "normal" )
	player.body:play()
	player.direction = config.direction
	player.deg = math.atan( player.direction.y/player.direction.x )
	player.value = math.sqrt(player.direction.x^2 + player.direction.y^2)
	player.image:insert( player.body )
	physics.addBody( player.body,{ density=10.0, friction=1, bounce=0.2, radius = 40} )
	--player.body.isFixedRotation = true
	--physics.setDrawMode( "hybrid" )
	function player:playerState(event)
		player.body.rotation = -90 + player.deg * 180 /math.pi 
		player.body:setLinearVelocity(player.direction.x , player.direction.y)

	end


	function player.image:collision(event)
		if(event.phase=="began") then
			if(event.other.name=="player" and event.other.name == "trap") then
				
				
				if ((self.type+2)%3==event.other.type or(self.type == nil and event.other.type ~= nil)) then
					--lose

					--
				end

			elseif (event.other.name=="element") then

				self.type = event.other.type
				--player.body:setSequence( "normal" )
				player.body:play()
				
			end

		end
	end

	player.image:addEventListener( "collision")

	scene:addEventListener( 'playerState', player )
	player.listeners[table.maxn(player.listeners)+1] = {event='playerState' , listener = player}
	return player
end
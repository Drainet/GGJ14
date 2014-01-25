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
	    { name="1", start=3, count=2, time=600 , loopCount=0 },
	    { name="2", start=5, count=2, time=600 , loopCount=0},
	    { name="0", start=7, count=2, time=600 , loopCount=0 }
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

	player.body.name ="player"
	function player:playerState(event)
		player.body.rotation = -90 + player.deg * 180 /math.pi 
		player.body:setLinearVelocity(player.direction.x , player.direction.y)

	end


	function player.body:collision(event)
		
		if(event.phase=="began") then
			if(event.other.name=="player" or event.other.name == "trap") then
				
				if ( self.type == nil and event.other.type == nil) then
				elseif ( (self.type == nil and event.other.type ~= nil) or (self.type+2)%3==event.other.type ) then
					--lose
					player.dispose()
					print( "lose" )
					--
				end

			elseif (event.other.name=="element") then
				print( "asas" )
				self.type = event.other.type
				print( self.type )
				player.body:setSequence( tostring(self.type) )
				player.body:play()
				
			end

		end
	end

	player.body:addEventListener( "collision")

	scene:addEventListener( 'playerState', player )
	player.listeners[table.maxn(player.listeners)+1] = {event='playerState' , listener = player}
	return player
end
module(..., package.seeall)

local object = require('Object')

function new(config)

	local player = object.new()
	
	player.image = display.newGroup( )
	player.image.type = nil
	
	player.id  = config.path 
	local imageSheet = graphics.newImageSheet( config.path, { width=100, height=100, numFrames=12 } )
	local sequenceData =
	{
	    { name="normal", start=1, count=2, time=600 , loopCount=0 },
	    { name="1", start=3, count=2, time=600 , loopCount=0 },
	    { name="2", start=5, count=2, time=600 , loopCount=0},
	    { name="0", start=7, count=2, time=600 , loopCount=0 },
	    { name="dead", start=9, count=4, time=1000 }
	}
	player.body = display.newSprite( imageSheet, sequenceData )
	player.body.selfCounter = false
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
					 --player.dispose()
					player.body:setSequence( "dead" )
					player.body:play()
					local victoryMenu = require("victoryMenu")
					

					physics.pause( )
					function delay( )
						victoryMenu.new(player.id)
					end
					timer.performWithDelay(1500,delay)
					-- player.image:insert(victory)
					--


				end

			elseif (event.other.name=="element" and player.body.selfCounter == false) then
				
				self.type = event.other.type

				scene:dispatchEvent({name='changeSkill',target = {type = self.type , id =player.id}})

				player.body:setSequence( tostring(self.type) )
				player.body:play()
				

				-- sound effect
				freeChannel = freeChannel +1
				local elementSound = audio.loadSound("element.wav")
				audio.play(elementSound , {channel = freeChannel ,loops = 0})
			end

		end

		if(event.phase=="ended" and event.other.name=="element" and player.body.selfCounter == true) then
			player.body.selfCounter = false
		end
	end

	player.body:addEventListener( "collision")

	scene:addEventListener( 'playerState', player )
	player.listeners[table.maxn(player.listeners)+1] = {event='playerState' , listener = player}
	return player
end
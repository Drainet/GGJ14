module(..., package.seeall)
local object = require('Object')
function new(config)

	imgList = {
		[1] =  "water_trap.png",
		[2] =  "fire_trap.png",
		[3] =  "tree_trap.png"
	}

	local trap = object.new()
	trap.image = display.newGroup( )
	trap.body = display.newImage( imgList[config.type+1])
	
	trap.image.type = config.type

	trap.image:insert(trap.body)
	trap.body.x = trap.image.x
	trap.body.y = trap.image.y
	trap.image.x = config.x
	trap.image.y = config.y

	physics.addBody(trap.image,"static")

	function trap.colllison(self , event)
		--- player can change tpye of trap ---
		if( (trap.image.type + 1)%3 == event.other.type ) then
			trap.image.type = event.other.type
			trap.body = display.newImage( imgList[config.type+1])
			trap.body.x = trap.image.x
			trap.body.y = trap.image.y
		end
	end

	trap.image:addEventListener("collision",trap)
	return trap
end
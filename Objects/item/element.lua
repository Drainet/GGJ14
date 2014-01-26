module(..., package.seeall)

local object = require('Object')

function new(config)

	local element = object.new()
	element.image = display.newGroup( )
	element.image.name = "element"
	element.image.type = config.type
	
	imgList = {
		[1] = "rune_w.png",
		[2] = "rune_f.png",
		[3] = "rune_t.png"
	}
	
	element.mainImg = display.newImage(imgList[element.image.type + 1], config.x, config.y, true)
	element.image:insert( element.mainImg )
	physics.addBody(element.image,"static",{radius = 35})
	
	element.mainImg.x = element.image.x
	element.mainImg.y = element.image.y
	element.image.x = config.x
	element.image.y = config.y

	element.image.isSensor = true

	function element.image.collision(self, event)
		--print("SSS")
		if(event.other.name == "player" and event.phase=="began" ) then
			
			-- element.image:removeSelf( )
			-- element.image = nil
			if(event.other.selfCounter == false)then
				element.dispose()
			end
		end
	end	

	element.image:addEventListener( "collision")
	return element.image

end
module(..., package.seeall)

local object = require('Object')

function new(config)

	local element = object.new()
	element.image = display.newGroup( )
	element.mainImg = display.newCircle(config.x,config.y,38)
	element.image:insert( element.mainImg )

	element.type = config.type


	return element.image

end
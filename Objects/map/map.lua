module(..., package.seeall)

local object = require('Object')
function new(config)
	local map = object.new()
	map.image = display.newGroup( )
	map.top = display.newRect( 360, 108, 720, 40 )
	map.left = display.newRect( -20, 640, 40, 1280 )
	map.right = display.newRect( 740, 640, 40, 1280 )
	map.down = display.newRect( 360, 1172, 720, 40 )

	physics.addBody( map.top, "static", {density=20, friction=0, bounce=0  } )
	physics.addBody( map.left, "static", {density=20, friction=0, bounce=0  } )
	physics.addBody( map.right, "static", {density=20, friction=0, bounce=0  } )
	physics.addBody( map.down, "static", {density=20, friction=0, bounce=0  } )

	--physics.setDrawMode( "hybrid" )

	map.image:insert( map.top)
	map.image:insert( map.left)
	map.image:insert( map.right)
	map.image:insert( map.down)
	return map
end
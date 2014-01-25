module(..., package.seeall)

local element = require "Objects.item.element"

function initDeploy(config)

	local xArr = {}
	local yArr = {}
	local eArr = {}
	local group = display.newGroup( )
	local number = 6


	if(config~=nil) then
		if(config.number~=nil) then
			number = config.number
		end
	end
	
	for i=1,number do
		local notDupFlag = 0
		local notDupElem = 0
		local X = 0
		local Y = 0

		while notDupFlag == 0 do
			notDupFlag = 1
			Y = 128 + 80 + math.random(900)
			X = 80 + math.random(600)
			if i > 1 then
				for j=1,i-1 do
					if X > xArr[j] -150 and X < xArr[j] + 150 then
						if Y > yArr[j] -150 and Y < yArr[j] + 150 then
							notDupFlag = 0					
						end
					end
				end
			end
		end
		
		local temp = element.new({x=X, y=Y, type = i % 3 })
		group:insert(temp)
		xArr[i] = X
		yArr[i] = Y
	end
	

	return group
end
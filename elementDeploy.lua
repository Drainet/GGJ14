module(..., package.seeall)

local element = require "Objects.item.element"
local trap = require "Objects.item.trap"
function initDeploy(config)

	local xArr = {}
	local yArr = {}
	local eArr = {}
	local group = display.newGroup( )
	local number = 6

	local trap_num = 3

	if(config~=nil) then
		if(config.number~=nil) then
			number = config.number
		end
	end
	
	for i=1,number do
		local notDupFlag = 0
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

	for i=number+1,number+trap_num do
		local notDupFlag = 0
		local X = 0
		local Y = 0

		while notDupFlag == 0 do
			notDupFlag = 1
			Y = 128 + 80 + math.random(900)
			X = 80 + math.random(600)
			for j=1,i-1 do
				if X > xArr[j] -150 and X < xArr[j] + 150 then
					if Y > yArr[j] -150 and Y < yArr[j] + 150 then
						notDupFlag = 0					
					end
				end
			end
		end
		
		local tempp = trap.new({ type = i % 3 ,x=X, y=Y})
		group:insert(tempp.image)

		xArr[i] = X
		yArr[i] = Y


	end


	return group

end
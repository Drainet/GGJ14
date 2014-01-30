--eventCentral.lua
module(..., package.seeall)
local scene = scene

function new()

    local Content = {}

    function Content.buffEffect()
        

        if playerA.body.type == nil and playerB.body.type == nil then
     
        elseif (playerA.body.type == nil and playerB.body.type ~= nil)  then    -- B beats A 
            playerA.body.xScale = 1
            playerB.body.xScale = 2
        elseif (playerA.body.type ~= nil and playerB.body.type == nil) then     -- A beats B
            playerA.body.xScale = 2
            playerB.body.xScale = 1    
        elseif ((playerA.body.type+2)%3 == playerB.body.type) then              -- B beats A by elements
            playerA.body.xScale = 1
            playerB.body.xScale = 2
        elseif ((playerB.body.type+2)%3 == playerA.body.type) then              -- A beats B by elements
            playerA.body.xScale = 2
            playerB.body.xScale = 1
        else                                                                    -- even
            playerA.body.xScale = 1
            playerB.body.xScale = 1    
        end

    end

    scene:addEventListener( 'buffEffect', Content ) 
end

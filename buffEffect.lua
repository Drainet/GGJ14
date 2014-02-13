--eventCentral.lua
module(..., package.seeall)
local scene = scene

function new()

    local Content = {}

   
    function Content.buffEffect()
        
        -- PlayerA is on the up side, PlayerB is on the down side.
        if playerA.body.type == nil and playerB.body.type == nil then
     
        elseif (playerA.body.type == nil and playerB.body.type ~= nil)  then    -- B beats A 
            buffElement[playerB.body.type+1].x = playerB.body.x
            buffElement[playerB.body.type+1].y = playerB.body.y
        elseif (playerA.body.type ~= nil and playerB.body.type == nil) then     -- A beats B
            buffElement[playerA.body.type+1].x = playerA.body.x
            buffElement[playerA.body.type+1].y = playerA.body.y   
        elseif ((playerA.body.type+2)%3 == playerB.body.type) then              -- B beats A by elements
            buffElement[playerB.body.type+1].x = playerB.body.x
            buffElement[playerB.body.type+1].y = playerB.body.y
        elseif ((playerB.body.type+2)%3 == playerA.body.type) then              -- A beats B by elements
            buffElement[playerA.body.type+1].x = playerA.body.x
            buffElement[playerA.body.type+1].y = playerA.body.y
        else                                                                    -- even
            -- playerA.body.xScale = 1
            -- playerB.body.xScale = 1    
        end

    end

    function Content.PauseAllEvent()
        buffElement[1].x = -100
        buffElement[1].y = -100
        buffElement[2].x = -100
        buffElement[2].y = -100
        buffElement[3].x = -100
        buffElement[3].y = -100 
    end

    scene:addEventListener( 'buffEffect', Content ) 
    scene:addEventListener( 'PauseAllEvent', Content ) 
end

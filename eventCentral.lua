--eventCentral.lua
module(..., package.seeall)
local scene = scene

function new()

    local eventCental = {}
    local backCover = {}
    
    

    function allEnterFrame()
        scene:dispatchEvent({name='floatingFloorMoving'} )
        scene:dispatchEvent({name='moveLayer'})
        scene:dispatchEvent({name='arrowControl'})
        scene:dispatchEvent({name='playerState'})
        scene:dispatchEvent({name='turnHead'})
    end    

    function allRuntimeTouch(event)
        scene:dispatchEvent({name='screenTouch',target = event})
    end  

    function callBackCover(switch)
        local backCover = display.newRect(  0, 0 , display.contentWidth, display.contentHeight)

        backCover.x = display.contentWidth/2
        backCover.y = display.contentHeight/2
        backCover:setFillColor(0, 0, 0)
        backCover.alpha = 0.2
        backCover.screenResume = switch

        function backCover:touch(event)
            if event.phase == "began" and backCover.screenResume == true then

                eventCental.resume()
                
            end
            return true
        end

        backCover:addEventListener( "touch",backCover)


        return backCover

    end

    function spriteListener( event )
        print( dodo )
        event.target:stop()
    end

--------------------------------- EventCentral API ---------------------------------
    function eventCental.start()
        Runtime:addEventListener("enterFrame", allEnterFrame)
        Runtime:addEventListener( "touch", allRuntimeTouch)
    end

    function eventCental.pause(pauseUI,switch)
        --transition.pause()
        Runtime:addEventListener( "sprite", spriteListener )
        eventCental.pauseUI = pauseUI
        backCover = callBackCover(switch)
        HUD:insert( backCover )
        HUD:insert( pauseUI )
        physics.pause()
        scene:dispatchEvent({name='pauseAllEvent'})
    end

    function eventCental.resume()
        display.remove( backCover )
        display.remove(eventCental.pauseUI)
        physics.start()
        scene:dispatchEvent({name='resumeAllEvent'})
    end

    function eventCental.stop()
        Runtime:removeEventListener("enterFrame", allEnterFrame)
        Runtime:removeEventListener("touch", allRuntimeTouch)
        scene:dispatchEvent({name='removeAllEvent'})
    end

    function eventCental.cancelCover()
        backCover.isVisible = false

    end

-- Add sprite listener
    
--------------------------------- EventCentral API End ---------------------------------

--------------------------------- External EventCentral API Start ---------------------------------
    function eventCental:callCentralStart(event)
        eventCental.start()
    end

    function eventCental:callCentralPause(event)
        eventCental.pause()
    end

    function eventCental:callCentralStop(event)
        eventCental.stop()
    end

    scene:addEventListener( 'callCentralStart', eventCental )
    scene:addEventListener( 'callCentralPause', eventCental )
    scene:addEventListener( 'callCentralStop', eventCental )
--------------------------------- External EventCentral API End ---------------------------------

    return eventCental
end

module(..., package.seeall)


function new(id)
    
    local widget = require( "widget" )
    local storyboard = require( "storyboard" )
	
	local Content = display.newGroup( )

------------------- buttonHandler Start ---------------
	local buttonHandler = function( event )
        if event.target.id == "Back" then
            Content.Back()
    	elseif event.target.id == "Again" then
	    	Content.Again()
	    end
    end
------------------- buttonHandler End ---------------


        --pauseMenu.isVisible = false

        local backCover = display.newRect(  0, 0 , display.contentWidth, display.contentHeight)

        backCover.x = display.contentWidth/2
        backCover.y = display.contentHeight/2
        backCover:setFillColor(0, 0, 0)
        backCover.alpha = 0.2

        Content:insert(backCover)

        local endview =display.newImage("image/end.png", 360,640)
        Content:insert(endview)
        endview:scale( 1.5, 2 )
        transition.scaleTo( endview, { xScale=1, yScale=1, time=500 } )

        --print( id )
        if(id == "image/playerA_set.png")then
            endview.rotation = 180
        end

        function backCover:touch(event )
            -- body
            return true
        end
        backCover:addEventListener( "touch", backCover)

        scene:dispatchEvent({name='pauseAllEvent'})

        buttonBack = widget.newButton
            {
                id = "Back",
                defaultFile = "buttonHome.png",
                label = " ",
                font = "arial",
                labelColor = {default = {255, 255, 255, 255}},
                fontSize = 28,
                emboss = true,
                onPress = buttonHandler,
            }

        buttonAgain = widget.newButton
            {
                id = "Again",
                defaultFile = "buttonBlue.png",
                label = " ",
                font = "arial",
                labelColor = {default = {255, 255, 255, 255}},
                fontSize = 28,
                emboss = true,
                onPress = buttonHandler,
            }

        buttonBack.x = -250   ; buttonBack.y = display.contentHeight/2    
        buttonAgain.x = display.contentWidth+250  ; buttonAgain.y = display.contentHeight/2    


        transition.moveTo( buttonBack, { x=50, y= display.contentHeight/2 , time=500 } )
        transition.moveTo( buttonAgain, { x=display.contentWidth-50, y=display.contentHeight/2, time=500 } )

        Content:insert(buttonBack)
        Content:insert(buttonAgain)

        
    
------------------- pauseMenu End ---------------

------------------- Button Function Start -------------------
    function Content.Back()
        storyboard.gotoScene( "menu", "fade", 200  )
        storyboard.removeAll() 
        Content:removeSelf()

    end

    function Content.Again()
        storyboard.gotoScene( "reloading", "fade", 200  )
        Content:removeSelf()

        
	end
------------------- Button Function End -------------------
    return Content
end
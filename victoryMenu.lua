module(..., package.seeall)


function new()
    
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

        scene:dispatchEvent({name='pauseAllEvent'})

        buttonBack = widget.newButton
            {
                id = "Back",
                defaultFile = "buttonBlue.png",
                label = "Back",
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
                label = "Again",
                font = "arial",
                labelColor = {default = {255, 255, 255, 255}},
                fontSize = 28,
                emboss = true,
                onPress = buttonHandler,
            }

        buttonBack.x = display.contentWidth/2   ; buttonBack.y = display.contentHeight/2    -180
        buttonAgain.x = display.contentWidth/2  ; buttonAgain.y = display.contentHeight/2    +180

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
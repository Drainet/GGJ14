--Classes/Object.lua

module(..., package.seeall)

local scene = scene
	--inherits Base Class

--INSTANCE FUNCTIONS
function new()
    --creates our instance's display image
	local Object={}
	
	Object.listeners={}
	Object.timers={}
	
	function Object.setImage(img)
		Object.image = display.newImage(img)
	end
	
	function Object.show(config)
		--show this object somewhere on-screen
		
		Object.image.x, Object.image.y = config.x, config.y
		Object.image.isVisible = true
	end

	function Object.hide()
		--hide this object
		Object.image.isVisible = false
	end
	
	function Object.dispose()
		--hide this object
		for i = 1,table.maxn( Object.listeners) do
			
			scene:removeEventListener( Object.listeners[i].event, Object.listeners[i].listener )
			
		end

		

		for i = 1,table.maxn( Object.timers) do
			
			if(Object.timers[i]~=nil)then
		 		timer.cancel( Object.timers[i] )
			end
		end

		scene:removeEventListener( 'removeAllEvent', Object )
    	scene:removeEventListener( 'pauseAllEvent', Object )
    	scene:removeEventListener( 'resumeAllEvent', Object )

		display.remove( Object.image )
		Object.image = nil

	end


	function Object.freeze()
		--hide this object
		for i = 1,table.maxn( Object.listeners) do
			
			scene:removeEventListener( Object.listeners[i].event, Object.listeners[i].listener )
			
		end

		


		for i = 1,table.maxn( Object.timers) do
			--print(Object.listeners[i].event)
			if(Object.timers[i]~=nil)then
		 		timer.pause( Object.timers[i] )
			end
		end

	end

	function Object.unfreeze()
		--hide this object
		for i = 1,table.maxn( Object.listeners) do
			
			 scene:addEventListener( Object.listeners[i].event, Object.listeners[i].listener )
			 
		end

		

		for i = 1,table.maxn( Object.timers) do
			
			if(Object.timers[i]~=nil)then
				
		 		timer.resume( Object.timers[i] )
			end
		end

	end

	function Object:removeAllEvent(event)
        
        Object.dispose()

    end

    function Object:pauseAllEvent(event)
        
        Object.freeze()

    end

    function Object:resumeAllEvent(event)
        
        Object.unfreeze()

    end

    scene:addEventListener( 'removeAllEvent', Object )
    scene:addEventListener( 'pauseAllEvent', Object )
    scene:addEventListener( 'resumeAllEvent', Object )
	
	-- Object.listeners[table.maxn(Object.listeners)+1] = {event='removeAllEvent' , listener = Object}
	-- Object.listeners[table.maxn(Object.listeners)+1] = {event='pauseAllEvent' , listener = Object}
	-- Object.listeners[table.maxn(Object.listeners)+1] = {event='resumeAllEvent' , listener = Object}
	

    
	return Object
end


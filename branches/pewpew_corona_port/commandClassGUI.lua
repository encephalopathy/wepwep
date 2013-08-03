function interface Order ()
   -- public abstract void
     execute ( )
end

-- Receiver 
function Receiver ()
    local function pressedListener( event )
        print("pressed")
    end
    public void hoverListener(event) 
        print("hovered")
    end
      public void dragListener(event) 
        print("dragged")
    end
      public void swipeListener(event) 
        print("swiped")
    end
      public void tapListener(event) 
        print("tapped")
    end
end

-- Invoker.
function Involker()
    local m_ordersQueue = new ArrayList();

    local Agent() 
    
    end
    
    function placeAction(Involker involker)
        ordersQueue.addLast(involker);
        involker.execute(ordersQueue.getFirstAndRemove());
    end    
end

--ConcreteCommand Class.
function pressedListenerExecute()
    local Reciever action
    function pressedListenerExecute ( Receiver st) 
        action = st;
    end
    function void execute( ) 
        action.pressedListener( )
    end
end

--ConcreteCommand Class.
function hoverListenerExecute()
    local Receiver action;
    global hoverListenerExecute( Receiver st) 
        stock = st;
    end
    global execute( ) 
        action.hoverListener()
    end
end

--ConcreteCommand Class.
function swipeListenerExecute()
    local Receiver action;
    global swipeListenerExecute( Receiver st) 
        stock = st;
    end
    global execute( ) 
        action.swipeListener()
    end
end

--ConcreteCommand Class.
function dragListenerExecute()
    local Receiver action;
    global dragListenerExecute( Receiver st) 
        stock = st;
    end
    global execute( ) 
        action.dragListener()
    end
end

--ConcreteCommand Class.
function tapListenerExecute()
    local Receiver action;
    global tapListenerExecute( Receiver st) 
        stock = st;
    end
    global execute( ) 
        action.tapListener()
    end
end



-- Client
global function Client ()
    function main(String[] args) 
        Receiver events = new Reciever()
        pressedListenerExecute PLE = new pressedListenerExecute(events)
        hoverListenerExecute HLE = new hoverListenerExecute(events)
        Involker agent = new Involker();

        agent.placeAction(PLE); --pressed
        agent.placeAction(HLE); --hover
    end
end
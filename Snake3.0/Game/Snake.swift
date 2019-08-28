import MetalKit

class Snake: GameObject {
    
    private var _nextDirection = float3(1,0,0)
    private var _timeTicked: Int = 0
    private var _head: SnakeBody!
    var canTick: Bool {
        if(_timeTicked > GameSettings.SnakeSpeed) {
            _timeTicked = 0
            return true
        }
        _timeTicked += 1
        return false
    }
    
    override init() {
        super.init()
    
        addBody()
    }
    
    func addBody() {
        _head = SnakeBody()
        
        addChild(_head)
    }
    
    override func doUpdate() {
        if(canTick){
            _head.move((1 / GameSettings.GridCellsWide) * self._nextDirection)
        }
        
        if(Keyboard.IsKeyPressed(.leftArrow)) {
            self._nextDirection = float3(-1,0,0)
        }
        if(Keyboard.IsKeyPressed(.rightArrow)) {
            self._nextDirection = float3(1,0,0)
        }
        if(Keyboard.IsKeyPressed(.upArrow)) {
            self._nextDirection = float3(0,1,0)
        }
        if(Keyboard.IsKeyPressed(.downArrow)) {
            self._nextDirection = float3(0,-1,0)
        }
    }
    
}

class SnakeBody: GameObject {
    
    override init() {
        super.init()
        
        self.setPositionZ(0.101)
        self.setScale(1 / GameSettings.GridCellsHigh * (1 - GameSettings.GridLinesWidth * 2))
    }
    
}

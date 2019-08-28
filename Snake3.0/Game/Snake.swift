import MetalKit

class Snake: GameObject {
    
    private var _nextDirection = float3(1,0,0)
    private var _timeTicked: Float = 0
    private var _head: SnakeBody! = nil
    private var _tail: SnakeBody! = nil
    var canTick: Bool {
        if(_timeTicked > 60 / GameSettings.SnakeSpeed) {
            _timeTicked = 0
            return true
        }
        _timeTicked += 1
        return false
    }
    
    override init() {
        super.init()
    
        addBody()
        addBody()
        addBody()
    }
    
    func addBody() {
        var body: SnakeBody!
        if(_head == nil) {
            body = SnakeBody(nextDirection: self._nextDirection)
            self._head = body
        }else{
            if(_tail.nextDirection == float3(1,0,0)) {
                body = SnakeBody(nextDirection: _tail.nextDirection)
                body.setPosition(_tail.getPosition() + -_tail.nextDirection / GameSettings.GridCellsWide)
            }
        }
        
        self._tail = body
        addChild(body)
    }
    
    private func getInput() {
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

    override func doUpdate() {
        getInput()
        
        if(canTick){
            if(self._head.nextDirection != _nextDirection && _nextDirection != -self._head.nextDirection) {
                _head.turn(_nextDirection)
            }
            for child in children {
                if let snakeBody = child as? SnakeBody {
                    snakeBody.slither()
                }
            }
        }
        
        
    }
    
}

class SnakeBody: GameObject {
    
    var nextDirection = float3(0,0,0)
    init(nextDirection: float3) {
        super.init()
        
        self.nextDirection = nextDirection
        self.setPositionZ(0.101)
        self.setScale(1 / GameSettings.GridCellsHigh * (1 - GameSettings.GridLinesWidth * 2))
    }
    
    func turn(_ direction: float3) {
        self.nextDirection = direction
    }
    
    func slither() {
        self.move((1 / GameSettings.GridCellsWide) * self.nextDirection)
    }
    
}

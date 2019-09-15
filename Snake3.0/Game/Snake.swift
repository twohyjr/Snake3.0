import MetalKit

class Snake: GameObject {
    private var _nextDirection = float3(0,-1,0)
    private var _head: SnakeBody! = nil
    public var head: SnakeBody { return _head }
    private var _tail: SnakeBody! = nil
    
    var positions: [String: SnakeBody] = [:]
    
    private var _turns: [String: float3] = [:]
    override init() {
        super.init()
    
        addBody()
        addBody()
        addBody()
    }
    
    func setNextDirection(_ direction: float3) {
        self._nextDirection = direction
    }
    
    func addBody() {
        var body: SnakeBody!
        if(_head == nil) {
            body = SnakeBody(cellX: 5, cellY: 5, nextDirection: self._nextDirection)
            self._head = body
        }else{
            var gridPosition = _tail.gridPosition
            gridPosition = int2(gridPosition.x - Int32(_tail.nextDirection.x),
                                gridPosition.y + Int32(_tail.nextDirection.y))
            body = SnakeBody(cellX: Int(gridPosition.x), cellY: Int(gridPosition.y), nextDirection: _tail.nextDirection)
            body.setPosition(_tail.getPosition() + -_tail.nextDirection / GameSettings.GridCellsWide)
        }
        
        self._tail = body
        addChild(body)
    }
    
    func updateSnake() {
        positions.removeAll()
        if(self._head.nextDirection != _nextDirection && _nextDirection != -self._head.nextDirection) {
            _turns.updateValue(_nextDirection, forKey: _head.gridPositionAsString)
        }
        for child in children {
            if let snakeBody = child as? SnakeBody {
                let key = snakeBody.gridPositionAsString
                
                if let snakeBodyHit = positions[snakeBody.gridPositionAsString] {
                    if(snakeBody.id != _head.id) {
                        snakeBodyHit.texture = Textures.Get(.SnakeDead)
                        GameSettings.GameOver = true
                        print("SCORE: \(GameSettings.Score)")
                    }
                }
                
                if let turn = _turns[key] {
                    snakeBody.turn(turn)
                    if (snakeBody.id == _tail.id) {
                        _turns.removeValue(forKey: key)
                    }
                }
                snakeBody.slither()
                positions.updateValue(snakeBody, forKey: snakeBody.gridPositionAsString)
            }
        }
    }
    

    
}

class SnakeBody: GridPositional {
    var nextDirection = float3(0,0,0)
    
    init(cellX: Int, cellY: Int, nextDirection: float3) {
        super.init(cellX: cellX, cellY: cellY)

        self.nextDirection = nextDirection
        
         self.texture = Textures.Get(.Snake)
    }
    
    func setInitialGridPosition(pos: int2) {
        self.gridPosition = pos
    }
    
    func turn(_ direction: float3) {
        self.nextDirection = direction
    }
    
    func slither() {
        self.gridPosition = int2(self.gridPosition.x + Int32(self.nextDirection.x),
                                  self.gridPosition.y - Int32(self.nextDirection.y))
        if(Float(self.gridPosition.x) >= GameSettings.GridCellsWide) {
            self.gridPosition.x = 0
        }
        if(Float(self.gridPosition.x) <= -1) {
            self.gridPosition.x = Int32(GameSettings.GridCellsWide - 1)
        }
        if(Float(self.gridPosition.y) >= GameSettings.GridCellsHigh) {
            self.gridPosition.y = 0
        }
        if(Float(self.gridPosition.y) <= -1) {
            self.gridPosition.y = Int32(GameSettings.GridCellsHigh - 1)
        }
        setPositionOnGrid()
    }
}

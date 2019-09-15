import MetalKit

class Grid: Node {
    private var _timeTicked: Float = 0
    var gridBackground = GridBackground()
    var gridLines = GridLines()
    var apples: [String: Apple] = [:]
    var snake: Snake!
    
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
        gridBackground.moveZ(-2)
        addChild(gridBackground)
        
        gridLines.moveZ(0.1)
        addChild(gridLines)
    }
    
    func addSnake(_ snake: Snake) {
        self.snake = snake
        addChild(snake)
    }
    
    func addApple(cellX: Int, cellY: Int) {
        let apple = Apple(cellX: cellX, cellY: cellY)
        apples.updateValue(apple, forKey: apple.gridPositionAsString)
        addChild(apple)
    }
    
    func isApple(cellX: Int, cellY: Int)->Bool {
        let key = "(\(cellX),\(cellY))"
        return apples[key] != nil
    }
    
    private func getInput() {
        if(Keyboard.IsKeyPressed(.leftArrow)) {
            snake.setNextDirection(float3(-1,0,0))
        }
        if(Keyboard.IsKeyPressed(.rightArrow)) {
            snake.setNextDirection(float3(1,0,0))
        }
        if(Keyboard.IsKeyPressed(.upArrow)) {
            snake.setNextDirection(float3(0,1,0))
        }
        if(Keyboard.IsKeyPressed(.downArrow)) {
            snake.setNextDirection(float3(0,-1,0))
        }
    }
    
    override func doUpdate() {
        getInput()
        
        if(canTick){
            snake.updateSnake()
            if(isApple(cellX: Int(snake.head.gridPosition.x), cellY: Int(snake.head.gridPosition.y))) {
                appleHit(snake.head.gridPosition)
                GameSettings.Score += 1
            }
        }
    }
    
    func appleHit(_ gridPosition: int2) {
        let key = "(\(gridPosition.x),\(gridPosition.y))"
        if let apple = apples[key] {
            let nextPosX = Int32.random(in: 0..<Int32(GameSettings.GridCellsWide))
            let nextPosY = Int32.random(in: 0..<Int32(GameSettings.GridCellsWide))
            apple.gridPosition = int2(nextPosX, nextPosY)
            apple.setPositionOnGrid()
            apples.removeValue(forKey: key)
            apples.updateValue(apple, forKey: apple.gridPositionAsString)
        }
    }
}

class GridBackground: GameObject {
    
    override var renderPipelineStateType: RenderPipelineStateTypes { return .GridBackground }
    
    override init() {
        super.init()
        
        self.setScale(10.0)
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var totalGameTime = GameTime.TotalGameTime
        renderCommandEncoder.setFragmentBytes(&totalGameTime, length: Float.size, index: 0)
        
        super.render(renderCommandEncoder)
    }
    
}

class GridLines: GameObject {
    
    override var renderPipelineStateType: RenderPipelineStateTypes { return .GridLines }
    var gridConstants = GridConstants()
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var totalGameTime = GameTime.TotalGameTime
        renderCommandEncoder.setFragmentBytes(&totalGameTime, length: Float.size, index: 0)
        renderCommandEncoder.setFragmentBytes(&gridConstants, length: GridConstants.stride, index: 1)
        super.render(renderCommandEncoder)
    }
    
    
}

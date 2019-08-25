import MetalKit

class SnakeScene: Scene {
    
    var grid = Grid()
    var snake = Snake()
    override func buildScene() {
        camera.moveZ(0.63)
        
        addChild(grid)
        
        addChild(snake)
    }
    
}

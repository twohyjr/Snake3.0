import MetalKit

class SnakeScene: Scene {
    
    var grid = Grid()
    var snake = Snake()
    override func buildScene() {
        camera.moveZ(0.63)
        
        grid.addSnake(snake)
        grid.addApple(cellX: 0, cellY: 0)
        addChild(grid)
    }

}

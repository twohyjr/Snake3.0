import MetalKit

class SnakeScene: Scene {
    
    var grid = Grid()
    override func buildScene() {
        camera.moveZ(0.63)
        
        
        addChild(grid)
    }
    
}

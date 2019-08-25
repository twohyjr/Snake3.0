import MetalKit

class SnakeScene: Scene {
    
    var gridBackground = GridBackground()
    override func buildScene() {
        addChild(gridBackground)
    }
    
    override func doUpdate() {
        gridBackground.rotateZ(GameTime.DeltaTime)
    }
    
}

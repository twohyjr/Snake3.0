import MetalKit

class Snake: GameObject {
    
    override init() {
        super.init()
        
        self.setPositionZ(0.101)
        self.setScale(1 / GameSettings.GridCellsHigh * (1 - GameSettings.GridLinesWidth))
    }
    
    override func doUpdate() {
        if(Keyboard.IsKeyPressed(.leftArrow)) {
            self.moveX(-GameTime.DeltaTime)
        }
        if(Keyboard.IsKeyPressed(.rightArrow)) {
            self.moveX(GameTime.DeltaTime)
        }
        if(Keyboard.IsKeyPressed(.upArrow)) {
            self.moveY(GameTime.DeltaTime)
        }
        if(Keyboard.IsKeyPressed(.downArrow)) {
            self.moveY(-GameTime.DeltaTime)
        }
    }
    
}

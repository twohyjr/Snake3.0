import MetalKit

class Apple: GridPositional {
    
    override init(cellX: Int, cellY: Int) {
        super.init(cellX: cellX, cellY: cellY)
        
        self.texture = Textures.Get(.Apple)
    }
    
}

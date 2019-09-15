import MetalKit

class GridPositional: GameObject {
    var gridPosition: int2 = int2(0,0)
    
    init(cellX: Int, cellY: Int) {
        super.init()
        
        self.gridPosition = int2(Int32(cellX), Int32(cellY))
        self.setScale(1 / GameSettings.GridCellsHigh * (1 - GameSettings.GridLinesWidth * 2))
        self.setPositionZ(0.101)
        self.setPositionOnGrid()
    }
    
    var gridPositionAsString: String {
        return "(\(gridPosition.x),\(gridPosition.y))"
    }
    
    func setPositionOnGrid() {
        let x: Float = (Float(gridPosition.x) - floor(GameSettings.GridCellsWide / 2.0)) / GameSettings.GridCellsWide
        let y: Float = -(Float(gridPosition.y) - floor(GameSettings.GridCellsHigh / 2.0)) / GameSettings.GridCellsHigh
        
        self.setPositionX(x)
        self.setPositionY(y)
    }
}


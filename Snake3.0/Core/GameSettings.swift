import MetalKit

class GameSettings {
    
    private static var _gridSize: float2 = float2(11, 11)
    
    public static var GridSize: float2 { return _gridSize }
    public static var GridCellsWide: Float { return _gridSize.x }
    public static var GridCellsHigh: Float { return _gridSize.y }
    public static var GridLinesWidth: Float = 0.05
    
    public static var SnakeSpeed: Float = 4.0
    public static var Score: Int = 0
    
}

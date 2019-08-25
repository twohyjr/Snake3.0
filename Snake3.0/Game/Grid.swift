import MetalKit

class Grid: Node {
    var gridBackground = GridBackground()
    var gridLines = GridLines()
    override init() {
        super.init()
        gridBackground.moveZ(-2)
        addChild(gridBackground)
        gridLines.moveZ(0.1)
        addChild(gridLines)
    }
    
    override func update() {
//        gridLines.rotateY(GameTime.DeltaTime)
        super.update()
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
    
    override init() {
        super.init()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var totalGameTime = GameTime.TotalGameTime
        renderCommandEncoder.setFragmentBytes(&totalGameTime, length: Float.size, index: 0)
        renderCommandEncoder.setFragmentBytes(&gridConstants, length: GridConstants.stride, index: 1)
        super.render(renderCommandEncoder)
    }
    
    
}

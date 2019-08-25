import MetalKit

class GridBackground: GameObject {
    
    override var renderPipelineStateType: RenderPipelineStateTypes { return .GridBackground }
    
    override init() {
        super.init()
        
        self.setScale(3.0)
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var totalGameTime = GameTime.TotalGameTime
        renderCommandEncoder.setFragmentBytes(&totalGameTime, length: Float.size, index: 0)
        
        super.render(renderCommandEncoder)
    }
    
}

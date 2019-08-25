import MetalKit

class GameObject: Node {
    var renderPipelineStateType: RenderPipelineStateTypes { return .Basic }
    var modelConstants = ModelConstants()
    var mesh: QuadMesh!
    
    override init() {
        super.init()
        self.mesh = QuadMesh()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStates.Get(renderPipelineStateType))
        
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        mesh.drawPrimitives(renderCommandEncoder)
        
        super.render(renderCommandEncoder)
    }
    
}
import MetalKit

class GameObject: Node {
    var renderPipelineStateType: RenderPipelineStateTypes { return .Basic }
    var modelConstants = ModelConstants()
    var mesh: QuadMesh!
    var texture: MTLTexture!
    
    override init() {
        super.init()
        self.mesh = QuadMesh()

    }
    
    override func update() {
        modelConstants.modelMatrix = modelMatrix
        super.update()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStates.Get(renderPipelineStateType))
        renderCommandEncoder.setDepthStencilState(DepthStencilStates.Get(.Less))
        
        renderCommandEncoder.setFragmentTexture(texture, index: 0)
        
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        mesh.drawPrimitives(renderCommandEncoder)
        
        super.render(renderCommandEncoder)
    }
    
}

import MetalKit

class Scene {
    var mesh: QuadMesh!
    
    init() {
        self.mesh = QuadMesh()
    }
    
    func update() {
        
    }
    
    func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStates.Get(.Basic))
        
        //renderCommandEncoder?.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        //renderCommandEncoder?.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
    
}

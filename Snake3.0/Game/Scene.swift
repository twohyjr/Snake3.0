import MetalKit

class Scene: Node {
    var sceneConstants = SceneConstants()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() { }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder)
    }
}

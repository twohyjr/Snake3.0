import MetalKit

class Scene: Node {
    var sceneConstants = SceneConstants()
    var camera = Camera()
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() { }
    
    override func update() {
        sceneConstants.viewMatrix = camera.viewMatrix
        sceneConstants.projectionMatrix = camera.projectionMatrix
        super.update()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder)
    }
}

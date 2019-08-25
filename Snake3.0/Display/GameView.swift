import MetalKit

class GameView: MTKView {
    var sceneConstants = SceneConstants()
    var modelConstants = ModelConstants()
    
    var scene: Scene!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device!)
        
        self.clearColor = MTLClearColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        
        self.colorPixelFormat = .bgra8Unorm_srgb
        
        self.depthStencilPixelFormat = .depth32Float_stencil8
    
        self.delegate = self
        
        RenderPipelineStates.Initialize()
        
        DepthStencilStates.Initialize()
        
        scene = SnakeScene()
    }

}

extension GameView: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        GameTime.UpdateTime(1 / Float(view.preferredFramesPerSecond))
        
        scene.update()
        
        scene.render(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
    
}

import MetalKit

class GameView: MTKView {
    var renderPipelineState: MTLRenderPipelineState!
    var sceneConstants = SceneConstants()
    var modelConstants = ModelConstants()
    var mesh: QuadMesh!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device!)
        
        self.clearColor = MTLClearColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        
        self.colorPixelFormat = .bgra8Unorm_srgb
    
        self.delegate = self
        
        self.mesh = QuadMesh()
        
        generateRenderPipelineState()
        
    }
    
    private func generateRenderPipelineState() {
        let vertexFunction = Engine.DefaultLibrary.makeFunction(name: "vertex_shader")
        let fragmentFunction = Engine.DefaultLibrary.makeFunction(name: "fragment_shader")
        
        let vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Texture Coordinate
        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::RENDERPIPELINESTATE::\(error)")
        }
    }
    
}

extension GameView: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
//        renderCommandEncoder?.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
//        renderCommandEncoder?.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
//
        mesh.drawPrimitives(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
    
}

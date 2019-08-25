
import MetalKit

enum RenderPipelineStateTypes {
    case Basic
}

class RenderPipelineStates {
    
    private static var _library: [RenderPipelineStateTypes: MTLRenderPipelineState] = [:]
    
    public static func Initialize() {
        generateBasicRenderPipelineState()
    }
    
    private static func generateBasicRenderPipelineState() {
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
        
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::RENDERPIPELINESTATE::\(error)")
        }
        
        _library.updateValue(renderPipelineState, forKey: .Basic)
    }
    
    
    public static func Get(_ type: RenderPipelineStateTypes)->MTLRenderPipelineState {
        return _library[type]!
    }
    
}

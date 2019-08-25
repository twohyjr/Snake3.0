
import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case GridBackground
}

class RenderPipelineStates {
    
    private static var _library: [RenderPipelineStateTypes: MTLRenderPipelineState] = [:]
    
    private static var VertexDescriptor: MTLVertexDescriptor {
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
        
        return vertexDescriptor
    }
    
    public static func Initialize() {
        generateBasicRenderPipelineState()
        generateGridBackgroundRenderPipelineState()
    }
    
    private static func generateBasicRenderPipelineState() {
        let vertexFunction = Engine.DefaultLibrary.makeFunction(name: "vertex_shader")
        let fragmentFunction = Engine.DefaultLibrary.makeFunction(name: "fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptor
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::RENDERPIPELINESTATE::\(error)")
        }
        
        _library.updateValue(renderPipelineState, forKey: .Basic)
    }
    
    private static func generateGridBackgroundRenderPipelineState() {
        let vertexFunction = Engine.DefaultLibrary.makeFunction(name: "vertex_shader")
        let fragmentFunction = Engine.DefaultLibrary.makeFunction(name: "grid_background_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptor
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::RENDERPIPELINESTATE::\(error)")
        }
        
        _library.updateValue(renderPipelineState, forKey: .GridBackground)
    }

    public static func Get(_ type: RenderPipelineStateTypes)->MTLRenderPipelineState {
        return _library[type]!
    }
    
}

import MetalKit

protocol sizeable{ }
extension sizeable{
    static var size: Int{
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int{
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension Bool: sizeable { }
extension uint32: sizeable { }
extension Int32: sizeable { }
extension Float: sizeable { }
extension float2: sizeable { }
extension float3: sizeable { }
extension float4: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var textureCoordinate: float2
}

struct SceneConstants: sizeable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
}

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}

struct GridConstants: sizeable {
    var cellCount: float2 = GameSettings.GridSize
    var lineWidth: Float = GameSettings.GridLinesWidth
}

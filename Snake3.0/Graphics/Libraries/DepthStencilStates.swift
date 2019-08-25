import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStates {
    
    private static var _library: [DepthStencilStateTypes: MTLDepthStencilState] = [:]
    
    public static func Initialize() {
        createLessDepthStencilState()
    }
    
    private static func createLessDepthStencilState() {
        let depthDescriptor = MTLDepthStencilDescriptor()
        depthDescriptor.isDepthWriteEnabled = true
        depthDescriptor.depthCompareFunction = .less
        
        let depthStencilState  = Engine.Device.makeDepthStencilState(descriptor: depthDescriptor)
        
        _library.updateValue(depthStencilState!, forKey: .Less)
    }
    
    public static func Get(_ type: DepthStencilStateTypes)->MTLDepthStencilState {
        return _library[type]!
    }
    
}
